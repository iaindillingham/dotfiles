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

-- Language Server Protocol
----------------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("OnLspAttach", { clear = true }),
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set("n", "grd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "grf", vim.lsp.buf.format, opts)
  end,
})

vim.lsp.config.fish_lsp = {
  cmd = { "fish-lsp", "start" },
  cmd_env = { fish_lsp_show_client_popups = false },
  filetypes = { "fish" },
  root_markers = { ".git" },
}

vim.lsp.config.lua_ls = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".git" },
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      semantic = { enable = false }
    },
  },
}

vim.lsp.config.pyright = {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { ".git" },
}

vim.lsp.config.ruff = {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { ".git" },
}

vim.lsp.config.yamlls = {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml" },
  root_markers = { ".git" },
  settings = {
    yaml = {
      format = {
        enable = true,
        validate = true,
        hover = true,
        completion = true,
      },
    },
  },
}

vim.lsp.enable({ "fish_lsp" })
vim.lsp.enable({ "lua_ls" })
vim.lsp.enable({ "pyright" })
vim.lsp.enable({ "ruff" })
vim.lsp.enable({ "ts_ls" })
vim.lsp.enable({ "yamlls" })

-- Tree-sitter
----------------------------------------------------------------------------------------
require("nvim-treesitter").setup = {
  ensure_installed = { "fish", "javascript", "just", "lua", "markdown", "markdown_inline", "python", "toml", "yaml" },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  }
}

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
    vim.keymap.set("n", "[m", vim.cmd.AerialPrev, { buffer = bufnr })
    vim.keymap.set("n", "]m", vim.cmd.AerialNext, { buffer = bufnr })
  end,
  post_jump_cmd = false,
})
vim.keymap.set("n", "<space>a", vim.cmd.AerialToggle)

-- Configuration
----------------------------------------------------------------------------------------
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.python_highlight_all = true

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
