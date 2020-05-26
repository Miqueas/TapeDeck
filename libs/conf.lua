local yaml = require("lyaml")
local cfile = nil
local cstr = ""
local cdata = nil
local conf = {
  path = {
    sys = "config.yaml",
    user = ("%s/.config/moonplayer/config.yaml"):format(os.getenv("HOME"))
  },
  _ = nil,
  __ = nil
}

function conf:load()
  if fexists(self.path.user) then
    cfile = io.open(self.path.user, "r+")
    for l in cfile:lines() do cstr = cstr .. l .. "\n" end
    self._ = yaml.load(cstr)
    cfile:close()
    cstr = ""
    cfile = io.open(self.path.sys, "r+")
    for l in cfile:lines() do cstr = cstr .. l .. "\n" end
    self.__ = yaml.load(cstr)
    cfile:close()
    cstr = ""
  else
    cfile = io.open(self.path.sys, "r+")
    for l in cfile:lines() do cstr = cstr .. l .. "\n" end
    self._  = yaml.load(cstr)
    self.__ = yaml.load(cstr)
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

  cdata = yaml.dump({ self._ })
  cfile:write(yaml.dump({ self._ }))
  cfile:close()
end

return conf