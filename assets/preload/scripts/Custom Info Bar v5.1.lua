local botPlayScore = 0;
local totalPlayableNSustainNotes = 0;
local totalPlayableWSustainNotes = 0;
local calculationDone = false;
local tnh = 0;

--Made by Acap09
--Improved by Superpowers04 (on v3)
--Version 5.2: Bug Fix
--Last updated on 4th June 2022 on 7:25 PM (UTC+8)

--custom functions xD
function spriteExists(obj)
    if tonumber(getProperty(obj..'.alpha')) == nil then
	    return 'false'
	else
	    return 'true'
	end
end

--main part of script
function onStartCountdown()
	if not calculationDone then
		for i = 0, getProperty('unspawnNotes.length')-1 do
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
			    if not getPropertyFromGroup('unspawnNotes', i, 'isSustainNote') then
			        totalPlayableNSustainNotes = totalPlayableNSustainNotes + 1;
				end
				totalPlayableWSustainNotes = totalPlayableWSustainNotes + 1;
			end
		end
		calculationDone = true;
	end
	maxScore = totalPlayableNSustainNotes*350;
	totalNotes = totalPlayableWSustainNotes;
	
	makeLuaText('scoreTxtLua', 'Score: 0 | FC | Notes Hit: 0 | Combo: 0 | Health: 50% | Accuracy: ? (0%)', getTextWidth('scoreTxt'), getProperty('scoreTxt.x'), getProperty('scoreTxt.y'))
	addLuaText('scoreTxtLua')

	setTextSize('scoreTxtLua', getTextSize('scoreTxt'))
	setProperty('scoreTxt.visible', false)
end

function goodNoteHit(noteID, noteDir, noteType, noteSustain)
	if not noteSustain and not getPropertyFromGroup('notes', noteID, 'ignoreNote') then
		botPlayScore = botPlayScore + 350;
	end
	tnh = tnh + 1;
end

function onUpdatePost(elapsed)
	health = getProperty('health');
	healthPer = math.floor((health*50)*1000)/1000;
	accuracyLua = math.floor((rating*100)*1000)/1000;
	scorePer = math.floor((score/maxScore)*100000)/1000;
	missesTxtExist = spriteExists('missesTxt');
	tnhTxtExist = spriteExists('tnhTxt');

	setProperty('scoreTxtLua.x', getProperty('scoreTxt.x'))
	setProperty('scoreTxtLua.y', getProperty('scoreTxt.y'))
	setProperty('scoreTxtLua.scale.x', getProperty('scoreTxt.scale.x'))
	setProperty('scoreTxtLua.scale.y', getProperty('scoreTxt.scale.y'))
    
	if missesTxtExist == 'false' and tnhTxtExist == 'false' then
        setTextString('scoreTxtLua', (botPlay and 'Botplay Score: '..botPlayScore or 'Score: '..score)..'/'..maxScore..' ('..scorePer..'%)'..(not botPlay and ' |' or '')..(misses == 0 and not botPlay and ' FC' or botPlay and '' or ' Misses: '..misses)..' | Notes '..(botPlay and 'Disappeared' or 'Hit')..': '..tnh..' | Combo: '..getProperty('combo')..' | Health: '..healthPer..'%'..(not botPlay and ' | Accuracy: '..ratingName..' ('..accuracyLua..'%)' or ''))
	elseif missesTxtExist == 'true' and tnhTxtExist == 'true' then
        setTextString('scoreTxtLua', (botPlay and 'Botplay Score: '..botPlayScore or 'Score: '..score)..'/'..maxScore..' ('..scorePer..'%)'..(not botPlay and (misses == 0 and ' |' or '') or '')..(misses == 0 and not botPlay and ' FC' or '')..' | Combo: '..getProperty('combo')..' | Health: '..healthPer..'%'..(not botPlay and ' | Accuracy: '..ratingName..' ('..accuracyLua..'%)' or ''))
	elseif missesTxtExist == 'false' and tnhTxtExist == 'true' then
        setTextString('scoreTxtLua', (botPlay and 'Botplay Score: '..botPlayScore or 'Score: '..score)..'/'..maxScore..' ('..scorePer..'%)'..(not botPlay and ' |' or '')..(misses == 0 and not botPlay and ' FC' or botPlay and '' or ' Misses: '..misses)..' | Combo: '..getProperty('combo')..' | Health: '..healthPer..'%'..(not botPlay and ' | Accuracy: '..ratingName..' ('..accuracyLua..'%)' or ''))
	elseif missesTxtExist == 'true' and tnhTxtExist == 'false' then
	    setTextString('scoreTxtLua', (botPlay and 'Botplay Score: '..botPlayScore or 'Score: '..score)..'/'..maxScore..' ('..scorePer..'%)'..(not botPlay and ' |' or '')..' | Notes '..(botPlay and 'Disappeared' or 'Hit')..': '..tnh..' | Combo: '..getProperty('combo')..' | Health: '..healthPer..'%'..(not botPlay and ' | Accuracy: '..ratingName..' ('..accuracyLua..'%)' or ''))
	end
	
	setProperty('scoreTxtLua.color', getColorFromHex((health > 1.6 and '00FF00' or
		(health > 0.4 and health < 1.6 and (misses == 0 and not botPlay and 'C4FFC4' or 'FFFFFF')
		or (misses == 0 and not botPlay and 'FF5000' or 'FF0000')))))
end

--Text Display (non-FC and non-BotPlay): 'Score: num/num | Misses: num | Notes Hit: num | Combo: num | Health: num% | Accuracy: str (num%)'
--Text Display (FC and non-BotPlay): 'Score: num/num | FC | Notes Hit: num | Combo: num | Health: num% | Accuracy: str (num%)'
--Text Display (BotPlay): 'Botplay Score: num | Combo: num | Health: num% | Notes Disappeared: num'

