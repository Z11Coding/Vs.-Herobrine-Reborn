--easy configs--
missLimit = 30 --this is the miss limit, if you put the value 0 you will die instantly, so dont put 0
cantDie = true --if the value is true you can only die by the miss limit
showHealthBar = false --if the value is false the health bar will not be shown
textSize = 20 --da text size


--da code--
function onCreate()
	makeLuaText('limitText', 'Miss limit:', 185, -20, 459)
	--setTextAlignment('limitText', 'left')
	setObjectCamera('limitText', 'other')
	setTextSize('limitText', textSize)
	setProperty('limitText.alpha', 0)
	addLuaText('limitText')

	makeLuaText('limit', missLimit, 185, 60, 459)
	--setTextAlignment('limit', 'left')
	setObjectCamera('limit', 'other')
	setTextSize('limit', textSize)
	setProperty('limit.alpha', 0)
	addLuaText('limit')
end

function onUpdate()
	if misses >= missLimit then
		setProperty('health', 0)
	end
	if cantDie == true and misses <= missLimit then
    	if getProperty('health') <= 0.1 then
      	  setProperty('health', 0.025)
    	end
	end
	if showHealthBar == false then
		setProperty('healthBarBG.visible', false)
		setProperty('healthBar.visible', false)
		setProperty('iconP1.visible', false)
		setProperty('iconP2.visible', false)
	end

	local missesleft = missLimit - misses

	setTextString('limit', missesleft)
end

function onSongStart()
	doTweenAlpha('limitTextTween', 'limitText', 1, 0.5, linear)
	doTweenAlpha('limitTween', 'limit', 1, 0.3, linear)
end
