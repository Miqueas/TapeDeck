function exec(cmd, ...)
  if ... then
    os.execute(cmd:format(...))
  else
    os.execute(cmd)
  end
end

function fexists(fname)
  local f = io.open(fname, "r")

  if not f then
    return false
  else
    f:close()
    return true
  end
end

function log(exp, mode, msg, ...)
  local warnt  = "[MoonPlayer] Warnning: %s"
  local errt   = "[MoonPlayer] Error: %s"
  local infot  = "[MoonPlayer] Info: %s"
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

function strToBool(str)
  if str == "true" then return true
  elseif str == "false" then return false
  else return nil end
end