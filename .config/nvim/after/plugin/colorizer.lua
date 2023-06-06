local status, colorizer = pcall(require, 'colorizer')

if (not status) then
  print("Colorizer is not installed.")
  return
end

colorizer.setup()
