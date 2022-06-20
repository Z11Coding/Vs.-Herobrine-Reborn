local reverseTime = false
didskip = false

function onCreate()
	-- background shit

	--precacheImage('characters/bf_steve');
	--precacheImage('characters/Brin_Normal');
	--precacheImage('sky_blue');
	--precacheImage('sunset_sky');
	--precacheImage('night_sky');
	--precacheImage('backmc');
	--precacheImage('groundmc');
	--precacheImage('shrin');
	--precacheImage('RTXBrin');

	if (songName == 'No-Escape') then
		makeLuaSprite('bg1funnie', 'RTXBrin',-1270,300);
		setScrollFactor('bg1funnie', 0.99, 0.99);
		scaleObject('bg1funnie', 200,200);
		screenCenter('bg1funnie');
		addLuaSprite('bg1funnie', false);
	end

	if (songName == 'summon') then
		makeLuaSprite('bg1', 'sky_blue',-1270,300);
		setScrollFactor('bg1', 0.99, 0.99);
		scaleObject('bg1', 2,2);
		addLuaSprite('bg1', false);
	end
	
	if (songName == 'Final-Warning') then
		makeLuaSprite('bg1', 'sunset_sky',-1270,300);
		setScrollFactor('bg1', 0.99, 0.99);
		scaleObject('bg1', 2,2);
		addLuaSprite('bg1', false);
	end
	
	if (songName == 'No-Escape') then
		makeLuaSprite('bg1', 'night_sky',-1270,300);
		setScrollFactor('bg1', 0.99, 0.99);
		scaleObject('bg1', 2,2);
		addLuaSprite('bg1', false);
	end

	if (songName == 'crashlog') then
		makeLuaSprite('bg1', 'night_sky',-1270,300);
		setScrollFactor('bg1', 0.99, 0.99);
		scaleObject('bg1', 2,2);
		addLuaSprite('bg1', false);
	end

	makeLuaSprite('bg2', 'backmc', -1070, 1200);
	setScrollFactor('bg2', 0.99, 0.99);
	scaleObject('bg2', 1.7,2.7);
	addLuaSprite('bg2', false);

	makeLuaSprite('fg', 'groundmc',-300, 2100);
	setScrollFactor('fg', 0.99, 0.99);
	scaleObject('fg', 1.1,1,1);
	addLuaSprite('fg', false);

	makeAnimatedLuaSprite('thesummoning', 'Shrine', 600, 1000);
	addAnimationByPrefix('thesummoning', 'idle', 'shrine', 24, false);
	setScrollFactor('thesummoning', 0.99, 0.99);
	scaleObject('thesummoning', 2.6,2.6);
	addLuaSprite('thesummoning', false);

	makeLuaText('skip', 'Press Space to Skip Intro', 1270, 0, 200);
	addLuaText('skip');
	setTextSize('skip', 30)
	setObjectCamera('skip', 'other')

end

function onCreatePost()
	if (songName == 'Final-Warning') then
		setProperty('dad.color', getColorFromHex('fc9458'));
		setProperty('boyfriend.color', getColorFromHex('fc9458'));
		setproperty('dad.x', getProperty('dad.x') - 24000);
	end
	if (songName == 'No-Escape') then
		setProperty('dad.color', getColorFromHex('9bdaf7'));
		setProperty('boyfriend.color', getColorFromHex('70b7d8'));
		setProperty('thesummoning.color', getColorFromHex('f5fc97'));
	end
end

function onUpdate(elapsed)

	if curStep >= 0 then
		songPos = getSongPosition();
		local currentBeat = (songPos/1000)*(bpm/80);
		if (songName == 'Final-Warning') then
			doTweenY('dadTweenY', 'dad', 1200-310*math.sin((currentBeat*0.25)*math.pi),0.001);
		end
		if (songName == 'No-Escape') then
			doTweenY('dadTweenY', 'dad', 1200-310*math.sin((currentBeat*0.25)*math.pi),0.001);
			doTweenX('dadTweenX', 'dad', 1000-310*math.sin((currentBeat*0.42)*math.pi),0.001);
		end
		if (songName == 'Final-Warning') then
			setproperty('dad.x', getProperty('dad.x') - 24000);
			setProperty('dad.color', getColorFromHex('fc9458'));
			setProperty('boyfriend.color', getColorFromHex('fc9458'));
		end
	end
end

function onUpdatePost()
	if (songName == 'summon') then
		if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') and not getProperty('startingSong') and didskip == false then
				didskip = true
				removeLuaText('skip');
				setPropertyFromClass('Conductor', 'songPosition', 19889) -- it is counted by milliseconds, 1000 = 1 second
				setPropertyFromClass('flixel.FlxG', 'sound.music.time', getPropertyFromClass('Conductor', 'songPosition'))
				setProperty('vocals.time', getPropertyFromClass('Conductor', 'songPosition'))
		end
		if curStep > 239 then
			doTweenAlpha('skipfuera','skip',0,2,'linear')
		end
	end
	if (songName == 'Final-Warning') then
		setTextString('skip', 'Press Space to Skip Intro (RECCOMMENDED)');
		if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') and not getProperty('startingSong') and didskip == false then
				didskip = true
				removeLuaText('skip');
				setPropertyFromClass('Conductor', 'songPosition', 18000) -- it is counted by milliseconds, 1000 = 1 second
				setPropertyFromClass('flixel.FlxG', 'sound.music.time', getPropertyFromClass('Conductor', 'songPosition'))
				setProperty('vocals.time', getPropertyFromClass('Conductor', 'songPosition'))
		end
		if curStep > 256 then
			doTweenAlpha('skipfuera','skip',0,2,'linear')
			didskip = true
		end
	end
	if (songName == 'No-Escape') then
		if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') and not getProperty('startingSong') and didskip == false then
				didskip = true
				removeLuaText('skip');
				setPropertyFromClass('Conductor', 'songPosition', 37959) -- it is counted by milliseconds, 1000 = 1 second
				setPropertyFromClass('flixel.FlxG', 'sound.music.time', getPropertyFromClass('Conductor', 'songPosition'))
				setProperty('vocals.time', getPropertyFromClass('Conductor', 'songPosition'))
		end
		if curStep > 495 then
			doTweenAlpha('skipfuera','skip',0,2,'linear')
			didskip = true
		end
	end

	if (songName == 'crashlog') then
		if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') and not getProperty('startingSong') and didskip == false then
				didskip = true
				removeLuaText('skip');
				setPropertyFromClass('Conductor', 'songPosition', 18461) -- it is counted by milliseconds, 1000 = 1 second
				setPropertyFromClass('flixel.FlxG', 'sound.music.time', getPropertyFromClass('Conductor', 'songPosition'))
				setProperty('vocals.time', getPropertyFromClass('Conductor', 'songPosition'))
		end
		if curStep > 239 then
			doTweenAlpha('skipfuera','skip',0,2,'linear')
			didskip = true
		end
	end
end

function onBeatHit()
	if curBeat % 1 == 0 then
		objectPlayAnimation('thesummoning', 'idle', true);
	end
end
