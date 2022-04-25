local state = {}

function state:init()
	self.timer = 0
	print('boot init')
end

function state:update(dt)
	self.timer = self.timer + dt
	
	if pda:btnp('a') then
		changestate('game')
	end
end

function state:draw()
	pda:cls(1)
	pda:color(0)
	pda:print(loc:get('boot1'),200,105,true)
	if self.timer > 300 then
		pda:print(loc:get('boot2'),200,125,true)
	end
end

return state