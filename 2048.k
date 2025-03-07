/ https://johnearnest.github.io/ok/ike/ike.html

pkey:0 2 4 8 16 32 64 128 256 512
pal:("#FFFCF5";"#FFEBB8";"#FFD98E";"#FFC366";"#FFA940";"#FF7A33";"#FA541C";"#D4380D";"#AD2102";"#730A02";"#D9F7BE";"#A0D911";"#5B8C00";"#237804";"#005000";"#002A00")

T:     30                             / tile size
D:     4 4                            / board dimensions
b:D#0								/ create board

srt:-4?*D; b[srt@0;srt@1]:2; b[srt@2;srt@3]:2;  / random initial grid
                 
h:w:   T*#b                           / set display size
dir:0


/ reverse list if dir=1, remove zeroes, then shift all over to left (merging if needed)
/ then unreverse list if it was reversed
sh:{{$[dir>0;|x;x]}[(){$[0=*|x; (-1_x),y+*|x; y=*|x ;(-1_x),(y+*|x),0; x,y]}/{x@?&x}$[dir>0;|x;x]]}

pad:{$[dir>0; / call sh, and brute force padding if need to fill out zeroes in grid (cause merge)
    (-*D)#(0,0,0,0,0,0,0,0,0,sh[x]);
     (*D)#(sh[x],0,0,0,0,0,0,0,0,0)]} 

lx:{dir::x;    / on side click, set dir=1 if right
    b:: pad'b; / main
    ite:(lee@1?#lee:&~,/b)@0; b::b[_ite%4;4!ite]:2} / create new 2 block

ux:{dir::x;    / on side click, set dir=1 if down
    b:: +pad'+b; / main but we send in flip, then unflip
    ite:(lee@1?#lee:&~,/b)@0; b::b[_ite%4;4!ite]:2} / create new 2 block

tile:: ,/'+,/'((2#T)#)'' +b      / draw the board as tiles
draw:: ,(0 0;pal;pkey'tile)