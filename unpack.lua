--unpacks string of map to array
--e.g.,"22|0,1,8,3;8,1,8,3"
function unpack_map_to_array(ls)
 local r={}
 for s in all(ls) do
  local item=split(s,"|")
  local k=item[1]
  local v=item[2]
  r[k]={}
  for t in all(split(v,";")) do
   add(r[k], split(t))
  end
 end
 return r
end

