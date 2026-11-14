-- Plug
----------------------------------------------------------------------------------------
local Plug = vim.fn["plug#"]
vim.call("plug#begin")
Plug("jremmen/vim-ripgrep")
Plug("junegunn/fzf")
Plug("junegunn/fzf.vim")
Plug("neovim/nvim-lspconfig")
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
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  if not vim.bo[bufnr].modifiable or vim.bo[bufnr].buftype ~= "" then
    return
  end

  local view = vim.fn.winsaveview()
  vim.api.nvim_buf_call(bufnr, function()
    vim.cmd([[silent keepjumps keeppatterns %s/\s\+$//e]])
  end)
  vim.fn.winrestview(view)
end

vim.api.nvim_create_autocmd("BufWritePre", {
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
vim.keymap.set("n", "<C-i>", "<C-o>", { desc = "Jump backward" })
vim.keymap.set("n", "<C-o>", "<C-i>", { desc = "Jump forward" })

-- FZF
vim.keymap.set("n", "<C-p>", function()
  if vim.fn.finddir(".git", ".;") ~= "" or vim.fn.findfile(".git", ".;") ~= "" then
    vim.cmd.GFiles()
    return
  end
  vim.cmd.Files()
end, { desc = "Find files (Git-aware)" })

-- Language Server Protocol
----------------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("OnLspAttach", { clear = true }),
  callback = function(args)
    vim.bo[args.buf].formatexpr = ""
    vim.keymap.set("n", "grd", vim.lsp.buf.definition, { buffer = args.buf, desc = "LSP definition" })
    vim.keymap.set("n", "grf", vim.lsp.buf.format, { buffer = args.buf, desc = "LSP format buffer" })
  end,
})

vim.lsp.config.fish_lsp = {
  cmd_env = { fish_lsp_show_client_popups = false },
}

vim.lsp.config.lua_ls = {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      semantic = { enable = false }
    },
  },
}

vim.lsp.config.yamlls = {
  settings = {
    yaml = {
      validate = true,
      hover = true,
      completion = true,
    },
  },
}

vim.lsp.enable({ "docker_language_server" })
vim.lsp.enable({ "fish_lsp" })
vim.lsp.enable({ "just" })
vim.lsp.enable({ "lua_ls" })
vim.lsp.enable({ "pyright" })
vim.lsp.enable({ "ruff" })
vim.lsp.enable({ "yamlls" })

-- Aerial
----------------------------------------------------------------------------------------
require("aerial").setup({
  keymaps = {
    ["{"] = false,
    ["}"] = false,
    ["[m"] = "actions.prev",
    ["]m"] = "actions.next",
  },
  on_attach = function(bufnr)
    vim.keymap.set("n", "[m", vim.cmd.AerialPrev, { buffer = bufnr, desc = "Aerial previous symbol" })
    vim.keymap.set("n", "]m", vim.cmd.AerialNext, { buffer = bufnr, desc = "Aerial next symbol" })
  end,
  post_jump_cmd = false,
})
vim.keymap.set("n", "<space>a", vim.cmd.AerialToggle, { desc = "Toggle Aerial" })

-- Configuration
----------------------------------------------------------------------------------------
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.python_highlight_all = true

vim.o.colorcolumn = "+1"
vim.o.completeopt = "menuone,noselect"
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
