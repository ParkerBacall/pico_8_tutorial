pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
--variables

function _init()
--starts first music track
music(0)

	player={
		sp=1,
		x=59,
		y=59,
		w=8,
		h=8,
		flp=false,
		dx=0,
		dy=0,
		max_dx=2,
		max_dy=3,
		acc=0.5,
		boost=4,
		anim=0,
		running = false,
		jumping = false,
		falling = false,
		sliding = false,
		landed = false
	}
	
	gravity=0.3
	friction=0.85
	
	--simple camera
	cam_x=0
	
	--map limits
	map_start=0
	map_end=1024
	
end


-->8
--update and draw


function _update()
	player_update()
	player_animate()
	
	
	--simple camera
	cam_x=player.x-64+player.w/2
	if cam_x<map_start then
		cam_x=map_start
	end
	if cam_x>map_end-128 then
		cam_x=map_end-128
	end
	camera(cam_x,0)
end

function _draw()
	cls()
	map(0,0)
	spr(player.sp,player.x,player.y,1,1,player.flp)
end
-->8
--collisions

function collide_map(obj,aim,flag)
	--obj = table needs x,y,w,h
	--aim = left right up down
	
	local x=obj.x local y=obj.y
	local w=obj.w local h=obj.h
	
	local x1=0 local y1=0
	local x2=0 local y2=0
	
	if aim=="left" then
		x1=x-1 y1=y
		x2=x   y2=y+h-1
	
	elseif aim=="right" then
		x1=x+w   y1=y
		x2=x+w+1 y2=y+h-1 
	
	elseif aim=="up" then 
		x1=x+1   y1=y-1
		x2=x+w-1	y2=y
	
	elseif aim=="down" then
		x1=x   y1=y+h
		x2=x+w y2=y+h
	end
	
	--pixel to tile
	x1/=8 y1/=8
	x2/=8 y2/=8
	
	
	if fget(mget(x1,y1), flag)
	or fget(mget(x1,y2), flag)
	or fget(mget(x2,y1), flag)
	or fget(mget(x2,y2), flag) then
		return true
	else
		return false
	end

end
-->8
--player functions

function player_update()
	player.dy+=gravity
	player.dx*=friction
	
	if btn(0) then 
		printh('hit',"@clip")
			player.dx-=player.acc
			player.running=true
			player.flp=true
		end
	if btn(1) then 
		player.dx+=player.acc
		player.running=true
		player.flp=false
	end
	
	--slide
	if player.running
		and not btn(0)
		and not btn(1)
		and not player.falling
		and not player.jumping then 
			player.running=false
			player.sliding=true
	end
	
	--jump
	if btnp(5)
	and player.landed then 
		player.dy-=player.boost
		player.landed=false
	end

	--check collision up and down
	if player.dy>0 then
		player.falling=true
		player.landed=false
		player.jumping=false
		
		player.dy=limit_speed(player.dy, player.max_dy)
		
		if collide_map(player,"down",0) then
			player.landed=true
			player.falling=false
			player.dy=0
			player.y-=(player.y+player.h)%8
		end
		elseif player.dy<0 then
			player.jumping=true
			if collide_map(player,"up",1) then
				player.dy=0
			end	
	end	
	
	--check collison left and right
		if player.dx<0 then
		
			player.dx=limit_speed(player.dx,player.max_dx)
		
			if collide_map(player, "left", 1) then
				player.dx=0
			end
			elseif player.dx>0 then
				player.dx=limit_speed(player.dx,player.max_dx)
				if collide_map(player, "right", 1) then
					player.dx=0 
			end
		end	
		
		--stop sliding
		if player.sliding then 
			if abs(player.dx)<.2
			or player.running then
				player.dx=0
				player.sliding=false
			end
		end	

	player.x+=player.dx
	player.y+=player.dy
	
	--limit player to map
	if player.x<map_start then 
		player.x=map_start
	end
	if player.x>map_end-player.w then
		player.x=map_end-player.w
	end
	
end

function player_animate()
	if player.jumping then
		player.sp=7
	elseif player.falling then
		player.sp=8
	elseif player.sliding then 
		player.sp=9
	elseif player.running then
		if time()-player.anim>.1 then
			player.anim=time()
			player.sp+=1
			if player.sp>6 then
				player.sp=3
			end
		end
	else --idle
		if time()-player.anim>.3 then
			player.anim=time()
			player.sp+=1
			if player.sp>2 then
				player.sp=1
			end
		end	
	end
	
end

function limit_speed(num,maximum)
	return mid(-maximum,num,maximum)
