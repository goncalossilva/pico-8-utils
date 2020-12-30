function fadepal(perc,pal_p)
 --perc:0 normal,
 --     1 is completely dark
 --pal_p:0 use for draw ops,
 --      1 set for screen

 local p=flr(mid(0,perc,1)*100)

 --table for pallete shifting
 local dpal={
  0,1,1,2,1,13,6,4,
  4,9,3,13,1,13,14
 }

 for j=1,15 do
  local col=j

  --this is a messy formula and
  --not science. when kmax
  --reaches 5 every color turns
  --black.
  local kmax=(p+(j*1.46))/22
  for k=1,kmax do
   col=dpal[col]
  end

  pal(j,col,pal_p)
 end
end

