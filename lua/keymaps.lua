local keymap = vim.keymap

-- no highlight after search
keymap.set("n", "<esc><esc>", ":noh<cr>", {})

-- copy
keymap.set({"n", "x"}, "cp", '"+y')

-- paste
keymap.set({"n", "x"}, "cv", '"+p')

-- select all text in current buffer
keymap.set("n", "<leader>a", ":keepumps normal! ggVG<cr>")

