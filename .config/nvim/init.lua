-- Plug
----------------------------------------------------------------------------------------
local Plug = vim.fn["plug#"]
vim.call("plug#begin")
Plug("jremmen/vim-ripgrep")
Plug("junegunn/fzf")
Plug("junegunn/fzf.vim")
Plug("neovim/nvim-lspconfig")
Plug("nvim-treesitter/nvim-treesitter")
Plug("sheerun/vim-polyglot")
Plug("stevearc/aerial.nvim")
Plug("tpope/vim-dispatch")
Plug("tpope/vim-fugitive")
Plug("tpope/vim-repeat")
Plug("tpope/vim-rhubarb")
Plug("tpope/vim-sensible")
Plug("tpope/vim-surround")
Plug("tpope/vim-unimpaired")
vim.call("plug#end")

-- Autocmd Functions
----------------------------------------------------------------------------------------
local function trim_trailing_whitespace(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)
  local new_lines = {}
  for i, line in ipairs(lines) do
    new_lines[i] = string.gsub(line, "%s+$", "", 1)
  end
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, new_lines)
end

vim.api.nvim_create_autocmd("BufWrite", {
  group = vim.api.nvim_create_augroup("OnBufWrite", { clear = true }),
  pattern = "*",
  callback = function(args)
    trim_trailing_whitespace(args.buf)
  end
})

-- Key mapping
----------------------------------------------------------------------------------------
-- Reverse the default backwards/forwards commands, so that "i" (to the left of the
-- keyboard) is backwards and "o" (to the right of the keyboard) is forwards.
vim.keymap.set("n", "<C-i>", "<C-o>")
vim.keymap.set("n", "<C-o>", "<C-i>")

-- FZF
vim.keymap.set("n", "<C-p>", vim.cmd.GFiles)

-- Add tab-completion to insert mode.
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

-- Language Server Protocol
----------------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("OnLspAttach", { clear = true }),
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<space>f", vim.lsp.buf.format, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
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

lspconfig.ruff.setup({})

lspconfig.fish_lsp.setup({})

-- Tree-sitter
----------------------------------------------------------------------------------------
require("nvim-treesitter.configs").setup = {
  ensure_installed = { "lua", "python" },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  }
}

-- Aerial
----------------------------------------------------------------------------------------
require("aerial").setup()

-- Configuration
----------------------------------------------------------------------------------------
vim.g.python_highlight_all = true

vim.o.background = "dark"
vim.o.colorcolumn = "+1"
vim.o.completeopt = "menu"
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.laststatus = 2
vim.o.number = true
vim.o.relativenumber = true
vim.o.shiftwidth = 0
vim.o.showmatch = true
vim.o.showtabline = 2
vim.o.softtabstop = -1
vim.o.spell = true
vim.o.spelllang = "en_gb"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.statusline = "%f%(%M%) %= %l,%c %p%%"
vim.o.swapfile = false
vim.o.tabline = "%!v:lua.TabLine()"
vim.o.termguicolors = true
vim.o.textwidth = 88
vim.o.winwidth = vim.o.textwidth + 1
vim.o.wrap = false

TabLine = function()
  local tl = ""
  for index = 1, vim.fn.tabpagenr("$") do
    local winnr = vim.fn.tabpagewinnr(index)
    local buflist = vim.fn.tabpagebuflist(index)
    local bufnr = buflist[winnr]
    local bufname = vim.fn.bufname(bufnr)

    if index == vim.fn.tabpagenr() then
      tl = tl .. "%#TabLineSel#"
    else
      tl = tl .. "%#TabLine#"
    end

    tl = tl .. "%" .. index .. "T"
    tl = tl .. index .. ":"

    if bufname == "" then
      tl = tl .. "[No Name]"
    else
      tl = tl .. vim.fn.fnamemodify(bufname, ":t")
    end

    tl = tl .. " "
  end
  tl = tl .. "%#TabLineFill#"
  return tl
end
