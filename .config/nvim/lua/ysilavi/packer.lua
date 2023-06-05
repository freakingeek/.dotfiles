local status, packer = pcall(require, 'packer')

if (not status) then
    print("Packer is not installed.")
    return
end

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'ellisonleao/gruvbox.nvim'
  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  
  use {
  	'nvim-telescope/telescope.nvim', tag = '0.1.1',
  	requires = { {'nvim-lua/plenary.nvim'} }
  }
  
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  use {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  requires = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},             -- Required
    {                                      -- Optional
      'williamboman/mason.nvim',
      run = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    {'williamboman/mason-lspconfig.nvim'}, -- Optional

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},     -- Required
    {'hrsh7th/cmp-nvim-lsp'}, -- Required
    {'L3MON4D3/LuaSnip'},     -- Required
  }
}
end)
