local opt = vim.opt
local g = vim.g

-- Leader key
g.mapleader = " "

-- General Settings
opt.autowrite = true
opt.preserveindent = true
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
opt.confirm = true
opt.grepprg = "rg --vimgrep"
opt.mouse = "a"
opt.ruler = false
opt.showmode = false
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.virtualedit = "block"
opt.writebackup = false
opt.backup = false

-- UI Settings
opt.conceallevel = 2
opt.cursorlineopt = "number"
opt.cursorline = true
opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
opt.laststatus = 3
opt.linebreak = true
opt.number = true
opt.pumblend = 10
opt.pumheight = 10
opt.relativenumber = true
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.termguicolors = true
opt.winminwidth = 5
opt.wrap = false
opt.smoothscroll = true

-- Editing Behavior
opt.completeopt = { "menu", "menuone", "noselect" }
opt.softtabstop = 2
opt.expandtab = true
opt.ignorecase = true
opt.inccommand = "nosplit"
opt.list = true
opt.shiftround = true
opt.shiftwidth = 2
opt.shortmess:append("WcC")
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 2
opt.wildmode = "longest:full,full"

-- Folding
opt.foldlevel = 99
opt.foldmethod = "expr"
opt.foldtext = ""

-- Disable unused providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
