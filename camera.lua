cam={
 x=0,
 y=0,
 frms=7.5,
 shk=0,

 --x that is fixed on screen
 fixed_x=function(c,x)
  return c.x+x
 end,

 --y that is fixed on screen
 fixed_y=function(c,y)
  return c.y+y
 end,

 --x bound to camera grid but
 --not its specific position
 inv_x=function(c,x)
  return c.x+(x-c.x%128)
 end,

 --y bound to camera grid but
 --not its specific position
 inv_y=function(c,y)
  return c.y+(y-c.y%128)
 end,

 shake=function(c,shk)
  shk=shk or 1
  c.shk+=shk
 end,

 move=function(c,p,now)
  --p:{x,y}
  --now:false for smooth move
  if p then
   local f=now and 1 or c.frms
   c.x=mid(
    -64,
    c.x+(p.x-c.x-64)/f,
    map_width+64
   )
   c.y=mid(
    0,
    c.y+(p.y-c.y-64)/f,
    map_height-128
   )
   c.shk*=0.9
  else
   c.x=0
   c.y=0
   c.shk=0
  end
 end,

 draw=function(c)
  local x=c.x
  local y=c.y
  local shk=c.shk

  if shk>0 then
   local shkx=16-rnd(32)
   local shky=16-rnd(32)
   x+=shkx*shk
   y+=shky*shk
  end

  camera(x,y)
 end,
}
