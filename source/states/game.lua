local state = {}

function state:init()
	print('game init')
	self.timer = 0
	self.map = {
		{1,1,1,1,1,1,1,1},
		{1,0,1,0,0,0,0,1},
		{1,0,1,0,0,0,0,1},
		{1,0,0,0,0,0,0,1},
		{1,0,0,0,0,0,0,1},
		{1,0,0,0,0,1,0,1},
		{1,0,0,0,0,0,0,1},
		{1,1,1,1,1,1,1,1}
	}
	self.player = {
		x=1.5,
		y=1.5,
		angle = playdate.getCrankPosition()
	}
end

function state:update(dt)
	self.timer = self.timer + dt
	if pda.platform == 'playdate' then
		local c,ac = playdate.getCrankChange()
		self.player.angle = self.player.angle + c
	end
	
	print(dt)
	local angleoffset = 0
	local domove = false
	if pda:btn('up') then
		domove = true
		angleoffset = 0
		if pda:btn('left') then
			angleoffset = -45
		elseif pda:btn('right') then
			angleoffset = 45
		end
	elseif pda:btn('down') then
		domove = true
		angleoffset = 180
		if pda:btn('left') then
			angleoffset = 225
		elseif pda:btn('right') then
			angleoffset = 135
		end
	else
		if pda:btn('left') then
			domove = true
			angleoffset = -90
		elseif pda:btn('right') then
			domove = true
			angleoffset = 90
		end
	end
	
	if domove then
		self.player.x = self.player.x + (math.sin((self.player.angle+angleoffset) * math.pi / 180))*dt*0.05
		self.player.y = self.player.y + (math.cos((self.player.angle+angleoffset) * math.pi / 180))*dt*-0.05
	end
	
end

function state:draw()
	pda:cls(1)
	--draw 2d map
	pda:color(1)
	pda:rectfill(0,0,64,64)
	pda:color(0)
	for y,yrow in ipairs(self.map) do
		for x,tile in ipairs(yrow) do
			if tile ==  1 then
				pda:rectfill((x-1)*8,(y-1)*8,7,7)
			end
		end
	end
	pda:color(0)
	pda:lineWidth(1)
	pda:circ(self.player.x*8,self.player.y*8,2)
	pda:circ(
		(2 * math.sin((self.player.angle) * math.pi / 180))+self.player.x*8,
		(0 - 2 * math.cos((self.player.angle) * math.pi / 180))+self.player.y*8,
		1
	)
end

return state