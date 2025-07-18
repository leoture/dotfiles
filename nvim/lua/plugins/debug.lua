-- Function to pick a target from the Swift package
---@param type string -- Type of target to pick (e.g., "executable", "test")
---@param resume function -- Callback function to call with the selected target
local function targetPicker(type, resume)
  local handle = io.popen("swift package dump-package 2>/dev/null")
  if not handle then
    vim.notify("Failed to run `swift package dump-package`", vim.log.levels.ERROR)
    return {}
  end
  local output = handle:read("*a")
  handle:close()

  local ok, parsed = pcall(vim.fn.json_decode, output)
  if type == "executable" then
    if not ok or not parsed or not parsed.products then
      vim.notify("Could not parse package dump", vim.log.levels.ERROR)
      return {}
    end
    local executables = {}
    for _, product in ipairs(parsed.products) do
      if product.type.executable ~= nil then
        table.insert(executables, product.name)
      end
    end
    if #executables == 0 then
      vim.notify("No executable products found", vim.log.levels.WARN)
      return {}
    end
    vim.ui.select(executables, { prompt = "Select an executable product" }, resume)
  else
    if not ok or not parsed or not parsed.targets then
      vim.notify("Could not parse package dump", vim.log.levels.ERROR)
      return {}
    end

    local targets = {}
    for _, target in ipairs(parsed.targets) do
      if target.type == type then
        table.insert(targets, target.name)
      end
    end

    if #targets == 0 then
      vim.notify("No executable or test targets found", vim.log.levels.WARN)
      return {}
    end

    vim.ui.select(targets, { prompt = "Select a target" }, resume)
  end
end

---@async
---@param cmd string[] -- Command to run in the shell
---@return string|nil -- Returns the output of the command or nil if it fails
local function shell(cmd)
  local handle = io.popen(table.concat(cmd, " ") .. " 2>/dev/null")
  if not handle then
    vim.notify("Failed to run command: " .. table.concat(cmd, " "), vim.log.levels.ERROR)
    return nil
  end
  local output = handle:read("*a")
  handle:close()
  return vim.fn.trim(output)
end

---Removes new line characters
---@param str string
---@return string
local function remove_nl(str)
  local trimmed, _ = string.gsub(str, "\n", "")
  return trimmed
end

---Returns Xcode devoloper path
---@async
---@return string|nil
local function get_test_process()
  --  TODO: use swiftly
  local result = shell({ "xcode-select", "-p" })
  if not result then
    return nil
  end
  result = shell({ "fd", "swiftpm-testing-helper", remove_nl(result) })
  if not result then
    return nil
  end
  return remove_nl(result)
end

return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      dap.adapters.lldb = {
        type = 'executable',
        command = vim.fn.trim(vim.fn.system("xcrun -f lldb-dap")),
        name = "lldb-dap"
      }

      dap.configurations.swift = {
        {
          name = "Debug",
          type = "lldb",
          request = "launch",
          program = function()
            return coroutine.create(function(dap_coro)
              -- Step 1: Select target
              targetPicker("executable", function(target)
                if not target or target == "" then
                  vim.notify("No target selected", vim.log.levels.WARN)
                  dap_coro.resume(nil)
                  return
                end

                -- Step 2: Get the build path
                local bin_path = shell({ "swift", "build", "--show-bin-path" })
                if not bin_path or bin_path == "" then
                  vim.notify("Failed to get build path", vim.log.levels.ERROR)
                  dap_coro.resume(nil)
                  return
                end

                -- Step 3: Open terminal in bottom split
                vim.cmd("botright new")
                vim.cmd("resize 15")
                local win = vim.api.nvim_get_current_win()

                -- Step 4: Build the target
                vim.fn.jobstart(
                  { "swift", "build", "--product", target },
                  {
                    term = true,
                    on_exit = function(_, code)
                      vim.api.nvim_set_current_win(win)
                      vim.cmd("stopinsert")
                      if code == 0 then
                        -- Close terminal only on success
                        vim.schedule(function()
                          if vim.api.nvim_win_is_valid(win) then
                            -- close buffer
                            local bufnr = vim.api.nvim_win_get_buf(win)
                            if vim.api.nvim_buf_is_valid(bufnr) then
                              -- vim.api.nvim_win_close(win, true)
                              vim.api.nvim_buf_delete(bufnr, { force = false })
                            end
                          end
                        end)
                        coroutine.resume(dap_coro, bin_path .. "/" .. target)
                      else
                        vim.notify("Build failed — fix issues and retry", vim.log.levels.ERROR)
                      end
                    end
                  }
                )

                vim.cmd("startinsert")
              end)
            end)
          end,
          cwd = '${workspaceFolder}',
        },
        {
          name = "Debug Test",
          type = "lldb",
          request = "attach",
          program = function()
            vim.schedule(function()
              vim.cmd("resize 15")
              local win = vim.api.nvim_get_current_win()

              vim.fn.jobstart(
                { "swift", "test" },
                {
                  on_exit = function(_, code)
                    if code == 0 then
                      -- Close terminal only on success
                      vim.schedule(function()
                        if vim.api.nvim_win_is_valid(win) then
                          vim.api.nvim_win_close(win, true)
                        end
                      end)
                    else
                      vim.api.nvim_set_current_win(win)
                      vim.cmd("stopinsert")
                    end
                  end,
                  --
                  stdout_buffered = false,
                  on_stdout = function(_, data, _)
                    if data then
                      for _, line in ipairs(data) do
                        if line ~= "" then
                          dap.repl.append(line .. "\n")
                        end
                      end
                    end
                  end,

                  stderr_buffered = false,
                  on_stderr = function(_, data, _)
                    if data then
                      for _, line in ipairs(data) do
                        if line ~= "" then
                          dap.repl.append(line .. "\n")
                        end
                      end
                    end
                  end,
                }
              )

              vim.cmd("startinsert")
              -- end)
            end)
            return get_test_process()
          end,
          waitFor = true,
          cwd = '${workspaceFolder}',
        }
      }
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    },
    config = function()
      require("dapui").setup()
      local dap = require("dap")
      local dapui = require("dapui")
      dap.listeners.on_session["Debug Test"] = function(old_session, new_session)
        if new_session then
          dapui.open()
        end
      end
    end
  }
}
