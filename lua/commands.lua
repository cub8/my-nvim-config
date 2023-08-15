local api = vim.api
local cmd = vim.cmd

local rails_run_test_cmd = function(args)
  local path = vim.fn.expand("%:p")
  local line = args["line1"]
  local command = "!bundle exec rails test " .. path .. ":" .. line

  cmd(command)
end

local spec_run_test_cmd = function(args)
  local path = vim.fn.expand("%:p")
  local line = args["line1"]
  local command = "!bundle exec rspec " .. path .. ":" .. line

  cmd(command)
end

api.nvim_create_user_command("RailsRunTest", rails_run_test_cmd, { range = 1 })
api.nvim_create_user_command("SpecRunTest", spec_run_test_cmd, { range = 1 })

