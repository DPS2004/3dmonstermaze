import "CoreLibs/graphics"
import "CoreLibs/math"

pda = import "pda"

loc = import "loc"

pda:setPlatform('playdate')

loc:load('localization.json')



if pda.platform == 'playdate' then
	playdate.display.setRefreshRate(0)
end

--0 = lua
--1 = image
--2 = sample

statestoload = {
	boot = 0
}

gfxtoload = {
	
}

audiotoload = {
	
}



function loadassets(tb,cpath)
	local newtab = {}
	for k,v in pairs(tb) do
		if v == 0 then
			print('not on playdate, sorry!')
		elseif v == 1 then
			local txtpath = ''
			for _i,_v in ipairs(cpath) do
				txtpath = txtpath .. _v .. '/'
			end
			txtpath = txtpath ..k .. '.png'
			print('loading image '..txtpath)
			newtab[k] = pda:newImage(txtpath)
		elseif v == 2 then
			local txtpath = ''
			for _i,_v in ipairs(cpath) do
				txtpath = txtpath .. _v .. '/'
			end
			txtpath = txtpath ..k .. '.wav'
			print('loading audio '..txtpath)
			newtab[k] = playdate.sound.sampleplayer.new(txtpath)
		else
			local newcpath = {}
			for _i,_v in ipairs(cpath) do
				table.insert(newcpath,_v)
			end
			table.insert(newcpath,k)
				
			newtab[k] = loadassets(v,newcpath)
		end
	end
	return newtab
end

states = {
	boot = import 'states/boot'
}
gfx = loadassets(gfxtoload,{'gfx'})
audio = loadassets(audiotoload,{'audio'})


function changestate(s)
	cstate = s
	states[cstate]:init()
	states[cstate]:update(dt)
end

cstate = 'boot'
states[cstate]:init()


function playdate.update()
	dt = playdate.getElapsedTime() * 60
	playdate.resetElapsedTime()
	
	states[cstate]:update(dt)
	
	states[cstate]:draw()
end