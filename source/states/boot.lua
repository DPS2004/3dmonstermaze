local state = {}

function state:init()

	print('boot init')
end

function state:update(dt)


end

function state:draw()
	pda:cls(1)
	pda:color(0)
	playdate.graphics.drawText(loc:get('boot1'),10,10)

end

return state