pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
--misc
score=0
ss=7
l=3
fr=0
timer=0
done=0
--paddle
padx=52
pady=122
padw=23
padh=4
mp=3
--ball
ballx=65
bally=60
ballsize=3
ballxdir=2
ballydir=-2
cclr=15

--move padde, define walls
function movepaddle()
	if (btn(0) and padx>3) then
			padx-=mp
	elseif (btn(1) and padx<102) then
			padx+=mp
	end
end

function moveball()
 --walls
 if ((ballx<3) or (ballx>125)) then
  ballxdir*=-1
 end
 if (bally<15) then
  ballydir*=-1
 end
 --move ball  
 ballx+=ballxdir
	bally+=ballydir
end

function bounce()
 --fix: stop the repeat bounce bug
	if ballx>=padx+2 and
				ballx<=padx+padw+2 and
				bally>pady-5 
	then
	   ballydir*=-1
	   score+=1
	end
end

function lives()
 if bally>=125 
 then 
    l-=1
    ballx=64
    bally=30
 end
end

function eg()
 if l==0
 then
    --end game
    ballx=20
    bally=64
    ballxdir=0
    ballydir=0
    mp=0
    cclr=5
 end
end

function tim()
	--timer function
	if l!=0
 then
   --30 frames per second
 		fr+=1
			if fr==30 then
	    timer+=1
	    fr=0
  	end
 end
end

function levelup()
 --if the player gets enough 
 --score, make score yellow
 if score>=25 and 
    ss==7
 then
    ss=10 
 end
 
 --if player lives long enough
 --increase difficulty and let
 --player know via ball color
 if timer>=60 and done==0
 then
    cclr=10
    done=1
    if ballxdir>0 then 
         ballxdir+=1
    else ballxdir-=1
    end
    if ballydir>0 then
         ballydir+=1
    else ballydir-=1
    end
 end   
end

function _update()
	movepaddle()
	bounce()
	moveball()
	lives()
	tim()
	eg() 
 levelup()      
end

function _draw()
	rectfill(0,0,128,128,5)
	
	rectfill(0,0,128,9,1)
	
	print("score: ",1,3,ss)
	print(score,25,3,ss)
	print("time: ",50,3,7)
	print(timer,70,3,7)
	
	for i=1,l do
	 spr(001,85+i*10,0)
	end
	
	if l==0
	then print("game over",46,64,1)
	end
	
	rectfill(padx,pady,padx+padw,pady+padh,15)	
	
	circfill(ballx,bally,ballsize,cclr)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700088008800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000888888780000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700088888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000008888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
