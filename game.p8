pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
--variables

function __init()
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
		mac_dy=3,
		acc=0.5,
		boost=4,
		anim=0,
		running = false,
		jumping = false,
		falling = false,
		sliding = false,
		landed = false
	}
end


-->8
--update and draw

function _draw()
	cls()
	map(0,0)
	spr(player.sp,player.x,player.y,1,1,player.flp)
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
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
7171000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7171000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7171000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7171000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7171000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7171000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7171000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7171000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7071000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7070000000000000000000000000000061606061610000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7070000000000000000000000000000000717100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7070000000565656560000006161616161717100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7070000056564445566500000070007000717100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7070000044435353434500000070007000717100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4041434041535353535342404142404042424242424200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5050505050505350505050505050505051515151515100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
