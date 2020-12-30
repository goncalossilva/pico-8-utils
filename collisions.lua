--TODO:adjust in context
--sprite flag to toggle blocks
flag_block=0

--TODO:adjust in context
--mechanics
--{{sp,x,y,collide?},..}
mcns={}

--TODO:adjust in context
--table of sprite to hitboxes
--{sp={{x,y,w,h},..},..}
custom_hitboxes={}

function sp_hitboxes(sp,x,y)
 local hbs=custom_hitboxes[sp]

 if not hbs then
  return {{x=x,y=y,w=8,h=8}}
 end

 local r={}
 for hb in all(hbs) do
  add(r,{
   x=hb[1]+x,
   y=hb[2]+y,
   w=hb[3],
   h=hb[4],
  })
 end
 return r
end

function sp_collisions_iter(
 sp,x,y,phb,flag
)
 if not fget(sp,flag) then
  return function() end
 end

 local hbs=sp_hitboxes(sp,x,y)
 local i=0
 return function()
  while i<#hbs do
   i+=1
   local hb=hbs[i]
   if intersects(phb,hb) then
    return hb
   end
  end
 end
end

function resolve_collisions(p)
 --p:{x,y,hitbox():{x,y,w,h}}

 local collisions={}

 local function add_colliding(
  sp,x,y,
  flag,phb,
  resolve_fn_args
 )
  for mhb in sp_collisions_iter(
   sp,x,y,phb,flag
  ) do
   local res_fn,res_args=
    resolve_fn_args(mhb)
   local x=intersect(phb,mhb)
   insert(
    collisions,
    {res_fn,res_args},
    x.w+x.h
   )
  end
 end

 --check colliding map tiles
 local phb=p:hitbox()
 local x1=phb.x
 local x2=phb.x+phb.w-1
 local y1=phb.y
 local y2=phb.y+phb.h-1
 for x in all({x1,x2}) do
  for y in all({y1,y2}) do
   local sp=mget(x/8,y/8)
   local tilex=x\8*8
   local tiley=y\8*8

   --block when colliding with
   --tiles that have flag_block
   add_colliding(
    sp,tilex,tiley,
    flag_block,
    phb,
    function(mhb)
     return block,{mhb,mhb,p}
    end
   )
 end

 --check colliding mechanics
 for mcn in all(mcns) do
  if mcn.collide then

   --invoke the mechanics'
   --collide() when flag_block
   add_colliding(
    mcn.sp,mcn.x,mcn.y,
    flag_block,
    phb,
    function(mhb)
     return mcn.collide,{mcn,mhb,p}B7
    end
   )
  end
 end

 --resolve collisions from the
 --most to least colliding
 while #collisions>0 do
  local r=pop(collisions)[1]
  local r_fn=r[1]
  r_fn(unpack(r[2]))
 end
end

--blocks p from intersecting cl,
--adjusting for specific hitboxes
--can be used as mcn.collide
--returns block direction
function block(cl,clhb,p)
 local phb=p:hitbox()
 local x=intersect(phb,clhb)

 --resolve using shallowest axis
 local aim=nil
 if x.w<x.h then
  aim=phb.x<cl.x and "⬅️" or "➡️"
 else
  aim=phb.y<cl.y and "⬆️" or "⬇️"
 end

 if aim=="⬅️" then
  p.dx=min(p.dx,0)
  p.x+=min(clhb.x-phb.x-phb.w,0)
  return aim
 elseif aim=="➡️" then
  p.dx=max(p.dx,0)
  p.x+=max(clhb.x+clhb.w-phb.x,0)
  return aim
 elseif aim=="⬆️" then
  p.dy=min(p.dy,0)
  p.y+=min(clhb.y-phb.y-phb.h,0)
  return aim
 elseif aim=="⬇️" then
  p.dy=max(p.dy,0)
  p.y+=max(clhb.y+clhb.h-phb.y,0)
  return aim
 end
end

--insert v in t and sort t by p
function insert(t,v,p)
 if #t>=1 then
  add(t,{})
  for i=(#t),2,-1 do
   local n=t[i-1]
   if p<n[2] then
    t[i]={v,p}
    return
   else
    t[i]=n
   end
  end
  t[1]={v,p}
 else
  add(t,{v,p})
 end
end

--pop first element of t
function pop(t)
 local top=t[1]
 for i=1,(#t) do
  if i==(#t) then
   del(t,t[i])
  else
   t[i]=t[i+1]
  end
 end
 return top
end

