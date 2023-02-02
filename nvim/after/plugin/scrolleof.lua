local status_ok, scrollEOF = pcall(require, "scrollEOF")
if not status_ok then
  return
end

require('scrollEOF').setup({})
