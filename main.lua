--- @since 26.9.1

local P = require("zeppelin")

local M = {}

function M:peek(job)
  local volume = P.volume_number(tostring(job.file.url))
  if volume and volume > 1 then
    return ya.preview_widget(job, ui.Text(ui.Line { ui.Span("\u{f1c6} Multi-volume part " .. volume) }):area(job.area))
  end
  local out = Command("7zz")
    :arg({ "l", "-slt", "-sccUTF-8", tostring(job.file.path) })
    :stdin(Command.NULL)
    :stdout(Command.PIPED)
    :stderr(Command.PIPED)
    :output()

  local text = out and out.stdout .. out.stderr or ""
  if text:find("Enter password", 1, true) or (out and not out.status.success and text:find("Can not open the file as", 1, true)) then
    return ya.preview_widget(job, ui.Text(ui.Line { ui.Span("\u{f023} Filename(s) encrypted") }):area(job.area))
  end

  return require("archive"):peek(job)
end

function M:seek(job)
  local volume = P.volume_number(tostring(job.file.url))
  if not volume or volume <= 1 then
    require("archive"):seek(job)
  end
end

return M
