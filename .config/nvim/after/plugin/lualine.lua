local status, lualine = pcall(require, 'lualine')

if (not status) then
    print("lualine is not installed.")
    return
end


lualine.setup {
  theme = auto,
  icons_enabled = true,
  disabled_filetypes = {},
  section_separators = { left = '', right = ''},
  component_separators = { left = '', right = ''},
}

