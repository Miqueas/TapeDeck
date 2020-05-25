function log(exp, mode, msg, ...)
  local warnt  = "[Logger] Warnning: %s"
  local errt   = "[Logger] Error: %s"
  local infot  = "[Logger] Info: %s"
  local msg    = msg:format(...)

  if not (exp) then
    if mode == "warn" then
      print(warnt:format(msg))
      return exp
    elseif mode == "err" then
      return error(errt:format(msg), 2)
    elseif mode == "info" then
      print(infot:format(msg))
      return exp
    end
  else
    return exp
  end
end