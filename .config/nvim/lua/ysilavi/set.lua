local opt = vim.opt

opt.guicursor = ""

opt.nu = true
opt.rnu = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true

opt.swapfile = false
opt.backup = false

opt.undodir = "/tmp/"
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true

opt.scrolloff = 16
opt.signcolumn = "no"
opt.isfname:append("@-@")

opt.updatetime = 50

-- opt.colorcolumn = "80"