end
__gfx__
0000000000aaaaa000aaaaa0000aaaaa000aaaaa000aaaaa000aaaaa000aaaaa100aaaaa00000000000000000000000000000000000000000000000000000000
0000000000111110001111100111111101011111100111111011111100111111011111110aaaaa00000000000000000000000000000000000000000000000000
0070070001f7efe001f7efe0100ff7ef101ff7ef011ff7ef010ff7ef010ff7ef000ff7ef01111100000000000000000000000000000000000000000000000000
0007700001fffff001fff2f0000ffff2000ffff2000ffff2000ffff2100ffff2000ffff21f7efe00000000000000000000000000000000000000000000000000
0007700000011000001111000f1110000f1110000f1110000f11100000111000000011001fff2f00000000000000000000000000000000000000000000000000
00700700001111000f0110f0000110000001100000011000000110000f0110000000110f001111f0000000000000000000000000000000000000000000000000
000000000f01d0f00001d0000110d000001d00000dd0100000d1000000d10000000001d00f011d00000000000000000000000000000000000000000000000000
0000000000100d0000100d000000d000001d00000000100000d100000d1000000000001d000011dd000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb00bbbb33bbbbbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000
3bbbbbbb3bbbbbbb3bbbb3bb3bbbbbbb0bbbb3343333b3b000000000000000000000000000000000000000000000000000000000000000000000000000000000
33bb3bbb33b444bb33bb33bb33bbbbbbbbbb334444433bbb00000000000000000000000000000000000000000000000000000000000000000000000000000000
4b3333b34b3444b34b3333b34b3bb3b3b3b3344454443bb300000000000000000000000000000000000000000000000000000000000000000000000000000000
4b3444444b3454444b34443446433444bb3444464444433b00000000000000000000000000000000000000000000000000000000000000000000000000000000
43444446434444464349444444443494b34444444444443b00000000000000000000000000000000000000000000000000000000000000000000000000000000
44444244444442444444244444944444b334f4444244443300000000000000000000000000000000000000000000000000000000000000000000000000000000
94444444944444444424444444444244b34444444449443300000000000000000000000000000000000000000000000000000000000000000000000000000000
44444444444444444444444444444444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
49444444494443444444449444444494000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
44444444444444444944444449444444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4444e444444444444444444444444444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
44444444444464444444474444444444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
49444944494444444477774444444444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
44444444444446444444444244444442000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
44444444444444444444444444444444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbb3bbbbbbb3bb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbb3bbbbbbb3bbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b3bbbbbbb3bbbbbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bb3bbbbbbb3bbbbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
003bb300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
003bb300003bb3000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
003bb300003bb3000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0033b3000033b3000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
003bb300003bb3000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
003bb300003bb3000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
003b3300003b33000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
003bb300003bb3000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
003bb300003bb3000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003030303030300000000000000000000030303030000000000000000000000000101000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
7171000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7171000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7171000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000071000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7171000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007171000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7171000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007100000000000000000000000000000000000000000000000000000000000000000000000052525252565656566159000000000000000000000000000000000000000000000000
7171000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007171000000000000000000000000000000000000000000000000000000000000000000000000000000000000610000000000000000000000000000000000000000000000000000
7171000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000071000000000000000000000000000000000000000000000000000000000000000000000000000000000061560000000000000000000000000000000000000000000000000000
7171000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000071000000000000000000000000000000000000000000000000000000000000000000000000000000006100005252525200000000000000000000000000000000000000000000
7071000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000071000000000000000000000000000000000000000000000000000000000000000000000000480000610000000000000000000000000000000000000000000000000000000000
7070000000000000000000000000000061606061610000000000000000000000000000616060616100000000000000000000616060616100000071000000000000616060616100000000000000000000616060616100000000000000000000484861484848000000000000000000616060616100000000000000000000000000
7070000000000000000000000000000000717100000000000000000000000000000000007171000000000000000000000000007171000000000071000000000000007171000000000000444343450000007171000000000000000000000000486148480000000000000000000000007171000000000000000000000000000000
7070000000565656560000006161616161717100000000000000000000000061616161617171000000000000000061616161617171000000000071000061616161617171000000000044535353534547477171000000000000000048484848614848000000000000000061616161617171000000000000000000000000000000
7070000056564445566500000070007000717100000000000000000000000000700070007171000000000000000000700070007171000000000071000000700070007171000000444352535353535345007171000000000000000048484861484848000000000000000000700070007171000000000000000000000000000000
7070000044435353434500000070007000717100000000000000000000000000700070007171000000000000000000700070007171000000000071000000700070007171000044535353535353535353457171000000000000000000486148484848480000000000000000700070007171000000000000000000000000000000
4041434041535353535342404142404042424242424243434343434343434241424040424242424242434343434341424040424242424242434343434341424040424242424253535353535353535353534242424242434343434341424040424242424242434343434341424040424242424242434343434342434343434341
5050505050505250505050505050505051515151515150505050525050505050505050515151515151505050505250505050515151515151505050505250505050515151515151505050505250505050515151515151505050505250505050515151515151505050505250505050515151515151505050505251505050505253
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000053535353535353535353535353535353535353535353535353535353535353535353535353535353535353
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000053535353535353535353535353535353535353535353535353535353535353535353535353535353535353
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000053535353535353535353535353535353535353535353535353535353535353535353535353535353535353
__sfx__
000100000000000000060500605006050090500f050140501a0501d0501d0501c0501c0501c05019050170501605014050120500f0500d0500d0501005014050170501a050000001d0501d0501d0500d05000000
0110000000000000000d0500d050000000d05010050100500000000000100500000010050110500f0500f05000000000000e05010050100501205000000000000c050000001b0500f050000000c0500000000000
001000000000000000000001c050000000000000000000001505009050000000000000000000000f0500f05000000000000000000000000000f0500000000000000000f0500000000000000000f0500000000000
00100000000000000000000000000000000000000000000000000000000000000000000001c0500000000000000001c0500000000000000001c050000001c05000000000000000000000000001c0500000000000
__music__
00 01024344
00 01024344
00 01020344
00 41020344
00 01020344
00 01024344
00 01024344
00 01024344
00 01024344
00 01020344
00 01020344
00 01020344

