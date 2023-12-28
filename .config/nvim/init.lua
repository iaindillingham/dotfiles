local Plug = vim.fn["plug#"]
vim.call("plug#begin")
Plug("csexton/trailertrash.vim")
Plug("jremmen/vim-ripgrep")
Plug("junegunn/fzf")
Plug("junegunn/fzf.vim")
Plug("lifepillar/vim-solarized8", { branch = "neovim" })
Plug("neovim/nvim-lspconfig")
Plug("sheerun/vim-polyglot")
Plug("tpope/vim-commentary")
Plug("tpope/vim-dispatch")
Plug("tpope/vim-fugitive")
Plug("tpope/vim-repeat")
Plug("tpope/vim-rhubarb")
Plug("tpope/vim-sensible")
Plug("tpope/vim-surround")
Plug("tpope/vim-unimpaired")
Plug("vim-test/vim-test")
vim.call("plug#end")

vim.api.nvim_create_autocmd("BufWrite", {
  group = vim.api.nvim_create_augroup("OnBufWrite", { clear = true }),
  callback = function()
    vim.cmd("TrailerTrim")
  end
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("OnSqlFileType", { clear = true }),
  pattern = "sql",
  callback = function()
    vim.bo.commentstring = "-- %s"
  end
})

-- Reverse the default backwards/forwards commands, so that "i" (to the left of the
-- keyboard) is backwards and "o" (to the right of the keyboard) is forwards.
vim.keymap.set("n", "<C-i>", "<C-o>")
vim.keymap.set("n", "<C-o>", "<C-i>")

vim.keymap.set("n", "gT", ":TestFile<CR>")
vim.keymap.set("n", "gt", ":TestNearest<CR>")

vim.keymap.set("n", "<C-p>", vim.cmd.GFiles)
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)
vim.keymap.set("i", "<Tab>", function()
  local function is_pumvisible() return vim.fn.pumvisible() ~= 0 end

  local function is_empty(line) return string.len(line) == 0 end

  local function is_indented(line) return is_empty(string.gsub(line, " ", "")) end

  local current_line = vim.api.nvim_get_current_line()
  if not is_pumvisible() and (is_empty(current_line) or is_indented(current_line)) then
    return "<Tab>"
  else
    return "<C-n>"
  end
end, { expr = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("OnLspAttach", { clear = true }),
  callback = function(args)
    vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    vim.bo[args.buf].formatexpr = nil

    local opts = { buffer = args.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end
})

local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      semantic = { enable = false }
    }
  }
})

lspconfig.pylsp.setup({})

lspconfig.ruff_lsp.setup({})

lspconfig.tsserver.setup({})

vim.cmd.colorscheme("solarized8")

vim.o.background = "dark"
vim.o.colorcolumn = "+1"
vim.o.completeopt = "menu"
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.shiftwidth = 0
vim.o.showmatch = true
vim.o.softtabstop = -1
vim.o.spell = true
vim.o.spelllang = "en_gb"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.statusline = " %f%( %m%) %y %= %l,%c %p%% "
vim.o.swapfile = false
vim.o.termguicolors = true
vim.o.textwidth = 88
vim.o.winwidth = vim.o.textwidth + 1
vim.o.wrap = false

vim.g.python_highlight_all = true
vim.g["test#python#runner"] = "pytest"
vim.g["test#strategy"] = "dispatch"
