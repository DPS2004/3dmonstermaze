local loc = {
  lang = "en",
  json=nil
}
function loc:load(j)
  self.json = json.decodeFile(j)
end
function loc:setlang(l)
  self.lang = l
end
function loc:get(s,ins)
  
  local outstr = self.lang .. "."..s
  if self.json[s] then
    if self.json[s][self.lang] then
      outstr = self.json[s][self.lang]
    end
  end
  
  if ins then
    for i,v in ipairs(ins) do
      outstr = string.gsub(outstr,'@@'..tostring(i)..'@@',v)
    end
  end
  return outstr
end
return loc