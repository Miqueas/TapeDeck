local unp = table.unpack or unpack

local LText = {
  ns = 'en',
  reg = { en = {} }
}

function LText:new(name)
  if name then
    self.ns = name
    self.reg[name] = {}
  end
  return self
end

function LText:switch(name)
  local ns = log(name,'err', "namespace not specified")
  log(self.reg[name], "namespace '%s' does not exists", name)
  self.ns = ns
end

function LText:set(key, val)
  log(val, 'warn', "value for '%s' was not set", key)
  self.reg[self.ns][key] = val
end

function LText:get(key)
  local str = log(self.reg[self.ns][key], 'err', "key '%s' does not exist in this namespace", key)
  return str
end

function LText:namespace() return self.ns end

function LText:list()
  local ls = {}
  for k, v in pairs(self.reg) do table.insert(ls, k) end
  return ls
end

function LText:load(name, filename)
  local data = dofile(filename)
  self.reg[name] = data
end

local meta = {
  __call = function (self, key, val, ...)
    local rstr = self:get(key)
    local fstr = rstr:format(...)
    return fstr
  end,
  __index = function (self, key, val)
    if val then self:set(key, val)
    else return self:get(key) end
  end,
  __len = function (self) return self:list() end
}

setmetatable(LText, meta)

return LText