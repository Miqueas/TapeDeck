local json = require("dkjson")
local cfile = nil
local cstr = ""
local cdata = nil
local conf = {
  user = false,
  path = {
    sys = "config.json",
    user = ("%s/.config/moonplayer/config.json"):format(os.getenv("HOME"))
  },
  _ = nil,
  __ = nil
}

function conf:open()
  if fexists(self.path.user) then
    self.user = true
    cfile = io.open(self.path.user, "r+")
    for l in cfile:lines() do cstr = cstr .. l .. "\n" end
    self._ = json.decode(cstr)
    cfile:close()
    cstr = ""
    cfile = io.open(self.path.sys, "r+")
    for l in cfile:lines() do cstr = cstr .. l .. "\n" end
    self.__ = json.decode(cstr)
    cfile:close()
    cstr = ""
  else
    cfile = io.open(self.path.sys, "r+")
    for l in cfile:lines() do cstr = cstr .. l .. "\n" end
    self._  = json.decode(cstr)
    self.__ = json.decode(cstr)
    cfile:close()
    cstr = ""
  end
end

function conf:get(key)
  if self._[key] then
    return self._[key]
  elseif self.__[key] then
    return self.__[key]
  else
    return log(nil, 'err', "La llave '%s' no existe.", key)
  end
end

function conf:set(key, val)
  self._[key] = val
end

function conf:write()
  if not fexists(self.path.user) then
    local home = os.getenv("HOME")
    exec("mkdir -p %s/.config/moonplayer/", home)
    exec("touch %s/.config/moonplayer/config.lua", home)
    cfile = io.open(self.path.user, "w+")
  else
    cfile = io.open(self.path.user, "w+")
  end

  cdata = json.encode(self._)
  cfile:write(cdata)
  cfile:close()
end

return conf