function tostring(any)
 if type(any)!="table" then
  return tostr(any)
 end
 local str="{"
 for k,v in pairs(any) do
  if (str!="{") str=str..","
  str..=tostring(k).."="..tostring(v)
 end
 return str.."}"
end

