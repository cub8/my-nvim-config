-- config
require("config")

-- keymaps
require("keymaps")

-- plugin manager
do
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

	if not vim.loop.fs_stat(lazypath) then
		print("Installing lazy.nvim....")
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable",
			lazypath,
		})
	end

	vim.opt.rtp:prepend(lazypath)
end

local lazy_ok, lazy = pcall(require, "lazy")

if lazy_ok then
	lazy.setup(require("plugins"))
else
	print("(init) Couldn't load Lazy!")
end

