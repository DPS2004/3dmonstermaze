local pda = {}

function pda:setPlatform(x)
	self.platform = x
	print('set platform to ' .. x)
end

function pda:cls(c)
	if self.platform == 'playdate' then
		if c == 1 then
			playdate.graphics.clear(playdate.graphics.kColorWhite)
		else
			playdate.graphics.clear(playdate.graphics.kColorBlack)
		end
	end
end

function pda:newImage(i)
	if self.platform == 'playdate' then
		return playdate.graphics.image.new(i)
	end

end

function pda:color(c)
	if self.platform == 'playdate' then
		if c == 1 then
			playdate.graphics.setColor(playdate.graphics.kColorWhite)
		else
			playdate.graphics.setColor(playdate.graphics.kColorBlack)
		end
	end
end

function pda:circle(x,y,r)
	if self.platform == 'playdate' then
		playdate.graphics.drawCircleAtPoint(x,y,r)
	end
end

function pda:circfill(x,y,r)
	if self.platform == 'playdate' then
		playdate.graphics.fillCircleAtPoint(x,y,r)
	end
end


return pda