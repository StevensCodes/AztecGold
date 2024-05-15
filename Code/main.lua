-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
--print (system.getInfo("model"))
--print (system.getInfo("architectureInfo"))

display.setStatusBar( display.HiddenStatusBar ) 

splash = display.newImage("Default.png", true)

splash.x = display.contentWidth / 2
splash.y = display.contentHeight / 2

function run()

--REMOVE SPLASH
splash:removeSelf()
splash = nil


audio.reserveChannels(16)

local a = {}

function setUpAudio()
--[[audio channels:

1 - soundTrack01
2 - introMusic
3 - menuMusic
4 - deathMusic
5 - finaleMusic

6 - myGuy
 
7 - otherGuys 1
8 - otherGuys 2
9 - otherGuys 3

11 - tentSound
12 - clickSoundMenu
13 - coinsSound

14 - other guy thud
15 - other guy thud
16 - other guy thud

--]]

	a.soundTrack01 = audio.loadSound("Theme Music 124 Half.wav")
	a.introMusic = audio.loadSound("Intro.wav")
	a.menuMusic = audio.loadSound("Menu Half.wav")
	a.deathMusic = audio.loadSound("Death.wav")
	a.finaleMusic = audio.loadSound("Menu Half.wav")


	a.pistolShot1 = nil
	a.pistolShot2 = nil
	a.pistolShot3 = nil
	a.pistolShot4 = nil

	a.rifleShot1 = nil
	a.rifleShot2 = nil
	a.rifleShot3 = nil
	a.rifleShot4 = nil

	a.granadeExplosion = audio.loadSound("Explosion Mix 1.wav")
	a.knifeMix1 = audio.loadSound("Knife Mix 1.wav")
	a.tomahawkMix1 = audio.loadSound("Tomahawk Mix 1.wav")
	a.crossbowMix1 = audio.loadSound("Crossbow Mix 1.wav")
	
	a.swingMix1 = audio.loadSound("Swing Mix 1.wav")
	a.swingMix2 = audio.loadSound("Swing Mix 2.wav")
	a.swingMix3 = audio.loadSound("Swing Mix 3.wav")
	a.swingMix4 = audio.loadSound("Swing Mix 4.wav")

	a.alabardMix1 = audio.loadSound("Alabard Mix 1.wav")

	a.coinsSound = audio.loadSound("Coins Mix 2.wav")
	a.tentSound1 = audio.loadSound("Tent 1.wav")
	a.tentSound2 = audio.loadSound("Tent 2.wav")

	a.clickSoundMenu = audio.loadSound("Click Mix 1.wav")
	
	--a.thud1 = nil
	--a.thud2 = nil
	--a.thud3 = nil
	
end

setUpAudio()


-- FPS

local t = {}

t.tTotal = 0
t.tTotalCounter = 0
t.t1 = 0
t.t2 = 0
t.tCounter = 1

--local tTemp = 0
--local FPSText = display.newText("", 240, 280, native.systemFont, 32)
--FPSText:setTextColor(150,150,150)

local fFrame = 1

-- FRAME RATE CONTROL
local f63 = 1


--IOS ONLY
--[[
if (display.contentScaleX < .51) then
	f63 = 1
else
	f63 = 2
end
--]]


-- END FPS


system.activate("multitouch")

-- the Canvas Size, basically 480 x 320
_W = display.contentWidth
_H = display.contentHeight

-- the Offscreen Bleed * -1, as they return negative values
_XB = display.screenOriginX * -1
_YB = display.screenOriginY * -1



-- VARIABLES

local v = {}

function setUpVariables()

	v.rightArmUp = 0
	v.moveIntoTent = 1
	v.wantOut = 0
	v.endOfWeaponsSelection = 0
	v.victorySequence = 1
	v.changeWeaponTo = nil
	v.changeWeaponFrom = nil
	v.playerCash = 100
	v.sumCash = 100
	v.playerHealth = 0
	v.playerHurt = 0
	v.dyingCounter = 1
	v.playerHurtDirection = 0
	v.victoryLetterCounter = 0
	v.cashFound = 0
	v.weaponMeetCounterOne = 0
	v.weaponMeetCounterTwo = 0
	v.myGuyHurtCounter = 0
	v.myGuyTorsoMoved = 0
	v.pyramidCounter = 1
	v.everPlayed = 0
	v.soundOn = 1
	v.musicOn = 1
	v.menuMusicPlaying = 0
	v.flareNum = 0
	v.levelCash = 0
	v.startOfLevel = 0
	v.healthChanged = 0
	v.tentMoveIntoX = 0
	v.endOfLevel = 0
	v.isPaused = false
	v.levelReached = 1
	v.levelPlaying = 1
	
end

setUpVariables()


-- MENU DISPLAY GROUP

local menuDisplayGroup = display.newGroup()

local b = {}
local sumDisplayGroup = display.newGroup()

function setUpMenuDisplayGroup()
	
	b.coinCounter = 1
	b.menuInCounter = 1
	b.enOrSp = 1

	b.menuBackground = display.newImage("Menu Background.png", true)
	b.aztecGoldLogoEn = display.newImage("Aztec Gold Logo En.png")
	b.aztecGoldLogoSp = display.newImage("Aztec Gold Logo Sp.png")
	b.chestLogo = display.newImage("Chest 1 Full Logo.png")
	b.myGuyLogo = display.newImage("My Guy Logo.png")
	b.otherGuyLogo = display.newImage("Other Guy Logo.png")

	b.playEn = display.newImage("Play En.png")
	b.playSp = display.newImage("Play Sp.png")
	b.optionsEn = display.newImage("Options En.png")
	b.optionsSp = display.newImage("Options Sp.png")

	b.facebookEn = display.newImage("Like Button.png")
		
	b.shine1 = display.newImage("Shine 1.png")
	--b.sumCoin = display.newImage("Gold Coin.png")
	b.sumCoin1 = display.newImage("Small Gold Coin 01.png")
	b.sumCoin2 = display.newImage("Small Gold Coin 02.png")
	b.sumCoin3 = display.newImage("Small Gold Coin 03.png")
	b.sumCoin4 = display.newImage("Small Gold Coin 04.png")
	b.sumCoin5 = display.newImage("Small Gold Coin 03.png")
	b.sumCoin6 = display.newImage("Small Gold Coin 02.png")
	
	
	menuDisplayGroup.isVisible = false

	menuDisplayGroup:insert(b.menuBackground)
	menuDisplayGroup:insert(b.aztecGoldLogoEn)
	menuDisplayGroup:insert(b.aztecGoldLogoSp)
	menuDisplayGroup:insert(b.chestLogo)
	menuDisplayGroup:insert(b.myGuyLogo)
	menuDisplayGroup:insert(b.otherGuyLogo)
	menuDisplayGroup:insert(b.shine1)
	menuDisplayGroup:insert(sumDisplayGroup)
	
	sumDisplayGroup:insert(b.sumCoin1)
	sumDisplayGroup:insert(b.sumCoin2)
	sumDisplayGroup:insert(b.sumCoin3)
	sumDisplayGroup:insert(b.sumCoin4)
	sumDisplayGroup:insert(b.sumCoin5)
	sumDisplayGroup:insert(b.sumCoin6)

	menuDisplayGroup:insert(b.facebookEn)
		
	b.facebookEn.x = 240
	b.facebookEn.y = 286 --248
	
	--b.sumCoin.x = -10
	--b.sumCoin.y = 11

	b.sumCoin1.x = -7
	b.sumCoin1.y = 11
	b.sumCoin2.x = -7
	b.sumCoin2.y = 11
	b.sumCoin3.x = -7
	b.sumCoin3.y = 11
	b.sumCoin4.x = -7
	b.sumCoin4.y = 11
	b.sumCoin5.x = -7
	b.sumCoin5.y = 11
	b.sumCoin6.x = -7
	b.sumCoin6.y = 11

	b.sumCoin1.isVisible = false
	b.sumCoin2.isVisible = false
	b.sumCoin3.isVisible = false
	b.sumCoin4.isVisible = false
	b.sumCoin5.isVisible = false
	b.sumCoin6.isVisible = false
	
	sumDisplayGroup.y = 235
	
	
	b.shine1.x = 1000
	
	b.menuBackground.x = _W / 2
	b.menuBackground.y = _H / 2

	b.aztecGoldLogoEn.x = 240
	b.aztecGoldLogoEn.y = 40

	b.aztecGoldLogoSp.x = 240
	b.aztecGoldLogoSp.y = 40
	
	b.chestLogo.x = 240
	b.chestLogo.y = 185
	
	b.myGuyLogo.x = 110
	b.myGuyLogo.y = 155
	
	b.otherGuyLogo.x = 380
	b.otherGuyLogo.y = 155
		
	menuDisplayGroup:insert(b.playEn)
	b.playEn.x = 100
	b.playEn.y = 285

	menuDisplayGroup:insert(b.playSp)
	b.playSp.x = 100
	b.playSp.y = 285

	menuDisplayGroup:insert(b.optionsEn)
	b.optionsEn.x = 380
	b.optionsEn.y = 285

	menuDisplayGroup:insert(b.optionsSp)
	b.optionsSp.x = 380
	b.optionsSp.y = 285
	
end

setUpMenuDisplayGroup()


-- OPTIONS DISPLAY GROUP

local optionsDisplayGroup = display.newGroup()


function setUpOptionsDisplayGroup()

	b.optionsBackground = display.newImage("Menu Background.png", true)
	b.optionsReturnButtonEn = display.newImage("Return En.png")
	b.optionsReturnButtonSp = display.newImage("Return Sp.png")
	b.englishEn = display.newImage("English En.png")
	b.spanishSp = display.newImage("Spanish Sp.png")
	b.exitEn = display.newImage("Exit En.png")
	b.exitSp = display.newImage("Exit Sp.png")
	b.tel = display.newImage("Tel.png")
	b.speaker = display.newImage("Speaker.png")
	b.speakerOff = display.newImage("Speaker Off.png")
	b.music = display.newImage("Music Note.png")
	b.musicOff = display.newImage("Speaker Off.png")

	
	
	optionsDisplayGroup.isVisible = false

	optionsDisplayGroup:insert(b.optionsBackground)
	optionsDisplayGroup:insert(b.englishEn)
	optionsDisplayGroup:insert(b.spanishSp)	
	optionsDisplayGroup:insert(b.exitEn)
	optionsDisplayGroup:insert(b.exitSp)
	optionsDisplayGroup:insert(b.tel)
	optionsDisplayGroup:insert(b.speaker)
	optionsDisplayGroup:insert(b.speakerOff)
	optionsDisplayGroup:insert(b.music)
	optionsDisplayGroup:insert(b.musicOff)
	
	b.optionsBackground.x = _W / 2
	b.optionsBackground.y = _H / 2

	optionsDisplayGroup:insert(b.optionsReturnButtonEn)
	b.optionsReturnButtonEn.x = 230
	b.optionsReturnButtonEn.y = 280

	optionsDisplayGroup:insert(b.optionsReturnButtonSp)
	b.optionsReturnButtonSp.x = 230
	b.optionsReturnButtonSp.y = 280
	
	b.englishEn.x = _W / 2 - 100
	b.englishEn.y = 70
	
	b.spanishSp.x = _W / 2 + 100 
	b.spanishSp.y = 70

	b.exitEn.x = 340
	b.exitEn.y = 180
	
	b.exitSp.x = 340
	b.exitSp.y = 180

	b.tel.x = 420
	b.tel.y = 180
	
	b.speaker.x = 100
	b.speaker.y = 180
	
	b.speakerOff.x = 100
	b.speakerOff.y = 180

	b.music.x = 190
	b.music.y = 180
	
	b.musicOff.x = 190
	b.musicOff.y = 180
	
end

setUpOptionsDisplayGroup()


-- SELECT COLORS DISPLAY GROUP

local selectColorsDisplayGroup = display.newGroup()


function setUpSelectColorsDisplayGroup()

	b.selectColorsBackground = display.newImage("Menu Background.png", true)
	b.selectColorsEn = display.newImage("Select Colors En.png")
	b.selectColorsSp = display.newImage("Select Colors Sp.png")
	b.selectColorsExit = display.newImage("Exit Colors.png")

	selectColorsDisplayGroup.isVisible = false

	selectColorsDisplayGroup:insert(b.selectColorsBackground)
	b.selectColorsBackground.x = _W / 2
	b.selectColorsBackground.y = _H / 2

	selectColorsDisplayGroup:insert(b.selectColorsEn)
	b.selectColorsEn.x = 240
	b.selectColorsEn.y = 30

	selectColorsDisplayGroup:insert(b.selectColorsSp)
	b.selectColorsSp.x = 240
	b.selectColorsSp.y = 30

	selectColorsDisplayGroup:insert(b.selectColorsExit)
	b.selectColorsExit.x = 424
	b.selectColorsExit.y = 296
	
	-- MYGUY
	
	b.myGuy = display.newGroup()
	b.leftArmGroup = display.newGroup()
	b.torsoGroup = display.newGroup()
	b.rightArmGroup = display.newGroup()
	b.shadow = display.newImage("Guy Shadow.png")
	
	
	b.leftArm1 = display.newImage("Left Arm Empty.png")
	b.leftArm2 = display.newImage("Left Arm Red.png")
	b.leftArm3 = display.newImage("Left Arm White.png")
	b.leftArm4 = display.newImage("Left Arm Blue.png")
	b.leftArm5 = display.newImage("Left Arm Black.png")
	b.leftArm6 = display.newImage("Left Arm Yellow.png")
	
	b.rightArm1 = display.newImage("Right Arm Empty.png")
	b.rightArm2 = display.newImage("Right Arm Red.png")
	b.rightArm3 = display.newImage("Right Arm White.png")
	b.rightArm4 = display.newImage("Right Arm Blue.png")
	b.rightArm5 = display.newImage("Right Arm Black.png")
	b.rightArm6 = display.newImage("Right Arm Yellow.png")

	b.leftLeg1 = display.newImage("Left Leg Empty.png")
	b.leftLeg2 = display.newImage("Left Leg Red.png")
	b.leftLeg3 = display.newImage("Left Leg White.png")
	b.leftLeg4 = display.newImage("Left Leg Blue.png")
	b.leftLeg5 = display.newImage("Left Leg Black.png")
	b.leftLeg6 = display.newImage("Left Leg Yellow.png")
	
	b.rightLeg1 = display.newImage("Right Leg Empty.png")
	b.rightLeg2 = display.newImage("Right Leg Red.png")
	b.rightLeg3 = display.newImage("Right Leg White.png")
	b.rightLeg4 = display.newImage("Right Leg Blue.png")
	b.rightLeg5 = display.newImage("Right Leg Black.png")
	b.rightLeg6 = display.newImage("Right Leg Yellow.png")

	b.torso2 = display.newImage("Torso Red.png")
	b.torso3 = display.newImage("Torso White.png")
	b.torso4 = display.newImage("Torso Blue.png")
	b.torso5 = display.newImage("Torso Black.png")
	b.torso6 = display.newImage("Torso Yellow.png")

	b.neck2 = display.newImage("Neck Red.png")
	b.neck3 = display.newImage("Neck White.png")
	b.neck4 = display.newImage("Neck Blue.png")
	b.neck5 = display.newImage("Neck Black.png")
	b.neck6 = display.newImage("Neck Yellow.png")

	b.belt2 = display.newImage("Belt Red.png")
	b.belt3 = display.newImage("Belt White.png")
	b.belt4 = display.newImage("Belt Blue.png")
	b.belt5 = display.newImage("Belt Black.png")
	b.belt6 = display.newImage("Belt Yellow.png")

	b.head1 = display.newImage("Head Red 1.png")
	b.head2 = display.newImage("Head Red 2.png")
	b.head3 = display.newImage("Head White 1.png")
	b.head4 = display.newImage("Head White 2.png")
	b.head5 = display.newImage("Head Blue 1.png")
	b.head6 = display.newImage("Head Blue 2.png")
	b.head7 = display.newImage("Head Black 1.png")
	b.head8 = display.newImage("Head Black 2.png")
	b.head9 = display.newImage("Head Yellow 1.png")
	b.head10 = display.newImage("Head Yellow 2.png")
	b.head11 = display.newImage("Head Black Outline.png")
	b.head12 = display.newImage("Head White Outline.png")
	b.head13 = display.newImage("Head Vegas 1.png")
	b.head14 = display.newImage("Head Vegas 2.png")
	b.head15 = display.newImage("Head Vegas 3.png")
	
	b.myGuyLeftFingers = display.newImage("My Guy Left Fingers.png")
	
	b.headSample = display.newImage("Head White Outline.png")
	b.torsoSample = display.newImage("Torso White.png")
	b.leftArmSample1 = display.newImage("Left Arm Empty.png")
	b.leftArmSample2 = display.newImage("Left Arm White.png")
	b.leftLegSample1 = display.newImage("Left Leg Empty.png")
	b.leftLegSample2 = display.newImage("Left Leg White.png")
	b.rightArmSample1 = display.newImage("Right Arm Empty.png")
	b.rightArmSample2 = display.newImage("Right Arm White.png")
	b.rightLegSample1 = display.newImage("Right Leg Empty.png")
	b.rightLegSample2 = display.newImage("Right Leg White.png")

	
	b.colorSquare111 = display.newImage("Color Square Red.png")
	b.colorSquare112 = display.newImage("Color Square White.png")
	b.colorSquare113 = display.newImage("Color Square Blue.png")
	b.colorSquare114 = display.newImage("Color Square Black.png")
	b.colorSquare115 = display.newImage("Color Square Yellow.png")
	
	b.colorSquare121 = display.newImage("Color Square Red.png")
	b.colorSquare122 = display.newImage("Color Square White.png")
	b.colorSquare123 = display.newImage("Color Square Blue.png")
	b.colorSquare124 = display.newImage("Color Square Black.png")
	b.colorSquare125 = display.newImage("Color Square Yellow.png")
	
	b.colorSquare211 = display.newImage("Color Square Red.png")
	b.colorSquare212 = display.newImage("Color Square White.png")
	b.colorSquare213 = display.newImage("Color Square Blue.png")
	b.colorSquare214 = display.newImage("Color Square Black.png")
	b.colorSquare215 = display.newImage("Color Square Yellow.png")
	
	b.colorSquare221 = display.newImage("Color Square Red.png")
	b.colorSquare222 = display.newImage("Color Square White.png")
	b.colorSquare223 = display.newImage("Color Square Blue.png")
	b.colorSquare224 = display.newImage("Color Square Black.png")
	b.colorSquare225 = display.newImage("Color Square Yellow.png")
	
	b.colorSquare311 = display.newImage("Color Square Red.png")
	b.colorSquare312 = display.newImage("Color Square White.png")
	b.colorSquare313 = display.newImage("Color Square Blue.png")
	b.colorSquare314 = display.newImage("Color Square Black.png")
	b.colorSquare315 = display.newImage("Color Square Yellow.png")
	
	b.colorSquare321 = display.newImage("Color Square Red.png")
	b.colorSquare322 = display.newImage("Color Square White.png")
	b.colorSquare323 = display.newImage("Color Square Blue.png")
	b.colorSquare324 = display.newImage("Color Square Black.png")
	b.colorSquare325 = display.newImage("Color Square Yellow.png")
	b.colorSquareX = display.newImage("Color Square Empty.png")
	
	
	b.pickSquare011 = display.newImage("Color Square Yellow.png")
	b.pickSquare012 = display.newImage("Color Square Black.png")
	b.pickSquare021 = display.newImage("Color Square Yellow.png")
	b.pickSquare022 = display.newImage("Color Square Black.png")
	b.pickSquare031 = display.newImage("Color Square Yellow.png")
	b.pickSquare032 = display.newImage("Color Square Black.png")
	
	b.pickSquare041 = display.newImage("Color Square Blue.png")
	b.pickSquare042 = display.newImage("Color Square Yellow.png")
	b.pickSquare051 = display.newImage("Color Square Blue.png")
	b.pickSquare052 = display.newImage("Color Square Yellow.png")
	b.pickSquare061 = display.newImage("Color Square Blue.png")
	b.pickSquare062 = display.newImage("Color Square Yellow.png")
	
	b.pickSquare071 = display.newImage("Color Square Blue.png")
	b.pickSquare072 = display.newImage("Color Square Red.png")
	b.pickSquare081 = display.newImage("Color Square Blue.png")
	b.pickSquare082 = display.newImage("Color Square Red.png")
	
	b.pickSquare091 = display.newImage("Color Square Red.png")
	b.pickSquare092 = display.newImage("Color Square White.png")
	b.pickSquare101 = display.newImage("Color Square Red.png")
	b.pickSquare102 = display.newImage("Color Square White.png")

	b.pickSquare111 = display.newImage("Color Square Blue.png")
	b.pickSquare112 = display.newImage("Color Square Black.png")
	
	b.pickSquare121 = display.newImage("Color Square Blue.png")
	b.pickSquare122 = display.newImage("Color Square Blue.png")
	b.pickSquare131 = display.newImage("Color Square Blue.png")
	b.pickSquare132 = display.newImage("Color Square White.png")
	b.pickSquare141 = display.newImage("Color Square Blue.png")
	b.pickSquare142 = display.newImage("Color Square White.png")
	
	b.pickSquare151 = display.newImage("Color Square Red.png")
	b.pickSquare152 = display.newImage("Color Square Black.png")
	
	b.pickSquare161 = display.newImage("Color Square Red.png")
	b.pickSquare162 = display.newImage("Color Square Red.png")

	b.pickSquare171 = display.newImage("Color Square Red.png")
	b.pickSquare172 = display.newImage("Color Square Yellow.png")
	b.pickSquare181 = display.newImage("Color Square Red.png")
	b.pickSquare182 = display.newImage("Color Square Yellow.png")
	
	b.pickSquare191 = display.newImage("Color Square Yellow.png")
	b.pickSquare192 = display.newImage("Color Square Yellow.png")
	
	b.pickSquare201 = display.newImage("Color Square Yellow.png")
	b.pickSquare202 = display.newImage("Color Square White.png")
	
	b.pickSquare211 = display.newImage("Color Square Black.png")
	b.pickSquare212 = display.newImage("Color Square Black.png")
	
	b.pickSquare221 = display.newImage("Color Square Black.png")
	b.pickSquare222 = display.newImage("Color Square White.png")
	b.pickSquare231 = display.newImage("Color Square Black.png")
	b.pickSquare232 = display.newImage("Color Square White.png")
	b.pickSquare241 = display.newImage("Color Square Black.png")
	b.pickSquare242 = display.newImage("Color Square White.png")
	b.pickSquare251 = display.newImage("Color Square Black.png")
	b.pickSquare252 = display.newImage("Color Square White.png")
	
	b.pickSquare261 = display.newImage("Color Square White.png")
	b.pickSquare262 = display.newImage("Color Square White.png")
	
	b.broadway = display.newImage("Broadway.png")
	b.lasVegas = display.newImage("Las Vegas.png")
	
	b.background1 = display.newImage("Color Square White.png")
	b.background2 = display.newImage("Color Square White.png")
	b.background3 = display.newImage("Color Square White.png")
	
	b.dot1 = display.newImage("Beam.png")
	b.dot2 = display.newImage("Beam.png")
	
	b.myGuy:insert(b.shadow)
	b.myGuy:insert(b.leftLeg1)
	b.myGuy:insert(b.leftLeg2)
	b.myGuy:insert(b.leftLeg3)
	b.myGuy:insert(b.leftLeg4)
	b.myGuy:insert(b.leftLeg5)
	b.myGuy:insert(b.leftLeg6)
	
	b.myGuy:insert(b.rightLeg1)
	b.myGuy:insert(b.rightLeg2)
	b.myGuy:insert(b.rightLeg3)
	b.myGuy:insert(b.rightLeg4)
	b.myGuy:insert(b.rightLeg5)
	b.myGuy:insert(b.rightLeg6)
	
	b.leftArmGroup:insert(b.leftArm1)
	b.leftArmGroup:insert(b.leftArm2)
	b.leftArmGroup:insert(b.leftArm3)
	b.leftArmGroup:insert(b.leftArm4)
	b.leftArmGroup:insert(b.leftArm5)
	b.leftArmGroup:insert(b.leftArm6)
	
	b.leftArmGroup:insert(b.myGuyLeftFingers)
	
		
	b.torsoGroup:insert(b.leftArmGroup)
	
	b.torsoGroup:insert(b.torso2)
	b.torsoGroup:insert(b.torso3)
	b.torsoGroup:insert(b.torso4)
	b.torsoGroup:insert(b.torso5)
	b.torsoGroup:insert(b.torso6)
	
	b.torsoGroup:insert(b.neck2)
	b.torsoGroup:insert(b.neck3)
	b.torsoGroup:insert(b.neck4)
	b.torsoGroup:insert(b.neck5)
	b.torsoGroup:insert(b.neck6)
	
	b.torsoGroup:insert(b.belt2)
	b.torsoGroup:insert(b.belt3)
	b.torsoGroup:insert(b.belt4)
	b.torsoGroup:insert(b.belt5)
	b.torsoGroup:insert(b.belt6)
	
	b.torsoGroup:insert(b.head1)
	b.torsoGroup:insert(b.head2)
	b.torsoGroup:insert(b.head3)
	b.torsoGroup:insert(b.head4)
	b.torsoGroup:insert(b.head5)
	b.torsoGroup:insert(b.head6)
	b.torsoGroup:insert(b.head7)
	b.torsoGroup:insert(b.head8)
	b.torsoGroup:insert(b.head9)
	b.torsoGroup:insert(b.head10)
	b.torsoGroup:insert(b.head11)
	b.torsoGroup:insert(b.head12)
	b.torsoGroup:insert(b.head13)
	b.torsoGroup:insert(b.head14)
	b.torsoGroup:insert(b.head15)
	
	b.rightArmGroup:insert(b.rightArm1)
	b.rightArmGroup:insert(b.rightArm2)
	b.rightArmGroup:insert(b.rightArm3)
	b.rightArmGroup:insert(b.rightArm4)
	b.rightArmGroup:insert(b.rightArm5)
	b.rightArmGroup:insert(b.rightArm6)	

	b.torsoGroup:insert(b.rightArmGroup)

	
	b.myGuy:insert(b.torsoGroup)
	
	selectColorsDisplayGroup:insert(b.myGuy)
	
	selectColorsDisplayGroup:insert(b.background1)
	selectColorsDisplayGroup:insert(b.background2)
	selectColorsDisplayGroup:insert(b.background3)
	
	selectColorsDisplayGroup:insert(b.headSample)
	selectColorsDisplayGroup:insert(b.torsoSample)
	selectColorsDisplayGroup:insert(b.leftArmSample1)
	selectColorsDisplayGroup:insert(b.leftArmSample2)
	selectColorsDisplayGroup:insert(b.leftLegSample1)
	selectColorsDisplayGroup:insert(b.leftLegSample2)
	selectColorsDisplayGroup:insert(b.rightArmSample1)
	selectColorsDisplayGroup:insert(b.rightArmSample2)
	selectColorsDisplayGroup:insert(b.rightLegSample1)
	selectColorsDisplayGroup:insert(b.rightLegSample2)
	
	selectColorsDisplayGroup:insert(b.colorSquare111)
	selectColorsDisplayGroup:insert(b.colorSquare112)
	selectColorsDisplayGroup:insert(b.colorSquare113)
	selectColorsDisplayGroup:insert(b.colorSquare114)
	selectColorsDisplayGroup:insert(b.colorSquare115)
		
	selectColorsDisplayGroup:insert(b.colorSquare121)
	selectColorsDisplayGroup:insert(b.colorSquare122)
	selectColorsDisplayGroup:insert(b.colorSquare123)
	selectColorsDisplayGroup:insert(b.colorSquare124)
	selectColorsDisplayGroup:insert(b.colorSquare125)
	
	selectColorsDisplayGroup:insert(b.colorSquare211)
	selectColorsDisplayGroup:insert(b.colorSquare212)
	selectColorsDisplayGroup:insert(b.colorSquare213)
	selectColorsDisplayGroup:insert(b.colorSquare214)
	selectColorsDisplayGroup:insert(b.colorSquare215)
	
	selectColorsDisplayGroup:insert(b.colorSquare221)
	selectColorsDisplayGroup:insert(b.colorSquare222)
	selectColorsDisplayGroup:insert(b.colorSquare223)
	selectColorsDisplayGroup:insert(b.colorSquare224)
	selectColorsDisplayGroup:insert(b.colorSquare225)
	
	selectColorsDisplayGroup:insert(b.colorSquare311)
	selectColorsDisplayGroup:insert(b.colorSquare312)
	selectColorsDisplayGroup:insert(b.colorSquare313)
	selectColorsDisplayGroup:insert(b.colorSquare314)
	selectColorsDisplayGroup:insert(b.colorSquare315)
	
	selectColorsDisplayGroup:insert(b.colorSquare321)
	selectColorsDisplayGroup:insert(b.colorSquare322)
	selectColorsDisplayGroup:insert(b.colorSquare323)
	selectColorsDisplayGroup:insert(b.colorSquare324)
	selectColorsDisplayGroup:insert(b.colorSquare325)
	selectColorsDisplayGroup:insert(b.colorSquareX)
	
	
	selectColorsDisplayGroup:insert(b.pickSquare011)
	selectColorsDisplayGroup:insert(b.pickSquare012)
	selectColorsDisplayGroup:insert(b.pickSquare021)
	selectColorsDisplayGroup:insert(b.pickSquare022)
	selectColorsDisplayGroup:insert(b.pickSquare031)
	selectColorsDisplayGroup:insert(b.pickSquare032)
	
	selectColorsDisplayGroup:insert(b.pickSquare041)
	selectColorsDisplayGroup:insert(b.pickSquare042)
	selectColorsDisplayGroup:insert(b.pickSquare051)
	selectColorsDisplayGroup:insert(b.pickSquare052)
	selectColorsDisplayGroup:insert(b.pickSquare061)
	selectColorsDisplayGroup:insert(b.pickSquare062)
	
	selectColorsDisplayGroup:insert(b.pickSquare071)
	selectColorsDisplayGroup:insert(b.pickSquare072)
	selectColorsDisplayGroup:insert(b.pickSquare081)
	selectColorsDisplayGroup:insert(b.pickSquare082)
	
	selectColorsDisplayGroup:insert(b.pickSquare091)
	selectColorsDisplayGroup:insert(b.pickSquare092)
	selectColorsDisplayGroup:insert(b.pickSquare101)
	selectColorsDisplayGroup:insert(b.pickSquare102)

	selectColorsDisplayGroup:insert(b.pickSquare111)
	selectColorsDisplayGroup:insert(b.pickSquare112)
	
	selectColorsDisplayGroup:insert(b.pickSquare121)
	selectColorsDisplayGroup:insert(b.pickSquare122)
	selectColorsDisplayGroup:insert(b.pickSquare131)
	selectColorsDisplayGroup:insert(b.pickSquare132)
	selectColorsDisplayGroup:insert(b.pickSquare141)
	selectColorsDisplayGroup:insert(b.pickSquare142)
	
	selectColorsDisplayGroup:insert(b.pickSquare151)
	selectColorsDisplayGroup:insert(b.pickSquare152)
	
	selectColorsDisplayGroup:insert(b.pickSquare161)
	selectColorsDisplayGroup:insert(b.pickSquare162)

	selectColorsDisplayGroup:insert(b.pickSquare171)
	selectColorsDisplayGroup:insert(b.pickSquare172)
	selectColorsDisplayGroup:insert(b.pickSquare181)
	selectColorsDisplayGroup:insert(b.pickSquare182)
	
	selectColorsDisplayGroup:insert(b.pickSquare191)
	selectColorsDisplayGroup:insert(b.pickSquare192)
	
	selectColorsDisplayGroup:insert(b.pickSquare201)
	selectColorsDisplayGroup:insert(b.pickSquare202)
	
	selectColorsDisplayGroup:insert(b.pickSquare211)
	selectColorsDisplayGroup:insert(b.pickSquare212)
	
	selectColorsDisplayGroup:insert(b.pickSquare221)
	selectColorsDisplayGroup:insert(b.pickSquare222)
	selectColorsDisplayGroup:insert(b.pickSquare231)
	selectColorsDisplayGroup:insert(b.pickSquare232)
	selectColorsDisplayGroup:insert(b.pickSquare241)
	selectColorsDisplayGroup:insert(b.pickSquare242)
	selectColorsDisplayGroup:insert(b.pickSquare251)
	selectColorsDisplayGroup:insert(b.pickSquare252)
	
	selectColorsDisplayGroup:insert(b.pickSquare261)
	selectColorsDisplayGroup:insert(b.pickSquare262)

	selectColorsDisplayGroup:insert(b.broadway)
	selectColorsDisplayGroup:insert(b.lasVegas)
	
	selectColorsDisplayGroup:insert(b.dot1)
	selectColorsDisplayGroup:insert(b.dot2)
	
	b.background1.x = 310
	b.background1.y = 100
	b.background1.alpha = .1
	b.background1.xScale = 5.5
	b.background1.yScale = 2.5
	
	b.background2.x = b.background1.x
	b.background2.y = 170
	b.background2.alpha = .1
	b.background2.xScale = 5.5
	b.background2.yScale = 2.5

	b.background3.x = b.background1.x
	b.background3.y = 240
	b.background3.alpha = .1
	b.background3.xScale = 5.5
	b.background3.yScale = 2.5
	

	b.headSample.xScale = .75
	b.headSample.yScale = .75
	b.torsoSample.xScale = .75
	b.torsoSample.yScale = .75
	b.leftArmSample1.xScale = .75
	b.leftArmSample1.yScale = .75
	b.leftArmSample2.xScale = .75
	b.leftArmSample2.yScale = .75
	b.leftLegSample1.xScale = .75
	b.leftLegSample1.yScale = .75
	b.leftLegSample2.xScale = .75
	b.leftLegSample2.yScale = .75
	b.rightArmSample1.xScale = .75
	b.rightArmSample1.yScale = .75
	b.rightArmSample2.xScale = .75
	b.rightArmSample2.yScale = .75
	b.rightLegSample1.xScale = .75
	b.rightLegSample1.yScale = .75
	b.rightLegSample2.xScale = .75
	b.rightLegSample2.yScale = .75

	
	b.headSample.x = 260
	b.headSample.y = 105
	b.torsoSample.x = 270
	b.torsoSample.y = 170
	b.leftArmSample1.x = 285
	b.leftArmSample1.y = 225
	b.leftArmSample2.x = b.leftArmSample1.x
	b.leftArmSample2.y = b.leftArmSample1.y
	b.leftLegSample1.x = 285
	b.leftLegSample1.y = 255
	b.leftLegSample2.x = b.leftLegSample1.x
	b.leftLegSample2.y = b.leftLegSample1.y
	b.rightArmSample1.x = 255
	b.rightArmSample1.y = 225
	b.rightArmSample2.x = b.rightArmSample1.x
	b.rightArmSample2.y = b.rightArmSample1.y
	b.rightLegSample1.x = 255
	b.rightLegSample1.y = 255
	b.rightLegSample2.x = b.rightLegSample1.x
	b.rightLegSample2.y = b.rightLegSample1.y


	b.colorSquare111.x = 320
	b.colorSquare112.x = b.colorSquare111.x
	b.colorSquare113.x = b.colorSquare111.x
	b.colorSquare114.x = b.colorSquare111.x
	b.colorSquare115.x = b.colorSquare111.x
		
	b.colorSquare211.x = b.colorSquare111.x
	b.colorSquare212.x = b.colorSquare111.x
	b.colorSquare213.x = b.colorSquare111.x
	b.colorSquare214.x = b.colorSquare111.x
	b.colorSquare215.x = b.colorSquare111.x
	
	b.colorSquare311.x = b.colorSquare111.x
	b.colorSquare312.x = b.colorSquare111.x
	b.colorSquare313.x = b.colorSquare111.x
	b.colorSquare314.x = b.colorSquare111.x
	b.colorSquare315.x = b.colorSquare111.x
		
	b.colorSquare121.x = 360
	b.colorSquare122.x = b.colorSquare121.x
	b.colorSquare123.x = b.colorSquare121.x
	b.colorSquare124.x = b.colorSquare121.x
	b.colorSquare125.x = b.colorSquare121.x
		
	b.colorSquare221.x = b.colorSquare121.x
	b.colorSquare222.x = b.colorSquare121.x
	b.colorSquare223.x = b.colorSquare121.x
	b.colorSquare224.x = b.colorSquare121.x
	b.colorSquare225.x = b.colorSquare121.x
	
	b.colorSquare321.x = b.colorSquare121.x
	b.colorSquare322.x = b.colorSquare121.x
	b.colorSquare323.x = b.colorSquare121.x
	b.colorSquare324.x = b.colorSquare121.x
	b.colorSquare325.x = b.colorSquare121.x
		
	b.colorSquare111.y = 100
	b.colorSquare112.y = b.colorSquare111.y
	b.colorSquare113.y = b.colorSquare111.y
	b.colorSquare114.y = b.colorSquare111.y
	b.colorSquare115.y = b.colorSquare111.y
		
	b.colorSquare121.y = b.colorSquare111.y
	b.colorSquare122.y = b.colorSquare111.y
	b.colorSquare123.y = b.colorSquare111.y
	b.colorSquare124.y = b.colorSquare111.y
	b.colorSquare125.y = b.colorSquare111.y
	
	b.colorSquare211.y = 170
	b.colorSquare212.y = b.colorSquare211.y
	b.colorSquare213.y = b.colorSquare211.y
	b.colorSquare214.y = b.colorSquare211.y
	b.colorSquare215.y = b.colorSquare211.y
	
	b.colorSquare221.y = b.colorSquare211.y
	b.colorSquare222.y = b.colorSquare211.y
	b.colorSquare223.y = b.colorSquare211.y
	b.colorSquare224.y = b.colorSquare211.y
	b.colorSquare225.y = b.colorSquare211.y
	
	b.colorSquare311.y = 238
	b.colorSquare312.y = b.colorSquare311.y
	b.colorSquare313.y = b.colorSquare311.y
	b.colorSquare314.y = b.colorSquare311.y
	b.colorSquare315.y = b.colorSquare311.y
		
	b.colorSquare321.y = b.colorSquare311.y
	b.colorSquare322.y = b.colorSquare311.y
	b.colorSquare323.y = b.colorSquare311.y
	b.colorSquare324.y = b.colorSquare311.y
	b.colorSquare325.y = b.colorSquare311.y
	
	b.colorSquareX.x = b.colorSquare111.x
	b.colorSquareX.y = b.colorSquare111.y
	

	b.pickSquare011.x = 78
	b.pickSquare012.x = b.pickSquare011.x
	b.pickSquare021.x = 117
	b.pickSquare022.x = b.pickSquare021.x
	b.pickSquare031.x = 156
	b.pickSquare032.x = b.pickSquare031.x
	
	b.pickSquare041.x = b.pickSquare011.x
	b.pickSquare042.x = b.pickSquare011.x
	b.pickSquare051.x = b.pickSquare021.x
	b.pickSquare052.x = b.pickSquare021.x
	b.pickSquare061.x = b.pickSquare031.x
	b.pickSquare062.x = b.pickSquare031.x
	
	b.pickSquare071.x = 59
	b.pickSquare072.x = b.pickSquare071.x
	b.pickSquare081.x = 98
	b.pickSquare082.x = b.pickSquare081.x
	
	b.pickSquare091.x = 137
	b.pickSquare092.x = b.pickSquare091.x
	b.pickSquare101.x = 176
	b.pickSquare102.x = b.pickSquare101.x

	b.pickSquare111.x = b.pickSquare071.x
	b.pickSquare112.x = b.pickSquare071.x
	
	b.pickSquare121.x = b.pickSquare081.x
	b.pickSquare122.x = b.pickSquare081.x
	b.pickSquare131.x = b.pickSquare091.x
	b.pickSquare132.x = b.pickSquare091.x
	b.pickSquare141.x = b.pickSquare101.x
	b.pickSquare142.x = b.pickSquare101.x
	
	b.pickSquare151.x = 20
	b.pickSquare152.x = b.pickSquare151.x
	
	b.pickSquare161.x = 59
	b.pickSquare162.x = b.pickSquare161.x

	b.pickSquare171.x = 98
	b.pickSquare172.x = b.pickSquare171.x
	b.pickSquare181.x = 137
	b.pickSquare182.x = b.pickSquare181.x
	
	b.pickSquare191.x = 176
	b.pickSquare192.x = b.pickSquare191.x
	
	b.pickSquare201.x = 215
	b.pickSquare202.x = b.pickSquare201.x
	
	b.pickSquare211.x = b.pickSquare151.x
	b.pickSquare212.x = b.pickSquare151.x
	
	b.pickSquare221.x = b.pickSquare161.x
	b.pickSquare222.x = b.pickSquare161.x
	b.pickSquare231.x = b.pickSquare171.x
	b.pickSquare232.x = b.pickSquare171.x
	b.pickSquare241.x = b.pickSquare181.x
	b.pickSquare242.x = b.pickSquare181.x
	b.pickSquare251.x = b.pickSquare191.x
	b.pickSquare252.x = b.pickSquare191.x
	
	b.pickSquare261.x = b.pickSquare201.x
	b.pickSquare262.x = b.pickSquare201.x



	b.pickSquare011.y = 79
	b.pickSquare012.y = b.pickSquare011.y
	b.pickSquare021.y = b.pickSquare011.y
	b.pickSquare022.y = b.pickSquare011.y
	b.pickSquare031.y = b.pickSquare011.y
	b.pickSquare032.y = b.pickSquare011.y
	
	b.pickSquare041.y = 114
	b.pickSquare042.y = b.pickSquare041.y
	b.pickSquare051.y = b.pickSquare041.y
	b.pickSquare052.y = b.pickSquare041.y
	b.pickSquare061.y = b.pickSquare041.y
	b.pickSquare062.y = b.pickSquare041.y
	
	b.pickSquare071.y = 149
	b.pickSquare072.y = b.pickSquare071.y
	b.pickSquare081.y = b.pickSquare071.y
	b.pickSquare082.y = b.pickSquare071.y
	
	b.pickSquare091.y = b.pickSquare071.y
	b.pickSquare092.y = b.pickSquare071.y
	b.pickSquare101.y = b.pickSquare071.y
	b.pickSquare102.y = b.pickSquare071.y

	b.pickSquare111.y = 184
	b.pickSquare112.y = b.pickSquare111.y
	
	b.pickSquare121.y = b.pickSquare111.y
	b.pickSquare122.y = b.pickSquare111.y
	b.pickSquare131.y = b.pickSquare111.y
	b.pickSquare132.y = b.pickSquare111.y
	b.pickSquare141.y = b.pickSquare111.y
	b.pickSquare142.y = b.pickSquare111.y
	
	b.pickSquare151.y = 219
	b.pickSquare152.y = b.pickSquare151.y
	
	b.pickSquare161.y = b.pickSquare151.y
	b.pickSquare162.y = b.pickSquare151.y

	b.pickSquare171.y = b.pickSquare151.y
	b.pickSquare172.y = b.pickSquare151.y
	b.pickSquare181.y = b.pickSquare151.y
	b.pickSquare182.y = b.pickSquare151.y
	
	b.pickSquare191.y = b.pickSquare151.y
	b.pickSquare192.y = b.pickSquare151.y
	
	b.pickSquare201.y = b.pickSquare151.y
	b.pickSquare202.y = b.pickSquare151.y
	
	b.pickSquare211.y = 254
	b.pickSquare212.y = b.pickSquare211.y
	
	b.pickSquare221.y = b.pickSquare211.y
	b.pickSquare222.y = b.pickSquare211.y
	b.pickSquare231.y = b.pickSquare211.y
	b.pickSquare232.y = b.pickSquare211.y
	b.pickSquare241.y = b.pickSquare211.y
	b.pickSquare242.y = b.pickSquare211.y
	b.pickSquare251.y = b.pickSquare211.y
	b.pickSquare252.y = b.pickSquare211.y
	
	b.pickSquare261.y = b.pickSquare211.y
	b.pickSquare262.y = b.pickSquare211.y


	
	b.pickSquare011.alpha = 1
	b.pickSquare012.alpha = .25
	b.pickSquare021.alpha = 1
	b.pickSquare022.alpha = .50
	b.pickSquare031.alpha = 1
	b.pickSquare032.alpha = .70
	
	b.pickSquare041.alpha = 1
	b.pickSquare042.alpha = .35
	b.pickSquare051.alpha = 1
	b.pickSquare052.alpha = .47
	b.pickSquare061.alpha = 1
	b.pickSquare062.alpha = .65
	
	b.pickSquare071.alpha = 1
	b.pickSquare072.alpha = .50
	b.pickSquare081.alpha = 1
	b.pickSquare082.alpha = .75
	
	b.pickSquare091.alpha = 1
	b.pickSquare092.alpha = .25
	b.pickSquare101.alpha = 1
	b.pickSquare102.alpha = .50

	b.pickSquare111.alpha = 1
	b.pickSquare112.alpha = .50
	
	b.pickSquare121.alpha = 1
	b.pickSquare122.alpha = 1
	b.pickSquare131.alpha = 1
	b.pickSquare132.alpha = .42
	b.pickSquare141.alpha = 1
	b.pickSquare142.alpha = .74
	
	b.pickSquare151.alpha = 1
	b.pickSquare152.alpha = .50
	
	b.pickSquare161.alpha = 1
	b.pickSquare162.alpha = 1

	b.pickSquare171.alpha = 1
	b.pickSquare172.alpha = .40
	b.pickSquare181.alpha = 1
	b.pickSquare182.alpha = .80
	
	b.pickSquare191.alpha = 1
	b.pickSquare192.alpha = 1
	
	b.pickSquare201.alpha = 1
	b.pickSquare202.alpha = .50
	
	b.pickSquare211.alpha = 1
	b.pickSquare212.alpha = 1
	
	b.pickSquare221.alpha = 1
	b.pickSquare222.alpha = .25
	b.pickSquare231.alpha = 1
	b.pickSquare232.alpha = .45
	b.pickSquare241.alpha = 1
	b.pickSquare242.alpha = .62
	b.pickSquare251.alpha = 1
	b.pickSquare252.alpha = .80
	
	b.pickSquare261.alpha = 1
	b.pickSquare262.alpha = 1
	

	b.broadway.x = 59
	b.broadway.y = 292
	b.broadway.alpha = .5

	b.lasVegas.x = 176
	b.lasVegas.y = 292
	b.lasVegas.alpha = .5
	
	b.dot1.x = 59
	b.dot1.y = 234
	b.dot1.xScale = .3
	b.dot1.yScale = .1
	b.dot1.alpha = .35

	b.dot2.x = 137
	b.dot2.y = 234
	b.dot2.xScale = .3	
	b.dot2.yScale = .1	
	b.dot2.alpha = .35
	
	
	b.colorToBeSelected = 1
	
	
	b.breatheCounter = 1
	
	b.bigSquare = 1
	
end


setUpSelectColorsDisplayGroup()


function zeroOutColorGuy()

	b.myGuy.x = 420
	b.myGuy.y = 180
	b.myGuy.xScale = -1.3
	b.myGuy.yScale = 1.3
	
	
	b.leftArmGroup.xReference = 0
	b.leftArmGroup.yReference = 0
	
	b.leftLeg1.xReference = 0
	b.leftLeg1.yReference = -10
	b.leftLeg2.xReference = 0
	b.leftLeg2.yReference = -10
	b.leftLeg3.xReference = 0
	b.leftLeg3.yReference = -10
	b.leftLeg4.xReference = 0
	b.leftLeg4.yReference = -10
	b.leftLeg5.xReference = 0
	b.leftLeg5.yReference = -10
	b.leftLeg6.xReference = 0
	b.leftLeg6.yReference = -10

	b.rightLeg1.xReference = 0
	b.rightLeg1.yReference = -13
	b.rightLeg2.xReference = 0
	b.rightLeg2.yReference = -13
	b.rightLeg3.xReference = 0
	b.rightLeg3.yReference = -13
	b.rightLeg4.xReference = 0
	b.rightLeg4.yReference = -13
	b.rightLeg5.xReference = 0
	b.rightLeg5.yReference = -13
	b.rightLeg6.xReference = 0
	b.rightLeg6.yReference = -13
		
	b.torso2.xReference = 0
	b.torso2.yReference = -15
	b.torso3.xReference = 0
	b.torso3.yReference = -15
	b.torso4.xReference = 0
	b.torso4.yReference = -15
	b.torso5.xReference = 0
	b.torso5.yReference = -15
	b.torso6.xReference = 0
	b.torso6.yReference = -15

	b.rightArmGroup.xReference = 16
	b.rightArmGroup.yReference = 4
	
	b.head1.xReference = 12
	b.head1.yReference = 22
	b.head2.xReference = 12
	b.head2.yReference = 22
	b.head3.xReference = 12
	b.head3.yReference = 22
	b.head4.xReference = 12
	b.head4.yReference = 22
	b.head5.xReference = 12
	b.head5.yReference = 22
	b.head6.xReference = 12
	b.head6.yReference = 22
	b.head7.xReference = 12
	b.head7.yReference = 22
	b.head8.xReference = 12
	b.head8.yReference = 22
	b.head9.xReference = 12
	b.head9.yReference = 22
	b.head10.xReference = 12
	b.head10.yReference = 22
	b.head11.xReference = 12
	b.head11.yReference = 22
	b.head12.xReference = 12
	b.head12.yReference = 22
	b.head13.xReference = 12
	b.head13.yReference = 22
	b.head14.xReference = 12
	b.head14.yReference = 22
	b.head15.xReference = 12
	b.head15.yReference = 22
	
	b.torsoGroup.yReference = 17
	b.torsoGroup.xReference = -13

	b.neck2.x = 1
	b.neck2.y = -9
	b.neck3.x = 1
	b.neck3.y = -9
	b.neck4.x = 1
	b.neck4.y = -9
	b.neck5.x = 1
	b.neck5.y = -9
	b.neck6.x = 1
	b.neck6.y = -9
		
	b.belt2.x = -2
	b.belt2.y = 16
	b.belt3.x = -2
	b.belt3.y = 16
	b.belt4.x = -2
	b.belt4.y = 16
	b.belt5.x = -2
	b.belt5.y = 16
	b.belt6.x = -2
	b.belt6.y = 16

	
	b.myGuy.rotation = 0
	b.shadow.x = 0
	b.shadow.y = 36
	b.leftArmGroup.rotation = 0
	b.leftArmGroup.x = 6
	b.leftArmGroup.y = -12
	
	b.leftLeg1.rotation = 0
	b.leftLeg1.x = 7
	b.leftLeg1.y = 15
	b.leftLeg2.rotation = 0
	b.leftLeg2.x = 7
	b.leftLeg2.y = 15
	b.leftLeg3.rotation = 0
	b.leftLeg3.x = 7
	b.leftLeg3.y = 15
	b.leftLeg4.rotation = 0
	b.leftLeg4.x = 7
	b.leftLeg4.y = 15
	b.leftLeg5.rotation = 0
	b.leftLeg5.x = 7
	b.leftLeg5.y = 15
	b.leftLeg6.rotation = 0
	b.leftLeg6.x = 7
	b.leftLeg6.y = 15
	
	b.rightLeg1.rotation = 0
	b.rightLeg1.x = -9
	b.rightLeg1.y = 13
	b.rightLeg2.rotation = 0
	b.rightLeg2.x = -9
	b.rightLeg2.y = 13
	b.rightLeg3.rotation = 0
	b.rightLeg3.x = -9
	b.rightLeg3.y = 13
	b.rightLeg4.rotation = 0
	b.rightLeg4.x = -9
	b.rightLeg4.y = 13
	b.rightLeg5.rotation = 0
	b.rightLeg5.x = -9
	b.rightLeg5.y = 13
	b.rightLeg6.rotation = 0
	b.rightLeg6.x = -9
	b.rightLeg6.y = 13

	b.torso2.rotation = 0
	b.torso2.x = 0
	b.torso2.y = -15
	b.torso3.rotation = 0
	b.torso3.x = 0
	b.torso3.y = -15
	b.torso4.rotation = 0
	b.torso4.x = 0
	b.torso4.y = -15
	b.torso5.rotation = 0
	b.torso5.x = 0
	b.torso5.y = -15
	b.torso6.rotation = 0
	b.torso6.x = 0
	b.torso6.y = -15
	
	b.rightArmGroup.rotation = 0
	b.rightArmGroup.x = -15
	b.rightArmGroup.y = -8
	
	b.head1.rotation = 0
	b.head1.x = 6
	b.head1.y = -16
	b.head2.rotation = 0
	b.head2.x = 6
	b.head2.y = -16
	b.head3.rotation = 0
	b.head3.x = 6
	b.head3.y = -16
	b.head4.rotation = 0
	b.head4.x = 6
	b.head4.y = -16
	b.head5.rotation = 0
	b.head5.x = 6
	b.head5.y = -16
	b.head6.rotation = 0
	b.head6.x = 6
	b.head6.y = -16
	b.head7.rotation = 0
	b.head7.x = 6
	b.head7.y = -16
	b.head8.rotation = 0
	b.head8.x = 6
	b.head8.y = -16
	b.head9.rotation = 0
	b.head9.x = 6
	b.head9.y = -16
	b.head10.rotation = 0
	b.head10.x = 6
	b.head10.y = -16
	b.head11.rotation = 0
	b.head11.x = 6
	b.head11.y = -16
	b.head12.rotation = 0
	b.head12.x = 6
	b.head12.y = -16
	b.head13.rotation = 0
	b.head13.x = 6
	b.head13.y = -16
	b.head14.rotation = 0
	b.head14.x = 6
	b.head14.y = -16
	b.head15.rotation = 0
	b.head15.x = 6
	b.head15.y = -16

	b.torsoGroup.rotation = 0
	b.torsoGroup.x = -13
	b.torsoGroup.y = 17	

	b.myGuyLeftFingers.x = 18
	b.myGuyLeftFingers.y = 20


end


zeroOutColorGuy()


-- SELECT LEVEL DISPLAY GROUP

local selectLevelDisplayGroup = display.newGroup()

local s = {}


function setUpSelectLevelDisplayGroup()

	b.selectLevelBackground = display.newImage("Menu Background.png", true)
	b.selectLevelEn = display.newImage("Select Level En.png")
	b.selectLevelSp = display.newImage("Select Level Sp.png")


	s.levelOneButton = display.newImage("Background 1 Button.png")
	s.levelTwoButton = display.newImage("Background 2 Button.png")
	s.levelThreeButton = display.newImage("Background 3 Button.png")
	s.levelFourButton = display.newImage("Background 4 Button.png")
	s.levelFiveButton = display.newImage("Background 5 Button.png")
	s.levelSixButton = display.newImage("Background 6 Button.png")

	s.levelTwoButtonMask = display.newImage("Mask Screen Button.png")
	s.levelThreeButtonMask = display.newImage("Mask Screen Button.png")
	s.levelFourButtonMask = display.newImage("Mask Screen Button.png")
	s.levelFiveButtonMask = display.newImage("Mask Screen Button.png")
	s.levelSixButtonMask = display.newImage("Mask Screen Button.png")

	s.levelSelectButtonBackground1 = display.newImage("Level Select Button Background.png")
	s.levelSelectButtonBackground2 = display.newImage("Level Select Button Background.png")
	s.levelSelectButtonBackground3 = display.newImage("Level Select Button Background.png")
	s.levelSelectButtonBackground4 = display.newImage("Level Select Button Background.png")
	s.levelSelectButtonBackground5 = display.newImage("Level Select Button Background.png")
	s.levelSelectButtonBackground6 = display.newImage("Level Select Button Background.png")
	



	selectLevelDisplayGroup.isVisible = false

	selectLevelDisplayGroup:insert(b.selectLevelBackground)
	b.selectLevelBackground.x = _W / 2
	b.selectLevelBackground.y = _H / 2

	selectLevelDisplayGroup:insert(b.selectLevelEn)
	b.selectLevelEn.x = 240
	b.selectLevelEn.y = 50

	selectLevelDisplayGroup:insert(b.selectLevelSp)
	b.selectLevelSp.x = 240
	b.selectLevelSp.y = 50
	
	selectLevelDisplayGroup:insert(s.levelSelectButtonBackground1)
	selectLevelDisplayGroup:insert(s.levelSelectButtonBackground2)
	selectLevelDisplayGroup:insert(s.levelSelectButtonBackground3)
	selectLevelDisplayGroup:insert(s.levelSelectButtonBackground4)
	selectLevelDisplayGroup:insert(s.levelSelectButtonBackground5)
	selectLevelDisplayGroup:insert(s.levelSelectButtonBackground6)
	
	s.levelSelectButtonBackground1.x = 100
	s.levelSelectButtonBackground1.y = 130
	
	s.levelSelectButtonBackground2.x = 240
	s.levelSelectButtonBackground2.y = 130
	
	s.levelSelectButtonBackground3.x = 380
	s.levelSelectButtonBackground3.y = 130
	
	s.levelSelectButtonBackground4.x = 100
	s.levelSelectButtonBackground4.y = 240
	
	s.levelSelectButtonBackground5.x = 240
	s.levelSelectButtonBackground5.y = 240
	
	s.levelSelectButtonBackground6.x = 380
	s.levelSelectButtonBackground6.y = 240
	
		
	selectLevelDisplayGroup:insert(s.levelOneButton)
	s.levelOneButton.x = 100
	s.levelOneButton.y = 130

	selectLevelDisplayGroup:insert(s.levelTwoButton)
	s.levelTwoButton.x = 240
	s.levelTwoButton.y = 130

	selectLevelDisplayGroup:insert(s.levelThreeButton)
	s.levelThreeButton.x = 380
	s.levelThreeButton.y = 130
	
	selectLevelDisplayGroup:insert(s.levelFourButton)
	s.levelFourButton.x = 100
	s.levelFourButton.y = 240
	
	selectLevelDisplayGroup:insert(s.levelFiveButton)
	s.levelFiveButton.x = 240
	s.levelFiveButton.y = 240
	
	selectLevelDisplayGroup:insert(s.levelSixButton)
	s.levelSixButton.x = 380
	s.levelSixButton.y = 240
	
		
	selectLevelDisplayGroup:insert(s.levelTwoButtonMask)
	s.levelTwoButtonMask.x = 240
	s.levelTwoButtonMask.y = 130
	
	selectLevelDisplayGroup:insert(s.levelThreeButtonMask)
	s.levelThreeButtonMask.x = 380
	s.levelThreeButtonMask.y = 130
	
	selectLevelDisplayGroup:insert(s.levelFourButtonMask)
	s.levelFourButtonMask.x = 100
	s.levelFourButtonMask.y = 240
	
	selectLevelDisplayGroup:insert(s.levelFiveButtonMask)
	s.levelFiveButtonMask.x = 240
	s.levelFiveButtonMask.y = 240
	
	selectLevelDisplayGroup:insert(s.levelSixButtonMask)
	s.levelSixButtonMask.x = 380
	s.levelSixButtonMask.y = 240
		
	
end

setUpSelectLevelDisplayGroup()


-- THE GAME SCREEN DISPLAY GROUP

local gameScreenDisplayGroup = display.newGroup()
gameScreenDisplayGroup.isVisible = false

-- BACKGROUND

local background = nil

-- ROAD

local road1 = nil
local road2 = nil
local road3 = nil

local roadCounter = 0

local roadShadow = nil

-- TREES, TENTS, ETC
local treesTentsEtc = {}

local tree1 = display.newGroup()
local tree2 = display.newGroup()
local tent1 = display.newGroup()
local tent2 = display.newGroup()

local tent = {}

local tree1Trunk = display.newImage("Tree 1 Trunk.png")
local tree2Trunk = display.newImage("Tree 2 Trunk.png")
local tree1Shadow = display.newImage("Tree Shadow.png")
local tree2Shadow = display.newImage("Tree Shadow.png")
local tree1Leaves = display.newImage("Tree Leaves.png")
local tree2Leaves = display.newImage("Tree Leaves.png")
local fireWood1 = display.newImage("Fire Wood 01.png")
local flame1 = display.newImage("Flame 01.png")
local flame2 = display.newImage("Flame 02.png")
local flame3 = display.newImage("Flame 03.png")
local flame4 = display.newImage("Flame 04.png")
local flame5 = display.newImage("Flame 05.png")
local flame6 = display.newImage("Flame 06.png")
local chest1 = display.newImage("Chest 1 Full.png")
local barrel1 = display.newImage("Bush 1.png")
local barrel2 = display.newImage("Beach Rocks 1.png")
local smallCoin1 = display.newGroup()
local smallCoin2 = display.newGroup()
local smallCoin3 = display.newGroup()


function setUpTent()

	tent.tent1background = display.newImage("Tent 1.png")
	tent.tent2background = display.newImage("Tent 2.png")
	tent.tent1opening1 = display.newImage("Tent 1 Opening 1.png")
	tent.tent1opening2 = display.newImage("Tent 1 Opening 2.png")
	tent.tent1opening3 = display.newImage("Tent 1 Opening 3.png")
	tent.tent1opening4 = display.newImage("Tent 1 Opening 4.png")
	tent.tent2opening1 = display.newImage("Tent 2 Opening 1.png")
	tent.tent2opening2 = display.newImage("Tent 2 Opening 2.png")
	tent.tent2opening3 = display.newImage("Tent 2 Opening 3.png")
	tent.tent2opening4 = display.newImage("Tent 2 Opening 4.png")
	tent.tent1Shadow = display.newImage("Tent Shadow.png")
	tent.tent2Shadow = display.newImage("Tent Shadow.png")

	tree1:insert(tree1Shadow)
	tree2:insert(tree2Shadow)
	tree1:insert(tree1Trunk)
	tree2:insert(tree2Trunk)
	tree1:insert(tree1Leaves)
	tree2:insert(tree2Leaves)

	tent1:insert(tent.tent1Shadow)
	tent1:insert(tent.tent1background)
	tent1:insert(tent.tent1opening1)
	tent1:insert(tent.tent1opening2)
	tent1:insert(tent.tent1opening3)
	tent1:insert(tent.tent1opening4)

	tent2:insert(tent.tent2Shadow)
	tent2:insert(tent.tent2background)
	tent2:insert(tent.tent2opening1)
	tent2:insert(tent.tent2opening2)
	tent2:insert(tent.tent2opening3)
	tent2:insert(tent.tent2opening4)

	tree1Trunk.x = 0
	tree2Trunk.x = 0
	tree1Trunk.y = 0
	tree2Trunk.y = 0
	tree1Leaves.x = 0
	tree2Leaves.x = 0
	tree1Leaves.y = -100
	tree2Leaves.y = -100
	tree1Shadow.x = -50
	tree2Shadow.x = -50
	tree1Shadow.y = 118
	tree2Shadow.y = 118

	tent.tent1background.x = 0
	tent.tent1background.y = 0
	tent.tent1Shadow.x = -40
	tent.tent1Shadow.y = 95
	tent.tent1opening1.x = 0
	tent.tent1opening1.y = 38
	tent.tent1opening2.x = 0
	tent.tent1opening2.y = 38
	tent.tent1opening3.x = 0
	tent.tent1opening3.y = 38
	tent.tent1opening4.x = 0
	tent.tent1opening4.y = 38

	tent.tent1opening2.isVisible = false
	tent.tent1opening3.isVisible = false
	tent.tent1opening4.isVisible = false

	tent.tent2background.x = 0
	tent.tent2background.y = 0
	tent.tent2Shadow.x = -40
	tent.tent2Shadow.y = 95
	tent.tent2opening1.x = 0
	tent.tent2opening1.y = 38
	tent.tent2opening2.x = 0
	tent.tent2opening2.y = 38
	tent.tent2opening3.x = 0
	tent.tent2opening3.y = 38
	tent.tent2opening4.x = 0
	tent.tent2opening4.y = 38

	tent.tent2opening2.isVisible = false
	tent.tent2opening3.isVisible = false
	tent.tent2opening4.isVisible = false

end

setUpTent()


local sGC = {}


function createCoins()
	
	sGC.aShadow = display.newImage("Small Gold Coin Shadow.png")
	sGC.a1 = display.newImage("Small Gold Coin 01.png")
	sGC.a2 = display.newImage("Small Gold Coin 02.png")
	sGC.a3 = display.newImage("Small Gold Coin 03.png")
	sGC.a4 = display.newImage("Small Gold Coin 04.png")
	sGC.a5 = display.newImage("Small Gold Coin 03.png")
	sGC.a6 = display.newImage("Small Gold Coin 02.png")
	sGC.a5.xScale = -1
	sGC.a6.xScale = -1
	
	sGC.bShadow = display.newImage("Small Gold Coin Shadow.png")
	sGC.b1 = display.newImage("Small Gold Coin 01.png")
	sGC.b2 = display.newImage("Small Gold Coin 02.png")
	sGC.b3 = display.newImage("Small Gold Coin 03.png")
	sGC.b4 = display.newImage("Small Gold Coin 04.png")
	sGC.b5 = display.newImage("Small Gold Coin 03.png")
	sGC.b6 = display.newImage("Small Gold Coin 02.png")
	sGC.b5.xScale = -1
	sGC.b6.xScale = -1
	
	sGC.cShadow = display.newImage("Small Gold Coin Shadow.png")
	sGC.c1 = display.newImage("Small Gold Coin 01.png")
	sGC.c2 = display.newImage("Small Gold Coin 02.png")
	sGC.c3 = display.newImage("Small Gold Coin 03.png")
	sGC.c4 = display.newImage("Small Gold Coin 04.png")
	sGC.c5 = display.newImage("Small Gold Coin 03.png")
	sGC.c6 = display.newImage("Small Gold Coin 02.png")
	sGC.c5.xScale = -1
	sGC.c6.xScale = -1
	
	smallCoin1:insert(sGC.aShadow)
	smallCoin1:insert(sGC.a1)
	smallCoin1:insert(sGC.a2)
	smallCoin1:insert(sGC.a3)
	smallCoin1:insert(sGC.a4)
	smallCoin1:insert(sGC.a5)
	smallCoin1:insert(sGC.a6)

	smallCoin2:insert(sGC.bShadow)
	smallCoin2:insert(sGC.b1)
	smallCoin2:insert(sGC.b2)
	smallCoin2:insert(sGC.b3)
	smallCoin2:insert(sGC.b4)
	smallCoin2:insert(sGC.b5)
	smallCoin2:insert(sGC.b6)

	smallCoin3:insert(sGC.cShadow)
	smallCoin3:insert(sGC.c1)
	smallCoin3:insert(sGC.c2)
	smallCoin3:insert(sGC.c3)
	smallCoin3:insert(sGC.c4)
	smallCoin3:insert(sGC.c5)
	smallCoin3:insert(sGC.c6)

	sGC.a1.x = 0
	sGC.a2.x = 0
	sGC.a3.x = 0
	sGC.a4.x = 0
	sGC.a5.x = 0
	sGC.a6.x = 0
	sGC.aShadow.x = 0
	sGC.aShadow.y = 24
	
	sGC.b1.x = 0
	sGC.b2.x = 0
	sGC.b3.x = 0
	sGC.b4.x = 0
	sGC.b5.x = 0
	sGC.b6.x = 0
	sGC.bShadow.x = 0
	sGC.bShadow.y = 24

	sGC.c1.x = 0
	sGC.c2.x = 0
	sGC.c3.x = 0
	sGC.c4.x = 0
	sGC.c5.x = 0
	sGC.c6.x = 0
	sGC.cShadow.x = 0
	sGC.cShadow.y = 24

	smallCoin1.isVisible = false
	smallCoin2.isVisible = false
	smallCoin3.isVisible = false

	smallCoin1.y = 210
	smallCoin2.y = 210
	smallCoin3.y = 210

	smallCoin1.x = -1000
	smallCoin2.x = -1000
	smallCoin3.x = -1000
	

end

createCoins()


-- WEAPONS WALL

local weaponsWallDisplayGroup = display.newGroup()

local w = {}


function assembleWeaponsWall()

	w.weaponsWall_1 = display.newImage("Weapons Wall 1.png", true)
	w.weaponsWall_2 = display.newImage("Weapons Wall 2.png", true)

	w.wArrow2 = display.newImage("Arrow 2 Wall.png")
	w.wArrow3 = display.newImage("Arrow 3 Wall.png")

	w.wKnife1 = display.newImage("Knife 1 Wall.png")
	w.wKnife2 = display.newImage("Knife 2 Wall.png")
	w.wKnife3 = display.newImage("Knife 3 Wall.png")

	w.wTomahawk1 = display.newImage("Tomahawk 1 Wall.png")
	w.wTomahawk2 = display.newImage("Tomahawk 2 Wall.png")
	w.wTomahawk3 = display.newImage("Tomahawk 3 Wall.png")

	w.wPistol1 = display.newImage("Pistol 1 Wall.png")
	w.wPistol2 = display.newImage("Pistol 2 Wall.png")
	w.wPistol3 = display.newImage("Pistol 3 Wall.png")

	w.wRifle1 = display.newImage("Rifle 1 Wall.png")
	w.wRifle2 = display.newImage("Rifle 2 Wall.png")
	w.wRifle3 = display.newImage("Rifle 3 Wall.png")

	w.wArrowGold = display.newImage("Arrow 3 Gold Wall.png")
	w.wKnifeGold = display.newImage("Knife 3 Gold Wall.png")
	w.wTomahawkGold = display.newImage("Tomahawk 3 Gold Wall.png")
	w.wPistolGold = display.newImage("Pistol 3 Gold Wall.png")
	w.wRifleGold = display.newImage("Rifle 3 Gold Wall.png")

	w.wMace1 = display.newImage("Mace Wall.png")
	w.wMachete1 = display.newImage("Machete Wall.png")

	w.wMacheteGold = display.newImage("Machete Gold Wall.png")

	w.wHealthPack = display.newImage("Health Pack Wall.png")
	w.wHealthPackGold = display.newImage("Health Pack Gold Wall.png")
	
	w.wGranade1 = display.newImage("Granade Wall.png")
	w.wGranadeGold = display.newImage("Granade Gold Wall.png")

	w.wShip = display.newImage("Ship.png")
	w.wShip.isVisible = false


	w.wPriceTag450 = display.newImage("Price Tag 450.png")
	w.wPriceTag200 = display.newImage("Price Tag 200.png")
	w.wPriceTag550 = display.newImage("Price Tag 550.png")
	w.wPriceTag6001 = display.newImage("Price Tag 600.png")
	w.wPriceTag6002 = display.newImage("Price Tag 600.png")
	w.wPriceTag7001 = display.newImage("Price Tag 700.png")
	w.wPriceTag7002 = display.newImage("Price Tag 700.png")
	w.wPriceTag800 = display.newImage("Price Tag 800.png")
	w.wPriceTag250 = display.newImage("Price Tag 250.png")
	w.wPriceTag850 = display.newImage("Price Tag 850.png")
	w.wPriceTag950 = display.newImage("Price Tag 950.png")
	w.wPriceTag10001 = display.newImage("Price Tag 1000.png")
	w.wPriceTag10002 = display.newImage("Price Tag 1000.png")
	w.wPriceTag1450 = display.newImage("Price Tag 1450.png")
	w.wPriceTag1100 = display.newImage("Price Tag 1100.png")
	w.wPriceTag1600 = display.newImage("Price Tag 1600.png")
	w.wPriceTag1250 = display.newImage("Price Tag 1250.png")
	w.wPriceTag1800 = display.newImage("Price Tag 1800.png")
	w.wPriceTag1750 = display.newImage("Price Tag 1750.png")
	w.wPriceTag1950 = display.newImage("Price Tag 1950.png")
	w.wPriceTag15001 = display.newImage("Price Tag 1500.png")
	w.wPriceTag15002 = display.newImage("Price Tag 1500.png")
	w.wPriceTag2100 = display.newImage("Price Tag 2100.png")
	w.wPriceTag2150 = display.newImage("Price Tag 2150.png")
	w.wPriceTag25001 = display.newImage("Price Tag 2500.png")
	w.wPriceTag25002 = display.newImage("Price Tag 2500.png")
	
	w.wAmmoTag1 = display.newImage("Ammo Tag.png")
	w.wAmmoTag2 = display.newImage("Ammo Tag.png")
	w.wAmmoTag3 = display.newImage("Ammo Tag.png")
	w.wAmmoTag4 = display.newImage("Ammo Tag.png")
	w.wAmmoTag5 = display.newImage("Ammo Tag.png")


	weaponsWallDisplayGroup:insert(w.weaponsWall_1)
	weaponsWallDisplayGroup:insert(w.weaponsWall_2)
	
	weaponsWallDisplayGroup:insert(w.wArrowGold)
	weaponsWallDisplayGroup:insert(w.wArrow3)
	weaponsWallDisplayGroup:insert(w.wArrow2)
		
	weaponsWallDisplayGroup:insert(w.wKnifeGold)
	weaponsWallDisplayGroup:insert(w.wKnife3)
	weaponsWallDisplayGroup:insert(w.wKnife2)
	weaponsWallDisplayGroup:insert(w.wKnife1)

	weaponsWallDisplayGroup:insert(w.wTomahawkGold)	
	weaponsWallDisplayGroup:insert(w.wTomahawk3)
	weaponsWallDisplayGroup:insert(w.wTomahawk2)
	weaponsWallDisplayGroup:insert(w.wTomahawk1)

	weaponsWallDisplayGroup:insert(w.wPistolGold)	
	weaponsWallDisplayGroup:insert(w.wPistol3)
	weaponsWallDisplayGroup:insert(w.wPistol2)
	weaponsWallDisplayGroup:insert(w.wPistol1)
	
	weaponsWallDisplayGroup:insert(w.wRifleGold)	
	weaponsWallDisplayGroup:insert(w.wRifle3)
	weaponsWallDisplayGroup:insert(w.wRifle2)
	weaponsWallDisplayGroup:insert(w.wRifle1)
	

	weaponsWallDisplayGroup:insert(w.wMacheteGold)
	weaponsWallDisplayGroup:insert(w.wMachete1)
	weaponsWallDisplayGroup:insert(w.wMace1)
		
	
	weaponsWallDisplayGroup:insert(w.wHealthPackGold)
	weaponsWallDisplayGroup:insert(w.wHealthPack)
	
	weaponsWallDisplayGroup:insert(w.wGranadeGold)
	weaponsWallDisplayGroup:insert(w.wGranade1)
	
	weaponsWallDisplayGroup:insert(w.wPriceTag450)
	weaponsWallDisplayGroup:insert(w.wPriceTag200)
	weaponsWallDisplayGroup:insert(w.wPriceTag550)	
	weaponsWallDisplayGroup:insert(w.wPriceTag6001)	
	weaponsWallDisplayGroup:insert(w.wPriceTag6002)	
	weaponsWallDisplayGroup:insert(w.wPriceTag7001)	
	weaponsWallDisplayGroup:insert(w.wPriceTag7002)	
	weaponsWallDisplayGroup:insert(w.wPriceTag800)	
	weaponsWallDisplayGroup:insert(w.wPriceTag250)	
	weaponsWallDisplayGroup:insert(w.wPriceTag850)	
	weaponsWallDisplayGroup:insert(w.wPriceTag950)	
	weaponsWallDisplayGroup:insert(w.wPriceTag10001)	
	weaponsWallDisplayGroup:insert(w.wPriceTag10002)	
	weaponsWallDisplayGroup:insert(w.wPriceTag1450)	
	weaponsWallDisplayGroup:insert(w.wPriceTag1100)	
	weaponsWallDisplayGroup:insert(w.wPriceTag1600)	
	weaponsWallDisplayGroup:insert(w.wPriceTag1250)	
	weaponsWallDisplayGroup:insert(w.wPriceTag1800)	
	weaponsWallDisplayGroup:insert(w.wPriceTag1750)	
	weaponsWallDisplayGroup:insert(w.wPriceTag1950)	
	weaponsWallDisplayGroup:insert(w.wPriceTag15001)	
	weaponsWallDisplayGroup:insert(w.wPriceTag15002)	
	weaponsWallDisplayGroup:insert(w.wPriceTag2100)	
	weaponsWallDisplayGroup:insert(w.wPriceTag2150)	
	weaponsWallDisplayGroup:insert(w.wPriceTag25001)	
	weaponsWallDisplayGroup:insert(w.wPriceTag25002)	
	
	weaponsWallDisplayGroup:insert(w.wAmmoTag1)
	weaponsWallDisplayGroup:insert(w.wAmmoTag2)
	weaponsWallDisplayGroup:insert(w.wAmmoTag3)
	weaponsWallDisplayGroup:insert(w.wAmmoTag4)
	weaponsWallDisplayGroup:insert(w.wAmmoTag5)
	
	w.weaponsWall_1.x = 350
	w.weaponsWall_1.y = 110
	
	w.weaponsWall_2.x = 760
	w.weaponsWall_2.y = 110

	w.wArrow2.x = 192
	w.wArrow2.y = 110
	
	w.wArrow3.x = w.wArrow2.x
	w.wArrow3.y = w.wArrow2.y

	w.wKnife1.x = 265
	w.wKnife1.y = w.wArrow2.y
	
	w.wKnife2.x = w.wKnife1.x
	w.wKnife2.y = w.wArrow2.y

	w.wKnife3.x = w.wKnife1.x
	w.wKnife3.y = w.wArrow2.y
	
	w.wTomahawk1.x = 338
	w.wTomahawk1.y = w.wArrow2.y	
	
	w.wTomahawk2.x = w.wTomahawk1.x
	w.wTomahawk2.y = w.wArrow2.y
	
	w.wTomahawk3.x = w.wTomahawk1.x
	w.wTomahawk3.y = w.wArrow2.y	
	
	w.wPistol1.x = 423
	w.wPistol1.y = w.wArrow2.y

	w.wPistol2.x = 	w.wPistol1.x
	w.wPistol2.y = w.wArrow2.y
	
	w.wPistol3.x = 	w.wPistol1.x
	w.wPistol3.y = w.wArrow2.y
	
	w.wRifle1.x = 539
	w.wRifle1.y = w.wArrow2.y
	
	w.wRifle2.x = w.wRifle1.x
	w.wRifle2.y = w.wArrow2.y
	
	w.wRifle3.x = w.wRifle1.x
	w.wRifle3.y = w.wArrow2.y
	
	w.wArrowGold.x = w.wArrow2.x
	w.wArrowGold.y = w.wArrow2.y

	w.wKnifeGold.x = w.wKnife1.x
	w.wKnifeGold.y = w.wArrow2.y
	
	w.wTomahawkGold.x = w.wTomahawk1.x
	w.wTomahawkGold.y = w.wArrow2.y
	
	w.wPistolGold.x = w.wPistol1.x
	w.wPistolGold.y = w.wArrow2.y
	
	w.wRifleGold.x = w.wRifle1.x
	w.wRifleGold.y = w.wArrow2.y
	
	w.wMace1.x = 707
	w.wMace1.y = w.wArrow2.y
	
	w.wMachete1.x = w.wMace1.x
	w.wMachete1.y = w.wArrow2.y
	
	w.wMacheteGold.x = w.wMace1.x
	w.wMacheteGold.y = w.wArrow2.y
	
	w.wHealthPack.x = 812
	w.wHealthPack.y = w.wArrow2.y

	w.wHealthPackGold.x = w.wHealthPack.x
	w.wHealthPackGold.y = w.wArrow2.y
	
	w.wGranade1.x = 886
	w.wGranade1.y = w.wArrow2.y

	w.wGranadeGold.x = w.wGranade1.x
	w.wGranadeGold.y = w.wArrow2.y

	
	
	
	w.wPriceTag450.x = w.wArrow2.x
	w.wPriceTag6001.x = w.wArrow2.x
	w.wPriceTag10001.x = w.wArrow2.x
	
	w.wPriceTag550.x = w.wKnife1.x
	w.wPriceTag7001.x = w.wKnife1.x
	w.wPriceTag850.x = w.wKnife1.x
	w.wPriceTag1250.x = w.wKnife1.x

	w.wPriceTag800.x = w.wTomahawk1.x
	w.wPriceTag950.x = w.wTomahawk1.x
	w.wPriceTag1100.x = w.wTomahawk1.x
	w.wPriceTag15001.x = w.wTomahawk1.x
	
	w.wPriceTag1450.x = w.wPistol1.x
	w.wPriceTag1600.x = w.wPistol1.x
	w.wPriceTag1750.x = w.wPistol1.x
	w.wPriceTag2150.x = w.wPistol1.x
	
	w.wPriceTag1800.x = w.wRifle1.x
	w.wPriceTag1950.x = w.wRifle1.x
	w.wPriceTag2100.x = w.wRifle1.x
	w.wPriceTag25001.x = w.wRifle1.x
	
	
	w.wPriceTag6002.x = w.wMace1.x
	w.wPriceTag15002.x = w.wMace1.x
	w.wPriceTag25002.x = w.wMace1.x
	
	w.wPriceTag200.x = w.wHealthPack.x
	w.wPriceTag250.x = w.wHealthPack.x
	
	w.wPriceTag7002.x = w.wGranade1.x
	w.wPriceTag10002.x = w.wGranade1.x
		
	w.wAmmoTag1.x = w.wArrow2.x
	w.wAmmoTag2.x = w.wKnife1.x
	w.wAmmoTag3.x = w.wTomahawk1.x
	w.wAmmoTag4.x = w.wPistol1.x
	w.wAmmoTag5.x = w.wRifle1.x

	w.wPriceTag450.y = 161
	w.wPriceTag6001.y = w.wPriceTag450.y
	w.wPriceTag10001.y = w.wPriceTag450.y
	
	w.wPriceTag550.y = w.wPriceTag450.y
	w.wPriceTag7001.y = w.wPriceTag450.y
	w.wPriceTag850.y = w.wPriceTag450.y
	w.wPriceTag1250.y = w.wPriceTag450.y

	w.wPriceTag800.y = w.wPriceTag450.y
	w.wPriceTag950.y = w.wPriceTag450.y
	w.wPriceTag1100.y = w.wPriceTag450.y
	w.wPriceTag15001.y = w.wPriceTag450.y
	
	w.wPriceTag1450.y = w.wPriceTag450.y
	w.wPriceTag1600.y = w.wPriceTag450.y
	w.wPriceTag1750.y = w.wPriceTag450.y
	w.wPriceTag2150.y = w.wPriceTag450.y
	
	w.wPriceTag1800.y = w.wPriceTag450.y
	w.wPriceTag1950.y = w.wPriceTag450.y
	w.wPriceTag2100.y = w.wPriceTag450.y
	w.wPriceTag25001.y = w.wPriceTag450.y
	
	w.wPriceTag6002.y = w.wPriceTag450.y
	w.wPriceTag15002.y = w.wPriceTag450.y
	w.wPriceTag25002.y = w.wPriceTag450.y
	
	w.wPriceTag200.y = w.wPriceTag450.y
	w.wPriceTag250.y = w.wPriceTag450.y

	w.wPriceTag7002.y = w.wPriceTag450.y
	w.wPriceTag10002.y = w.wPriceTag450.y	

	
	w.wAmmoTag1.y = 142
	w.wAmmoTag2.y = w.wAmmoTag1.y
	w.wAmmoTag3.y = w.wAmmoTag1.y
	w.wAmmoTag4.y = w.wAmmoTag1.y
	w.wAmmoTag5.y = w.wAmmoTag1.y
	
	

	

	w.wArrow2.flareNum = 0
	w.wArrow3.flareNum = 0

	w.wKnife1.flareNum = 0
	w.wKnife2.flareNum = 0
	w.wKnife3.flareNum = 0

	w.wTomahawk1.flareNum = 0
	w.wTomahawk2.flareNum = 0
	w.wTomahawk3.flareNum = 0

	w.wPistol1.flareNum = 0
	w.wPistol2.flareNum = 0
	w.wPistol3.flareNum = 0

	w.wRifle1.flareNum = 0
	w.wRifle2.flareNum = 0
	w.wRifle3.flareNum = 0

	w.wArrowGold.flareNum = 0
	w.wKnifeGold.flareNum = 0
	w.wTomahawkGold.flareNum = 0
	w.wPistolGold.flareNum = 0
	w.wRifleGold.flareNum = 0

	w.wMace1.flareNum = 0
	w.wMachete1.flareNum = 0

	w.wMacheteGold.flareNum = 0

	w.wHealthPack.flareNum = 0
	w.wHealthPackGold.flareNum = 0
	
	w.wGranade1.flareNum = 0
	w.wGranadeGold.flareNum = 0
		
end

assembleWeaponsWall()


local pyramidDisplayGroup = display.newGroup()

function losePyramid()

	pyramidDisplayGroup.isVisible = false
	
	if (b.pyramidBackground ~= nil) then
		
		b.pyramidBackground:removeSelf()
		b.pyramidBackground = nil	


		b.leftFlame01:removeSelf()
		b.leftFlame02:removeSelf()
		b.leftFlame03:removeSelf()
		b.leftFlame04:removeSelf()
		b.leftFlame05:removeSelf()
		b.leftFlame06:removeSelf()

		b.leftFlame01 = nil
		b.leftFlame02 = nil
		b.leftFlame03 = nil
		b.leftFlame04 = nil
		b.leftFlame05 = nil
		b.leftFlame06 = nil

		
		b.rightFlame01:removeSelf()
		b.rightFlame02:removeSelf()
		b.rightFlame03:removeSelf()
		b.rightFlame04:removeSelf()
		b.rightFlame05:removeSelf()
		b.rightFlame06:removeSelf()

		b.rightFlame01 = nil
		b.rightFlame02 = nil
		b.rightFlame03 = nil
		b.rightFlame04 = nil
		b.rightFlame05 = nil
		b.rightFlame06 = nil

		b.beam01:removeSelf()
		b.beam02:removeSelf()
		b.beam03:removeSelf()
		b.beam04:removeSelf()

		b.beam01 = nil
		b.beam02 = nil
		b.beam03 = nil
		b.beam04 = nil
		
	end
end


-- POPULATING MAP
function populateMap()
	
	
	gameScreenDisplayGroup:insert(tree1)
	gameScreenDisplayGroup:insert(tree2)
	gameScreenDisplayGroup:insert(tent1)
	gameScreenDisplayGroup:insert(tent2)
	gameScreenDisplayGroup:insert(fireWood1)
	gameScreenDisplayGroup:insert(flame1)
	gameScreenDisplayGroup:insert(flame2)
	gameScreenDisplayGroup:insert(flame3)
	gameScreenDisplayGroup:insert(flame4)
	gameScreenDisplayGroup:insert(flame5)
	gameScreenDisplayGroup:insert(flame6)
	gameScreenDisplayGroup:insert(chest1)
	gameScreenDisplayGroup:insert(barrel1)
	gameScreenDisplayGroup:insert(barrel2)
	gameScreenDisplayGroup:insert(weaponsWallDisplayGroup)
			
	
	for i = 1, 28 , 1 do
		treesTentsEtc[i] = {0, 0, 0}
	end

	
	for i = 1, 7, 1 do
		treesTentsEtc[i][1] = "Tree 1"
	end
	
	for i = 8, 14, 1 do
		treesTentsEtc[i][1] = "Tree 2"
	end

	for i = 15, 17, 1 do
		treesTentsEtc[i][1] = "Tent 1"
	end

	for i = 18, 20, 1 do
		treesTentsEtc[i][1] = "Tent 2"
	end

	for i = 21, 23, 1 do
		treesTentsEtc[i][1] = "Fire 1"
	end

	for i = 24, 26, 1 do
		treesTentsEtc[i][1] = "Barrel 1"
	end

	treesTentsEtc[27][1] = "Chest 1"
	
	treesTentsEtc[28][1] = "Weapons Wall"
	

end 


function zeroOutMap()
	
	tree1.x = 1000
	tree2.x = 1000
	tent1.x = 1000
	tent2.x = 1000
	fireWood1.x = 1000
	flame1.x = 1000
	flame2.x = 1000
	flame3.x = 1000
	flame4.x = 1000
	flame5.x = 1000
	flame6.x = 1000
	chest1.x = 1000
	barrel1.x = 1000
	barrel2.x = 1000
	weaponsWallDisplayGroup.x = 1000
	
	chest1.isVisible = true
	
	weaponsWallDisplayGroup.isVisible = false
	
	flame1.isVisible = false
	flame2.isVisible = false
	flame3.isVisible = false
	flame4.isVisible = false
	flame5.isVisible = false
	flame6.isVisible = false
	
	tree1.y = 108
	tree2.y = 108
	tent1.y = 112
	tent2.y = 112
	fireWood1.y = 193
	chest1.y = 190
	barrel1.y = 185
	barrel2.y = 190
	weaponsWallDisplayGroup.y = 16
	
	flame1.y = 158
	flame2.y = 158
	flame3.y = 158
	flame4.y = 158
	flame5.y = 158
	flame6.y = 158
	

end 


function reArrangeMap(level)

	-- Tree 1, 1 - 7 -- 
	-- Tree 2, 8 - 14 -- 
	-- Tent 1, 15 - 17 -- 
	-- Tent 2, 18 - 20 -- 
	-- Fire 1, 21 - 23 -- 
	-- Barrel 1, 24 - 26 -- 
	-- Chest 1, 27 --
	-- Weapons Wall 28
	

	local sequence = {{1, 8,   15, 24,   2,   18, 21,   9, 3,   16, 25,   10, 4,   19, 22,   11, 5,   17, 26,   12, 6,   20, 23,   13, 7,   27, 28, 14},
					  {1, 8,   18, 24,   2,   15, 21,   9, 3,   19, 25,   10, 4,   16, 22,   11, 5,   20, 26,   12, 6,   17, 23,   13, 7,   27, 28, 14}}
	
	local seqDimOne = math.random(1, 2)
	local treesTentsEtcX = 75
				
	for i = 1, table.getn(treesTentsEtc), 1 do
		
		if (sequence[seqDimOne][i] >= 1 and sequence[seqDimOne][i] <= 7) then
			
			treesTentsEtc[sequence[seqDimOne][i]][2] = treesTentsEtcX
			treesTentsEtcX = treesTentsEtcX + 280
						
		elseif(sequence[seqDimOne][i] >= 8 and sequence[seqDimOne][i] <= 14) then
			
			treesTentsEtc[sequence[seqDimOne][i]][2] = treesTentsEtcX
			treesTentsEtcX = treesTentsEtcX + 280
						
		elseif(sequence[seqDimOne][i] >= 15 and sequence[seqDimOne][i] <= 17) then
			
			treesTentsEtc[sequence[seqDimOne][i]][2] = treesTentsEtcX
			treesTentsEtcX = treesTentsEtcX + 140
			
			treesTentsEtc[sequence[seqDimOne][i]][3] = math.random(10, 20) + math.floor(v.levelPlaying / 2)
						
		elseif(sequence[seqDimOne][i] >= 18 and sequence[seqDimOne][i] <= 20) then
			
			treesTentsEtc[sequence[seqDimOne][i]][2] = treesTentsEtcX
			treesTentsEtcX = treesTentsEtcX + 140
			
			treesTentsEtc[sequence[seqDimOne][i]][3] = math.random(10, 20) + math.floor(v.levelPlaying / 2)
						
		elseif(sequence[seqDimOne][i] >= 21 and sequence[seqDimOne][i] <= 23) then
			
			treesTentsEtc[sequence[seqDimOne][i]][2] = treesTentsEtcX
			treesTentsEtcX = treesTentsEtcX + 140
						
		elseif(sequence[seqDimOne][i] >= 24 and sequence[seqDimOne][i] <= 26) then
			
			treesTentsEtc[sequence[seqDimOne][i]][2] = treesTentsEtcX
			treesTentsEtcX = treesTentsEtcX + 140
						
		elseif(sequence[seqDimOne][i] == 27) then
			
			treesTentsEtc[sequence[seqDimOne][i]][2] = treesTentsEtcX
			treesTentsEtcX = treesTentsEtcX + 720
		
		elseif(sequence[seqDimOne][i] == 28) then
			treesTentsEtc[sequence[seqDimOne][i]][2] = treesTentsEtc[27][2] + 100
		end
		
	end 
	
end 

-- OTHER GUY

local m1 = {}
local m2 = {}
local m3 = {}

function assembleOtherGuys()

	m1.myGuy = display.newGroup()

	m1.leftArmGroup = display.newGroup()
	m1.torsoGroup = display.newGroup()
	m1.rightArmGroup = display.newGroup()

	m1.shadow = display.newImage("Guy Shadow.png")
	m1.leftArm = display.newImage("Other Guy Left Arm Red.png")
	m1.leftLeg = display.newImage("Other Guy Left Leg Red.png")
	m1.rightLeg = display.newImage("Other Guy Right Leg Red.png")
	m1.torso = display.newImage("Other Guy Torso.png")
	m1.head = display.newImage("Other Guy Head.png")
	m1.rightArm = display.newImage("Other Guy Right Arm Red.png")

	m1.alabard = display.newImage("Alabard.png")
	m1.sword = display.newImage("Sword.png")
	m1.battleAxe = display.newImage("Battle Axe.png")
	m1.pistol = display.newImage("Pistol 1.png")
	m1.rifle = display.newImage("Rifle 1.png")
	m1.myGuyLeftFingers = display.newImage("My Guy Left Fingers.png")

	m1.myGuyShield = display.newImage("Other Guy Shield.png")

	m1.gunSmoke01 = display.newImage("Gun Smoke 01.png")
	m1.gunSmoke02 = display.newImage("Gun Smoke 02.png")
	m1.gunSmoke03 = display.newImage("Gun Smoke 03.png")
	m1.splash01 = display.newImage("Splash 01.png")
	
	m1.activeWeapon = ""

	m1.myGuy:insert(m1.shadow)
	m1.myGuy:insert(m1.leftLeg)
	m1.myGuy:insert(m1.rightLeg)

	m1.leftArmGroup:insert(m1.leftArm)

	m1.leftArmGroup:insert(m1.alabard)
	m1.leftArmGroup:insert(m1.sword)
	m1.leftArmGroup:insert(m1.battleAxe)
	m1.leftArmGroup:insert(m1.pistol)
	m1.leftArmGroup:insert(m1.rifle)

	m1.leftArmGroup:insert(m1.myGuyLeftFingers)

	m1.torsoGroup:insert(m1.leftArmGroup)
	m1.torsoGroup:insert(m1.torso)
	m1.torsoGroup:insert(m1.head)

	m1.rightArmGroup:insert(m1.rightArm)
	m1.rightArmGroup:insert(m1.myGuyShield)
	m1.torsoGroup:insert(m1.rightArmGroup)
	m1.torsoGroup:insert(m1.splash01)

	m1.myGuy:insert(m1.torsoGroup)
			
	m1.myGuy.xReference = 0
	m1.myGuy.yReference = 0
	m1.leftArmGroup.xReference = 0
	m1.leftArmGroup.yReference = 0
	m1.leftLeg.xReference = 0
	m1.leftLeg.yReference = -10
	m1.rightLeg.xReference = 0
	m1.rightLeg.yReference = -13
	m1.torso.xReference = 0
	m1.torso.yReference = -15
	m1.rightArmGroup.xReference = 16
	m1.rightArmGroup.yReference = 4
	m1.head.xReference = 12
	m1.head.yReference = 22
	m1.torsoGroup.yReference = 17
	m1.torsoGroup.xReference = -13
	m1.splash01.x = 10
	m1.splash01.y = -35
	
	m1.myGuyLeftFingers.x = 18
	m1.myGuyLeftFingers.y = 20
	
	m1.myGuyShield.rotation = 15
	m1.myGuyShield.x = 10
	m1.myGuyShield.y = 20

	m1.alabard.xReference = 0
	m1.alabard.yReference = 30
		
	m1.sword.xReference = 0
	m1.sword.yReference = 30
	m1.sword.x = 19
	m1.sword.y = 19

	m1.battleAxe.xReference = 0
	m1.battleAxe.yReference = 30
	m1.battleAxe.x = 19
	m1.battleAxe.y = 19
	
	m1.pistol.xReference = 0
	m1.pistol.yReference = 30
	m1.pistol.rotation = 40
	m1.pistol.x = 15
	m1.pistol.y = 50

	m1.rifle.xReference = 0
	m1.rifle.yReference = 30
	m1.rifle.rotation = 40
	m1.rifle.x = 18
	m1.rifle.y = 58
	
	
	-- GUY 2

	m2.myGuy = display.newGroup()

	m2.leftArmGroup = display.newGroup()
	m2.torsoGroup = display.newGroup()
	m2.rightArmGroup = display.newGroup()

	m2.shadow = display.newImage("Guy Shadow.png")
	m2.leftArm = display.newImage("Other Guy Left Arm Blue.png")
	m2.leftLeg = display.newImage("Other Guy Left Leg Blue.png")
	m2.rightLeg = display.newImage("Other Guy Right Leg Blue.png")
	m2.torso = display.newImage("Other Guy Torso.png")
	m2.head = display.newImage("Other Guy Head.png")
	m2.rightArm = display.newImage("Other Guy Right Arm Blue.png")

	m2.alabard = display.newImage("Alabard.png")
	m2.sword = display.newImage("Sword.png")
	m2.battleAxe = display.newImage("Battle Axe.png")
	m2.pistol = display.newImage("Pistol 1.png")
	m2.rifle = display.newImage("Rifle 1.png")
	m2.myGuyLeftFingers = display.newImage("My Guy Left Fingers.png")

	m2.myGuyShield = display.newImage("Other Guy Shield.png")

	m2.gunSmoke01 = display.newImage("Gun Smoke 01.png")
	m2.gunSmoke02 = display.newImage("Gun Smoke 02.png")
	m2.gunSmoke03 = display.newImage("Gun Smoke 03.png")
	m2.splash01 = display.newImage("Splash 01.png")
	
	m2.activeWeapon = ""

	m2.myGuy:insert(m2.shadow)
	m2.myGuy:insert(m2.leftLeg)
	m2.myGuy:insert(m2.rightLeg)

	m2.leftArmGroup:insert(m2.leftArm)

	m2.leftArmGroup:insert(m2.alabard)
	m2.leftArmGroup:insert(m2.sword)
	m2.leftArmGroup:insert(m2.battleAxe)
	m2.leftArmGroup:insert(m2.pistol)
	m2.leftArmGroup:insert(m2.rifle)

	m2.leftArmGroup:insert(m2.myGuyLeftFingers)

	m2.torsoGroup:insert(m2.leftArmGroup)
	m2.torsoGroup:insert(m2.torso)
	m2.torsoGroup:insert(m2.head)

	m2.rightArmGroup:insert(m2.rightArm)
	m2.rightArmGroup:insert(m2.myGuyShield)
	m2.torsoGroup:insert(m2.rightArmGroup)
	m2.torsoGroup:insert(m2.splash01)

	m2.myGuy:insert(m2.torsoGroup)
		
	m2.myGuy.xReference = 0
	m2.myGuy.yReference = 0
	m2.leftArmGroup.xReference = 0
	m2.leftArmGroup.yReference = 0
	m2.leftLeg.xReference = 0
	m2.leftLeg.yReference = -10
	m2.rightLeg.xReference = 0
	m2.rightLeg.yReference = -13
	m2.torso.xReference = 0
	m2.torso.yReference = -15
	m2.rightArmGroup.xReference = 16
	m2.rightArmGroup.yReference = 4
	m2.head.xReference = 12
	m2.head.yReference = 22
	m2.torsoGroup.yReference = 17
	m2.torsoGroup.xReference = -13
	m2.splash01.x = 10
	m2.splash01.y = -35
	
	m2.myGuyLeftFingers.x = 18
	m2.myGuyLeftFingers.y = 20
	
	m2.myGuyShield.rotation = 15
	m2.myGuyShield.x = 10
	m2.myGuyShield.y = 20

	m2.alabard.xReference = 0
	m2.alabard.yReference = 30
		
	m2.sword.xReference = 0
	m2.sword.yReference = 30
	m2.sword.x = 19
	m2.sword.y = 19

	m2.battleAxe.xReference = 0
	m2.battleAxe.yReference = 30
	m2.battleAxe.x = 19
	m2.battleAxe.y = 19
	
	m2.pistol.xReference = 0
	m2.pistol.yReference = 30
	m2.pistol.rotation = 40
	m2.pistol.x = 15
	m2.pistol.y = 50

	m2.rifle.xReference = 0
	m2.rifle.yReference = 30
	m2.rifle.rotation = 40
	m2.rifle.x = 18
	m2.rifle.y = 58

	-- GUY 3
			
	m3.myGuy = display.newGroup()

	m3.leftArmGroup = display.newGroup()
	m3.torsoGroup = display.newGroup()
	m3.rightArmGroup = display.newGroup()

	m3.shadow = display.newImage("Guy Shadow.png")
	m3.leftArm = display.newImage("Other Guy Left Arm Silver.png")
	m3.leftLeg = display.newImage("Other Guy Left Leg Silver.png")
	m3.rightLeg = display.newImage("Other Guy Right Leg Silver.png")
	m3.torso = display.newImage("Other Guy Torso.png")
	m3.collar = display.newImage("Other Guy Collar.png")
	m3.head = display.newImage("Other Guy Head.png")
	m3.rightArm = display.newImage("Other Guy Right Arm Silver.png")

	m3.sword = display.newImage("Sword.png")
	m3.battleAxe = display.newImage("Battle Axe.png")
	m3.pistol = display.newImage("Pistol 1.png")
	m3.rifle = display.newImage("Rifle 1.png")
	m3.myGuyLeftFingers = display.newImage("My Guy Left Fingers.png")

	m3.myGuyShield = display.newImage("Other Guy Shield.png")

	m3.gunSmoke01 = display.newImage("Gun Smoke 01.png")
	m3.gunSmoke02 = display.newImage("Gun Smoke 02.png")
	m3.gunSmoke03 = display.newImage("Gun Smoke 03.png")
	m3.splash01 = display.newImage("Splash 01.png")
	
	m3.activeWeapon = ""

	m3.myGuy:insert(m3.shadow)
	m3.myGuy:insert(m3.leftLeg)
	m3.myGuy:insert(m3.rightLeg)

	m3.leftArmGroup:insert(m3.leftArm)

	m3.leftArmGroup:insert(m3.sword)
	m3.leftArmGroup:insert(m3.battleAxe)
	m3.leftArmGroup:insert(m3.pistol)
	m3.leftArmGroup:insert(m3.rifle)

	m3.leftArmGroup:insert(m3.myGuyLeftFingers)

	m3.torsoGroup:insert(m3.leftArmGroup)
	m3.torsoGroup:insert(m3.torso)
	m3.torsoGroup:insert(m3.collar)
	m3.torsoGroup:insert(m3.head)

	m3.rightArmGroup:insert(m3.rightArm)
	m3.rightArmGroup:insert(m3.myGuyShield)
	m3.torsoGroup:insert(m3.rightArmGroup)
	m3.torsoGroup:insert(m3.splash01)

	m3.myGuy:insert(m3.torsoGroup)
		
	m3.myGuy.xReference = 0
	m3.myGuy.yReference = 0
	m3.leftArmGroup.xReference = 0
	m3.leftArmGroup.yReference = 0
	m3.leftLeg.xReference = 0
	m3.leftLeg.yReference = -10
	m3.rightLeg.xReference = 0
	m3.rightLeg.yReference = -13
	m3.torso.xReference = 0
	m3.torso.yReference = -15
	m3.collar.x = -1
	m3.collar.y = -14
	m3.rightArmGroup.xReference = 16
	m3.rightArmGroup.yReference = 4
	m3.head.xReference = 12
	m3.head.yReference = 22
	m3.torsoGroup.yReference = 17
	m3.torsoGroup.xReference = -13
	m3.splash01.x = 10
	m3.splash01.y = -35

	m3.myGuyLeftFingers.x = 18
	m3.myGuyLeftFingers.y = 20
	
	m3.myGuyShield.rotation = 15
	m3.myGuyShield.x = 10
	m3.myGuyShield.y = 20

	m3.sword.xReference = 0
	m3.sword.yReference = 30
	m3.sword.x = 19
	m3.sword.y = 19

	m3.battleAxe.xReference = 0
	m3.battleAxe.yReference = 30
	m3.battleAxe.x = 19
	m3.battleAxe.y = 19
	
	m3.pistol.xReference = 0
	m3.pistol.yReference = 30
	m3.pistol.rotation = 40
	m3.pistol.x = 15
	m3.pistol.y = 50

	m3.rifle.xReference = 0
	m3.rifle.yReference = 30
	m3.rifle.rotation = 40
	m3.rifle.x = 18
	m3.rifle.y = 58
	
end

assembleOtherGuys()

function spawnOtherGuys(p)

	if (p == "m1") then
		m1.shadow.x = 0
		m1.shadow.y = 36
		m1.leftArmGroup.rotation = -25
		m1.leftArmGroup.x = 1
		m1.leftArmGroup.y = -12
		m1.leftLeg.rotation = 0
		m1.leftLeg.x = 7
		m1.leftLeg.y = 15
		m1.rightLeg.rotation = 0
		m1.rightLeg.x = -9
		m1.rightLeg.y = 13
		m1.torso.rotation = -6
		m1.torso.x = -5
		m1.torso.y = -15
		m1.rightArmGroup.rotation = 0
		m1.rightArmGroup.x = -15
		m1.rightArmGroup.y = -8
		m1.head.rotation = 0
		m1.head.x = 11
		m1.head.y = -18

		m1.torsoGroup.rotation = 0
		m1.torsoGroup.x = -13
		m1.torsoGroup.y = 17
		
		m1.myGuy.y = 200
		m1.myGuy.rotation = 0

		m1.alabard.rotation = 100
		m1.alabard.x = 15
		m1.alabard.y = 20

		m1.sword.rotation = 40	
		
		m1.battleAxe.rotation = 40
	
		m1.gunSmoke01.isVisible = false
		m1.gunSmoke02.isVisible = false
		m1.gunSmoke03.isVisible = false
		m1.gunSmokeDirection = nil
	
		m1.myGuy.isVisible = true
		
		m1.isAttackOne = 1
		
		m1.speed = 1.75
		m1.playerHurt = 0
		
		m1.metMyGuy = 0
		m1.inShotRange = 0
		m1.inSpearRange = 0
		m1.inSwordRange = 0
		m1.inKickRange = 0

		m1.breatheCounter = 1		
		m1.walkCounter = 1
		m1.dyingCounter = 1
		
		m1.alabard.isVisible = false
		m1.sword.isVisible = false
		m1.battleAxe.isVisible = false
		m1.pistol.isVisible = false
		m1.rifle.isVisible = false
		
		m1.splash01.isVisible = false
		
		m1.shadow.isVisible = true
		
		m1.sideing = 0

	elseif (p == "m2") then
		-- Guy 2
		m2.shadow.x = 0
		m2.shadow.y = 36
		m2.leftArmGroup.rotation = -25
		m2.leftArmGroup.x = 1
		m2.leftArmGroup.y = -12
		m2.leftLeg.rotation = 0
		m2.leftLeg.x = 7
		m2.leftLeg.y = 15
		m2.rightLeg.rotation = 0
		m2.rightLeg.x = -9
		m2.rightLeg.y = 13
		m2.torso.rotation = -6
		m2.torso.x = -5
		m2.torso.y = -15
		m2.rightArmGroup.rotation = 0
		m2.rightArmGroup.x = -15
		m2.rightArmGroup.y = -8
		m2.head.rotation = 0
		m2.head.x = 11
		m2.head.y = -18

		m2.torsoGroup.rotation = 0
		m2.torsoGroup.x = -13
		m2.torsoGroup.y = 17

		m2.myGuy.y = 200
		m2.myGuy.rotation = 0

		m2.alabard.rotation = 100
		m2.alabard.x = 15
		m2.alabard.y = 20

		m2.sword.rotation = 40	
		
		m2.battleAxe.rotation = 40

		m2.gunSmoke01.isVisible = false
		m2.gunSmoke02.isVisible = false
		m2.gunSmoke03.isVisible = false
		m2.gunSmokeDirection = nil

		m2.myGuy.isVisible = true
		
		m2.isAttackOne = 1

		m2.speed = 1.75
		m2.playerHurt = 0

		m2.metMyGuy = 0
		m2.inShotRange = 0
		m2.inSpearRange = 0
		m2.inSwordRange = 0
		m2.inKickRange = 0

		m2.breatheCounter = 3
		m2.walkCounter = 1
		m2.dyingCounter = 1

		m2.alabard.isVisible = false
		m2.sword.isVisible = false
		m2.battleAxe.isVisible = false
		m2.pistol.isVisible = false
		m2.rifle.isVisible = false
	
		m2.splash01.isVisible = false
		
		m2.shadow.isVisible = true
		
		m2.sideing = 0
		
	elseif (p == "m3") then
		-- Guy 3
		m3.shadow.x = 0
		m3.shadow.y = 36
		m3.leftArmGroup.rotation = -25
		m3.leftArmGroup.x = 1
		m3.leftArmGroup.y = -12
		m3.leftLeg.rotation = 0
		m3.leftLeg.x = 7
		m3.leftLeg.y = 15
		m3.rightLeg.rotation = 0
		m3.rightLeg.x = -9
		m3.rightLeg.y = 13
		m3.torso.rotation = -6
		m3.torso.x = -5
		m3.torso.y = -15
		m3.rightArmGroup.rotation = 0
		m3.rightArmGroup.x = -15
		m3.rightArmGroup.y = -8
		m3.head.rotation = 0
		m3.head.x = 11
		m3.head.y = -18

		m3.torsoGroup.rotation = 0
		m3.torsoGroup.x = -13
		m3.torsoGroup.y = 17

		m3.myGuy.y = 200
		m3.myGuy.rotation = 0

		m3.sword.rotation = 40	
		
		m3.battleAxe.rotation = 40
		
		m3.gunSmoke01.isVisible = false
		m3.gunSmoke02.isVisible = false
		m3.gunSmoke03.isVisible = false
		m3.gunSmokeDirection = nil
		
		m3.myGuy.isVisible = true
		
		m3.isAttackOne = 1
		
		m3.speed = 1.75
		m3.playerHurt = 0

		m3.metMyGuy = 0
		m3.inShotRange = 0
		m3.inSpearRange = 0
		m3.inSwordRange = 0
		m3.inKickRange = 0
		
		m3.breatheCounter = 5
		m3.walkCounter = 1
		m3.dyingCounter = 1

		m3.sword.isVisible = false
		m3.battleAxe.isVisible = false
		m3.pistol.isVisible = false
		m3.rifle.isVisible = false
		
		m3.splash01.isVisible = false
		
		m3.shadow.isVisible = true
		
		m3.sideing = 0
	end
	
	-- ALL WEAPONS
	
	local gun = 0

	if(v.levelPlaying < 10)then
		gun = math.random(1, 3)
	elseif(v.levelPlaying < 14)then
		gun = math.random(1, 4)
	elseif(v.levelPlaying < 21)then
		gun = math.random(1, 5)
	elseif(v.levelPlaying < 26)then
		gun = math.random(1, 6)
	else
		gun = math.random(1, 6)
	end

	--gun = 1
	
	if (p == "m1") then
		if (gun == 1) then
			m1.activeWeapon = "alabard"
			m1.alabard.isVisible = true
		elseif(gun == 2) then
			m1.activeWeapon = "sword"
			m1.sword.isVisible = true
		elseif(gun == 3) then
			m1.activeWeapon = "battleAxe"
			m1.battleAxe.isVisible = true
		elseif(gun == 4) then
			m1.activeWeapon = "pistol"
			m1.pistol.isVisible = true
		elseif(gun > 4) then
			m1.activeWeapon = "rifle"
			m1.rifle.isVisible = true
		end
	elseif (p == "m2") then
		if (gun == 1) then
			m2.activeWeapon = "alabard"
			m2.alabard.isVisible = true
		elseif(gun == 2) then
			m2.activeWeapon = "sword"
			m2.sword.isVisible = true
		elseif(gun == 3) then
			m2.activeWeapon = "battleAxe"
			m2.battleAxe.isVisible = true
		elseif(gun == 4) then
			m2.activeWeapon = "pistol"
			m2.pistol.isVisible = true
		elseif(gun > 4) then
			m2.activeWeapon = "rifle"
			m2.rifle.isVisible = true
		end
	elseif (p == "m3") then
		if(gun == 1 or gun == 3) then
			m3.activeWeapon = "sword"
			m3.sword.isVisible = true
		elseif(gun == 2) then
			m3.activeWeapon = "battleAxe"
			m3.battleAxe.isVisible = true
		elseif(gun == 4) then
			m3.activeWeapon = "pistol"
			m3.pistol.isVisible = true
		elseif(gun > 4) then
			m3.activeWeapon = "rifle"
			m3.rifle.isVisible = true
		end
	end
	
	
	
	-- HEALTH
	--[[
	if (p == "m1") then
		if(v.levelReached < 13) then
			if (m1.activeWeapon == "alabard") then
				m1.playerHealth = 100 + v.levelReached - 1
			else
				m1.playerHealth = 100 + v.levelReached - 60
			end
		elseif (v.levelReached < 19) then
			m1.playerHealth = 100 + v.levelReached
		else
			m1.playerHealth = 100 + v.levelReached
		end
	elseif (p == "m2") then
		if(v.levelReached < 13) then
			if (m2.activeWeapon == "alabard") then
				m2.playerHealth = 100 + v.levelReached - 1
			else
				m2.playerHealth = 100 + v.levelReached - 60
			end
		elseif (v.levelReached < 19) then
			m2.playerHealth = 100 + v.levelReached
		else
			m2.playerHealth = 100 + v.levelReached
		end
	elseif (p == "m3") then
		if (v.levelReached < 13) then
			m3.playerHealth = 100 + v.levelReached - 1
		elseif (v.levelReached < 19) then
			m3.playerHealth = 100 + v.levelReached
		else
			m3.playerHealth = 100 + v.levelReached
		end
	end
	--]]

	if (p == "m1") then
		m1.playerHealth = 100 + v.levelPlaying * 4
	elseif (p == "m2") then
		m2.playerHealth = 100 + v.levelPlaying * 4
	elseif (p == "m3") then
		m3.playerHealth = 100 + v.levelPlaying * 4
	end

	
	--ALL	--560 - Guy Himself	  -- 650 - iPhone
	
	local direction = math.random(1, 10)
	
	if (direction < 4) then
		direction = 1
	else
		direction = -1
	end
	
	if (p == "m1") then
		if (m2.myGuy.xScale == 1 or m3.myGuy.xScale == 1) then
			direction = -1
		end
	elseif (p == "m2") then
		if (m1.myGuy.xScale == 1 or m3.myGuy.xScale == 1) then
			direction = -1
		end
	elseif (p == "m3") then
		if (m1.myGuy.xScale == 1 or m2.myGuy.xScale == 1) then
			direction = -1
		end
	end
	
	local distance = 650000 + (math.random(1, 72 - (v.levelPlaying * 2)) * 20) + math.random(1, 300)
	--local distance = 650 + math.random(1, 700)
	
	if (direction == 1) then
		distance = 0 - _XB - 150
	end
	--print(direction)
	--print(distance)

	if (p == "m1") then
		m1.isWalking = direction
		m1.myGuy.xScale = m1.isWalking
		m1.myGuy.x = distance
		m1.speed = 1.75 + v.levelPlaying / 40
	elseif (p == "m2") then
		m2.isWalking = direction
		m2.myGuy.xScale = m2.isWalking
		m2.myGuy.x = distance
		m2.speed = 1.75 + v.levelPlaying / 40
	elseif (p == "m3") then
		m3.isWalking = direction
		m3.myGuy.xScale = m3.isWalking
		m3.myGuy.x = distance
		m3.speed = 1.75 + v.levelPlaying / 40
	end
	
end

	
function insertOtherGuys()

	gameScreenDisplayGroup:insert(m3.myGuy)
	gameScreenDisplayGroup:insert(m3.gunSmoke01)
	gameScreenDisplayGroup:insert(m3.gunSmoke02)
	gameScreenDisplayGroup:insert(m3.gunSmoke03)
	
	gameScreenDisplayGroup:insert(m2.myGuy)
	gameScreenDisplayGroup:insert(m2.gunSmoke01)
	gameScreenDisplayGroup:insert(m2.gunSmoke02)
	gameScreenDisplayGroup:insert(m2.gunSmoke03)
	
	gameScreenDisplayGroup:insert(m1.myGuy)	
	gameScreenDisplayGroup:insert(m1.gunSmoke01)
	gameScreenDisplayGroup:insert(m1.gunSmoke02)
	gameScreenDisplayGroup:insert(m1.gunSmoke03)
	
end 

-- MY GUY

local h = {}

local myGuy = display.newGroup()

local leftArmGroup = display.newGroup()
local torsoGroup = display.newGroup()
local rightArmGroup = display.newGroup()

local shadow = display.newImage("Guy Shadow.png")
local myGuyLeftFingers = display.newImage("My Guy Left Fingers.png")

local exp01 = display.newImage("Exp 02.png")

local gunSmoke01 = display.newImage("Gun Smoke 01.png")
local gunSmoke02 = display.newImage("Gun Smoke 02.png")
local gunSmoke03 = display.newImage("Gun Smoke 03.png")
local splash01 = display.newImage("Splash 01.png")

-- MY GUY WEAPONS
local g = {}


function assembleMyGuy_1()

	g.crossbow = display.newGroup()
	
	g.crossbow1 = display.newImage("Crossbow 1.png")
	g.crossbow2 = display.newImage("Crossbow 2.png")
	g.crossbow3 = display.newImage("Crossbow 3.png")
	g.crossbowGold = display.newImage("Crossbow Gold.png")
	g.crossbowStringPulled = display.newImage("Crossbow String Pulled.png")
	g.crossbowStringRelaxed = display.newImage("Crossbow String Relaxed.png")

	g.crossbow:insert(g.crossbow1)
	g.crossbow:insert(g.crossbow2)
	g.crossbow:insert(g.crossbow3)
	g.crossbow:insert(g.crossbowGold)
	g.crossbow:insert(g.crossbowStringRelaxed)
	
	g.arrow = display.newGroup()
	
	g.arrow1 = display.newImage("Arrow 1.png")
	g.arrow2 = display.newImage("Arrow 2.png")
	g.arrow3 = display.newImage("Arrow 3.png")
	g.arrowGold = display.newImage("Arrow Gold.png")

	g.arrow:insert(g.arrow1)
	g.arrow:insert(g.arrow2)
	g.arrow:insert(g.arrow3)
	g.arrow:insert(g.arrowGold)
	
	g.arrowDouble = display.newGroup()
	
	g.arrow1Double = display.newImage("Arrow 1.png")
	g.arrow2Double = display.newImage("Arrow 2.png")
	g.arrow3Double = display.newImage("Arrow 3.png")
	g.arrowGoldDouble = display.newImage("Arrow Gold.png")

	g.arrowDouble:insert(g.arrow1Double)
	g.arrowDouble:insert(g.arrow2Double)
	g.arrowDouble:insert(g.arrow3Double)
	g.arrowDouble:insert(g.arrowGoldDouble)
	
	g.knifeLeft = display.newGroup()

	g.knife1Left = display.newImage("Knife 1.png")
	g.knife2Left = display.newImage("Knife 2.png")
	g.knife3Left = display.newImage("Knife 3.png")
	g.knifeGoldLeft = display.newImage("Knife Gold.png")

	g.knifeLeft:insert(g.knife1Left)
	g.knifeLeft:insert(g.knife2Left)
	g.knifeLeft:insert(g.knife3Left)
	g.knifeLeft:insert(g.knifeGoldLeft)
	
	g.knifeRight = display.newGroup()
	
	g.knife1Right = display.newImage("Knife 1.png")
	g.knife2Right = display.newImage("Knife 2.png")
	g.knife3Right = display.newImage("Knife 3.png")
	g.knifeGoldRight = display.newImage("Knife Gold.png")

	g.knifeRight:insert(g.knife1Right)
	g.knifeRight:insert(g.knife2Right)
	g.knifeRight:insert(g.knife3Right)
	g.knifeRight:insert(g.knifeGoldRight)
	
	g.knifeLeftDouble = display.newGroup()	
	
	g.knifeLeftDouble.xReference = 7
	g.knifeLeftDouble.yReference = 29
	
	g.knife1LeftDouble = display.newImage("Knife 1.png")
	g.knife2LeftDouble = display.newImage("Knife 2.png")
	g.knife3LeftDouble = display.newImage("Knife 3.png")
	g.knifeGoldLeftDouble = display.newImage("Knife Gold.png")

	g.knifeLeftDouble:insert(g.knife1LeftDouble)
	g.knifeLeftDouble:insert(g.knife2LeftDouble)
	g.knifeLeftDouble:insert(g.knife3LeftDouble)
	g.knifeLeftDouble:insert(g.knifeGoldLeftDouble)
	
	g.knifeRightDouble = display.newGroup()	

	g.knifeRightDouble.xReference = 7
	g.knifeRightDouble.yReference = 29

	g.knife1RightDouble = display.newImage("Knife 1.png")
	g.knife2RightDouble = display.newImage("Knife 2.png")
	g.knife3RightDouble = display.newImage("Knife 3.png")
	g.knifeGoldRightDouble = display.newImage("Knife Gold.png")

	g.knifeRightDouble:insert(g.knife1RightDouble)
	g.knifeRightDouble:insert(g.knife2RightDouble)
	g.knifeRightDouble:insert(g.knife3RightDouble)
	g.knifeRightDouble:insert(g.knifeGoldRightDouble)
	
	g.tomahawkLeft = display.newGroup()

	g.tomahawk1Left = display.newImage("Tomahawk 1.png")
	g.tomahawk2Left = display.newImage("Tomahawk 2.png")
	g.tomahawk3Left = display.newImage("Tomahawk 3.png")
	g.tomahawkGoldLeft = display.newImage("Tomahawk Gold.png")
	
	g.tomahawkLeft:insert(g.tomahawk1Left)
	g.tomahawkLeft:insert(g.tomahawk2Left)
	g.tomahawkLeft:insert(g.tomahawk3Left)
	g.tomahawkLeft:insert(g.tomahawkGoldLeft)

	g.tomahawkRight = display.newGroup()
	
	g.tomahawk1Right = display.newImage("Tomahawk 1.png")
	g.tomahawk2Right = display.newImage("Tomahawk 2.png")
	g.tomahawk3Right = display.newImage("Tomahawk 3.png")
	g.tomahawkGoldRight = display.newImage("Tomahawk Gold.png")
	
	g.tomahawkRight:insert(g.tomahawk1Right)
	g.tomahawkRight:insert(g.tomahawk2Right)
	g.tomahawkRight:insert(g.tomahawk3Right)
	g.tomahawkRight:insert(g.tomahawkGoldRight)

	g.tomahawkLeftDouble = display.newGroup()	
	
	g.tomahawkLeftDouble.xReference = 17
	g.tomahawkLeftDouble.yReference = 27
	
	g.tomahawk1LeftDouble = display.newImage("Tomahawk 1.png")
	g.tomahawk2LeftDouble = display.newImage("Tomahawk 2.png")
	g.tomahawk3LeftDouble = display.newImage("Tomahawk 3.png")
	g.tomahawkGoldLeftDouble = display.newImage("Tomahawk Gold.png")

	g.tomahawkLeftDouble:insert(g.tomahawk1LeftDouble)
	g.tomahawkLeftDouble:insert(g.tomahawk2LeftDouble)
	g.tomahawkLeftDouble:insert(g.tomahawk3LeftDouble)
	g.tomahawkLeftDouble:insert(g.tomahawkGoldLeftDouble)
	
	g.tomahawkRightDouble = display.newGroup()	

	g.tomahawkRightDouble.xReference = 17
	g.tomahawkRightDouble.yReference = 27
	
	g.tomahawk1RightDouble = display.newImage("Tomahawk 1.png")
	g.tomahawk2RightDouble = display.newImage("Tomahawk 2.png")
	g.tomahawk3RightDouble = display.newImage("Tomahawk 3.png")
	g.tomahawkGoldRightDouble = display.newImage("Tomahawk Gold.png")

	g.tomahawkRightDouble:insert(g.tomahawk1RightDouble)
	g.tomahawkRightDouble:insert(g.tomahawk2RightDouble)
	g.tomahawkRightDouble:insert(g.tomahawk3RightDouble)
	g.tomahawkRightDouble:insert(g.tomahawkGoldRightDouble)
	
	g.pistolLeft = display.newGroup()
	
	g.pistol1Left = display.newImage("Pistol 1.png")
	g.pistol2Left = display.newImage("Pistol 2.png")
	g.pistol3Left = display.newImage("Pistol 3.png")
	g.pistolGoldLeft = display.newImage("Pistol Gold.png")

	g.pistol1LeftDot = display.newImage("dot.png")
	g.pistol2LeftDot = display.newImage("dot.png")
	g.pistol3LeftDot = display.newImage("dot.png")
	g.pistolGoldLeftDot = display.newImage("dot.png")

	g.pistolLeft:insert(g.pistol1Left)
	g.pistolLeft:insert(g.pistol2Left)
	g.pistolLeft:insert(g.pistol3Left)
	g.pistolLeft:insert(g.pistolGoldLeft)
	g.pistolLeft:insert(g.pistol1LeftDot)
	g.pistolLeft:insert(g.pistol2LeftDot)
	g.pistolLeft:insert(g.pistol3LeftDot)
	g.pistolLeft:insert(g.pistolGoldLeftDot)	
	
	g.pistolRight = display.newGroup()
	
	g.pistol1Right = display.newImage("Pistol 1.png")
	g.pistol2Right = display.newImage("Pistol 2.png")
	g.pistol3Right = display.newImage("Pistol 3.png")
	g.pistolGoldRight = display.newImage("Pistol Gold.png")

	g.pistol1RightDot = display.newImage("dot.png")
	g.pistol2RightDot = display.newImage("dot.png")
	g.pistol3RightDot = display.newImage("dot.png")
	g.pistolGoldRightDot = display.newImage("dot.png")

	g.pistolRight:insert(g.pistol1Right)
	g.pistolRight:insert(g.pistol2Right)
	g.pistolRight:insert(g.pistol3Right)
	g.pistolRight:insert(g.pistolGoldRight)
	g.pistolRight:insert(g.pistol1RightDot)
	g.pistolRight:insert(g.pistol2RightDot)
	g.pistolRight:insert(g.pistol3RightDot)
	g.pistolRight:insert(g.pistolGoldRightDot)
	
	g.rifleLeft = display.newGroup()

	g.rifle1Left = display.newImage("Rifle 1.png")
	g.rifle2Left = display.newImage("Rifle 2.png")
	g.rifle3Left = display.newImage("Rifle 3.png")
	g.rifleGoldLeft = display.newImage("Rifle Gold.png")

	g.rifle1LeftDot = display.newImage("dot.png")
	g.rifle2LeftDot = display.newImage("dot.png")
	g.rifle3LeftDot = display.newImage("dot.png")
	g.rifleGoldLeftDot = display.newImage("dot.png")

	g.rifleLeft:insert(g.rifle1Left)
	g.rifleLeft:insert(g.rifle2Left)
	g.rifleLeft:insert(g.rifle3Left)
	g.rifleLeft:insert(g.rifleGoldLeft)
	g.rifleLeft:insert(g.rifle1LeftDot)
	g.rifleLeft:insert(g.rifle2LeftDot)
	g.rifleLeft:insert(g.rifle3LeftDot)
	g.rifleLeft:insert(g.rifleGoldLeftDot)
	
	g.rifleRight = display.newGroup()
	
	g.rifle1Right = display.newImage("Rifle 1.png")
	g.rifle2Right = display.newImage("Rifle 2.png")
	g.rifle3Right = display.newImage("Rifle 3.png")
	g.rifleGoldRight = display.newImage("Rifle Gold.png")

	g.rifle1RightDot = display.newImage("dot.png")
	g.rifle2RightDot = display.newImage("dot.png")
	g.rifle3RightDot = display.newImage("dot.png")
	g.rifleGoldRightDot = display.newImage("dot.png")

	g.rifleRight:insert(g.rifle1Right)
	g.rifleRight:insert(g.rifle2Right)
	g.rifleRight:insert(g.rifle3Right)
	g.rifleRight:insert(g.rifleGoldRight)
	g.rifleRight:insert(g.rifle1RightDot)
	g.rifleRight:insert(g.rifle2RightDot)
	g.rifleRight:insert(g.rifle3RightDot)
	g.rifleRight:insert(g.rifleGoldRightDot)
	
	g.battleAxe1 = display.newImage("Battle Axe.png")
	g.mace1 = display.newImage("Mace.png")
	g.machete1 = display.newImage("Machete.png")
	g.macheteGold = display.newImage("Machete Gold.png")
	

	g.granade = display.newGroup()
	g.granadeDouble = display.newGroup()
	
	g.granade1 = display.newImage("Granade.png")
	g.granade1Double = display.newImage("Granade.png")

	g.granadeGold = display.newImage("Granade Gold.png")
	g.granadeGoldDouble = display.newImage("Granade Gold.png")	
	
	g.granade:insert(g.granade1)
	g.granade:insert(g.granadeGold)

	g.granadeDouble:insert(g.granade1Double)
	g.granadeDouble:insert(g.granadeGoldDouble)
	

	h.leftArm1 = display.newImage("Left Arm Empty.png")	
	h.leftLeg1 = display.newImage("Left Leg Empty.png")
	h.rightLeg1 = display.newImage("Right Leg Empty.png")
	h.rightArm1 = display.newImage("Right Arm Empty.png")
	
	h.cHead1 = 16
	h.cHead2 = 16
	h.cTorso1 = 18
	h.cTorso2 = 16
	h.cArms = 18
	h.cLegs = 18
	h.cBroadway = 0
	h.cVegas = 0
	
	
	g.myGuyShield = display.newImage("dot.png")
	g.myGuyShieldGold = display.newImage("dot.png")
	g.myGuyShield.alpha = 0
	g.myGuyShieldGold.alpha = 0
	g.myGuyShield.isVisible = false
	g.myGuyShieldGold.isVisible = false
	
	g.shieldGold = display.newImage("Shield Gold 2.png")
	g.shieldGold.alpha = 1

	
end 

assembleMyGuy_1()

function assembleMyGuy_2()

	if (h.leftArm2 ~= nil) then
		
		h.leftArm2:removeSelf()
		h.leftArm2 = nil
		h.leftArm3:removeSelf()
		h.leftArm3 = nil
		
		h.rightArm2:removeSelf()
		h.rightArm2 = nil
		h.rightArm3:removeSelf()
		h.rightArm3 = nil

		h.leftLeg2:removeSelf()
		h.leftLeg2 = nil
		h.leftLeg3:removeSelf()
		h.leftLeg3 = nil
		
		h.rightLeg2:removeSelf()
		h.rightLeg2 = nil
		h.rightLeg3:removeSelf()
		h.rightLeg3 = nil
		
		h.torso1:removeSelf()
		h.torso1 = nil
		h.torso2:removeSelf()
		h.torso2 = nil

		h.neck1:removeSelf()
		h.neck1 = nil
		h.neck2:removeSelf()
		h.neck2 = nil

		h.belt1:removeSelf()
		h.belt1 = nil
		h.belt2:removeSelf()
		h.belt2 = nil

		h.head11:removeSelf()
		h.head11 = nil		
		h.head12:removeSelf()
		h.head12 = nil		
		h.head21:removeSelf()
		h.head21 = nil		
		h.head22:removeSelf()
		h.head22 = nil		
		
		h.head3:removeSelf()
		h.head3 = nil		

		h.head4:removeSelf()
		h.head4 = nil		

		h.head5:removeSelf()
		h.head5 = nil		

		h.head6:removeSelf()
		h.head6 = nil		
		
		g.shield11:removeSelf()
		g.shield12:removeSelf()
		g.shield21:removeSelf()
		g.shield22:removeSelf()
		
	end

	---ARMS
	if (h.cArms == 1 or h.cArms == 2 or h.cArms == 3 or h.cArms == 19 or h.cArms == 20) then
		h.leftArm2 = display.newImage("Left Arm Yellow.png")
		h.leftArm2.aplha = 1
		h.rightArm2 = display.newImage("Right Arm Yellow.png")
		h.rightArm2.alpha = 1
	elseif (h.cArms == 4 or h.cArms == 5 or h.cArms == 6 or h.cArms == 7 or h.cArms == 8 or h.cArms == 11 or h.cArms == 12 or h.cArms == 13 or h.cArms == 14) then
		h.leftArm2 = display.newImage("Left Arm Blue.png")
		h.leftArm2.aplha = 1
		h.rightArm2 = display.newImage("Right Arm Blue.png")
		h.rightArm2.alpha = 1
	elseif (h.cArms == 9 or h.cArms == 10 or h.cArms == 15 or h.cArms == 16 or h.cArms == 17 or h.cArms == 18) then
		h.leftArm2 = display.newImage("Left Arm Red.png")
		h.leftArm2.aplha = 1
		h.rightArm2 = display.newImage("Right Arm Red.png")
		h.rightArm2.alpha = 1
	elseif (h.cArms == 21 or h.cArms == 22 or h.cArms == 23 or h.cArms == 24 or h.cArms == 25) then
		h.leftArm2 = display.newImage("Left Arm Black.png")
		h.leftArm2.aplha = 1
		h.rightArm2 = display.newImage("Right Arm Black.png")
		h.rightArm2.alpha = 1
	elseif (h.cArms == 26) then		
		h.leftArm2 = display.newImage("Left Arm White.png")
		h.leftArm2.aplha = 1
		h.rightArm2 = display.newImage("Right Arm White.png")
		h.rightArm2.alpha = 1
	end
	
	if (h.cArms == 1 or h.cArms == 2 or h.cArms == 3 or h.cArms == 11 or h.cArms == 15 or h.cArms == 21) then
		h.leftArm3 = display.newImage("Left Arm Black.png")
		h.rightArm3 = display.newImage("Right Arm Black.png")
	elseif (h.cArms == 4 or h.cArms == 5 or h.cArms == 6 or h.cArms == 17 or h.cArms == 18 or h.cArms == 19) then
		h.leftArm3 = display.newImage("Left Arm Yellow.png")
		h.rightArm3 = display.newImage("Right Arm Yellow.png")	
	elseif (h.cArms == 7 or h.cArms == 8 or h.cArms == 16) then
		h.leftArm3 = display.newImage("Left Arm Red.png")
		h.rightArm3 = display.newImage("Right Arm Red.png")	
	elseif (h.cArms == 12) then
		h.leftArm3 = display.newImage("Left Arm Blue.png")
		h.rightArm3 = display.newImage("Right Arm Blue.png")	
	elseif (h.cArms == 9 or h.cArms == 10 or h.cArms == 13 or h.cArms == 14 or h.cArms == 20 or h.cArms == 22 or h.cArms == 23 or h.cArms == 24 or h.cArms == 25 or h.cArms == 26) then
		h.leftArm3 = display.newImage("Left Arm White.png")
		h.rightArm3 = display.newImage("Right Arm White.png")	
	end

	if (h.cArms == 1) then
		h.leftArm3.alpha = .25
		h.rightArm3.alpha = .25
	elseif (h.cArms == 2) then
		h.leftArm3.alpha = .50
		h.rightArm3.alpha = .50
	elseif (h.cArms == 3) then
		h.leftArm3.alpha = .70
		h.rightArm3.alpha = .70
	elseif (h.cArms == 4) then
		h.leftArm3.alpha = .35
		h.rightArm3.alpha = .35
	elseif (h.cArms == 5) then
		h.leftArm3.alpha = .47
		h.rightArm3.alpha = .47
	elseif (h.cArms == 6) then
		h.leftArm3.alpha = .65
		h.rightArm3.alpha = .65
	elseif (h.cArms == 7) then
		h.leftArm3.alpha = .50
		h.rightArm3.alpha = .50
	elseif (h.cArms == 8) then
		h.leftArm3.alpha = .75
		h.rightArm3.alpha = .75
	elseif (h.cArms == 9) then
		h.leftArm3.alpha = .25
		h.rightArm3.alpha = .25
	elseif (h.cArms == 10) then
		h.leftArm3.alpha = .50
		h.rightArm3.alpha = .50
	elseif (h.cArms == 11) then
		h.leftArm3.alpha = .50
		h.rightArm3.alpha = .50
	elseif (h.cArms == 12) then
		h.leftArm3.alpha = 1
		h.rightArm3.alpha = 1
	elseif (h.cArms == 13) then
		h.leftArm3.alpha = .42
		h.rightArm3.alpha = .42
	elseif (h.cArms == 14) then
		h.leftArm3.alpha = .74
		h.rightArm3.alpha = .74
	elseif (h.cArms == 15) then
		h.leftArm3.alpha = .50
		h.rightArm3.alpha = .50
	elseif (h.cArms == 16) then
		h.leftArm3.alpha = 1
		h.rightArm3.alpha = 1
	elseif (h.cArms == 17) then
		h.leftArm3.alpha = .40
		h.rightArm3.alpha = .40
	elseif (h.cArms == 18) then
		h.leftArm3.alpha = .80
		h.rightArm3.alpha = .80
	elseif (h.cArms == 19) then
		h.leftArm3.alpha = 1
		h.rightArm3.alpha = 1
	elseif (h.cArms == 20) then
		h.leftArm3.alpha = .50
		h.rightArm3.alpha = .50
	elseif (h.cArms == 21) then
		h.leftArm3.alpha = 1
		h.rightArm3.alpha = 1
	elseif (h.cArms == 22) then
		h.leftArm3.alpha = .25
		h.rightArm3.alpha = .25
	elseif (h.cArms == 23) then
		h.leftArm3.alpha = .45
		h.rightArm3.alpha = .45
	elseif (h.cArms == 24) then
		h.leftArm3.alpha = .62
		h.rightArm3.alpha = .62
	elseif (h.cArms == 25) then
		h.leftArm3.alpha = .80
		h.rightArm3.alpha = .80
	elseif (h.cArms == 26) then
		h.leftArm3.alpha = 1
		h.rightArm3.alpha = 1
	end


	-- LEGS
	if (h.cLegs == 1 or h.cLegs == 2 or h.cLegs == 3 or h.cLegs == 19 or h.cLegs == 20) then
		h.leftLeg2 = display.newImage("Left Leg Yellow.png")
		h.leftLeg2.aplha = 1
		h.rightLeg2 = display.newImage("Right Leg Yellow.png")
		h.rightLeg2.alpha = 1
	elseif (h.cLegs == 4 or h.cLegs == 5 or h.cLegs == 6 or h.cLegs == 7 or h.cLegs == 8 or h.cLegs == 11 or h.cLegs == 12 or h.cLegs == 13 or h.cLegs == 14) then
		h.leftLeg2 = display.newImage("Left Leg Blue.png")
		h.leftLeg2.aplha = 1
		h.rightLeg2 = display.newImage("Right Leg Blue.png")
		h.rightLeg2.alpha = 1
	elseif (h.cLegs == 9 or h.cLegs == 10 or h.cLegs == 15 or h.cLegs == 16 or h.cLegs == 17 or h.cLegs == 18) then
		h.leftLeg2 = display.newImage("Left Leg Red.png")
		h.leftLeg2.aplha = 1
		h.rightLeg2 = display.newImage("Right Leg Red.png")
		h.rightLeg2.alpha = 1
	elseif (h.cLegs == 21 or h.cLegs == 22 or h.cLegs == 23 or h.cLegs == 24 or h.cLegs == 25) then
		h.leftLeg2 = display.newImage("Left Leg Black.png")
		h.leftLeg2.aplha = 1
		h.rightLeg2 = display.newImage("Right Leg Black.png")
		h.rightLeg2.alpha = 1
	elseif (h.cLegs == 26) then		
		h.leftLeg2 = display.newImage("Left Leg White.png")
		h.leftLeg2.aplha = 1
		h.rightLeg2 = display.newImage("Right Leg White.png")
		h.rightLeg2.alpha = 1
	end
	
	if (h.cLegs == 1 or h.cLegs == 2 or h.cLegs == 3 or h.cLegs == 11 or h.cLegs == 15 or h.cLegs == 21) then
		h.leftLeg3 = display.newImage("Left Leg Black.png")
		h.rightLeg3 = display.newImage("Right Leg Black.png")
	elseif (h.cLegs == 4 or h.cLegs == 5 or h.cLegs == 6 or h.cLegs == 17 or h.cLegs == 18 or h.cLegs == 19) then
		h.leftLeg3 = display.newImage("Left Leg Yellow.png")
		h.rightLeg3 = display.newImage("Right Leg Yellow.png")	
	elseif (h.cLegs == 7 or h.cLegs == 8 or h.cLegs == 16) then
		h.leftLeg3 = display.newImage("Left Leg Red.png")
		h.rightLeg3 = display.newImage("Right Leg Red.png")	
	elseif (h.cLegs == 12) then
		h.leftLeg3 = display.newImage("Left Leg Blue.png")
		h.rightLeg3 = display.newImage("Right Leg Blue.png")	
	elseif (h.cLegs == 9 or h.cLegs == 10 or h.cLegs == 13 or h.cLegs == 14 or h.cLegs == 20 or h.cLegs == 22 or h.cLegs == 23 or h.cLegs == 24 or h.cLegs == 25 or h.cLegs == 26) then
		h.leftLeg3 = display.newImage("Left Leg White.png")
		h.rightLeg3 = display.newImage("Right Leg White.png")	
	end

	if (h.cLegs == 1) then
		h.leftLeg3.alpha = .25
		h.rightLeg3.alpha = .25
	elseif (h.cLegs == 2) then
		h.leftLeg3.alpha = .50
		h.rightLeg3.alpha = .50
	elseif (h.cLegs == 3) then
		h.leftLeg3.alpha = .70
		h.rightLeg3.alpha = .70
	elseif (h.cLegs == 4) then
		h.leftLeg3.alpha = .35
		h.rightLeg3.alpha = .35
	elseif (h.cLegs == 5) then
		h.leftLeg3.alpha = .47
		h.rightLeg3.alpha = .47
	elseif (h.cLegs == 6) then
		h.leftLeg3.alpha = .65
		h.rightLeg3.alpha = .65
	elseif (h.cLegs == 7) then
		h.leftLeg3.alpha = .50
		h.rightLeg3.alpha = .50
	elseif (h.cLegs == 8) then
		h.leftLeg3.alpha = .75
		h.rightLeg3.alpha = .75
	elseif (h.cLegs == 9) then
		h.leftLeg3.alpha = .25
		h.rightLeg3.alpha = .25
	elseif (h.cLegs == 10) then
		h.leftLeg3.alpha = .50
		h.rightLeg3.alpha = .50
	elseif (h.cLegs == 11) then
		h.leftLeg3.alpha = .50
		h.rightLeg3.alpha = .50
	elseif (h.cLegs == 12) then
		h.leftLeg3.alpha = 1
		h.rightLeg3.alpha = 1
	elseif (h.cLegs == 13) then
		h.leftLeg3.alpha = .42
		h.rightLeg3.alpha = .42
	elseif (h.cLegs == 14) then
		h.leftLeg3.alpha = .74
		h.rightLeg3.alpha = .74
	elseif (h.cLegs == 15) then
		h.leftLeg3.alpha = .50
		h.rightLeg3.alpha = .50
	elseif (h.cLegs == 16) then
		h.leftLeg3.alpha = 1
		h.rightLeg3.alpha = 1
	elseif (h.cLegs == 17) then
		h.leftLeg3.alpha = .40
		h.rightLeg3.alpha = .40
	elseif (h.cLegs == 18) then
		h.leftLeg3.alpha = .80
		h.rightLeg3.alpha = .80
	elseif (h.cLegs == 19) then
		h.leftLeg3.alpha = 1
		h.rightLeg3.alpha = 1
	elseif (h.cLegs == 20) then
		h.leftLeg3.alpha = .50
		h.rightLeg3.alpha = .50
	elseif (h.cLegs == 21) then
		h.leftLeg3.alpha = 1
		h.rightLeg3.alpha = 1
	elseif (h.cLegs == 22) then
		h.leftLeg3.alpha = .25
		h.rightLeg3.alpha = .25
	elseif (h.cLegs == 23) then
		h.leftLeg3.alpha = .45
		h.rightLeg3.alpha = .45
	elseif (h.cLegs == 24) then
		h.leftLeg3.alpha = .62
		h.rightLeg3.alpha = .62
	elseif (h.cLegs == 25) then
		h.leftLeg3.alpha = .80
		h.rightLeg3.alpha = .80
	elseif (h.cLegs == 26) then
		h.leftLeg3.alpha = 1
		h.rightLeg3.alpha = 1
	end
	
	
	-- TORSO
	if (h.cTorso1 == 1 or h.cTorso1 == 2 or h.cTorso1 == 3 or h.cTorso1 == 19 or h.cTorso1 == 20) then
		h.torso1 = display.newImage("Torso Yellow.png")
		h.torso1.aplha = 1
	elseif (h.cTorso1 == 4 or h.cTorso1 == 5 or h.cTorso1 == 6 or h.cTorso1 == 7 or h.cTorso1 == 8 or h.cTorso1 == 11 or h.cTorso1 == 12 or h.cTorso1 == 13 or h.cTorso1 == 14) then
		h.torso1 = display.newImage("Torso Blue.png")
		h.torso1.aplha = 1
	elseif (h.cTorso1 == 9 or h.cTorso1 == 10 or h.cTorso1 == 15 or h.cTorso1 == 16 or h.cTorso1 == 17 or h.cTorso1 == 18) then
		h.torso1 = display.newImage("Torso Red.png")
		h.torso1.aplha = 1
	elseif (h.cTorso1 == 21 or h.cTorso1 == 22 or h.cTorso1 == 23 or h.cTorso1 == 24 or h.cTorso1 == 25) then
		h.torso1 = display.newImage("Torso Black.png")
		h.torso1.aplha = 1
	elseif (h.cTorso1 == 26) then		
		h.torso1 = display.newImage("Torso White.png")
		h.torso1.aplha = 1
	end
	
	if (h.cTorso1 == 1 or h.cTorso1 == 2 or h.cTorso1 == 3 or h.cTorso1 == 11 or h.cTorso1 == 15 or h.cTorso1 == 21) then
		h.torso2 = display.newImage("Torso Black.png")
	elseif (h.cTorso1 == 4 or h.cTorso1 == 5 or h.cTorso1 == 6 or h.cTorso1 == 17 or h.cTorso1 == 18 or h.cTorso1 == 19) then
		h.torso2 = display.newImage("Torso Yellow.png")
	elseif (h.cTorso1 == 7 or h.cTorso1 == 8 or h.cTorso1 == 16) then
		h.torso2 = display.newImage("Torso Red.png")
	elseif (h.cTorso1 == 12) then
		h.torso2 = display.newImage("Torso Blue.png")
	elseif (h.cTorso1 == 9 or h.cTorso1 == 10 or h.cTorso1 == 13 or h.cTorso1 == 14 or h.cTorso1 == 20 or h.cTorso1 == 22 or h.cTorso1 == 23 or h.cTorso1 == 24 or h.cTorso1 == 25 or h.cTorso1 == 26) then
		h.torso2 = display.newImage("Torso White.png")
	end

	if (h.cTorso1 == 1) then
		h.torso2.alpha = .25
	elseif (h.cTorso1 == 2) then
		h.torso2.alpha = .50
	elseif (h.cTorso1 == 3) then
		h.torso2.alpha = .70
	elseif (h.cTorso1 == 4) then
		h.torso2.alpha = .35
	elseif (h.cTorso1 == 5) then
		h.torso2.alpha = .47
	elseif (h.cTorso1 == 6) then
		h.torso2.alpha = .65
	elseif (h.cTorso1 == 7) then
		h.torso2.alpha = .50
	elseif (h.cTorso1 == 8) then
		h.torso2.alpha = .75
	elseif (h.cTorso1 == 9) then
		h.torso2.alpha = .25
	elseif (h.cTorso1 == 10) then
		h.torso2.alpha = .50
	elseif (h.cTorso1 == 11) then
		h.torso2.alpha = .50
	elseif (h.cTorso1 == 12) then
		h.torso2.alpha = 1
	elseif (h.cTorso1 == 13) then
		h.torso2.alpha = .42
	elseif (h.cTorso1 == 14) then
		h.torso2.alpha = .74
	elseif (h.cTorso1 == 15) then
		h.torso2.alpha = .50
	elseif (h.cTorso1 == 16) then
		h.torso2.alpha = 1
	elseif (h.cTorso1 == 17) then
		h.torso2.alpha = .40
	elseif (h.cTorso1 == 18) then
		h.torso2.alpha = .80
	elseif (h.cTorso1 == 19) then
		h.torso2.alpha = 1
	elseif (h.cTorso1 == 20) then
		h.torso2.alpha = .50
	elseif (h.cTorso1 == 21) then
		h.torso2.alpha = 1
	elseif (h.cTorso1 == 22) then
		h.torso2.alpha = .25
	elseif (h.cTorso1 == 23) then
		h.torso2.alpha = .45
	elseif (h.cTorso1 == 24) then
		h.torso2.alpha = .62
	elseif (h.cTorso1 == 25) then
		h.torso2.alpha = .80
	elseif (h.cTorso1 == 26) then
		h.torso2.alpha = 1
	end
	
	
	-- NECK / BELT

	if (h.cTorso2 == 1 or h.cTorso2 == 2 or h.cTorso2 == 3 or h.cTorso2 == 19 or h.cTorso2 == 20) then
		h.neck1 = display.newImage("Neck Yellow.png")
		h.neck1.aplha = 1
		h.belt1 = display.newImage("Belt Yellow.png")
		h.belt1.alpha = 1
	elseif (h.cTorso2 == 4 or h.cTorso2 == 5 or h.cTorso2 == 6 or h.cTorso2 == 7 or h.cTorso2 == 8 or h.cTorso2 == 11 or h.cTorso2 == 12 or h.cTorso2 == 13 or h.cTorso2 == 14) then
		h.neck1 = display.newImage("Neck Blue.png")
		h.neck1.aplha = 1
		h.belt1 = display.newImage("Belt Blue.png")
		h.belt1.alpha = 1
	elseif (h.cTorso2 == 9 or h.cTorso2 == 10 or h.cTorso2 == 15 or h.cTorso2 == 16 or h.cTorso2 == 17 or h.cTorso2 == 18) then
		h.neck1 = display.newImage("Neck Red.png")
		h.neck1.aplha = 1
		h.belt1 = display.newImage("Belt Red.png")
		h.belt1.alpha = 1
	elseif (h.cTorso2 == 21 or h.cTorso2 == 22 or h.cTorso2 == 23 or h.cTorso2 == 24 or h.cTorso2 == 25) then
		h.neck1 = display.newImage("Neck Black.png")
		h.neck1.aplha = 1
		h.belt1 = display.newImage("Belt Black.png")
		h.belt1.alpha = 1
	elseif (h.cTorso2 == 26) then		
		h.neck1 = display.newImage("Neck White.png")
		h.neck1.aplha = 1
		h.belt1 = display.newImage("Belt White.png")
		h.belt1.alpha = 1
	end
	
	if (h.cTorso2 == 1 or h.cTorso2 == 2 or h.cTorso2 == 3 or h.cTorso2 == 11 or h.cTorso2 == 15 or h.cTorso2 == 21) then
		h.neck2 = display.newImage("Neck Black.png")
		h.belt2 = display.newImage("Belt Black.png")
	elseif (h.cTorso2 == 4 or h.cTorso2 == 5 or h.cTorso2 == 6 or h.cTorso2 == 17 or h.cTorso2 == 18 or h.cTorso2 == 19) then
		h.neck2 = display.newImage("Neck Yellow.png")
		h.belt2 = display.newImage("Belt Yellow.png")	
	elseif (h.cTorso2 == 7 or h.cTorso2 == 8 or h.cTorso2 == 16) then
		h.neck2 = display.newImage("Neck Red.png")
		h.belt2 = display.newImage("Belt Red.png")	
	elseif (h.cTorso2 == 12) then
		h.neck2 = display.newImage("Neck Blue.png")
		h.belt2 = display.newImage("Belt Blue.png")	
	elseif (h.cTorso2 == 9 or h.cTorso2 == 10 or h.cTorso2 == 13 or h.cTorso2 == 14 or h.cTorso2 == 20 or h.cTorso2 == 22 or h.cTorso2 == 23 or h.cTorso2 == 24 or h.cTorso2 == 25 or h.cTorso2 == 26) then
		h.neck2 = display.newImage("Neck White.png")
		h.belt2 = display.newImage("Belt White.png")	
	end

	if (h.cTorso2 == 1) then
		h.neck2.alpha = .25
		h.belt2.alpha = .25
	elseif (h.cTorso2 == 2) then
		h.neck2.alpha = .50
		h.belt2.alpha = .50
	elseif (h.cTorso2 == 3) then
		h.neck2.alpha = .70
		h.belt2.alpha = .70
	elseif (h.cTorso2 == 4) then
		h.neck2.alpha = .35
		h.belt2.alpha = .35
	elseif (h.cTorso2 == 5) then
		h.neck2.alpha = .47
		h.belt2.alpha = .47
	elseif (h.cTorso2 == 6) then
		h.neck2.alpha = .65
		h.belt2.alpha = .65
	elseif (h.cTorso2 == 7) then
		h.neck2.alpha = .50
		h.belt2.alpha = .50
	elseif (h.cTorso2 == 8) then
		h.neck2.alpha = .75
		h.belt2.alpha = .75
	elseif (h.cTorso2 == 9) then
		h.neck2.alpha = .25
		h.belt2.alpha = .25
	elseif (h.cTorso2 == 10) then
		h.neck2.alpha = .50
		h.belt2.alpha = .50
	elseif (h.cTorso2 == 11) then
		h.neck2.alpha = .50
		h.belt2.alpha = .50
	elseif (h.cTorso2 == 12) then
		h.neck2.alpha = 1
		h.belt2.alpha = 1
	elseif (h.cTorso2 == 13) then
		h.neck2.alpha = .42
		h.belt2.alpha = .42
	elseif (h.cTorso2 == 14) then
		h.neck2.alpha = .74
		h.belt2.alpha = .74
	elseif (h.cTorso2 == 15) then
		h.neck2.alpha = .50
		h.belt2.alpha = .50
	elseif (h.cTorso2 == 16) then
		h.neck2.alpha = 1
		h.belt2.alpha = 1
	elseif (h.cTorso2 == 17) then
		h.neck2.alpha = .40
		h.belt2.alpha = .40
	elseif (h.cTorso2 == 18) then
		h.neck2.alpha = .80
		h.belt2.alpha = .80
	elseif (h.cTorso2 == 19) then
		h.neck2.alpha = 1
		h.belt2.alpha = 1
	elseif (h.cTorso2 == 20) then
		h.neck2.alpha = .50
		h.belt2.alpha = .50
	elseif (h.cTorso2 == 21) then
		h.neck2.alpha = 1
		h.belt2.alpha = 1
	elseif (h.cTorso2 == 22) then
		h.neck2.alpha = .25
		h.belt2.alpha = .25
	elseif (h.cTorso2 == 23) then
		h.neck2.alpha = .45
		h.belt2.alpha = .45
	elseif (h.cTorso2 == 24) then
		h.neck2.alpha = .62
		h.belt2.alpha = .62
	elseif (h.cTorso2 == 25) then
		h.neck2.alpha = .80
		h.belt2.alpha = .80
	elseif (h.cTorso2 == 26) then
		h.neck2.alpha = 1
		h.belt2.alpha = 1
	end
	
	
	-- HEAD COLOR 1

	if (h.cHead1 == 1 or h.cHead1 == 2 or h.cHead1 == 3 or h.cHead1 == 19 or h.cHead1 == 20) then
		h.head11 = display.newImage("Head Yellow 1.png")
		h.head11.aplha = 1
	elseif (h.cHead1 == 4 or h.cHead1 == 5 or h.cHead1 == 6 or h.cHead1 == 7 or h.cHead1 == 8 or h.cHead1 == 11 or h.cHead1 == 12 or h.cHead1 == 13 or h.cHead1 == 14) then
		h.head11 = display.newImage("Head Blue 1.png")
		h.head11.aplha = 1
	elseif (h.cHead1 == 9 or h.cHead1 == 10 or h.cHead1 == 15 or h.cHead1 == 16 or h.cHead1 == 17 or h.cHead1 == 18) then
		h.head11 = display.newImage("Head Red 1.png")
		h.head11.aplha = 1
	elseif (h.cHead1 == 21 or h.cHead1 == 22 or h.cHead1 == 23 or h.cHead1 == 24 or h.cHead1 == 25) then
		h.head11 = display.newImage("Head Black 1.png")
		h.head11.aplha = 1
	elseif (h.cHead1 == 26) then		
		h.head11 = display.newImage("Head White 1.png")
		h.head11.aplha = 1
	end
	
	if (h.cHead1 == 1 or h.cHead1 == 2 or h.cHead1 == 3 or h.cHead1 == 11 or h.cHead1 == 15 or h.cHead1 == 21) then
		h.head12 = display.newImage("Head Black 1.png")
	elseif (h.cHead1 == 4 or h.cHead1 == 5 or h.cHead1 == 6 or h.cHead1 == 17 or h.cHead1 == 18 or h.cHead1 == 19) then
		h.head12 = display.newImage("Head Yellow 1.png")
	elseif (h.cHead1 == 7 or h.cHead1 == 8 or h.cHead1 == 16) then
		h.head12 = display.newImage("Head Red 1.png")
	elseif (h.cHead1 == 12) then
		h.head12 = display.newImage("Head Blue 1.png")
	elseif (h.cHead1 == 9 or h.cHead1 == 10 or h.cHead1 == 13 or h.cHead1 == 14 or h.cHead1 == 20 or h.cHead1 == 22 or h.cHead1 == 23 or h.cHead1 == 24 or h.cHead1 == 25 or h.cHead1 == 26) then
		h.head12 = display.newImage("Head White 1.png")
	end

	if (h.cHead1 == 1) then
		h.head12.alpha = .25
	elseif (h.cHead1 == 2) then
		h.head12.alpha = .50
	elseif (h.cHead1 == 3) then
		h.head12.alpha = .70
	elseif (h.cHead1 == 4) then
		h.head12.alpha = .35
	elseif (h.cHead1 == 5) then
		h.head12.alpha = .47
	elseif (h.cHead1 == 6) then
		h.head12.alpha = .65
	elseif (h.cHead1 == 7) then
		h.head12.alpha = .50
	elseif (h.cHead1 == 8) then
		h.head12.alpha = .75
	elseif (h.cHead1 == 9) then
		h.head12.alpha = .25
	elseif (h.cHead1 == 10) then
		h.head12.alpha = .50
	elseif (h.cHead1 == 11) then
		h.head12.alpha = .50
	elseif (h.cHead1 == 12) then
		h.head12.alpha = 1
	elseif (h.cHead1 == 13) then
		h.head12.alpha = .42
	elseif (h.cHead1 == 14) then
		h.head12.alpha = .74
	elseif (h.cHead1 == 15) then
		h.head12.alpha = .50
	elseif (h.cHead1 == 16) then
		h.head12.alpha = 1
	elseif (h.cHead1 == 17) then
		h.head12.alpha = .40
	elseif (h.cHead1 == 18) then
		h.head12.alpha = .80
	elseif (h.cHead1 == 19) then
		h.head12.alpha = 1
	elseif (h.cHead1 == 20) then
		h.head12.alpha = .50
	elseif (h.cHead1 == 21) then
		h.head12.alpha = 1
	elseif (h.cHead1 == 22) then
		h.head12.alpha = .25
	elseif (h.cHead1 == 23) then
		h.head12.alpha = .45
	elseif (h.cHead1 == 24) then
		h.head12.alpha = .62
	elseif (h.cHead1 == 25) then
		h.head12.alpha = .80
	elseif (h.cHead1 == 26) then
		h.head12.alpha = 1
	end

	
	-- HEAD COLOR 2

	if (h.cHead2 == 1 or h.cHead2 == 2 or h.cHead2 == 3 or h.cHead2 == 19 or h.cHead2 == 20) then
		h.head21 = display.newImage("Head Yellow 2.png")
		h.head21.aplha = 1
	elseif (h.cHead2 == 4 or h.cHead2 == 5 or h.cHead2 == 6 or h.cHead2 == 7 or h.cHead2 == 8 or h.cHead2 == 11 or h.cHead2 == 12 or h.cHead2 == 13 or h.cHead2 == 14) then
		h.head21 = display.newImage("Head Blue 2.png")
		h.head21.aplha = 1
	elseif (h.cHead2 == 9 or h.cHead2 == 10 or h.cHead2 == 15 or h.cHead2 == 16 or h.cHead2 == 17 or h.cHead2 == 18) then
		h.head21 = display.newImage("Head Red 2.png")
		h.head21.aplha = 1
	elseif (h.cHead2 == 21 or h.cHead2 == 22 or h.cHead2 == 23 or h.cHead2 == 24 or h.cHead2 == 25) then
		h.head21 = display.newImage("Head Black 2.png")
		h.head21.aplha = 1
	elseif (h.cHead2 == 26) then		
		h.head21 = display.newImage("Head White 2.png")
		h.head21.aplha = 1
	end
	
	if (h.cHead2 == 1 or h.cHead2 == 2 or h.cHead2 == 3 or h.cHead2 == 11 or h.cHead2 == 15 or h.cHead2 == 21) then
		h.head22 = display.newImage("Head Black 2.png")
	elseif (h.cHead2 == 4 or h.cHead2 == 5 or h.cHead2 == 6 or h.cHead2 == 17 or h.cHead2 == 18 or h.cHead2 == 19) then
		h.head22 = display.newImage("Head Yellow 2.png")
	elseif (h.cHead2 == 7 or h.cHead2 == 8 or h.cHead2 == 16) then
		h.head22 = display.newImage("Head Red 2.png")
	elseif (h.cHead2 == 12) then
		h.head22 = display.newImage("Head Blue 2.png")
	elseif (h.cHead2 == 9 or h.cHead2 == 10 or h.cHead2 == 13 or h.cHead2 == 14 or h.cHead2 == 20 or h.cHead2 == 22 or h.cHead2 == 23 or h.cHead2 == 24 or h.cHead2 == 25 or h.cHead2 == 26) then
		h.head22 = display.newImage("Head White 2.png")
	end

	if (h.cHead2 == 1) then
		h.head22.alpha = .25
	elseif (h.cHead2 == 2) then
		h.head22.alpha = .50
	elseif (h.cHead2 == 3) then
		h.head22.alpha = .70
	elseif (h.cHead2 == 4) then
		h.head22.alpha = .35
	elseif (h.cHead2 == 5) then
		h.head22.alpha = .47
	elseif (h.cHead2 == 6) then
		h.head22.alpha = .65
	elseif (h.cHead2 == 7) then
		h.head22.alpha = .50
	elseif (h.cHead2 == 8) then
		h.head22.alpha = .75
	elseif (h.cHead2 == 9) then
		h.head22.alpha = .25
	elseif (h.cHead2 == 10) then
		h.head22.alpha = .50
	elseif (h.cHead2 == 11) then
		h.head22.alpha = .50
	elseif (h.cHead2 == 12) then
		h.head22.alpha = 1
	elseif (h.cHead2 == 13) then
		h.head22.alpha = .42
	elseif (h.cHead2 == 14) then
		h.head22.alpha = .74
	elseif (h.cHead2 == 15) then
		h.head22.alpha = .50
	elseif (h.cHead2 == 16) then
		h.head22.alpha = 1
	elseif (h.cHead2 == 17) then
		h.head22.alpha = .40
	elseif (h.cHead2 == 18) then
		h.head22.alpha = .80
	elseif (h.cHead2 == 19) then
		h.head22.alpha = 1
	elseif (h.cHead2 == 20) then
		h.head22.alpha = .50
	elseif (h.cHead2 == 21) then
		h.head22.alpha = 1
	elseif (h.cHead2 == 22) then
		h.head22.alpha = .25
	elseif (h.cHead2 == 23) then
		h.head22.alpha = .45
	elseif (h.cHead2 == 24) then
		h.head22.alpha = .62
	elseif (h.cHead2 == 25) then
		h.head22.alpha = .80
	elseif (h.cHead2 == 26) then
		h.head22.alpha = 1
	end

	
	-- OUTLINE
	
	if (h.cBroadway == 1) then
		h.head3 = display.newImage("Head White Outline.png")
	else
		h.head3 = display.newImage("Head Black Outline.png")
	end
	h.head3.alpha = 1

	
	-- VEGAS
	h.head4 = display.newImage("Head Vegas 1.png")
	h.head5 = display.newImage("Head Vegas 2.png")
	h.head6 = display.newImage("Head Vegas 3.png")
	
	if (h.cVegas == 1) then
		h.head4.alpha = 1
		h.head5.alpha = 1
		h.head6.alpha = 1
	else
		h.head4.alpha = 0
		h.head5.alpha = 0
		h.head6.alpha = 0
	end

	
	-- SHIELD COLOR 1	
	
	if (h.cTorso1 == 1 or h.cTorso1 == 2 or h.cTorso1 == 3 or h.cTorso1 == 19 or h.cTorso1 == 20) then
		g.shield11 = display.newImage("Shield Yellow 2.png")
		g.shield11.aplha = 1
	elseif (h.cTorso1 == 4 or h.cTorso1 == 5 or h.cTorso1 == 6 or h.cTorso1 == 7 or h.cTorso1 == 8 or h.cTorso1 == 11 or h.cTorso1 == 12 or h.cTorso1 == 13 or h.cTorso1 == 14) then
		g.shield11 = display.newImage("Shield Blue 2.png")
		g.shield11.aplha = 1
	elseif (h.cTorso1 == 9 or h.cTorso1 == 10 or h.cTorso1 == 15 or h.cTorso1 == 16 or h.cTorso1 == 17 or h.cTorso1 == 18) then
		g.shield11 = display.newImage("Shield Red 2.png")
		g.shield11.aplha = 1
	elseif (h.cTorso1 == 21 or h.cTorso1 == 22 or h.cTorso1 == 23 or h.cTorso1 == 24 or h.cTorso1 == 25) then
		g.shield11 = display.newImage("Shield Black 2.png")
		g.shield11.aplha = 1
	elseif (h.cTorso1 == 26) then		
		g.shield11 = display.newImage("Shield White 2.png")
		g.shield11.aplha = 1
	end
	
	if (h.cTorso1 == 1 or h.cTorso1 == 2 or h.cTorso1 == 3 or h.cTorso1 == 11 or h.cTorso1 == 15 or h.cTorso1 == 21) then
		g.shield12 = display.newImage("Shield Black 2.png")
	elseif (h.cTorso1 == 4 or h.cTorso1 == 5 or h.cTorso1 == 6 or h.cTorso1 == 17 or h.cTorso1 == 18 or h.cTorso1 == 19) then
		g.shield12 = display.newImage("Shield Yellow 2.png")
	elseif (h.cTorso1 == 7 or h.cTorso1 == 8 or h.cTorso1 == 16) then
		g.shield12 = display.newImage("Shield Red 2.png")
	elseif (h.cTorso1 == 12) then
		g.shield12 = display.newImage("Shield Blue 2.png")
	elseif (h.cTorso1 == 9 or h.cTorso1 == 10 or h.cTorso1 == 13 or h.cTorso1 == 14 or h.cTorso1 == 20 or h.cTorso1 == 22 or h.cTorso1 == 23 or h.cTorso1 == 24 or h.cTorso1 == 25 or h.cTorso1 == 26) then
		g.shield12 = display.newImage("Shield White 2.png")
	end

	if (h.cTorso1 == 1) then
		g.shield12.alpha = .25
	elseif (h.cTorso1 == 2) then
		g.shield12.alpha = .50
	elseif (h.cTorso1 == 3) then
		g.shield12.alpha = .70
	elseif (h.cTorso1 == 4) then
		g.shield12.alpha = .35
	elseif (h.cTorso1 == 5) then
		g.shield12.alpha = .47
	elseif (h.cTorso1 == 6) then
		g.shield12.alpha = .65
	elseif (h.cTorso1 == 7) then
		g.shield12.alpha = .50
	elseif (h.cTorso1 == 8) then
		g.shield12.alpha = .75
	elseif (h.cTorso1 == 9) then
		g.shield12.alpha = .25
	elseif (h.cTorso1 == 10) then
		g.shield12.alpha = .50
	elseif (h.cTorso1 == 11) then
		g.shield12.alpha = .50
	elseif (h.cTorso1 == 12) then
		g.shield12.alpha = 1
	elseif (h.cTorso1 == 13) then
		g.shield12.alpha = .42
	elseif (h.cTorso1 == 14) then
		g.shield12.alpha = .74
	elseif (h.cTorso1 == 15) then
		g.shield12.alpha = .50
	elseif (h.cTorso1 == 16) then
		g.shield12.alpha = 1
	elseif (h.cTorso1 == 17) then
		g.shield12.alpha = .40
	elseif (h.cTorso1 == 18) then
		g.shield12.alpha = .80
	elseif (h.cTorso1 == 19) then
		g.shield12.alpha = 1
	elseif (h.cTorso1 == 20) then
		g.shield12.alpha = .50
	elseif (h.cTorso1 == 21) then
		g.shield12.alpha = 1
	elseif (h.cTorso1 == 22) then
		g.shield12.alpha = .25
	elseif (h.cTorso1 == 23) then
		g.shield12.alpha = .45
	elseif (h.cTorso1 == 24) then
		g.shield12.alpha = .62
	elseif (h.cTorso1 == 25) then
		g.shield12.alpha = .80
	elseif (h.cTorso1 == 26) then
		g.shield12.alpha = 1
	end


	--COLOR 2
	
	if (h.cTorso2 == 1 or h.cTorso2 == 2 or h.cTorso2 == 3 or h.cTorso2 == 19 or h.cTorso2 == 20) then
		g.shield21 = display.newImage("Shield Yellow 1.png")
		g.shield21.aplha = 1
	elseif (h.cTorso2 == 4 or h.cTorso2 == 5 or h.cTorso2 == 6 or h.cTorso2 == 7 or h.cTorso2 == 8 or h.cTorso2 == 11 or h.cTorso2 == 12 or h.cTorso2 == 13 or h.cTorso2 == 14) then
		g.shield21 = display.newImage("Shield Blue 1.png")
		g.shield21.aplha = 1
	elseif (h.cTorso2 == 9 or h.cTorso2 == 10 or h.cTorso2 == 15 or h.cTorso2 == 16 or h.cTorso2 == 17 or h.cTorso2 == 18) then
		g.shield21 = display.newImage("Shield Red 1.png")
		g.shield21.aplha = 1
	elseif (h.cTorso2 == 21 or h.cTorso2 == 22 or h.cTorso2 == 23 or h.cTorso2 == 24 or h.cTorso2 == 25) then
		g.shield21 = display.newImage("Shield Black 1.png")
		g.shield21.aplha = 1
	elseif (h.cTorso2 == 26) then		
		g.shield21 = display.newImage("Shield White 1.png")
		g.shield21.aplha = 1
	end
	
	if (h.cTorso2 == 1 or h.cTorso2 == 2 or h.cTorso2 == 3 or h.cTorso2 == 11 or h.cTorso2 == 15 or h.cTorso2 == 21) then
		g.shield22 = display.newImage("Shield Black 1.png")
	elseif (h.cTorso2 == 4 or h.cTorso2 == 5 or h.cTorso2 == 6 or h.cTorso2 == 17 or h.cTorso2 == 18 or h.cTorso2 == 19) then
		g.shield22 = display.newImage("Shield Yellow 1.png")
	elseif (h.cTorso2 == 7 or h.cTorso2 == 8 or h.cTorso2 == 16) then
		g.shield22 = display.newImage("Shield Red 1.png")
	elseif (h.cTorso2 == 12) then
		g.shield22 = display.newImage("Shield Blue 1.png")
	elseif (h.cTorso2 == 9 or h.cTorso2 == 10 or h.cTorso2 == 13 or h.cTorso2 == 14 or h.cTorso2 == 20 or h.cTorso2 == 22 or h.cTorso2 == 23 or h.cTorso2 == 24 or h.cTorso2 == 25 or h.cTorso2 == 26) then
		g.shield22 = display.newImage("Shield White 1.png")
	end

	
	if (h.cTorso2 == 1) then
		g.shield22.alpha = .25
	elseif (h.cTorso2 == 2) then
		g.shield22.alpha = .50
	elseif (h.cTorso2 == 3) then
		g.shield22.alpha = .70
	elseif (h.cTorso2 == 4) then
		g.shield22.alpha = .35
	elseif (h.cTorso2 == 5) then
		g.shield22.alpha = .47
	elseif (h.cTorso2 == 6) then
		g.shield22.alpha = .65
	elseif (h.cTorso2 == 7) then
		g.shield22.alpha = .50
	elseif (h.cTorso2 == 8) then
		g.shield22.alpha = .75
	elseif (h.cTorso2 == 9) then
		g.shield22.alpha = .25
	elseif (h.cTorso2 == 10) then
		g.shield22.alpha = .50
	elseif (h.cTorso2 == 11) then
		g.shield22.alpha = .50
	elseif (h.cTorso2 == 12) then
		g.shield22.alpha = 1
	elseif (h.cTorso2 == 13) then
		g.shield22.alpha = .42
	elseif (h.cTorso2 == 14) then
		g.shield22.alpha = .74
	elseif (h.cTorso2 == 15) then
		g.shield22.alpha = .50
	elseif (h.cTorso2 == 16) then
		g.shield22.alpha = 1
	elseif (h.cTorso2 == 17) then
		g.shield22.alpha = .40
	elseif (h.cTorso2 == 18) then
		g.shield22.alpha = .80
	elseif (h.cTorso2 == 19) then
		g.shield22.alpha = 1
	elseif (h.cTorso2 == 20) then
		g.shield22.alpha = .50
	elseif (h.cTorso2 == 21) then
		g.shield22.alpha = 1
	elseif (h.cTorso2 == 22) then
		g.shield22.alpha = .25
	elseif (h.cTorso2 == 23) then
		g.shield22.alpha = .45
	elseif (h.cTorso2 == 24) then
		g.shield22.alpha = .62
	elseif (h.cTorso2 == 25) then
		g.shield22.alpha = .80
	elseif (h.cTorso2 == 26) then
		g.shield22.alpha = 1
	end
	

	
	h.t1 = 1
	h.t2 = 1
	h.t3 = 1
	
end


function initializeMyGuy()

	myGuy.x = 200
	myGuy.y = 200

	leftArmGroup.xReference = 0
	leftArmGroup.yReference = 0
	
	h.leftLeg1.xReference = 0
	h.leftLeg1.yReference = -10
	h.leftLeg2.xReference = 0
	h.leftLeg2.yReference = -10
	h.leftLeg3.xReference = 0
	h.leftLeg3.yReference = -10
	
	h.rightLeg1.xReference = 0
	h.rightLeg1.yReference = -13
	h.rightLeg2.xReference = 0
	h.rightLeg2.yReference = -13
	h.rightLeg3.xReference = 0
	h.rightLeg3.yReference = -13
	
	h.torso1.xReference = 0
	h.torso1.yReference = -15
	h.torso2.xReference = 0
	h.torso2.yReference = -15

	rightArmGroup.xReference = 16
	rightArmGroup.yReference = 4
	
	h.head11.xReference = 12
	h.head11.yReference = 22
	h.head12.xReference = 12
	h.head12.yReference = 22
	h.head21.xReference = 12
	h.head21.yReference = 22
	h.head22.xReference = 12
	h.head22.yReference = 22
	h.head3.xReference = 12
	h.head3.yReference = 22
	h.head4.xReference = 12
	h.head4.yReference = 22
	h.head5.xReference = 12
	h.head5.yReference = 22
	h.head6.xReference = 12
	h.head6.yReference = 22
	
	torsoGroup.yReference = 17
	torsoGroup.xReference = -13

	splash01.x = 13
	splash01.y = -35

	splash01.alpha = .5
	
	h.neck1.x = 1
	h.neck1.y = -9
	h.neck2.x = 1
	h.neck2.y = -9
		
	h.belt1.x = -2
	h.belt1.y = 16
	h.belt2.x = -2
	h.belt2.y = 16

end


function zeroOutMyGuyBodyPosture()
	
	myGuy.rotation = 0
	shadow.x = 0
	shadow.y = 36
	shadow.isVisible = true
	leftArmGroup.rotation = -25
	leftArmGroup.x = 6
	leftArmGroup.y = -12
	
	h.leftLeg1.rotation = 0
	h.leftLeg1.x = 7
	h.leftLeg1.y = 15
	h.leftLeg2.rotation = 0
	h.leftLeg2.x = 7
	h.leftLeg2.y = 15
	h.leftLeg3.rotation = 0
	h.leftLeg3.x = 7
	h.leftLeg3.y = 15
	
	h.rightLeg1.rotation = 0
	h.rightLeg1.x = -9
	h.rightLeg1.y = 13
	h.rightLeg2.rotation = 0
	h.rightLeg2.x = -9
	h.rightLeg2.y = 13
	h.rightLeg3.rotation = 0
	h.rightLeg3.x = -9
	h.rightLeg3.y = 13

	h.torso1.rotation = 0
	h.torso1.x = 0
	h.torso1.y = -15
	h.torso2.rotation = 0
	h.torso2.x = 0
	h.torso2.y = -15
	
	rightArmGroup.rotation = 0
	rightArmGroup.x = -15
	rightArmGroup.y = -8
	
	h.head11.rotation = 0
	h.head11.x = 6
	h.head11.y = -16
	h.head12.rotation = 0
	h.head12.x = 6
	h.head12.y = -16
	h.head21.rotation = 0
	h.head21.x = 6
	h.head21.y = -16
	h.head22.rotation = 0
	h.head22.x = 6
	h.head22.y = -16
	h.head3.rotation = 0
	h.head3.x = 6
	h.head3.y = -16
	h.head4.rotation = 0
	h.head4.x = 6
	h.head4.y = -16
	h.head5.rotation = 0
	h.head5.x = 6
	h.head5.y = -16
	h.head6.rotation = 0
	h.head6.x = 6
	h.head6.y = -16

	torsoGroup.rotation = 0
	torsoGroup.x = -13
	torsoGroup.y = 17
	
	
	g.shield11.rotation = 15
	g.shield11.x = 15
	g.shield11.y = 20
	
	g.shield12.rotation = 15
	g.shield12.x = 15
	g.shield12.y = 20

	g.shield21.rotation = 15
	g.shield21.x = 15
	g.shield21.y = 20

	g.shield22.rotation = 15
	g.shield22.x = 15
	g.shield22.y = 20

	g.shieldGold.rotation = 15
	g.shieldGold.x = 16
	g.shieldGold.y = 19.5

	
	
end


function assembleMyGuy_3()

	assembleMyGuy_2()
	initializeMyGuy()
	zeroOutMyGuyBodyPosture()
	
	myGuy:insert(shadow)
	myGuy:insert(h.leftLeg1)
	myGuy:insert(h.leftLeg2)
	myGuy:insert(h.leftLeg3)
	
	myGuy:insert(h.rightLeg1)
	myGuy:insert(h.rightLeg2)
	myGuy:insert(h.rightLeg3)

	leftArmGroup:insert(h.leftArm1)
	leftArmGroup:insert(h.leftArm2)
	leftArmGroup:insert(h.leftArm3)
	
	leftArmGroup:insert(g.crossbow)
	leftArmGroup:insert(g.arrow)
	leftArmGroup:insert(g.knifeLeft)
	leftArmGroup:insert(g.tomahawkLeft)
	leftArmGroup:insert(g.pistolLeft)
	leftArmGroup:insert(g.rifleLeft)
	leftArmGroup:insert(g.granade)
	leftArmGroup:insert(g.battleAxe1)
	leftArmGroup:insert(g.mace1)
	leftArmGroup:insert(g.machete1)
	leftArmGroup:insert(g.macheteGold)
	
	leftArmGroup:insert(myGuyLeftFingers)
	
	leftArmGroup:insert(g.crossbowStringPulled)
		
	torsoGroup:insert(leftArmGroup)
	torsoGroup:insert(h.torso1)
	torsoGroup:insert(h.torso2)
	
	torsoGroup:insert(h.neck1)
	torsoGroup:insert(h.neck2)
	
	torsoGroup:insert(h.belt1)
	torsoGroup:insert(h.belt2)
	
	torsoGroup:insert(h.head11)
	torsoGroup:insert(h.head12)
	torsoGroup:insert(h.head21)
	torsoGroup:insert(h.head22)
	torsoGroup:insert(h.head3)
	torsoGroup:insert(h.head4)
	torsoGroup:insert(h.head5)
	torsoGroup:insert(h.head6)
	
	rightArmGroup:insert(g.knifeRight)
	rightArmGroup:insert(g.tomahawkRight)
	rightArmGroup:insert(g.pistolRight)
	rightArmGroup:insert(g.rifleRight)


	rightArmGroup:insert(h.rightArm1)
	rightArmGroup:insert(h.rightArm2)
	rightArmGroup:insert(h.rightArm3)
	
	rightArmGroup:insert(g.shield21)
	rightArmGroup:insert(g.shield22)
	rightArmGroup:insert(g.shield11)
	rightArmGroup:insert(g.shield12)
	rightArmGroup:insert(g.shieldGold)
	

	torsoGroup:insert(rightArmGroup)

	torsoGroup:insert(splash01)	
	
	myGuy:insert(torsoGroup)

end


function insertMyGuy()

	assembleMyGuy_3()
	
	gameScreenDisplayGroup:insert(myGuy)
	
	gameScreenDisplayGroup:insert(g.knifeLeftDouble)
	
	gameScreenDisplayGroup:insert(g.knifeRightDouble)
	
	gameScreenDisplayGroup:insert(g.tomahawkLeftDouble)
	
	gameScreenDisplayGroup:insert(g.tomahawkRightDouble)
	
	gameScreenDisplayGroup:insert(g.arrowDouble)
	
	gameScreenDisplayGroup:insert(g.granadeDouble)
		
	gameScreenDisplayGroup:insert(gunSmoke01)
	gameScreenDisplayGroup:insert(gunSmoke02)
	gameScreenDisplayGroup:insert(gunSmoke03)
	
end 


-- GRASS
local grass1 = nil
local grass2 = nil
local grass3 = nil

local grassCounter = 0


-- CONTROLS
local leftButton = display.newImage("Arrow Left.png")
local rightButton = display.newImage("Arrow Right.png")
local leftButtonMask = display.newImage("Arrow Left Mask.png")
local rightButtonMask = display.newImage("Arrow Right Mask.png")
local pauseButton = display.newImage("Pause.png")
local attackButton = display.newImage("Attack Button.png")
local attackButtonMask = display.newImage("Round Button Mask.png")
attackButtonMask.num = 0
local attackButtonDarkMask = display.newImage("Round Button Dark Mask.png")

local swingButton = display.newImage("Swing Button.png")
local swingButtonMask = display.newImage("Round Button Mask.png")
swingButtonMask.num = 0
local granadeButton = display.newImage("Granade Button.png")
local granadeButtonMask = display.newImage("Round Button Mask.png")
granadeButtonMask.num = 0
local granadeButtonDarkMask = display.newImage("Round Button Dark Mask.png")

-- WEAPONS ICONS
local weaponsIconsDisplayGroup = display.newGroup()

local i = {}


function initializeWeaponsChangeDisplayGroup()

	i.arrow1Icon = display.newImage("Arrow 1 Icon.png")
	i.arrow2Icon = display.newImage("Arrow 2 Icon.png")
	i.arrow3Icon = display.newImage("Arrow 3 Icon.png")
	i.arrowGoldIcon = display.newImage("Arrow Gold Icon.png")
	
	i.knife1Icon = display.newImage("Knife 1 Icon.png")
	i.knife2Icon = display.newImage("Knife 2 Icon.png")
	i.knife3Icon = display.newImage("Knife 3 Icon.png")
	i.knifeGoldIcon = display.newImage("Knife Gold Icon.png")

	i.tomahawk1Icon = display.newImage("Tomahawk 1 Icon.png")
	i.tomahawk2Icon = display.newImage("Tomahawk 2 Icon.png")
	i.tomahawk3Icon = display.newImage("Tomahawk 3 Icon.png")
	i.tomahawkGoldIcon = display.newImage("Tomahawk Gold Icon.png")

	i.pistol1Icon = display.newImage("Pistol 1 Icon.png")
	i.pistol2Icon = display.newImage("Pistol 2 Icon.png")
	i.pistol3Icon = display.newImage("Pistol 3 Icon.png")
	i.pistolGoldIcon = display.newImage("Pistol Gold Icon.png")
	
	i.rifle1Icon = display.newImage("Rifle 1 Icon.png")
	i.rifle2Icon = display.newImage("Rifle 2 Icon.png")
	i.rifle3Icon = display.newImage("Rifle 3 Icon.png")
	i.rifleGoldIcon = display.newImage("Rifle Gold Icon.png")
	
	i.battleAxe1Icon = display.newImage("Battle Axe Icon.png")
	i.mace1Icon = display.newImage("Mace Icon.png")
	i.machete1Icon = display.newImage("Machete Icon.png")
	i.macheteGoldIcon = display.newImage("Machete Gold Icon.png")
	
	i.granade1Icon = display.newImage("Granade Icon.png")
	i.granadeGoldIcon = display.newImage("Granade Gold Icon.png")
	
	
	i.weaponsButtonBackground = display.newImage("Weapons Change Button.png")
	i.weaponsButtonMask = display.newImage("Round Button Mask.png")
	i.weaponsButtonBackground.num = 0


	weaponsIconsDisplayGroup:insert(i.weaponsButtonBackground)

	weaponsIconsDisplayGroup:insert(i.arrow1Icon)
	weaponsIconsDisplayGroup:insert(i.arrow2Icon)
	weaponsIconsDisplayGroup:insert(i.arrow3Icon)
	weaponsIconsDisplayGroup:insert(i.arrowGoldIcon)
	
	weaponsIconsDisplayGroup:insert(i.knife1Icon)
	weaponsIconsDisplayGroup:insert(i.knife2Icon)
	weaponsIconsDisplayGroup:insert(i.knife3Icon)
	weaponsIconsDisplayGroup:insert(i.knifeGoldIcon)

	weaponsIconsDisplayGroup:insert(i.tomahawk1Icon)
	weaponsIconsDisplayGroup:insert(i.tomahawk2Icon)
	weaponsIconsDisplayGroup:insert(i.tomahawk3Icon)
	weaponsIconsDisplayGroup:insert(i.tomahawkGoldIcon)

	weaponsIconsDisplayGroup:insert(i.pistol1Icon)
	weaponsIconsDisplayGroup:insert(i.pistol2Icon)
	weaponsIconsDisplayGroup:insert(i.pistol3Icon)
	weaponsIconsDisplayGroup:insert(i.pistolGoldIcon)
	
	weaponsIconsDisplayGroup:insert(i.rifle1Icon)
	weaponsIconsDisplayGroup:insert(i.rifle2Icon)
	weaponsIconsDisplayGroup:insert(i.rifle3Icon)
	weaponsIconsDisplayGroup:insert(i.rifleGoldIcon)
	
	weaponsIconsDisplayGroup:insert(i.battleAxe1Icon)
	weaponsIconsDisplayGroup:insert(i.mace1Icon)
	weaponsIconsDisplayGroup:insert(i.machete1Icon)
	weaponsIconsDisplayGroup:insert(i.macheteGoldIcon)
	
	weaponsIconsDisplayGroup:insert(i.granade1Icon)
	weaponsIconsDisplayGroup:insert(i.granadeGoldIcon)

	weaponsIconsDisplayGroup:insert(i.weaponsButtonMask)
	
	weaponsIconsDisplayGroup.isVisible = true
	weaponsIconsDisplayGroup.x = 0
	weaponsIconsDisplayGroup.y = 0


	i.arrow1Icon.x = 36
	i.arrow2Icon.x = 36
	i.arrow3Icon.x = 36
	i.arrowGoldIcon.x = 36
	
	i.knife1Icon.x = 36
	i.knife2Icon.x = 36
	i.knife3Icon.x = 36
	i.knifeGoldIcon.x = 36

	i.tomahawk1Icon.x = 36
	i.tomahawk2Icon.x = 36
	i.tomahawk3Icon.x = 36
	i.tomahawkGoldIcon.x = 36

	i.pistol1Icon.x = 36
	i.pistol2Icon.x = 36
	i.pistol3Icon.x = 36
	i.pistolGoldIcon.x = 36
	
	i.rifle1Icon.x = 36
	i.rifle2Icon.x = 36
	i.rifle3Icon.x = 36
	i.rifleGoldIcon.x = 36
	
	i.battleAxe1Icon.x = 36
	i.mace1Icon.x = 36
	i.machete1Icon.x = 36
	i.macheteGoldIcon.x = 36
	
	i.granade1Icon.x = 36
	i.granadeGoldIcon.x = 36


	i.arrow1Icon.y = 36
	i.arrow2Icon.y = 36
	i.arrow3Icon.y = 36
	i.arrowGoldIcon.y = 36
	
	i.knife1Icon.y = 36
	i.knife2Icon.y = 36
	i.knife3Icon.y = 36
	i.knifeGoldIcon.y = 36

	i.tomahawk1Icon.y = 36
	i.tomahawk2Icon.y = 36
	i.tomahawk3Icon.y = 36
	i.tomahawkGoldIcon.y = 36

	i.pistol1Icon.y = 36
	i.pistol2Icon.y = 36
	i.pistol3Icon.y = 36
	i.pistolGoldIcon.y = 36
	
	i.rifle1Icon.y = 36
	i.rifle2Icon.y = 36
	i.rifle3Icon.y = 36
	i.rifleGoldIcon.y = 36
	
	i.battleAxe1Icon.y = 36
	i.mace1Icon.y = 36
	i.machete1Icon.y = 36
	i.macheteGoldIcon.y = 36
	
	i.granade1Icon.y = 36
	i.granadeGoldIcon.y = 36
		
	i.weaponsButtonMask.isVisible = false
	
end 

initializeWeaponsChangeDisplayGroup()



-- CASH DISPLAY GROUP

local cashDisplayGroup = display.newGroup()
local cashTentCoinDisplayGroup = display.newGroup()
local cashChestCoinDisplayGroup = display.newGroup()
local c = {}


function initializeCashTent()

	c.trophy1 = display.newImage("Trophy 1.png")
	c.trophy2 = display.newImage("Trophy 1.png")
	c.trophy3 = display.newImage("Trophy 1.png")
	
	c.cashCoin = display.newImage("Gold Coin.png")
	c.cashCoinMask = display.newImage("Gold Coin Mask.png")
	c.cashCoin.num = 0
	c.cashCoinMask.isVisible = false

	c.cashTentCoin = display.newImage("Gold Coin Halo.png")
	c.cashTentGranade = display.newImage("Granade Halo.png")
	
	c.cashChestCoin = display.newImage("Gold Coin Halo.png")


	cashDisplayGroup:insert(c.trophy1)
	cashDisplayGroup:insert(c.trophy2)
	cashDisplayGroup:insert(c.trophy3)
	cashDisplayGroup:insert(c.cashCoin)
	cashDisplayGroup:insert(c.cashCoinMask)
	cashDisplayGroup:insert(cashTentCoinDisplayGroup)
	cashDisplayGroup:insert(cashChestCoinDisplayGroup)

	cashTentCoinDisplayGroup:insert(c.cashTentCoin)
	cashTentCoinDisplayGroup:insert(c.cashTentGranade)
	

	cashChestCoinDisplayGroup:insert(c.cashChestCoin)

	c.cashChestCoin.xScale = 1.5
	c.cashChestCoin.yScale = 1.5
	
	cashTentCoinDisplayGroup.x = -115
	cashTentCoinDisplayGroup.y = 100
	cashTentCoinDisplayGroup.isVisible = false
	
	c.cashTentCoin.isVisible = false
	c.cashTentCoin.xScale = 1
	c.cashTentCoin.yScale = 1

	c.cashTentGranade.isVisible = false
	c.cashTentGranade.xScale = 1
	c.cashTentGranade.yScale = 1
	
	
	c.trophy1.x = -66
	c.trophy1.y = 15
	c.trophy1.isVisible = false

	c.trophy2.x = -37
	c.trophy2.y = 15
	c.trophy1.isVisible = false

	c.trophy3.x = -95
	c.trophy3.y = 15
	c.trophy3.isVisible = false

	
	c.cashCoin.x = -10
	c.cashCoin.y = 11
	
	c.cashCoinMask.x = -10
	c.cashCoinMask.y = 11

	cashDisplayGroup.x = 300
	cashDisplayGroup.y = 5

	cashChestCoinDisplayGroup.isVisible = false
	cashChestCoinDisplayGroup.x = 0
	cashChestCoinDisplayGroup.y = 100



	
end

initializeCashTent()

local cashNumbers = {}
local sumNumbers = {}

function initializeCashSumNumbers()
	
	for i = 1, 10 , 1 do
			cashNumbers[i] = {0, 0, 0, 0, 0}
	end

	for i = 1, 10 , 1 do
		if (i == 1)	then
			cashNumbers[i][1] = display.newImage("1.png")
			cashNumbers[i][2] = display.newImage("1.png")
			cashNumbers[i][3] = display.newImage("1.png")
			cashNumbers[i][4] = display.newImage("1.png")
			cashNumbers[i][5] = display.newImage("1.png")
			cashDisplayGroup:insert(cashNumbers[i][1])
			cashDisplayGroup:insert(cashNumbers[i][2])
			cashDisplayGroup:insert(cashNumbers[i][3])
			cashDisplayGroup:insert(cashNumbers[i][4])
			cashDisplayGroup:insert(cashNumbers[i][5])
		elseif(i == 2) then
			cashNumbers[i][1] = display.newImage("2.png")
			cashNumbers[i][2] = display.newImage("2.png")
			cashNumbers[i][3] = display.newImage("2.png")	
			cashNumbers[i][4] = display.newImage("2.png")	
			cashNumbers[i][5] = display.newImage("2.png")	
			cashDisplayGroup:insert(cashNumbers[i][1])
			cashDisplayGroup:insert(cashNumbers[i][2])
			cashDisplayGroup:insert(cashNumbers[i][3])
			cashDisplayGroup:insert(cashNumbers[i][4])
			cashDisplayGroup:insert(cashNumbers[i][5])
		elseif(i == 3) then
			cashNumbers[i][1] = display.newImage("3.png")
			cashNumbers[i][2] = display.newImage("3.png")
			cashNumbers[i][3] = display.newImage("3.png")	
			cashNumbers[i][4] = display.newImage("3.png")	
			cashNumbers[i][5] = display.newImage("3.png")	
			cashDisplayGroup:insert(cashNumbers[i][1])
			cashDisplayGroup:insert(cashNumbers[i][2])
			cashDisplayGroup:insert(cashNumbers[i][3])
			cashDisplayGroup:insert(cashNumbers[i][4])
			cashDisplayGroup:insert(cashNumbers[i][5])
		elseif(i == 4) then
			cashNumbers[i][1] = display.newImage("4.png")
			cashNumbers[i][2] = display.newImage("4.png")
			cashNumbers[i][3] = display.newImage("4.png")
			cashNumbers[i][4] = display.newImage("4.png")
			cashNumbers[i][5] = display.newImage("4.png")
			cashDisplayGroup:insert(cashNumbers[i][1])
			cashDisplayGroup:insert(cashNumbers[i][2])
			cashDisplayGroup:insert(cashNumbers[i][3])
			cashDisplayGroup:insert(cashNumbers[i][4])
			cashDisplayGroup:insert(cashNumbers[i][5])
		elseif(i == 5) then
			cashNumbers[i][1] = display.newImage("5.png")
			cashNumbers[i][2] = display.newImage("5.png")
			cashNumbers[i][3] = display.newImage("5.png")	
			cashNumbers[i][4] = display.newImage("5.png")	
			cashNumbers[i][5] = display.newImage("5.png")	
			cashDisplayGroup:insert(cashNumbers[i][1])
			cashDisplayGroup:insert(cashNumbers[i][2])
			cashDisplayGroup:insert(cashNumbers[i][3])
			cashDisplayGroup:insert(cashNumbers[i][4])
			cashDisplayGroup:insert(cashNumbers[i][5])
		elseif(i == 6) then
			cashNumbers[i][1] = display.newImage("6.png")
			cashNumbers[i][2] = display.newImage("6.png")
			cashNumbers[i][3] = display.newImage("6.png")	
			cashNumbers[i][4] = display.newImage("6.png")	
			cashNumbers[i][5] = display.newImage("6.png")	
			cashDisplayGroup:insert(cashNumbers[i][1])
			cashDisplayGroup:insert(cashNumbers[i][2])
			cashDisplayGroup:insert(cashNumbers[i][3])
			cashDisplayGroup:insert(cashNumbers[i][4])
			cashDisplayGroup:insert(cashNumbers[i][5])
		elseif(i == 7) then
			cashNumbers[i][1] = display.newImage("7.png")
			cashNumbers[i][2] = display.newImage("7.png")
			cashNumbers[i][3] = display.newImage("7.png")	
			cashNumbers[i][4] = display.newImage("7.png")	
			cashNumbers[i][5] = display.newImage("7.png")	
			cashDisplayGroup:insert(cashNumbers[i][1])
			cashDisplayGroup:insert(cashNumbers[i][2])
			cashDisplayGroup:insert(cashNumbers[i][3])
			cashDisplayGroup:insert(cashNumbers[i][4])
			cashDisplayGroup:insert(cashNumbers[i][5])
		elseif(i == 8) then
			cashNumbers[i][1] = display.newImage("8.png")
			cashNumbers[i][2] = display.newImage("8.png")
			cashNumbers[i][3] = display.newImage("8.png")	
			cashNumbers[i][4] = display.newImage("8.png")	
			cashNumbers[i][5] = display.newImage("8.png")	
			cashDisplayGroup:insert(cashNumbers[i][1])
			cashDisplayGroup:insert(cashNumbers[i][2])
			cashDisplayGroup:insert(cashNumbers[i][3])
			cashDisplayGroup:insert(cashNumbers[i][4])
			cashDisplayGroup:insert(cashNumbers[i][5])
		elseif(i == 9) then
			cashNumbers[i][1] = display.newImage("9.png")
			cashNumbers[i][2] = display.newImage("9.png")
			cashNumbers[i][3] = display.newImage("9.png")	
			cashNumbers[i][4] = display.newImage("9.png")	
			cashNumbers[i][5] = display.newImage("9.png")	
			cashDisplayGroup:insert(cashNumbers[i][1])
			cashDisplayGroup:insert(cashNumbers[i][2])
			cashDisplayGroup:insert(cashNumbers[i][3])
			cashDisplayGroup:insert(cashNumbers[i][4])
			cashDisplayGroup:insert(cashNumbers[i][5])
		elseif(i == 10) then
			cashNumbers[i][1] = display.newImage("0.png")
			cashNumbers[i][2] = display.newImage("0.png")
			cashNumbers[i][3] = display.newImage("0.png")	
			cashNumbers[i][4] = display.newImage("0.png")	
			cashNumbers[i][5] = display.newImage("0.png")	
			cashDisplayGroup:insert(cashNumbers[i][1])
			cashDisplayGroup:insert(cashNumbers[i][2])
			cashDisplayGroup:insert(cashNumbers[i][3])
			cashDisplayGroup:insert(cashNumbers[i][4])
			cashDisplayGroup:insert(cashNumbers[i][5])
		end
		
	end





	--SUM NUMBERS	
	
	for i = 1, 10 , 1 do
			sumNumbers[i] = {0, 0, 0, 0, 0, 0, 0}
	end

	for i = 1, 10 , 1 do
		if (i == 1)	then
			sumNumbers[i][1] = display.newImage("1.png")
			sumNumbers[i][2] = display.newImage("1.png")
			sumNumbers[i][3] = display.newImage("1.png")
			sumNumbers[i][4] = display.newImage("1.png")
			sumNumbers[i][5] = display.newImage("1.png")
			sumNumbers[i][6] = display.newImage("1.png")
			sumNumbers[i][7] = display.newImage("1.png")
			sumDisplayGroup:insert(sumNumbers[i][1])
			sumDisplayGroup:insert(sumNumbers[i][2])
			sumDisplayGroup:insert(sumNumbers[i][3])
			sumDisplayGroup:insert(sumNumbers[i][4])
			sumDisplayGroup:insert(sumNumbers[i][5])
			sumDisplayGroup:insert(sumNumbers[i][6])
			sumDisplayGroup:insert(sumNumbers[i][7])
		elseif(i == 2) then
			sumNumbers[i][1] = display.newImage("2.png")
			sumNumbers[i][2] = display.newImage("2.png")
			sumNumbers[i][3] = display.newImage("2.png")	
			sumNumbers[i][4] = display.newImage("2.png")	
			sumNumbers[i][5] = display.newImage("2.png")	
			sumNumbers[i][6] = display.newImage("2.png")	
			sumNumbers[i][7] = display.newImage("2.png")	
			sumDisplayGroup:insert(sumNumbers[i][1])
			sumDisplayGroup:insert(sumNumbers[i][2])
			sumDisplayGroup:insert(sumNumbers[i][3])
			sumDisplayGroup:insert(sumNumbers[i][4])
			sumDisplayGroup:insert(sumNumbers[i][5])
			sumDisplayGroup:insert(sumNumbers[i][6])
			sumDisplayGroup:insert(sumNumbers[i][7])
		elseif(i == 3) then
			sumNumbers[i][1] = display.newImage("3.png")
			sumNumbers[i][2] = display.newImage("3.png")
			sumNumbers[i][3] = display.newImage("3.png")	
			sumNumbers[i][4] = display.newImage("3.png")	
			sumNumbers[i][5] = display.newImage("3.png")	
			sumNumbers[i][6] = display.newImage("3.png")	
			sumNumbers[i][7] = display.newImage("3.png")	
			sumDisplayGroup:insert(sumNumbers[i][1])
			sumDisplayGroup:insert(sumNumbers[i][2])
			sumDisplayGroup:insert(sumNumbers[i][3])
			sumDisplayGroup:insert(sumNumbers[i][4])
			sumDisplayGroup:insert(sumNumbers[i][5])
			sumDisplayGroup:insert(sumNumbers[i][6])
			sumDisplayGroup:insert(sumNumbers[i][7])
		elseif(i == 4) then
			sumNumbers[i][1] = display.newImage("4.png")
			sumNumbers[i][2] = display.newImage("4.png")
			sumNumbers[i][3] = display.newImage("4.png")
			sumNumbers[i][4] = display.newImage("4.png")
			sumNumbers[i][5] = display.newImage("4.png")
			sumNumbers[i][6] = display.newImage("4.png")
			sumNumbers[i][7] = display.newImage("4.png")
			sumDisplayGroup:insert(sumNumbers[i][1])
			sumDisplayGroup:insert(sumNumbers[i][2])
			sumDisplayGroup:insert(sumNumbers[i][3])
			sumDisplayGroup:insert(sumNumbers[i][4])
			sumDisplayGroup:insert(sumNumbers[i][5])
			sumDisplayGroup:insert(sumNumbers[i][6])
			sumDisplayGroup:insert(sumNumbers[i][7])
		elseif(i == 5) then
			sumNumbers[i][1] = display.newImage("5.png")
			sumNumbers[i][2] = display.newImage("5.png")
			sumNumbers[i][3] = display.newImage("5.png")	
			sumNumbers[i][4] = display.newImage("5.png")	
			sumNumbers[i][5] = display.newImage("5.png")	
			sumNumbers[i][6] = display.newImage("5.png")	
			sumNumbers[i][7] = display.newImage("5.png")	
			sumDisplayGroup:insert(sumNumbers[i][1])
			sumDisplayGroup:insert(sumNumbers[i][2])
			sumDisplayGroup:insert(sumNumbers[i][3])
			sumDisplayGroup:insert(sumNumbers[i][4])
			sumDisplayGroup:insert(sumNumbers[i][5])
			sumDisplayGroup:insert(sumNumbers[i][6])
			sumDisplayGroup:insert(sumNumbers[i][7])
		elseif(i == 6) then
			sumNumbers[i][1] = display.newImage("6.png")
			sumNumbers[i][2] = display.newImage("6.png")
			sumNumbers[i][3] = display.newImage("6.png")	
			sumNumbers[i][4] = display.newImage("6.png")	
			sumNumbers[i][5] = display.newImage("6.png")	
			sumNumbers[i][6] = display.newImage("6.png")	
			sumNumbers[i][7] = display.newImage("6.png")	
			sumDisplayGroup:insert(sumNumbers[i][1])
			sumDisplayGroup:insert(sumNumbers[i][2])
			sumDisplayGroup:insert(sumNumbers[i][3])
			sumDisplayGroup:insert(sumNumbers[i][4])
			sumDisplayGroup:insert(sumNumbers[i][5])
			sumDisplayGroup:insert(sumNumbers[i][6])
			sumDisplayGroup:insert(sumNumbers[i][7])
		elseif(i == 7) then
			sumNumbers[i][1] = display.newImage("7.png")
			sumNumbers[i][2] = display.newImage("7.png")
			sumNumbers[i][3] = display.newImage("7.png")	
			sumNumbers[i][4] = display.newImage("7.png")	
			sumNumbers[i][5] = display.newImage("7.png")	
			sumNumbers[i][6] = display.newImage("7.png")	
			sumNumbers[i][7] = display.newImage("7.png")	
			sumDisplayGroup:insert(sumNumbers[i][1])
			sumDisplayGroup:insert(sumNumbers[i][2])
			sumDisplayGroup:insert(sumNumbers[i][3])
			sumDisplayGroup:insert(sumNumbers[i][4])
			sumDisplayGroup:insert(sumNumbers[i][5])
			sumDisplayGroup:insert(sumNumbers[i][6])
			sumDisplayGroup:insert(sumNumbers[i][7])
		elseif(i == 8) then
			sumNumbers[i][1] = display.newImage("8.png")
			sumNumbers[i][2] = display.newImage("8.png")
			sumNumbers[i][3] = display.newImage("8.png")	
			sumNumbers[i][4] = display.newImage("8.png")	
			sumNumbers[i][5] = display.newImage("8.png")	
			sumNumbers[i][6] = display.newImage("8.png")	
			sumNumbers[i][7] = display.newImage("8.png")	
			sumDisplayGroup:insert(sumNumbers[i][1])
			sumDisplayGroup:insert(sumNumbers[i][2])
			sumDisplayGroup:insert(sumNumbers[i][3])
			sumDisplayGroup:insert(sumNumbers[i][4])
			sumDisplayGroup:insert(sumNumbers[i][5])
			sumDisplayGroup:insert(sumNumbers[i][6])
			sumDisplayGroup:insert(sumNumbers[i][7])
		elseif(i == 9) then
			sumNumbers[i][1] = display.newImage("9.png")
			sumNumbers[i][2] = display.newImage("9.png")
			sumNumbers[i][3] = display.newImage("9.png")	
			sumNumbers[i][4] = display.newImage("9.png")	
			sumNumbers[i][5] = display.newImage("9.png")	
			sumNumbers[i][6] = display.newImage("9.png")	
			sumNumbers[i][7] = display.newImage("9.png")	
			sumDisplayGroup:insert(sumNumbers[i][1])
			sumDisplayGroup:insert(sumNumbers[i][2])
			sumDisplayGroup:insert(sumNumbers[i][3])
			sumDisplayGroup:insert(sumNumbers[i][4])
			sumDisplayGroup:insert(sumNumbers[i][5])
			sumDisplayGroup:insert(sumNumbers[i][6])
			sumDisplayGroup:insert(sumNumbers[i][7])
		elseif(i == 10) then
			sumNumbers[i][1] = display.newImage("0.png")
			sumNumbers[i][2] = display.newImage("0.png")
			sumNumbers[i][3] = display.newImage("0.png")	
			sumNumbers[i][4] = display.newImage("0.png")	
			sumNumbers[i][5] = display.newImage("0.png")	
			sumNumbers[i][6] = display.newImage("0.png")	
			sumNumbers[i][7] = display.newImage("0.png")	
			sumDisplayGroup:insert(sumNumbers[i][1])
			sumDisplayGroup:insert(sumNumbers[i][2])
			sumDisplayGroup:insert(sumNumbers[i][3])
			sumDisplayGroup:insert(sumNumbers[i][4])
			sumDisplayGroup:insert(sumNumbers[i][5])
			sumDisplayGroup:insert(sumNumbers[i][6])
			sumDisplayGroup:insert(sumNumbers[i][7])
		end
		
	end
	
end

initializeCashSumNumbers()


function hideCashNumbers()

	for i = 1, 10 , 1 do
		if (i == 1)	then
			cashNumbers[i][1].isVisible = false
			cashNumbers[i][2].isVisible = false
			cashNumbers[i][3].isVisible = false
			cashNumbers[i][4].isVisible = false
			cashNumbers[i][5].isVisible = false
		elseif(i == 2) then
			cashNumbers[i][1].isVisible = false
			cashNumbers[i][2].isVisible = false
			cashNumbers[i][3].isVisible = false
			cashNumbers[i][4].isVisible = false
			cashNumbers[i][5].isVisible = false
		elseif(i == 3) then
			cashNumbers[i][1].isVisible = false
			cashNumbers[i][2].isVisible = false
			cashNumbers[i][3].isVisible = false
			cashNumbers[i][4].isVisible = false
			cashNumbers[i][5].isVisible = false
		elseif(i == 4) then
			cashNumbers[i][1].isVisible = false
			cashNumbers[i][2].isVisible = false
			cashNumbers[i][3].isVisible = false
			cashNumbers[i][4].isVisible = false
			cashNumbers[i][5].isVisible = false
		elseif(i == 5) then
			cashNumbers[i][1].isVisible = false
			cashNumbers[i][2].isVisible = false
			cashNumbers[i][3].isVisible = false
			cashNumbers[i][4].isVisible = false
			cashNumbers[i][5].isVisible = false
		elseif(i == 6) then
			cashNumbers[i][1].isVisible = false
			cashNumbers[i][2].isVisible = false
			cashNumbers[i][3].isVisible = false
			cashNumbers[i][4].isVisible = false
			cashNumbers[i][5].isVisible = false
		elseif(i == 7) then
			cashNumbers[i][1].isVisible = false
			cashNumbers[i][2].isVisible = false
			cashNumbers[i][3].isVisible = false
			cashNumbers[i][4].isVisible = false
			cashNumbers[i][5].isVisible = false
		elseif(i == 8) then
			cashNumbers[i][1].isVisible = false
			cashNumbers[i][2].isVisible = false
			cashNumbers[i][3].isVisible = false
			cashNumbers[i][4].isVisible = false
			cashNumbers[i][5].isVisible = false
		elseif(i == 9) then
			cashNumbers[i][1].isVisible = false
			cashNumbers[i][2].isVisible = false
			cashNumbers[i][3].isVisible = false
			cashNumbers[i][4].isVisible = false
			cashNumbers[i][5].isVisible = false
		elseif(i == 10) then
			cashNumbers[i][1].isVisible = false
			cashNumbers[i][2].isVisible = false
			cashNumbers[i][3].isVisible = false
			cashNumbers[i][4].isVisible = false
			cashNumbers[i][5].isVisible = false
		end
		
	end

end

hideCashNumbers()


function hideSumNumbers()

	for i = 1, 10 , 1 do
		if (i == 1)	then
			sumNumbers[i][1].isVisible = false
			sumNumbers[i][2].isVisible = false
			sumNumbers[i][3].isVisible = false
			sumNumbers[i][4].isVisible = false
			sumNumbers[i][5].isVisible = false
			sumNumbers[i][6].isVisible = false
			sumNumbers[i][7].isVisible = false
		elseif(i == 2) then
			sumNumbers[i][1].isVisible = false
			sumNumbers[i][2].isVisible = false
			sumNumbers[i][3].isVisible = false
			sumNumbers[i][4].isVisible = false
			sumNumbers[i][5].isVisible = false
			sumNumbers[i][6].isVisible = false
			sumNumbers[i][7].isVisible = false
		elseif(i == 3) then
			sumNumbers[i][1].isVisible = false
			sumNumbers[i][2].isVisible = false
			sumNumbers[i][3].isVisible = false
			sumNumbers[i][4].isVisible = false
			sumNumbers[i][5].isVisible = false
			sumNumbers[i][6].isVisible = false
			sumNumbers[i][7].isVisible = false
		elseif(i == 4) then
			sumNumbers[i][1].isVisible = false
			sumNumbers[i][2].isVisible = false
			sumNumbers[i][3].isVisible = false
			sumNumbers[i][4].isVisible = false
			sumNumbers[i][5].isVisible = false
			sumNumbers[i][6].isVisible = false
			sumNumbers[i][7].isVisible = false
		elseif(i == 5) then
			sumNumbers[i][1].isVisible = false
			sumNumbers[i][2].isVisible = false
			sumNumbers[i][3].isVisible = false
			sumNumbers[i][4].isVisible = false
			sumNumbers[i][5].isVisible = false
			sumNumbers[i][6].isVisible = false
			sumNumbers[i][7].isVisible = false
		elseif(i == 6) then
			sumNumbers[i][1].isVisible = false
			sumNumbers[i][2].isVisible = false
			sumNumbers[i][3].isVisible = false
			sumNumbers[i][4].isVisible = false
			sumNumbers[i][5].isVisible = false
			sumNumbers[i][6].isVisible = false
			sumNumbers[i][7].isVisible = false
		elseif(i == 7) then
			sumNumbers[i][1].isVisible = false
			sumNumbers[i][2].isVisible = false
			sumNumbers[i][3].isVisible = false
			sumNumbers[i][4].isVisible = false
			sumNumbers[i][5].isVisible = false
			sumNumbers[i][6].isVisible = false
			sumNumbers[i][7].isVisible = false
		elseif(i == 8) then
			sumNumbers[i][1].isVisible = false
			sumNumbers[i][2].isVisible = false
			sumNumbers[i][3].isVisible = false
			sumNumbers[i][4].isVisible = false
			sumNumbers[i][5].isVisible = false
			sumNumbers[i][6].isVisible = false
			sumNumbers[i][7].isVisible = false
		elseif(i == 9) then
			sumNumbers[i][1].isVisible = false
			sumNumbers[i][2].isVisible = false
			sumNumbers[i][3].isVisible = false
			sumNumbers[i][4].isVisible = false
			sumNumbers[i][5].isVisible = false
			sumNumbers[i][6].isVisible = false
			sumNumbers[i][7].isVisible = false
		elseif(i == 10) then
			sumNumbers[i][1].isVisible = false
			sumNumbers[i][2].isVisible = false
			sumNumbers[i][3].isVisible = false
			sumNumbers[i][4].isVisible = false
			sumNumbers[i][5].isVisible = false
			sumNumbers[i][6].isVisible = false
			sumNumbers[i][7].isVisible = false
		end
		
	end

end

hideSumNumbers()

-- HEALT DISPLAY GROUP

local healthDisplayGroup = display.newGroup()

healthDisplayGroup.x = 47
healthDisplayGroup.y = 5

local healthBarBackground = display.newImage("Healthbar Background.png")
local healthBarTop1 = display.newImage("Healthbar Top 1.png")
local healthBarTop2 = display.newImage("Healthbar Top 2.png")
local healthBarTop3 = display.newImage("Healthbar Top 2.png")
local healthBarTop4 = display.newImage("Healthbar Top 2.png")

local healthBarTop1Cover = display.newImage("Healthbar Top 1 Cover.png")
local healthBarTop2Cover = display.newImage("Healthbar Top 2 Cover.png")
local healthBarTop3Cover = display.newImage("Healthbar Top 2 Cover.png")
local healthBarTop4Cover = display.newImage("Healthbar Top 2 Cover.png")

function initializeHealthBar()

	healthDisplayGroup:insert(healthBarBackground)
	healthDisplayGroup:insert(healthBarTop1)
	healthDisplayGroup:insert(healthBarTop2)
	healthDisplayGroup:insert(healthBarTop3)
	healthDisplayGroup:insert(healthBarTop4)

	healthDisplayGroup:insert(healthBarTop1Cover)
	healthDisplayGroup:insert(healthBarTop2Cover)
	healthDisplayGroup:insert(healthBarTop3Cover)
	healthDisplayGroup:insert(healthBarTop4Cover)

	
	healthBarBackground.x = 75
	
	healthBarTop1.x = 129
	healthBarTop1.y = 10

	healthBarTop2.x = 95
	healthBarTop2.y = 10

	healthBarTop3.x = 61
	healthBarTop3.y = 10

	healthBarTop4.x = 27
	healthBarTop4.y = 10

	healthBarTop1Cover.x = healthBarTop1.x
	healthBarTop1Cover.y = healthBarTop1.y

	healthBarTop2Cover.x = healthBarTop2.x
	healthBarTop2Cover.y = healthBarTop2.y

	healthBarTop3Cover.x = healthBarTop3.x
	healthBarTop3Cover.y = healthBarTop3.y

	healthBarTop4Cover.x = healthBarTop4.x
	healthBarTop4Cover.y = healthBarTop4.y
	
	healthBarTop1Cover.isVisible = false
	healthBarTop2Cover.isVisible = false
	healthBarTop3Cover.isVisible = false
	healthBarTop4Cover.isVisible = false
	

end

initializeHealthBar()

-- WRITE SCREEN AMMO DISPLAY GROUP

local ammoDisplayGroup = display.newGroup()

ammoDisplayGroup.isVisible = false
ammoDisplayGroup.x = 79
ammoDisplayGroup.y = 25


local ammoNumbers = {}
local ammoX = display.newImage("x.png")


function initializeAmmoNumbers()
	
	ammoDisplayGroup:insert(ammoX)
	
	for i = 1, 10 , 1 do
			ammoNumbers[i] = {0, 0, 0}
	end

	for i = 1, 10 , 1 do
		if (i == 1)	then
			ammoNumbers[i][1] = display.newImage("1.png")
			ammoNumbers[i][2] = display.newImage("1.png")
			ammoNumbers[i][3] = display.newImage("1.png")
			ammoDisplayGroup:insert(ammoNumbers[i][1])
			ammoDisplayGroup:insert(ammoNumbers[i][2])
			ammoDisplayGroup:insert(ammoNumbers[i][3])
		elseif(i == 2) then
			ammoNumbers[i][1] = display.newImage("2.png")
			ammoNumbers[i][2] = display.newImage("2.png")
			ammoNumbers[i][3] = display.newImage("2.png")	
			ammoDisplayGroup:insert(ammoNumbers[i][1])
			ammoDisplayGroup:insert(ammoNumbers[i][2])
			ammoDisplayGroup:insert(ammoNumbers[i][3])
		elseif(i == 3) then
			ammoNumbers[i][1] = display.newImage("3.png")
			ammoNumbers[i][2] = display.newImage("3.png")
			ammoNumbers[i][3] = display.newImage("3.png")	
			ammoDisplayGroup:insert(ammoNumbers[i][1])
			ammoDisplayGroup:insert(ammoNumbers[i][2])
			ammoDisplayGroup:insert(ammoNumbers[i][3])
		elseif(i == 4) then
			ammoNumbers[i][1] = display.newImage("4.png")
			ammoNumbers[i][2] = display.newImage("4.png")
			ammoNumbers[i][3] = display.newImage("4.png")
			ammoDisplayGroup:insert(ammoNumbers[i][1])
			ammoDisplayGroup:insert(ammoNumbers[i][2])
			ammoDisplayGroup:insert(ammoNumbers[i][3])
		elseif(i == 5) then
			ammoNumbers[i][1] = display.newImage("5.png")
			ammoNumbers[i][2] = display.newImage("5.png")
			ammoNumbers[i][3] = display.newImage("5.png")	
			ammoDisplayGroup:insert(ammoNumbers[i][1])
			ammoDisplayGroup:insert(ammoNumbers[i][2])
			ammoDisplayGroup:insert(ammoNumbers[i][3])
		elseif(i == 6) then
			ammoNumbers[i][1] = display.newImage("6.png")
			ammoNumbers[i][2] = display.newImage("6.png")
			ammoNumbers[i][3] = display.newImage("6.png")	
			ammoDisplayGroup:insert(ammoNumbers[i][1])
			ammoDisplayGroup:insert(ammoNumbers[i][2])
			ammoDisplayGroup:insert(ammoNumbers[i][3])
		elseif(i == 7) then
			ammoNumbers[i][1] = display.newImage("7.png")
			ammoNumbers[i][2] = display.newImage("7.png")
			ammoNumbers[i][3] = display.newImage("7.png")	
			ammoDisplayGroup:insert(ammoNumbers[i][1])
			ammoDisplayGroup:insert(ammoNumbers[i][2])
			ammoDisplayGroup:insert(ammoNumbers[i][3])
		elseif(i == 8) then
			ammoNumbers[i][1] = display.newImage("8.png")
			ammoNumbers[i][2] = display.newImage("8.png")
			ammoNumbers[i][3] = display.newImage("8.png")	
			ammoDisplayGroup:insert(ammoNumbers[i][1])
			ammoDisplayGroup:insert(ammoNumbers[i][2])
			ammoDisplayGroup:insert(ammoNumbers[i][3])
		elseif(i == 9) then
			ammoNumbers[i][1] = display.newImage("9.png")
			ammoNumbers[i][2] = display.newImage("9.png")
			ammoNumbers[i][3] = display.newImage("9.png")	
			ammoDisplayGroup:insert(ammoNumbers[i][1])
			ammoDisplayGroup:insert(ammoNumbers[i][2])
			ammoDisplayGroup:insert(ammoNumbers[i][3])
		elseif(i == 10) then
			ammoNumbers[i][1] = display.newImage("0.png")
			ammoNumbers[i][2] = display.newImage("0.png")
			ammoNumbers[i][3] = display.newImage("0.png")	
			ammoDisplayGroup:insert(ammoNumbers[i][1])
			ammoDisplayGroup:insert(ammoNumbers[i][2])
			ammoDisplayGroup:insert(ammoNumbers[i][3])
		end
		
	end

end

initializeAmmoNumbers()


function hideAmmoNumbers()

	for i = 1, 10 , 1 do
		if (i == 1)	then
			ammoNumbers[i][1].isVisible = false
			ammoNumbers[i][2].isVisible = false
			ammoNumbers[i][3].isVisible = false
		elseif(i == 2) then
			ammoNumbers[i][1].isVisible = false
			ammoNumbers[i][2].isVisible = false
			ammoNumbers[i][3].isVisible = false
		elseif(i == 3) then
			ammoNumbers[i][1].isVisible = false
			ammoNumbers[i][2].isVisible = false
			ammoNumbers[i][3].isVisible = false
		elseif(i == 4) then
			ammoNumbers[i][1].isVisible = false
			ammoNumbers[i][2].isVisible = false
			ammoNumbers[i][3].isVisible = false
		elseif(i == 5) then
			ammoNumbers[i][1].isVisible = false
			ammoNumbers[i][2].isVisible = false
			ammoNumbers[i][3].isVisible = false
		elseif(i == 6) then
			ammoNumbers[i][1].isVisible = false
			ammoNumbers[i][2].isVisible = false
			ammoNumbers[i][3].isVisible = false
		elseif(i == 7) then
			ammoNumbers[i][1].isVisible = false
			ammoNumbers[i][2].isVisible = false
			ammoNumbers[i][3].isVisible = false
		elseif(i == 8) then
			ammoNumbers[i][1].isVisible = false
			ammoNumbers[i][2].isVisible = false
			ammoNumbers[i][3].isVisible = false
		elseif(i == 9) then
			ammoNumbers[i][1].isVisible = false
			ammoNumbers[i][2].isVisible = false
			ammoNumbers[i][3].isVisible = false
		elseif(i == 10) then
			ammoNumbers[i][1].isVisible = false
			ammoNumbers[i][2].isVisible = false
			ammoNumbers[i][3].isVisible = false
		end
		
	end

end

hideAmmoNumbers()


-- VICTORY SCREEN DISPLAY GROUP

local victoryDisplayGroup = display.newGroup()
victoryDisplayGroup.x = -300
victoryDisplayGroup.y = 140

local victoryLetters = {}


function setUpVictoryLetters()

	victoryLetters.V = display.newImage("Vc.png")
	victoryLetters.i = display.newImage("isc.png")
	victoryLetters.c = display.newImage("csc.png")
	victoryLetters.t = display.newImage("tsc.png")
	victoryLetters.o = display.newImage("osc.png")
	victoryLetters.r = display.newImage("rsc.png")
	victoryLetters.y = display.newImage("ysc.png")
	victoryLetters.i2 = display.newImage("isc.png")
	victoryLetters.a = display.newImage("asc.png")


	victoryDisplayGroup:insert(victoryLetters.V)
	victoryDisplayGroup:insert(victoryLetters.i)
	victoryDisplayGroup:insert(victoryLetters.c)
	victoryDisplayGroup:insert(victoryLetters.t)
	victoryDisplayGroup:insert(victoryLetters.o)
	victoryDisplayGroup:insert(victoryLetters.r)
	victoryDisplayGroup:insert(victoryLetters.y)
	victoryDisplayGroup:insert(victoryLetters.i2)
	victoryDisplayGroup:insert(victoryLetters.a)

end

setUpVictoryLetters()


function zeroOutVictoryLetters()

	victoryLetters.V.x = 0
	victoryLetters.i.x = 30
	victoryLetters.c.x = 60
	victoryLetters.t.x = 90
	victoryLetters.o.x = 120
	victoryLetters.r.x = 150
	victoryLetters.y.x = 180
	victoryLetters.i2.x = 180
	victoryLetters.a.x = 210
	
	victoryLetters.V.y = 0
	victoryLetters.i.y = 1
	victoryLetters.c.y = 7
	victoryLetters.t.y = 0
	victoryLetters.o.y = 7
	victoryLetters.r.y = 7
	victoryLetters.y.y = 11
	victoryLetters.i2.y = 1
	victoryLetters.a.y = 7

end

zeroOutVictoryLetters()

-- START OF LEVEL DISPLAY GROUP

local startOfLevelDisplayGroup = display.newGroup()
startOfLevelDisplayGroup.x = -300
startOfLevelDisplayGroup.y = 140

local startUpLetters = {}
local startUpNumbers = {}
local startUpMessage = {}

function initalizeStarUpLetters()

	startUpLetters.L = display.newImage("Lc.png")
	startUpLetters.N = display.newImage("Nc.png")
	startUpLetters.i = display.newImage("isc.png")
	startUpLetters.e = display.newImage("esc.png")
	startUpLetters.e2 = display.newImage("esc.png")
	startUpLetters.v = display.newImage("vsc.png")
	startUpLetters.l = display.newImage("lsc.png")

	startOfLevelDisplayGroup:insert(startUpLetters.L)
	startOfLevelDisplayGroup:insert(startUpLetters.N)
	startOfLevelDisplayGroup:insert(startUpLetters.i)
	startOfLevelDisplayGroup:insert(startUpLetters.e)
	startOfLevelDisplayGroup:insert(startUpLetters.e2)
	startOfLevelDisplayGroup:insert(startUpLetters.v)
	startOfLevelDisplayGroup:insert(startUpLetters.l)

	
	for i = 1, 10 , 1 do
			startUpNumbers[i] = {0, 0}
	end
	
	for i = 1, 10 , 1 do
		if (i == 1)	then
			startUpNumbers[i][1] = display.newImage("1c.png")
			startUpNumbers[i][2] = display.newImage("1c.png")
			startOfLevelDisplayGroup:insert(startUpNumbers[i][1])
			startOfLevelDisplayGroup:insert(startUpNumbers[i][2])
		elseif(i == 2) then
			startUpNumbers[i][1] = display.newImage("2c.png")
			startUpNumbers[i][2] = display.newImage("2c.png")
			startOfLevelDisplayGroup:insert(startUpNumbers[i][1])
			startOfLevelDisplayGroup:insert(startUpNumbers[i][2])
		elseif(i == 3) then
			startUpNumbers[i][1] = display.newImage("3c.png")
			startUpNumbers[i][2] = display.newImage("3c.png")
			startOfLevelDisplayGroup:insert(startUpNumbers[i][1])
			startOfLevelDisplayGroup:insert(startUpNumbers[i][2])
		elseif(i == 4) then
			startUpNumbers[i][1] = display.newImage("4c.png")
			startUpNumbers[i][2] = display.newImage("4c.png")
			startOfLevelDisplayGroup:insert(startUpNumbers[i][1])
			startOfLevelDisplayGroup:insert(startUpNumbers[i][2])
		elseif(i == 5) then
			startUpNumbers[i][1] = display.newImage("5c.png")
			startUpNumbers[i][2] = display.newImage("5c.png")
			startOfLevelDisplayGroup:insert(startUpNumbers[i][1])
			startOfLevelDisplayGroup:insert(startUpNumbers[i][2])
		elseif(i == 6) then
			startUpNumbers[i][1] = display.newImage("6c.png")
			startUpNumbers[i][2] = display.newImage("6c.png")
			startOfLevelDisplayGroup:insert(startUpNumbers[i][1])
			startOfLevelDisplayGroup:insert(startUpNumbers[i][2])
		elseif(i == 7) then
			startUpNumbers[i][1] = display.newImage("7c.png")
			startUpNumbers[i][2] = display.newImage("7c.png")
			startOfLevelDisplayGroup:insert(startUpNumbers[i][1])
			startOfLevelDisplayGroup:insert(startUpNumbers[i][2])
		elseif(i == 8) then
			startUpNumbers[i][1] = display.newImage("8c.png")
			startUpNumbers[i][2] = display.newImage("8c.png")
			startOfLevelDisplayGroup:insert(startUpNumbers[i][1])
			startOfLevelDisplayGroup:insert(startUpNumbers[i][2])
		elseif(i == 9) then
			startUpNumbers[i][1] = display.newImage("9c.png")
			startUpNumbers[i][2] = display.newImage("9c.png")
			startOfLevelDisplayGroup:insert(startUpNumbers[i][1])
			startOfLevelDisplayGroup:insert(startUpNumbers[i][2])
		elseif(i == 10) then
			startUpNumbers[i][1] = display.newImage("0c.png")
			startUpNumbers[i][2] = display.newImage("0c.png")
			startOfLevelDisplayGroup:insert(startUpNumbers[i][1])
			startOfLevelDisplayGroup:insert(startUpNumbers[i][2])
		end
		
	end

	
end

initalizeStarUpLetters()

function hideStartUpLetters()

	startUpLetters.L.isVisible = false
	startUpLetters.N.isVisible = false
	startUpLetters.i.isVisible = false
	startUpLetters.e.isVisible = false
	startUpLetters.e2.isVisible = false
	startUpLetters.v.isVisible = false
	startUpLetters.l.isVisible = false

	for i = 1, 10 , 1 do
		startUpNumbers[i][1].isVisible = false
		startUpNumbers[i][2].isVisible = false
	end
	
end

hideStartUpLetters()

-- END OF LEVEL DISPLAY GROUP

local endOfLevelDisplayGroup = display.newGroup()
endOfLevelDisplayGroup.x = 130
endOfLevelDisplayGroup.y = 140

local endLetters = {}

function initializeEndLetters()
	endLetters.Y = display.newImage("Yc.png")
	endLetters.o = display.newImage("osc.png")
	endLetters.u = display.newImage("usc.png")
	endLetters.D = display.newImage("Dc.png")
	endLetters.i = display.newImage("isc.png")
	endLetters.e = display.newImage("esc.png")
	endLetters.d = display.newImage("dsc.png")
	endLetters.ExM = display.newImage("ExMsc.png")

	endLetters.T = display.newImage("Tc.png")
	endLetters.u2 = display.newImage("usc.png")
	endLetters.ekezet = display.newImage("Ekezet.png")
	endLetters.M = display.newImage("Mc.png")
	endLetters.o2 = display.newImage("osc.png")
	endLetters.r = display.newImage("rsc.png")
	endLetters.i2 = display.newImage("isc.png")
	endLetters.s = display.newImage("ssc.png")
	endLetters.t = display.newImage("tsc.png")
	endLetters.e2 = display.newImage("esc.png")	
	endLetters.ExM2 = display.newImage("ExMsc.png")

	endOfLevelDisplayGroup:insert(endLetters.Y)
	endOfLevelDisplayGroup:insert(endLetters.o)
	endOfLevelDisplayGroup:insert(endLetters.u)
	endOfLevelDisplayGroup:insert(endLetters.D)
	endOfLevelDisplayGroup:insert(endLetters.i)
	endOfLevelDisplayGroup:insert(endLetters.e)
	endOfLevelDisplayGroup:insert(endLetters.d)
	endOfLevelDisplayGroup:insert(endLetters.ExM)

	endOfLevelDisplayGroup:insert(endLetters.T)
	endOfLevelDisplayGroup:insert(endLetters.u2)
	endOfLevelDisplayGroup:insert(endLetters.ekezet)
	endOfLevelDisplayGroup:insert(endLetters.M)
	endOfLevelDisplayGroup:insert(endLetters.o2)
	endOfLevelDisplayGroup:insert(endLetters.r)
	endOfLevelDisplayGroup:insert(endLetters.i2)
	endOfLevelDisplayGroup:insert(endLetters.s)
	endOfLevelDisplayGroup:insert(endLetters.t)
	endOfLevelDisplayGroup:insert(endLetters.e2)	
	endOfLevelDisplayGroup:insert(endLetters.ExM2)

	endLetters.Y.x = 0
	endLetters.o.x = 30
	endLetters.u.x = 60
	endLetters.D.x = 110
	endLetters.i.x = 135
	endLetters.e.x = 158
	endLetters.d.x = 190
	endLetters.ExM.x = 218

	endLetters.Y.y = 0
	endLetters.o.y = 7
	endLetters.u.y = 7
	endLetters.D.y = 0
	endLetters.i.y = 0
	endLetters.e.y = 6
	endLetters.d.y = 0
	endLetters.ExM.y = 0

	endLetters.T.x = -20
	endLetters.u2.x = 10
	endLetters.ekezet.x = 12
	endLetters.M.x = 70
	endLetters.o2.x = 110
	endLetters.r.x = 140
	endLetters.i2.x = 160
	endLetters.s.x = 184
	endLetters.t.x = 205
	endLetters.e2.x = 231
	endLetters.ExM2.x = 259

	endLetters.T.y = 0
	endLetters.u2.y = 7
	endLetters.ekezet.y = -23
	endLetters.M.y = 0
	endLetters.o2.y = 7
	endLetters.r.y = 7
	endLetters.i2.y = 1
	endLetters.s.y = 7
	endLetters.t.y = 0
	endLetters.e2.y = 7
	endLetters.ExM2.y = 0

	endOfLevelDisplayGroup.isVisible = false

end

initializeEndLetters()

-- INSERT CONTROLS

function insertControls()
	gameScreenDisplayGroup:insert(leftButton)
	gameScreenDisplayGroup:insert(rightButton)
	gameScreenDisplayGroup:insert(leftButtonMask)
	gameScreenDisplayGroup:insert(rightButtonMask)
	gameScreenDisplayGroup:insert(pauseButton)
	gameScreenDisplayGroup:insert(attackButton)
	gameScreenDisplayGroup:insert(attackButtonMask)
	gameScreenDisplayGroup:insert(attackButtonDarkMask)
	gameScreenDisplayGroup:insert(swingButton)
	gameScreenDisplayGroup:insert(swingButtonMask)
	gameScreenDisplayGroup:insert(granadeButton)
	gameScreenDisplayGroup:insert(granadeButtonMask)
	gameScreenDisplayGroup:insert(granadeButtonDarkMask)
	
	gameScreenDisplayGroup:insert(cashDisplayGroup)
	gameScreenDisplayGroup:insert(healthDisplayGroup)
	gameScreenDisplayGroup:insert(ammoDisplayGroup)
	gameScreenDisplayGroup:insert(weaponsIconsDisplayGroup)
	--gameScreenDisplayGroup:insert(FPSText)
	
	
	i.arrow1Icon.isVisible = false
	i.arrow2Icon.isVisible = false
	i.arrow3Icon.isVisible = false
	i.arrowGoldIcon.isVisible = false
	
	i.knife1Icon.isVisible = false
	i.knife2Icon.isVisible = false
	i.knife3Icon.isVisible = false
	i.knifeGoldIcon.isVisible = false

	i.tomahawk1Icon.isVisible = false
	i.tomahawk2Icon.isVisible = false
	i.tomahawk3Icon.isVisible = false
	i.tomahawkGoldIcon.isVisible = false

	i.pistol1Icon.isVisible = false
	i.pistol2Icon.isVisible = false
	i.pistol3Icon.isVisible = false
	i.pistolGoldIcon.isVisible = false
	
	i.rifle1Icon.isVisible = false
	i.rifle2Icon.isVisible = false
	i.rifle3Icon.isVisible = false
	i.rifleGoldIcon.isVisible = false
	
	i.battleAxe1Icon.isVisible = false
	i.mace1Icon.isVisible = false
	i.machete1Icon.isVisible = false
	i.macheteGoldIcon.isVisible = false
	
	i.granade1Icon.isVisible = false

	attackButtonMask.isVisible = false
	attackButtonDarkMask.isVisible = false
	swingButtonMask.isVisible = false
	granadeButtonMask.isVisible = false
	granadeButtonDarkMask.isVisible = false
	
	leftButtonMask.isVisible = false
	rightButtonMask.isVisible = false
	
end


function initializeControls()
	leftButton.x = 25
	leftButton.y = 285

	rightButton.x = 115
	rightButton.y = 285

	leftButtonMask.x = 25
	leftButtonMask.y = 285

	rightButtonMask.x = 115
	rightButtonMask.y = 285
	
	pauseButton.x = 440
	pauseButton.y = 22
	
	attackButton.x = 445
	attackButton.y = 285
	attackButtonMask.x = 445
	attackButtonMask.y = 285
	attackButtonDarkMask.x = 445
	attackButtonDarkMask.y = 285

	swingButton.x = 375
	swingButton.y = 285
	swingButtonMask.x = 375
	swingButtonMask.y = 285

	granadeButton.x = 305
	granadeButton.y = 285
	granadeButtonMask.x = 305
	granadeButtonMask.y = 285
	granadeButtonDarkMask.x = 305
	granadeButtonDarkMask.y = 285
	
end

initializeControls()

local leftButtonDown = 0
local rightButtonDown = 0
local attackButtonDown = 0
local swingButtonDown = 0
local granadeButtonDown = 0

function zeroOutControls()

	leftButtonDown = 0
	rightButtonDown = 0
	attackButtonDown = 0
	swingButtonDown = 0
	granadeButtonDown = 0

	pauseButton.isVisible = true

end

zeroOutControls()


function makeUpMap(level)

	if (background ~= nil) then
		background:removeSelf()
		background = nil	
	end
	
	if (road1 ~= nil) then
		road1:removeSelf()
		road1 = nil
	end

	if (road2 ~= nil) then
		road2:removeSelf()
		road2 = nil
	end

	if (road3 ~= nil) then
		road3:removeSelf()
		road3 = nil
	end

	if (roadShadow ~= nil) then
		roadShadow:removeSelf()
		roadShadow = nil
	end
	
	if (grass1 ~= nil) then
		grass1:removeSelf()
		grass1 = nil
	end
	
	if (grass2 ~= nil) then
		grass2:removeSelf()
		grass2 = nil
	end
	
	if (grass3 ~= nil) then
		grass3:removeSelf()
		grass3 = nil
	end
	
		
	if (level < 6) then
		background = display.newImage("Background 1.png", true)
		road1 = display.newImage("Road 1.png", true)
		road2 = display.newImage("Road 1.png", true)
		road3 = display.newImage("Road 1.png", true)
		roadShadow = display.newImage("Road Shadow Green.png", true)
		grass1 = display.newImage("Grass Green 1.png", true)
		grass2 = display.newImage("Grass Green 1.png", true)
		grass3 = display.newImage("Grass Green 1.png", true)
	
	elseif (level < 11) then
		background = display.newImage("Background 2.png", true)
		road1 = display.newImage("Road 1.png", true)
		road2 = display.newImage("Road 1.png", true)
		road3 = display.newImage("Road 1.png", true)
		roadShadow = display.newImage("Road Shadow Pink.png", true)
		grass1 = display.newImage("Grass Green 1.png", true)
		grass2 = display.newImage("Grass Green 1.png", true)
		grass3 = display.newImage("Grass Green 1.png", true)

		
	elseif (level < 16) then
		background = display.newImage("Background 3.png", true)
		road1 = display.newImage("Road 1.png", true)
		road2 = display.newImage("Road 1.png", true)
		road3 = display.newImage("Road 1.png", true)
		roadShadow = display.newImage("Road Shadow Black.png", true)
		grass1 = display.newImage("Grass Green 1.png", true)
		grass2 = display.newImage("Grass Green 1.png", true)
		grass3 = display.newImage("Grass Green 1.png", true)

		
	elseif (level < 21) then
		background = display.newImage("Background 4.png", true)
		grass1 = display.newImage("Grass Sand 1.png", true)
		grass2 = display.newImage("Grass Sand 1.png", true)
		grass3 = display.newImage("Grass Sand 1.png", true)
		
	elseif (level < 26) then
		background = display.newImage("Background 5.png", true)
		grass1 = display.newImage("Grass Sand 1.png", true)
		grass2 = display.newImage("Grass Sand 1.png", true)
		grass3 = display.newImage("Grass Sand 1.png", true)

		
	elseif (level < 31) then
		background = display.newImage("Background 6.png", true)	
		grass1 = display.newImage("Grass Sand 1.png", true)
		grass2 = display.newImage("Grass Sand 1.png", true)
		grass3 = display.newImage("Grass Sand 1.png", true)
	
	end


	gameScreenDisplayGroup:insert(background)
	background.x = _W / 2
	background.y = _H / 2
	
	if (level == 30) then
		gameScreenDisplayGroup:insert(w.wShip)
		w.wShip.x = 240
		w.wShip.y = 111
	end

	if (road1 ~= nil) then
		gameScreenDisplayGroup:insert(road1)
		gameScreenDisplayGroup:insert(road2)
		gameScreenDisplayGroup:insert(road3)
		
		road1.x = _W / 2
		road1.y = 215

		road2.x = (_W / 2) - 570
		road2.y = 215

		road3.x = (_W / 2) + 570
		road3.y = 215

		roadCounter = 0
		
		gameScreenDisplayGroup:insert(roadShadow)
		roadShadow.x = _W / 2
		roadShadow.y = 189 -- 214
	end
	
	populateMap()
	reArrangeMap()
	
	insertMyGuy()	
	insertOtherGuys()
	
	gameScreenDisplayGroup:insert(smallCoin1)
	gameScreenDisplayGroup:insert(smallCoin2)
	gameScreenDisplayGroup:insert(smallCoin3)

	gameScreenDisplayGroup:insert(exp01)
		
	gameScreenDisplayGroup:insert(grass1)
	gameScreenDisplayGroup:insert(grass2)
	gameScreenDisplayGroup:insert(grass3)	
	
	grass1.x = _W / 2
	grass1.y = 300

	grass2.x = (_W / 2) - 570
	grass2.y = 300

	grass3.x = (_W / 2) + 570
	grass3.y = 300

	grassCounter = 0
	
	insertControls()
	
	if (v.sumCash > 99999) then
		c.trophy1.isVisible = true
	else
		c.trophy1.isVisible = false
	end
	if (v.sumCash > 199999) then
		c.trophy2.isVisible = true
	else
		c.trophy2.isVisible = false
	end
	if (v.sumCash > 299999) then
		c.trophy3.isVisible = true
	else
		c.trophy3.isVisible = false
	end
	
	if (level < 16) then
		barrel1.isVisible = true
		barrel2.isVisible = false
	else
		barrel2.isVisible = true
		barrel1.isVisible = false	
	end
	
end 

makeUpMap(1)



-- MASKING SCREEN DISPLAY GROUP

local maskScreenDisplayGroup = display.newGroup()
local menuMaskScreen = display.newImage("Mask Screen.png")
local victoryMaskScreen = display.newImage("Mask Screen.png")
--local saveing = display.newImage("Exit Colors.png")
--local reallyWantToQuit = display.newImage("Really Want To Quit.png")

function insertMaskScreenDisplayGroup()
	
	b.returnToMenuEn = display.newImage("Return to Menu En.png")
	b.returnToMenuSp = display.newImage("Return to Menu Sp.png")
	b.yesButtonEn = display.newImage("Yes En.png")
	b.yesButtonSp = display.newImage("Yes Sp.png")
	b.noButton = display.newImage("No.png")

	
	
	
	
	menuMaskScreen.xScale = 10
	menuMaskScreen.yScale = 10
	victoryMaskScreen.xScale = 10
	victoryMaskScreen.yScale = 10
	maskScreenDisplayGroup:insert(victoryMaskScreen)
	maskScreenDisplayGroup:insert(startOfLevelDisplayGroup)
	maskScreenDisplayGroup:insert(victoryDisplayGroup)
	maskScreenDisplayGroup:insert(endOfLevelDisplayGroup)
	maskScreenDisplayGroup:insert(menuMaskScreen)
	maskScreenDisplayGroup:insert(b.returnToMenuEn)
	maskScreenDisplayGroup:insert(b.returnToMenuSp)
	maskScreenDisplayGroup:insert(b.yesButtonEn)
	maskScreenDisplayGroup:insert(b.yesButtonSp)
	maskScreenDisplayGroup:insert(b.noButton)
	--maskScreenDisplayGroup:insert(saveing)
	--maskScreenDisplayGroup:insert(reallyWantToQuit)
end 

insertMaskScreenDisplayGroup()


function initializeMaskScreenDisplayGroup()

	menuMaskScreen.alpha = 0
	menuMaskScreen.x = _W / 2
	menuMaskScreen.y = _H / 2
	
	victoryMaskScreen.alpha = 0
	victoryMaskScreen.x = _W / 2
	victoryMaskScreen.y = _H / 2

	b.returnToMenuEn.x = 240
	b.returnToMenuEn.y = 120

	b.returnToMenuSp.x = 240
	b.returnToMenuSp.y = 120
	
	b.yesButtonEn.x = 180
	b.yesButtonEn.y = 180

	b.yesButtonSp.x = 180
	b.yesButtonSp.y = 180
	
	b.noButton.x = 300
	b.noButton.y = 180

	--saveing.x = 300
	--saveing.y = 260
	
	--saveing.isVisible = false
	
	--reallyWantToQuit.x = 200
	--reallyWantToQuit.y = 250

end

initializeMaskScreenDisplayGroup()

function zeroOutMaskScreenDisplayGroup()

	maskScreenDisplayGroup.isVisible = false
	menuMaskScreen.isVisible = false
	victoryMaskScreen.isVisible = false
	b.returnToMenuEn.isVisible = false
	b.returnToMenuSp.isVisible = false
	b.yesButtonEn.isVisible = false
	b.yesButtonSp.isVisible = false
	b.noButton.isVisible = false
	--reallyWantToQuit.isVisible = false

end 

zeroOutMaskScreenDisplayGroup()

-- COUNTERS

local breatheCounter = 1
local walkCounter = 1
local leanForwardCounter = 0
local isAttackOne = 1
local isAttackTwo = 1
local isAttackThree = 1
local isAttackFour = 1
local isWeaponsChange = 0
local worldCounter = 45
local flameCounter = 1


-- HIDE WEAPONS

function hideWeapons()

	-- WEAPONS
	myGuyLeftFingers.isVisible = true
		
	g.crossbow.isVisible = false
	g.crossbow1.isVisible = false
	g.crossbow2.isVisible = false
	g.crossbow3.isVisible = false
	g.crossbowGold.isVisible = false
	g.crossbowStringPulled.isVisible = false
	g.crossbowStringRelaxed.isVisible = false

	g.arrow.isVisible = false
	g.arrow1.isVisible = false
	g.arrow2.isVisible = false
	g.arrow3.isVisible = false
	g.arrowGold.isVisible = false

	g.arrowDouble.isVisible = false
	g.arrow1Double.isVisible = false
	g.arrow2Double.isVisible = false
	g.arrow3Double.isVisible = false
	g.arrowGoldDouble.isVisible = false


	g.knifeLeft.isVisible = false
	g.knife1Left.isVisible = false
	g.knife2Left.isVisible = false
	g.knife3Left.isVisible = false
	g.knifeGoldLeft.isVisible = false

	g.knifeRight.isVisible = false
	g.knife1Right.isVisible = false
	g.knife2Right.isVisible = false
	g.knife3Right.isVisible = false
	g.knifeGoldRight.isVisible = false

	g.knifeLeftDouble.isVisible = false
	g.knife1LeftDouble.isVisible = false
	g.knife2LeftDouble.isVisible = false
	g.knife3LeftDouble.isVisible = false
	g.knifeGoldLeftDouble.isVisible = false

	g.knifeRightDouble.isVisible = false
	g.knife1RightDouble.isVisible = false
	g.knife2RightDouble.isVisible = false
	g.knife3RightDouble.isVisible = false
	g.knifeGoldRightDouble.isVisible = false

	
	g.tomahawkLeft.isVisible = false
	g.tomahawk1Left.isVisible = false
	g.tomahawk2Left.isVisible = false
	g.tomahawk3Left.isVisible = false
	g.tomahawkGoldLeft.isVisible = false

	g.tomahawkRight.isVisible = false
	g.tomahawk1Right.isVisible = false
	g.tomahawk2Right.isVisible = false
	g.tomahawk3Right.isVisible = false
	g.tomahawkGoldRight.isVisible = false

	g.tomahawkLeftDouble.isVisible = false
	g.tomahawk1LeftDouble.isVisible = false
	g.tomahawk2LeftDouble.isVisible = false
	g.tomahawk3LeftDouble.isVisible = false
	g.tomahawkGoldLeftDouble.isVisible = false

	g.tomahawkRightDouble.isVisible = false
	g.tomahawk1RightDouble.isVisible = false
	g.tomahawk2RightDouble.isVisible = false
	g.tomahawk3RightDouble.isVisible = false
	g.tomahawkGoldRightDouble.isVisible = false


	g.pistolLeft.isVisible = false
	g.pistol1Left.isVisible = false
	g.pistol2Left.isVisible = false
	g.pistol3Left.isVisible = false
	g.pistolGoldLeft.isVisible = false

	g.pistol1LeftDot.isVisible = false
	g.pistol2LeftDot.isVisible = false
	g.pistol3LeftDot.isVisible = false
	g.pistolGoldLeftDot.isVisible = false

	g.pistolRight.isVisible = false
	g.pistol1Right.isVisible = false
	g.pistol2Right.isVisible = false
	g.pistol3Right.isVisible = false
	g.pistolGoldRight.isVisible = false

	g.pistol1RightDot.isVisible = false
	g.pistol2RightDot.isVisible = false
	g.pistol3RightDot.isVisible = false
	g.pistolGoldRightDot.isVisible = false


	g.rifleLeft.isVisible = false
	g.rifle1Left.isVisible = false
	g.rifle2Left.isVisible = false
	g.rifle3Left.isVisible = false
	g.rifleGoldLeft.isVisible = false

	g.rifle1LeftDot.isVisible = false
	g.rifle2LeftDot.isVisible = false
	g.rifle3LeftDot.isVisible = false
	g.rifleGoldLeftDot.isVisible = false

	g.rifleRight.isVisible = false
	g.rifle1Right.isVisible = false
	g.rifle2Right.isVisible = false
	g.rifle3Right.isVisible = false
	g.rifleGoldRight.isVisible = false

	g.rifle1RightDot.isVisible = false
	g.rifle2RightDot.isVisible = false
	g.rifle3RightDot.isVisible = false
	g.rifleGoldRightDot.isVisible = false


	g.battleAxe1.isVisible = false
	g.mace1.isVisible = false
	g.machete1.isVisible = false
	g.macheteGold.isVisible = false

	g.granade.isVisible = false
	g.granade1.isVisible = false
	g.granadeGold.isVisible = false
	
	g.granadeDouble.isVisible = false
	g.granade1Double.isVisible = false
	g.granadeGoldDouble.isVisible = false
	
	g.shield11.isVisible = false
	g.shield12.isVisible = false
	g.shield21.isVisible = false
	g.shield22.isVisible = false
	g.shieldGold.isVisible = false
	

	splash01.isVisible = false
	
	gunSmoke01.isVisible = false
	gunSmoke02.isVisible = false
	gunSmoke03.isVisible = false
	
	exp01.isVisible = false

end


function initializeWeapons()

	hideWeapons()
	
	g.arrow1.isPurchased = 1
	g.arrow2.isPurchased = 0
	g.arrow3.isPurchased = 0
	g.arrowGold.isPurchased = 0

	g.knife1Left.isPurchased = 0
	g.knife2Left.isPurchased = 0
	g.knife3Left.isPurchased = 0
	g.knifeGoldLeft.isPurchased = 0

	g.tomahawk1Left.isPurchased = 0
	g.tomahawk2Left.isPurchased = 0
	g.tomahawk3Left.isPurchased = 0
	g.tomahawkGoldLeft.isPurchased = 0

	g.pistol1Left.isPurchased = 0
	g.pistol2Left.isPurchased = 0
	g.pistol3Left.isPurchased = 0
	g.pistolGoldLeft.isPurchased = 0

	g.rifle1Left.isPurchased = 0
	g.rifle2Left.isPurchased = 0
	g.rifle3Left.isPurchased = 0
	g.rifleGoldLeft.isPurchased = 0


	g.battleAxe1.isPurchased = 1
	g.mace1.isPurchased = 0
	g.machete1.isPurchased = 0
	g.macheteGold.isPurchased = 0

	g.granade1.isPurchased = 1
	g.granadeGold.isPurchased = 0
	
	g.myGuyShield.isPurchased = 1
	g.myGuyShieldGold.isPurchased = 0
	

	g.arrow1.name = "crossbow"

	g.knife1Left.name = "knifeLeft"

	g.tomahawk1Left.name = "tomahawkLeft"

	g.pistol1Left.name = "pistolRight"

	g.rifle1Left.name = "rifleRight"


	g.battleAxe1.name = "battleAxe"
	g.mace1.name = "mace"
	g.machete1.name = "machete"
	g.macheteGold.name = "macheteGold"

	g.granade1.name = "granade"
	
end

initializeWeapons()

function zeroOutWeapons()

	splash01.isVisible = false
	
	gunSmoke01.isVisible = false
	gunSmoke02.isVisible = false
	gunSmoke03.isVisible = false
	
	exp01.isVisible = false


	-- WEAPONS
	myGuyLeftFingers.x = 18
	myGuyLeftFingers.y = 20
	
	
	g.crossbow.rotation = 40
	g.crossbow.x = 22
	g.crossbow.y = 14

	g.crossbow1.x = 0
	g.crossbow1.y = 0

	g.crossbow2.x = 0
	g.crossbow2.y = 0
	
	g.crossbow3.x = 0
	g.crossbow3.y = 0	
	
	g.crossbowGold.x = 0
	g.crossbowGold.y = 0

	g.crossbowStringPulled.rotation = 40
	g.crossbowStringPulled.x = 22
	g.crossbowStringPulled.y = 15

	g.crossbowStringRelaxed.rotation = 0
	g.crossbowStringRelaxed.x = 10
	g.crossbowStringRelaxed.y = 0

	
	g.arrow.rotation = 40
	g.arrow.x = 22
	g.arrow.y = 0

	g.arrow2.y = 5
	
	g.knifeLeft.rotation = 40
	g.knifeLeft.x = 40
	g.knifeLeft.y = -20
	
	g.knife2Left.rotation = 10
	g.knife2Left.x = 12
	g.knife2Left.y = 24

	g.knife3Left.x = 9
	g.knife3Left.y = 22

	g.knifeGoldLeft.x = 9
	g.knifeGoldLeft.y = 20
	
	g.knifeRight.rotation = 110
	g.knifeRight.x = 55
	g.knifeRight.y = 30

	g.knife2Right.rotation = 10
	g.knife2Right.x = 12
	g.knife2Right.y = 24

	g.knife3Right.x = 10
	g.knife3Right.y = 23

	g.knifeGoldRight.x = 10
	g.knifeGoldRight.y = 21


	
	g.tomahawkLeft.rotation = 40
	g.tomahawkLeft.x = 38
	g.tomahawkLeft.y = -28
	
	g.tomahawk2Left.x = 15
	g.tomahawk2Left.y = 22

	g.tomahawk3Left.x = 15
	g.tomahawk3Left.y = 22

	g.tomahawkGoldLeft.x = 15
	g.tomahawkGoldLeft.y = 22

	
	g.tomahawkRight.rotation = 110
	g.tomahawkRight.x = 62
	g.tomahawkRight.y = 26

	g.tomahawk2Right.x = 15
	g.tomahawk2Right.y = 22
	
	g.tomahawk3Right.x = 16
	g.tomahawk3Right.y = 24
	
	g.tomahawkGoldRight.x = 16
	g.tomahawkGoldRight.y = 24
	
	
	g.pistolLeft.rotation = 40
	g.pistolLeft.x = 20
	g.pistolLeft.y = -2

	g.pistol2Left.x = 34
	g.pistol2Left.y = 10	
	
	g.pistol3Left.x = 36
	g.pistol3Left.y = 10
	
	g.pistolGoldLeft.x = 34
	g.pistolGoldLeft.y = 11
	
	g.pistol1LeftDot.x = 64
	g.pistol1LeftDot.y = 14
	g.pistol2LeftDot.x = 70
	g.pistol2LeftDot.y = 10
	g.pistol3LeftDot.x = 73
	g.pistol3LeftDot.y = 10
	g.pistolGoldLeftDot.x = 73
	g.pistolGoldLeftDot.y = 10

	
	g.pistolRight.rotation = 110
	g.pistolRight.x = 31
	g.pistolRight.y = 18

	g.pistol2Right.x = 33
	g.pistol2Right.y = 12
	
	g.pistol3Right.x = 35
	g.pistol3Right.y = 10

	g.pistolGoldRight.x = 33
	g.pistolGoldRight.y = 10
	
	g.pistol1RightDot.x = 64
	g.pistol1RightDot.y = 14
	g.pistol2RightDot.x = 68
	g.pistol2RightDot.y = 12
	g.pistol3RightDot.x = 72
	g.pistol3RightDot.y = 9
	g.pistolGoldRightDot.x = 72
	g.pistolGoldRightDot.y = 9


	g.rifleLeft.rotation = 40
	g.rifleLeft.x = 14
	g.rifleLeft.y = -6

	g.rifle2Left.x = 40
	g.rifle2Left.y = 14
	
	g.rifle3Left.x = 42
	g.rifle3Left.y = 12

	g.rifleGoldLeft.x = 42
	g.rifleGoldLeft.y = 12
	
	g.rifle1LeftDot.x = 91
	g.rifle1LeftDot.y = 14
	g.rifle2LeftDot.x = 93
	g.rifle2LeftDot.y = 14
	g.rifle3LeftDot.x = 96
	g.rifle3LeftDot.y = 14
	g.rifleGoldLeftDot.x = 96
	g.rifleGoldLeftDot.y = 14

	
	g.rifleRight.rotation = 110
	g.rifleRight.x = 35
	g.rifleRight.y = 11

	g.rifle2Right.x = 42
	g.rifle2Right.y = 16

	g.rifle3Right.x = 44
	g.rifle3Right.y = 15

	g.rifleGoldRight.x = 44
	g.rifleGoldRight.y = 15
	
	g.rifle1RightDot.x = 91
	g.rifle1RightDot.y = 14
	g.rifle2RightDot.x = 95
	g.rifle2RightDot.y = 16
	g.rifle3RightDot.x = 97
	g.rifle3RightDot.y = 16
	g.rifleGoldRightDot.x = 97
	g.rifleGoldRightDot.y = 16


	g.battleAxe1.rotation = 40
	g.battleAxe1.x = 36
	g.battleAxe1.y = 0

	g.mace1.rotation = 40
	g.mace1.x = 38
	g.mace1.y = -6

	g.machete1.rotation = 40
	g.machete1.x = 46
	g.machete1.y = -8

	g.macheteGold.rotation = 40
	g.macheteGold.x = 49
	g.macheteGold.y = -12

	g.granade.rotation = 60
	g.granade.x = 28
	g.granade.y = -8
	
	g.granadeGold.x = 12
	g.granadeGold.y	= 20
	
	


end

zeroOutWeapons()

-- ACTIVE SCREEN

local activeScreen = "menu"

-- GAME STATES


local activeWeapon = ""

local knifeAmmo = 0
local tomahawkAmmo = 0
local crossbowAmmo = 150
local pistolAmmo = 0
local rifleAmmo = 0
local granadeAmmo = 3

-- Touch ID
local eID = 0

-- THROW INITIAL DIRECTIONS
local tomahawkLeftDoubleDirection = nil
local knifeLeftDoubleDirection = nil
local tomahawkRightDoubleDirection = nil
local knifeRightDoubleDirection = nil
local granadeDoubleDirection = nil
local gunSmokeDirection = nil
local crossbowArrowDirection = nil
local leftNext = true


local openingScene




-- FUNCTIONS FROM HERE ---------------------------------------------------------------------------------------------
-- FUNCTIONS FROM HERE ---------------------------------------------------------------------------------------------
-- FUNCTIONS FROM HERE ---------------------------------------------------------------------------------------------
-- FUNCTIONS FROM HERE ---------------------------------------------------------------------------------------------
-- FUNCTIONS FROM HERE ---------------------------------------------------------------------------------------------




function randNums(e)

	local ret = ""

	for i = 1, e, 1 do
		ret = ret ..tostring(math.random(0, 9))
		--ret = ret .. "0"
	end
	
	return ret
	
end


function offset(what, much, direction)

	if(direction == 1) then
		return math.fmod(tonumber(what) + tonumber(much), 10)
	else
		return math.fmod(tonumber(what) + 10 - tonumber(much), 10)
	end
	
end


function capid()

	local id = system.getInfo( "deviceID" )
	local mid = ""
	
	for i = 1, id:len(), 1 do
		if(id:sub(i, i) == "1" or id:sub(i, i) == "2" or id:sub(i, i) == "3" or id:sub(i, i) == "4" or id:sub(i, i) == "5" or id:sub(i, i) == "6" or id:sub(i, i) == "7" or id:sub(i, i) == "8" or id:sub(i, i) == "9" or id:sub(i, i) == "0") then
			mid = mid..id:sub(i, i)
		elseif(id:sub(i, i) == "a" or id:sub(i, i) == "A") then
			mid = mid.."1"
		elseif(id:sub(i, i) == "b" or id:sub(i, i) == "B") then
			mid = mid.."2"
		elseif(id:sub(i, i) == "c" or id:sub(i, i) == "C") then
			mid = mid.."3"
		elseif(id:sub(i, i) == "d" or id:sub(i, i) == "D") then
			mid = mid.."4"		
		elseif(id:sub(i, i) == "e" or id:sub(i, i) == "E") then
			mid = mid.."5"
		elseif(id:sub(i, i) == "f" or id:sub(i, i) == "F") then
			mid = mid.."6"
		end
	end
	
	return mid
	--return "9999999999"
	
end


function fill(what, much)

	local rw = string.reverse(tostring(what))
	
	for i = 1, much, 1 do
		if (rw:len() < much) then
			rw = rw.."0"
		end
	end
	
	return string.reverse(rw)
	
end


function saveFileHandling(p)
	local path = system.pathForFile("agsg.svf", system.DocumentsDirectory)
	local iin = 20
	local jjn = 1
	local jn = 1
	local x = {}
	local xind = 1
	local x2 = {}
	local x2ind = 1
	local y = {}
	local stw = ""
	local rls = ""
	local rs = 0
		
	if (p == "load") then
		local saveFile = io.open(path, "r+")
		if (saveFile ~= nil) then
			for line in saveFile:lines() do
				iin = iin + 1
				x[xind] = tonumber(string.sub(line, iin, iin)) -- the offset bit
				iin = iin + 1
				xind = xind + 1

				for i = 1 ,2, 1 do
					rls = rls..offset(string.sub(line, iin, iin), x[1], -1)
					iin = iin + 1
					rls = rls..offset(string.sub(line, iin, iin), x[1], -1)
					iin = iin + 1
					iin = iin + tonumber(rls)
					rls = ""
									
					x[xind] = offset(string.sub(line, iin, iin), x[1], -1)
					iin = iin + 1
					xind = xind + 1
				end

				for i = 1, tonumber(x[2]..x[3]) + 87, 1 do
					rls = rls..offset(string.sub(line, iin, iin), x[1], -1)
					iin = iin + 1
					rls = rls..offset(string.sub(line, iin, iin), x[1], -1)
					iin = iin + 1
					iin = iin + tonumber(rls)
					rls = ""
					
					x[xind] = offset(string.sub(line, iin, iin), x[1], -1)
					iin = iin + 1
					xind = xind + 1
				end

				xind = 4

				x2[x2ind] = ""
				for i = 1, tonumber(x[2]..x[3]), 1 do
					x2[x2ind] = x2[x2ind]..x[xind] --the id
					xind = xind + 1
				end
				x2ind = x2ind + 1

				x2[x2ind] = ""				
				for i = 1, 7, 1 do
					x2[x2ind] = x2[x2ind]..x[xind] --parbit
					xind = xind + 1
				end
				x2ind = x2ind + 1

				x2[x2ind] = ""				
				for i = 1, 2, 1 do
					x2[x2ind] = x2[x2ind]..x[xind]
					xind = xind + 1
				end
				x2ind = x2ind + 1

				x2[x2ind] = ""				
				for i = 1, 6, 1 do
					x2[x2ind] = x2[x2ind]..x[xind]
					xind = xind + 1
				end
				x2ind = x2ind + 1

				x2[x2ind] = ""				
				for i = 1, 7, 1 do
					x2[x2ind] = x2[x2ind]..x[xind]
					xind = xind + 1
				end
				x2ind = x2ind + 1

				
				for h = 1, 6 , 1 do
					x2[x2ind] = ""
					for i = 1, 3, 1 do
						x2[x2ind] = x2[x2ind]..x[xind]
						xind = xind + 1
					end
					x2ind = x2ind + 1
				end

				for h = 1, 28, 1 do
					x2[x2ind] = ""
					x2[x2ind] = x2[x2ind]..x[xind]
					xind = xind + 1
					x2ind = x2ind + 1
				end

				for h = 1, 6 , 1 do
					x2[x2ind] = ""
					for i = 1, 2, 1 do
						x2[x2ind] = x2[x2ind]..x[xind]
						xind = xind + 1
					end
					x2ind = x2ind + 1
				end

				for h = 1, 7, 1 do
					x2[x2ind] = ""
					x2[x2ind] = x2[x2ind]..x[xind]
					xind = xind + 1
					x2ind = x2ind + 1
				end

				
			end
				
			if (x2[1] == capid() and tonumber(x2[2]) == tonumber(x2[3]) + tonumber(x2[4]) + tonumber(x2[6]) + tonumber(x2[7]) + tonumber(x2[8]) + tonumber(x2[9]) + tonumber(x2[11])) then
				
				v.levelReached = tonumber(x2[3])
				v.playerCash = tonumber(x2[4])
				v.sumCash = tonumber(x2[5])
				
				knifeAmmo = tonumber(x2[6])
				tomahawkAmmo = tonumber(x2[7])
				crossbowAmmo = tonumber(x2[8])
				pistolAmmo = tonumber(x2[9])
				rifleAmmo = tonumber(x2[10])
				granadeAmmo = tonumber(x2[11])

				g.arrow1.isPurchased = tonumber(x2[12])
				g.arrow2.isPurchased = tonumber(x2[13])
				g.arrow3.isPurchased = tonumber(x2[14])
				g.arrowGold.isPurchased = tonumber(x2[15])
				g.knife1Left.isPurchased = tonumber(x2[16])
				g.knife2Left.isPurchased = tonumber(x2[17])
				g.knife3Left.isPurchased = tonumber(x2[18])
				g.knifeGoldLeft.isPurchased = tonumber(x2[19])
				g.tomahawk1Left.isPurchased = tonumber(x2[20])
				g.tomahawk2Left.isPurchased = tonumber(x2[21])
				g.tomahawk3Left.isPurchased = tonumber(x2[22])
				g.tomahawkGoldLeft.isPurchased = tonumber(x2[23])
				g.pistol1Left.isPurchased = tonumber(x2[24])
				g.pistol2Left.isPurchased = tonumber(x2[25])
				g.pistol3Left.isPurchased = tonumber(x2[26])
				g.pistolGoldLeft.isPurchased = tonumber(x2[27])
				g.rifle1Left.isPurchased = tonumber(x2[28])
				g.rifle2Left.isPurchased = tonumber(x2[29])
				g.rifle3Left.isPurchased = tonumber(x2[30])
				g.rifleGoldLeft.isPurchased = tonumber(x2[31])
				g.battleAxe1.isPurchased = tonumber(x2[32])
				g.mace1.isPurchased = tonumber(x2[33])
				g.machete1.isPurchased = tonumber(x2[34])
				g.macheteGold.isPurchased = tonumber(x2[35])
				g.granade1.isPurchased = tonumber(x2[36])
				g.granadeGold.isPurchased = tonumber(x2[37])
				g.myGuyShield.isPurchased = tonumber(x2[38])
				g.myGuyShieldGold.isPurchased = tonumber(x2[39])
				
				h.cHead1 = tonumber(x2[40])
				h.cHead2 = tonumber(x2[41])
				h.cTorso1 = tonumber(x2[42])
				h.cTorso2 = tonumber(x2[43])
				h.cArms = tonumber(x2[44])
				h.cLegs = tonumber(x2[45])
				
				h.cBroadway = tonumber(x2[46])
				h.cVegas = tonumber(x2[47])
								
				b.enOrSp = tonumber(x2[48])
				f63 = tonumber(x2[49])
				v.everPlayed = tonumber(x2[50])
				v.soundOn = tonumber(x2[51])
				v.musicOn = tonumber(x2[52])
					
			end		
			
			io.close(saveFile)
			saveFile = nil		
		end
	elseif (p == "save") then

		local saveFile = io.open(path, "w+")
		if (saveFile ~= nil) then
			
			y[1] = math.random(0, 9) --offset
			y[2] = offset(string.sub(fill(string.len(capid()), 2), 1, 1), y[1], 1) --len of id
			y[3] = offset(string.sub(fill(string.len(capid()), 2), 2, 2), y[1], 1) --len of id
			
			jn = 4
			for i = 1, string.len(capid()), 1 do
				y[jn] = offset(string.sub(capid(), i, i), y[1], 1) --the id
				jn = jn + 1
			end
			
			for i = 1, 7, 1 do
				y[jn] = offset(string.sub(fill(v.levelReached + v.playerCash + knifeAmmo + tomahawkAmmo + crossbowAmmo + pistolAmmo + granadeAmmo, 7), i, i), y[1], 1) --parbit
				jn = jn + 1
			end
			
			for i = 1, 2, 1 do
				y[jn] = offset(string.sub(fill(v.levelReached, 2), i, i), y[1], 1)
				jn = jn + 1
			end

			for i = 1, 6, 1 do
				y[jn] = offset(string.sub(fill(v.playerCash, 6), i, i), y[1], 1)
				jn = jn + 1
			end

			for i = 1, 7, 1 do
				y[jn] = offset(string.sub(fill(v.sumCash, 7), i, i), y[1], 1)
				jn = jn + 1
			end
			
			for i = 1, 3, 1 do
				y[jn] = offset(string.sub(fill(knifeAmmo, 3), i, i), y[1], 1)
				jn = jn + 1
			end

			for i = 1, 3, 1 do
				y[jn] = offset(string.sub(fill(tomahawkAmmo, 3), i, i), y[1], 1)
				jn = jn + 1
			end

			for i = 1, 3, 1 do
				y[jn] = offset(string.sub(fill(crossbowAmmo, 3), i, i), y[1], 1)
				jn = jn + 1
			end

			for i = 1, 3, 1 do
				y[jn] = offset(string.sub(fill(pistolAmmo, 3), i, i), y[1], 1)
				jn = jn + 1
			end

			for i = 1, 3, 1 do
				y[jn] = offset(string.sub(fill(rifleAmmo, 3), i, i), y[1], 1)
				jn = jn + 1
			end

			for i = 1, 3, 1 do
				y[jn] = offset(string.sub(fill(granadeAmmo, 3), i, i), y[1], 1)
				jn = jn + 1
			end

			y[jn] = offset(g.arrow1.isPurchased, y[1], 1)
			jn = jn + 1
			y[jn] = offset(g.arrow2.isPurchased, y[1], 1)
			jn = jn + 1
			y[jn] = offset(g.arrow3.isPurchased, y[1], 1)
			jn = jn + 1
			y[jn] = offset(g.arrowGold.isPurchased, y[1], 1)
			jn = jn + 1
			y[jn] = offset(g.knife1Left.isPurchased, y[1], 1)
			jn = jn + 1
			y[jn] = offset(g.knife2Left.isPurchased, y[1], 1)
			jn = jn + 1
			y[jn] = offset(g.knife3Left.isPurchased, y[1], 1)
			jn = jn + 1
			y[jn] = offset(g.knifeGoldLeft.isPurchased, y[1], 1)
			jn = jn + 1
			y[jn] = offset(g.tomahawk1Left.isPurchased, y[1], 1)
			jn = jn + 1
			y[jn] = offset(g.tomahawk2Left.isPurchased, y[1], 1)
			jn = jn + 1
			y[jn] = offset(g.tomahawk3Left.isPurchased, y[1], 1)
			jn = jn + 1
			y[jn] = offset(g.tomahawkGoldLeft.isPurchased, y[1], 1)
			jn = jn + 1
			y[jn] = offset(g.pistol1Left.isPurchased, y[1], 1)
			jn = jn + 1
			y[jn] = offset(g.pistol2Left.isPurchased, y[1], 1)
			jn = jn + 1
			y[jn] = offset(g.pistol3Left.isPurchased, y[1], 1)
			jn = jn + 1
			y[jn] = offset(g.pistolGoldLeft.isPurchased, y[1], 1)
			jn = jn + 1
			y[jn] = offset(g.rifle1Left.isPurchased, y[1], 1)
			jn = jn + 1
			y[jn] = offset(g.rifle2Left.isPurchased, y[1], 1)
			jn = jn + 1
			y[jn] = offset(g.rifle3Left.isPurchased, y[1], 1)
			jn = jn + 1
			y[jn] = offset(g.rifleGoldLeft.isPurchased, y[1], 1)
			jn = jn + 1
			y[jn] = offset(g.battleAxe1.isPurchased, y[1], 1)
			jn = jn + 1
			y[jn] = offset(g.mace1.isPurchased, y[1], 1)
			jn = jn + 1
			y[jn] = offset(g.machete1.isPurchased, y[1], 1)
			jn = jn + 1
			y[jn] = offset(g.macheteGold.isPurchased, y[1], 1)
			jn = jn + 1
			y[jn] = offset(g.granade1.isPurchased, y[1], 1)
			jn = jn + 1
			y[jn] = offset(g.granadeGold.isPurchased, y[1], 1)
			jn = jn + 1
			y[jn] = offset(g.myGuyShield.isPurchased, y[1], 1)
			jn = jn + 1
			y[jn] = offset(g.myGuyShieldGold.isPurchased, y[1], 1)
			jn = jn + 1

			for i = 1, 2, 1 do
				y[jn] = offset(string.sub(fill(h.cHead1, 2), i, i), y[1], 1)
				jn = jn + 1
			end
			for i = 1, 2, 1 do
				y[jn] = offset(string.sub(fill(h.cHead2, 2), i, i), y[1], 1)
				jn = jn + 1
			end
			for i = 1, 2, 1 do
				y[jn] = offset(string.sub(fill(h.cTorso1, 2), i, i), y[1], 1)
				jn = jn + 1
			end
			for i = 1, 2, 1 do
				y[jn] = offset(string.sub(fill(h.cTorso2, 2), i, i), y[1], 1)
				jn = jn + 1
			end
			for i = 1, 2, 1 do
				y[jn] = offset(string.sub(fill(h.cArms, 2), i, i), y[1], 1)
				jn = jn + 1
			end
			for i = 1, 2, 1 do
				y[jn] = offset(string.sub(fill(h.cLegs, 2), i, i), y[1], 1)
				jn = jn + 1
			end
			
			y[jn] = offset(h.cBroadway, y[1], 1)
			jn = jn + 1
			y[jn] = offset(h.cVegas, y[1], 1)
			jn = jn + 1

			
			y[jn] = offset(b.enOrSp, y[1], 1)
			jn = jn + 1
			y[jn] = offset(f63, y[1], 1)
			jn = jn + 1
			y[jn] = offset(v.everPlayed, y[1], 1)
			jn = jn + 1
			y[jn] = offset(v.soundOn, y[1], 1)
			jn = jn + 1
			y[jn] = offset(v.musicOn, y[1], 1)
			jn = jn + 1


			
			stw = stw..randNums(20)
			for i = 1, table.maxn(y), 1 do
				stw = stw..y[i]
				rs = math.random(10, 19)
				--rs = 1
				stw = stw..offset(string.sub(tostring(rs), 1, 1), y[1], 1)
				stw = stw..offset(string.sub(tostring(rs), 2, 2), y[1], 1)
				stw = stw..randNums(rs)
			end
			stw = stw..randNums(20)
			
			saveFile:write(stw)
		
			io.close(saveFile)
			saveFile = nil
		end	
	end
	
end 


saveFileHandling("load")



v.levelReached = 29

--v.everPlayed = 2

--v.musicOn = 0


function putOutTreesTentsEtc()

	
	weaponsWallDisplayGroup.x = treesTentsEtc[28][2]

	for i = 1, table.getn(treesTentsEtc), 1 do
		
		if (treesTentsEtc[i][2] >= -530 and treesTentsEtc[i][2] <= 655) then
			
			if (treesTentsEtc[i][1] == "Tree 1") then
				tree1.x = treesTentsEtc[i][2]
			elseif (treesTentsEtc[i][1] == "Tree 2") then
				tree2.x = treesTentsEtc[i][2]
			elseif (treesTentsEtc[i][1] == "Tent 1") then
				tent1.x = treesTentsEtc[i][2]
			elseif (treesTentsEtc[i][1] == "Tent 2") then
				tent2.x = treesTentsEtc[i][2]
			elseif (treesTentsEtc[i][1] == "Fire 1") then
				fireWood1.x = treesTentsEtc[i][2]
				flame1.x = fireWood1.x + 3
				flame2.x = flame1.x
				flame3.x = flame1.x
				flame4.x = flame1.x
				flame5.x = flame1.x
				flame6.x = flame1.x
			elseif (treesTentsEtc[i][1] == "Chest 1") then
				chest1.x = treesTentsEtc[i][2]
			elseif (treesTentsEtc[i][1] == "Barrel 1") then
				barrel1.x = treesTentsEtc[i][2]
				barrel2.x = treesTentsEtc[i][2]
			--elseif (treesTentsEtc[i][1] == "Weapons Wall") then
				--weaponsWallDisplayGroup.x = treesTentsEtc[i][2]
			end
			
		end
		
	end


end


function otherGuyMoveSide(p)

		-- MOVING INTO TENT, SO WORLD IS MOVING
	if (p == 1) then
		m1.myGuy.x = m1.myGuy.x - 2.25 * f63
		m2.myGuy.x = m2.myGuy.x - 2.25 * f63
		m3.myGuy.x = m3.myGuy.x - 2.25 * f63
	elseif (p == -1) then
		m1.myGuy.x = m1.myGuy.x + 2.25 * f63
		m2.myGuy.x = m2.myGuy.x + 2.25 * f63
		m3.myGuy.x = m3.myGuy.x + 2.25 * f63
	end


end


function moveSide(p)

	local buttonLeft = leftButtonDown
	local buttonRight = rightButtonDown
	
	if (m1.metMyGuy == 1 or m2.metMyGuy == 1 or m3.metMyGuy == 1) then
		if(buttonLeft == 1) then
			myGuy.xScale = -1
			buttonLeft = 0
		end
	end
	
	if (m1.metMyGuy == -1 or m2.metMyGuy == -1 or m3.metMyGuy == -1) then
		if(buttonRight == 1) then
			myGuy.xScale = 1
			buttonRight = 0
		end
	end
	
	
	if(p ~= nil) then
		if(p == 1) then
			buttonRight = 1
			buttonLeft = 0
			otherGuyMoveSide(p)
		else
			buttonLeft = 1
			buttonRight = 0
			otherGuyMoveSide(p)
		end	
	end

	-- GOING RIGHT
	
	if(buttonRight == 1) then
		
		myGuy.xScale = 1
		
		worldCounter = worldCounter + 2.25 * f63
				
		--MOVING
		
		if (worldCounter >= 0) then

				
			-- TREES, TENTS, ETC
		
			for i = 1, table.getn(treesTentsEtc), 1 do
				treesTentsEtc[i][2] = treesTentsEtc[i][2] - 2.25 * f63 -- 22.5
			end
		
			putOutTreesTentsEtc()
			
			-- COINS
			
			smallCoin1.x = smallCoin1.x - 2.25 * f63
			smallCoin2.x = smallCoin2.x - 2.25 * f63
			smallCoin3.x = smallCoin3.x - 2.25 * f63
		
			-- ROAD
			if (road1 ~= nil) then

				roadCounter = roadCounter + 2.25 * f63
				
				if (roadCounter >= 570) then
					road1.x = road1.x + 570
					road2.x = road2.x + 570
					road3.x = road3.x + 570
					roadCounter = 0
				end
			
				road1.x = road1.x - 2.25 * f63
				road2.x = road2.x - 2.25 * f63
				road3.x = road3.x - 2.25 * f63
			end
		
			-- GRASS
		
			grassCounter = grassCounter + 4.5 * f63
			if (grassCounter >= 570) then
				grass1.x = grass1.x + 570
				grass2.x = grass2.x + 570
				grass3.x = grass3.x + 570
				grassCounter = 0
			end
		
			grass1.x = grass1.x - 4.5 * f63
			grass2.x = grass2.x - 4.5 * f63
			grass3.x = grass3.x - 4.5 * f63
		
		
		else
			myGuy.x = myGuy.x + 2.25 * f63
		end
		
		
	end
	
	
	-- GOING LEFT
	
	if(buttonLeft == 1) then

		myGuy.xScale = -1
		
		
		--IF NO MORE LEFT
		
		if(worldCounter >= 0) then
			worldCounter = worldCounter - 2.25 * f63
		
			-- TREES, TENTS, ETC
		
			for i = 1, table.getn(treesTentsEtc), 1 do
				treesTentsEtc[i][2] = treesTentsEtc[i][2] + 2.25 * f63
			end
		
			putOutTreesTentsEtc()
				
			-- COINS
			
			smallCoin1.x = smallCoin1.x + 2.25 * f63
			smallCoin2.x = smallCoin2.x + 2.25 * f63
			smallCoin3.x = smallCoin3.x + 2.25 * f63

			-- ROAD

			if (road1 ~= nil) then
			
				roadCounter = roadCounter - 2.25 * f63
				
				if (roadCounter <= -570) then
					road1.x = road1.x - 570
					road2.x = road2.x - 570
					road3.x = road3.x - 570

					roadCounter = 0
				end
			
				road1.x = road1.x + 2.25 * f63
				road2.x = road2.x + 2.25 * f63
				road3.x = road3.x + 2.25 * f63
			
			end
			-- GRASS
		
			grassCounter = grassCounter - 4.5 * f63
			if (grassCounter <= -570) then
				grass1.x = grass1.x - 570
				grass2.x = grass2.x - 570
				grass3.x = grass3.x - 570
				grassCounter = 0
			end
		
			grass1.x = grass1.x + 4.5 * f63
			grass2.x = grass2.x + 4.5 * f63
			grass3.x = grass3.x + 4.5 * f63
				
		
		else
			if(worldCounter > -180) then
				myGuy.x = myGuy.x - 2.25 * f63
				worldCounter = worldCounter - 2.25 * f63
			end
		
		end
		

	end

end  


function moveBody(what, xp, yp, rp)

	if (what == "head") then
		
		if (xp ~= 0) then
			h.head11.x = h.head11.x + xp
			h.head12.x = h.head12.x + xp
			h.head21.x = h.head21.x + xp
			h.head22.x = h.head22.x + xp
			h.head3.x = h.head3.x + xp
			if (h.cVegas == 1) then
				h.head4.x = h.head4.x + xp
				h.head5.x = h.head5.x + xp
				h.head6.x = h.head6.x + xp
			end
		end

		if (yp ~= 0) then			
			h.head11.y = h.head11.y + yp
			h.head12.y = h.head12.y + yp
			h.head21.y = h.head21.y + yp
			h.head22.y = h.head22.y + yp
			h.head3.y = h.head3.y + yp
			if (h.cVegas == 1) then
				h.head4.y = h.head4.y + yp
				h.head5.y = h.head5.y + yp
				h.head6.y = h.head6.y + yp
			end
		end

		if (rp ~= 0) then		
			h.head11.rotation = h.head11.rotation + rp
			h.head12.rotation = h.head12.rotation + rp
			h.head21.rotation = h.head21.rotation + rp
			h.head22.rotation = h.head22.rotation + rp
			h.head3.rotation = h.head3.rotation + rp
			if (h.cVegas == 1) then
				h.head4.rotation = h.head4.rotation + rp
				h.head5.rotation = h.head5.rotation + rp
				h.head6.rotation = h.head6.rotation + rp
			end
		end
	
	elseif (what == "leftLeg") then
		h.leftLeg1.rotation = h.leftLeg1.rotation + rp
		h.leftLeg2.rotation = h.leftLeg2.rotation + rp
		h.leftLeg3.rotation = h.leftLeg3.rotation + rp
	elseif (what == "rightLeg") then
		h.rightLeg1.rotation = h.rightLeg1.rotation + rp
		h.rightLeg2.rotation = h.rightLeg2.rotation + rp
		h.rightLeg3.rotation = h.rightLeg3.rotation + rp
	end
	
end


function moveColorBody(what, xp, yp, rp)

	if (what == "head") then
		
		if (xp ~= 0) then
			b.head1.x = b.head1.x + xp
			b.head2.x = b.head2.x + xp
			b.head3.x = b.head3.x + xp
			b.head4.x = b.head4.x + xp
			b.head5.x = b.head5.x + xp
			b.head6.x = b.head6.x + xp
			b.head7.x = b.head7.x + xp
			b.head8.x = b.head8.x + xp
			b.head9.x = b.head9.x + xp
			b.head10.x = b.head10.x + xp
			b.head11.x = b.head11.x + xp
			b.head12.x = b.head12.x + xp
			b.head13.x = b.head13.x + xp
			b.head14.x = b.head14.x + xp
			b.head15.x = b.head15.x + xp
			
		end

		if (yp ~= 0) then			
			b.head1.y = b.head1.y + yp
			b.head2.y = b.head2.y + yp
			b.head3.y = b.head3.y + yp
			b.head4.y = b.head4.y + yp
			b.head5.y = b.head5.y + yp
			b.head6.y = b.head6.y + yp
			b.head7.y = b.head7.y + yp
			b.head8.y = b.head8.y + yp
			b.head9.y = b.head9.y + yp
			b.head10.y = b.head10.y + yp
			b.head11.y = b.head11.y + yp
			b.head12.y = b.head12.y + yp
			b.head13.y = b.head13.y + yp
			b.head14.y = b.head14.y + yp
			b.head15.y = b.head15.y + yp
			
		end

		if (rp ~= 0) then		
			b.head1.rotation = b.head1.rotation + rp
			b.head2.rotation = b.head2.rotation + rp
			b.head3.rotation = b.head3.rotation + rp
			b.head4.rotation = b.head4.rotation + rp
			b.head5.rotation = b.head5.rotation + rp
			b.head6.rotation = b.head6.rotation + rp
			b.head7.rotation = b.head7.rotation + rp
			b.head8.rotation = b.head8.rotation + rp
			b.head9.rotation = b.head9.rotation + rp
			b.head10.rotation = b.head10.rotation + rp
			b.head11.rotation = b.head11.rotation + rp
			b.head12.rotation = b.head12.rotation + rp
			b.head13.rotation = b.head13.rotation + rp
			b.head14.rotation = b.head14.rotation + rp
			b.head15.rotation = b.head15.rotation + rp
		end
	end
end


function breathe()

	if(breatheCounter == 1) then
		breatheCounter = breatheCounter + 1

	elseif(breatheCounter == 2) then
		breatheCounter = breatheCounter + 1

		leftArmGroup.rotation = leftArmGroup.rotation + .3

		torsoGroup.y = torsoGroup.y - .0
		torsoGroup.rotation = torsoGroup.rotation - .5

		rightArmGroup.rotation = rightArmGroup.rotation + .8

		moveBody("head", .1, .07, .1)
		
		--head.y = head.y + .07
		--head.x = head.x + .1
		--head.rotation = head.rotation + .1

	elseif(breatheCounter == 3) then
		breatheCounter = breatheCounter + 1		
		
	elseif(breatheCounter == 4) then
		breatheCounter = breatheCounter + 1		

		leftArmGroup.rotation = leftArmGroup.rotation + .0

		torsoGroup.y = torsoGroup.y - .0
		torsoGroup.rotation = torsoGroup.rotation - .5
		
		rightArmGroup.rotation = rightArmGroup.rotation + .4

		moveBody("head", .1, .07, .1)
		
		--head.y = head.y + .07
		--head.x = head.x + .1
		--head.rotation = head.rotation + .1


-- at the very top starting to go down from here

	elseif(breatheCounter == 5) then
		breatheCounter = breatheCounter + 1		

	elseif(breatheCounter == 6) then
		breatheCounter = breatheCounter + 1		

		leftArmGroup.rotation = leftArmGroup.rotation - .0

		torsoGroup.y = torsoGroup.y - .0
		torsoGroup.rotation = torsoGroup.rotation - .5

		rightArmGroup.rotation = rightArmGroup.rotation - .4

		moveBody("head", .07, .03, 0)
		
		--head.y = head.y + .03
		--head.x = head.x + .07
		--head.rotation = head.rotation - .0

	elseif(breatheCounter == 7) then
		breatheCounter = breatheCounter + 1		
		
	elseif(breatheCounter == 8) then
		breatheCounter = breatheCounter + 1		

		leftArmGroup.rotation = leftArmGroup.rotation - .3

		torsoGroup.y = torsoGroup.y + .5
		torsoGroup.rotation = torsoGroup.rotation + .0

		rightArmGroup.rotation = rightArmGroup.rotation - .8

		moveBody("head", 0, -.1, -.1)
		
		--head.y = head.y - .1
		--head.x = head.x - .0
		--head.rotation = head.rotation - .1

	elseif(breatheCounter == 9) then
		breatheCounter = breatheCounter + 1		
		
	elseif(breatheCounter == 10) then
		breatheCounter = breatheCounter + 1		

		leftArmGroup.rotation = leftArmGroup.rotation - .7

		torsoGroup.y = torsoGroup.y + .5
		torsoGroup.rotation = torsoGroup.rotation + .0

		rightArmGroup.rotation = rightArmGroup.rotation - 1.2

		moveBody("head", 0, -.13, -.1)
		
		--head.y = head.y - .13
		--head.x = head.x - .0
		--head.rotation = head.rotation - .1

	elseif(breatheCounter == 11) then
		breatheCounter = breatheCounter + 1		
		
	elseif(breatheCounter == 12) then
		breatheCounter = breatheCounter + 1		

		leftArmGroup.rotation = leftArmGroup.rotation - 1.5

		torsoGroup.y = torsoGroup.y + .4
		torsoGroup.rotation = torsoGroup.rotation + .0

		rightArmGroup.rotation = rightArmGroup.rotation - 2.0

		moveBody("head", 0, -.13, -.1)
		
		--head.y = head.y - .13
		--head.x = head.x - .0
		--head.rotation = head.rotation - .1


-- halway position on the way down in speed

	elseif(breatheCounter == 13) then
		breatheCounter = breatheCounter + 1

	elseif(breatheCounter == 14) then
		breatheCounter = breatheCounter + 1

		leftArmGroup.rotation = leftArmGroup.rotation - 1.5

		torsoGroup.y = torsoGroup.y + .3
		torsoGroup.rotation = torsoGroup.rotation + .6

		rightArmGroup.rotation = rightArmGroup.rotation - 2.0

		moveBody("head", -.1, -.1, -.1)
		
		--head.y = head.y - .1
		--head.x = head.x - .1
		--head.rotation = head.rotation - .1

	elseif(breatheCounter == 15) then
		breatheCounter = breatheCounter + 1

	elseif(breatheCounter == 16) then
		breatheCounter = breatheCounter + 1

		leftArmGroup.rotation = leftArmGroup.rotation - .7

		torsoGroup.y = torsoGroup.y + .3

		torsoGroup.rotation = torsoGroup.rotation + .6

		rightArmGroup.rotation = rightArmGroup.rotation - 1.2

		moveBody("head", -.1, -.1, -.1)
		
		--head.y = head.y - .1
		--head.x = head.x - .1
		--head.rotation = head.rotation - .1

	elseif(breatheCounter == 17) then
		breatheCounter = breatheCounter + 1

	elseif(breatheCounter == 18) then
		breatheCounter = breatheCounter + 1

		leftArmGroup.rotation = leftArmGroup.rotation - .3

		torsoGroup.y = torsoGroup.y + .0
		torsoGroup.rotation = torsoGroup.rotation + .6

		rightArmGroup.rotation = rightArmGroup.rotation - .8

		moveBody("head", -.1, -.07, -.1)
		
		--head.y = head.y - .07
		--head.x = head.x - .1
		--head.rotation = head.rotation - .1

	elseif(breatheCounter == 19) then
		breatheCounter = breatheCounter + 1

	elseif(breatheCounter == 20) then
		breatheCounter = breatheCounter + 1

		leftArmGroup.rotation = leftArmGroup.rotation - .0

		torsoGroup.y = torsoGroup.y + .0

		torsoGroup.rotation = torsoGroup.rotation + .6

		rightArmGroup.rotation = rightArmGroup.rotation - .4

		moveBody("head", -.1, -.1, -.03)
		
		--head.y = head.y - .1
		--head.x = head.x - .1
		--head.rotation = head.rotation - .03

--11 rock buttom here starting to going up

	elseif(breatheCounter == 21) then
		breatheCounter = breatheCounter + 1

	elseif(breatheCounter == 22) then
		breatheCounter = breatheCounter + 1

		leftArmGroup.rotation = leftArmGroup.rotation + .0

		torsoGroup.y = torsoGroup.y + .0
		torsoGroup.rotation = torsoGroup.rotation + .6

		rightArmGroup.rotation = rightArmGroup.rotation + .4

		moveBody("head", -.03, -.07, -.07)
		
		--head.y = head.y - .07
		--head.x = head.x - .03
		--head.rotation = head.rotation - .07

	elseif(breatheCounter == 23) then
		breatheCounter = breatheCounter + 1

	elseif(breatheCounter == 24) then
		breatheCounter = breatheCounter + 1

		leftArmGroup.rotation = leftArmGroup.rotation + .3

		torsoGroup.y = torsoGroup.y - .5
		torsoGroup.rotation = torsoGroup.rotation - .0

		rightArmGroup.rotation = rightArmGroup.rotation + .8

		moveBody("head", -.04, .13, .1)
		
		--head.y = head.y + .13
		--head.x = head.x - .04
		--head.rotation = head.rotation + .1

	elseif(breatheCounter == 25) then
		breatheCounter = breatheCounter + 1

	elseif(breatheCounter == 26) then
		breatheCounter = breatheCounter + 1

		leftArmGroup.rotation = leftArmGroup.rotation + .7

		torsoGroup.y = torsoGroup.y - .5
		torsoGroup.rotation = torsoGroup.rotation - .0

		rightArmGroup.rotation = rightArmGroup.rotation + 1.2

		moveBody("head", 0, .13, .1)
		
		--head.y = head.y + .13
		--head.x = head.x + .0
		--head.rotation = head.rotation + .1

	elseif(breatheCounter == 27) then
		breatheCounter = breatheCounter + 1

	elseif(breatheCounter == 28) then
		breatheCounter = breatheCounter + 1

		leftArmGroup.rotation = leftArmGroup.rotation + 1.5

		torsoGroup.y = torsoGroup.y - .5
		torsoGroup.rotation = torsoGroup.rotation - .5

		rightArmGroup.rotation = rightArmGroup.rotation + 2.0

		moveBody("head", 0, .1, .1)
		
		--head.y = head.y + .1
		--head.x = head.x + .0
		--head.rotation = head.rotation + .1

-- halfway from going up here

	elseif(breatheCounter == 29) then
		breatheCounter = breatheCounter + 1		

	elseif(breatheCounter == 30) then
		breatheCounter = breatheCounter + 1		

		leftArmGroup.rotation = leftArmGroup.rotation + 1.5

		torsoGroup.y = torsoGroup.y - .5
		torsoGroup.rotation = torsoGroup.rotation - .5

		rightArmGroup.rotation = rightArmGroup.rotation + 2.0

		moveBody("head", .1, .2, .1)
		
		--head.y = head.y + .2
		--head.x = head.x + .1
		--head.rotation = head.rotation + .1

	elseif(breatheCounter == 31) then
		breatheCounter = breatheCounter + 1		

	elseif(breatheCounter == 32) then
		breatheCounter = 1

		leftArmGroup.rotation = leftArmGroup.rotation + .7

		torsoGroup.y = torsoGroup.y - .0
		torsoGroup.rotation = torsoGroup.rotation - .5

		rightArmGroup.rotation = rightArmGroup.rotation + 1.2

		moveBody("head", .1, .07, .1)
		
		--head.y = head.y + .07
		--head.x = head.x + .1
		--head.rotation = head.rotation + .1

	end


end 


function otherGuyBreathe(p)

	if(p.breatheCounter == 1) then
		p.breatheCounter = p.breatheCounter + 1

	elseif(p.breatheCounter == 2) then
		p.breatheCounter = p.breatheCounter + 1

		p.leftArmGroup.rotation = p.leftArmGroup.rotation + .3

		p.torsoGroup.y = p.torsoGroup.y - .0
		p.torsoGroup.rotation = p.torsoGroup.rotation - .5

		p.rightArmGroup.rotation = p.rightArmGroup.rotation + .8

		p.head.y = p.head.y + .07
		p.head.x = p.head.x + .1
		p.head.rotation = p.head.rotation + .1

	elseif(p.breatheCounter == 3) then
		p.breatheCounter = p.breatheCounter + 1		

	elseif(p.breatheCounter == 4) then
		p.breatheCounter = p.breatheCounter + 1		

		p.leftArmGroup.rotation = p.leftArmGroup.rotation + .0

		p.torsoGroup.y = p.torsoGroup.y - .0
		p.torsoGroup.rotation = p.torsoGroup.rotation - .5
		
		p.rightArmGroup.rotation = p.rightArmGroup.rotation + .4

		p.head.y = p.head.y + .07
		p.head.x = p.head.x + .1
		p.head.rotation = p.head.rotation + .1


-- at the very top starting to go down from here

	elseif(p.breatheCounter == 5) then
		p.breatheCounter = p.breatheCounter + 1		

	elseif(p.breatheCounter == 6) then
		p.breatheCounter = p.breatheCounter + 1		

		p.leftArmGroup.rotation = p.leftArmGroup.rotation - .0

		p.torsoGroup.y = p.torsoGroup.y - .0
		p.torsoGroup.rotation = p.torsoGroup.rotation - .5

		p.rightArmGroup.rotation = p.rightArmGroup.rotation - .4

		p.head.y = p.head.y + .03
		p.head.x = p.head.x + .07
		p.head.rotation = p.head.rotation - .0

	elseif(p.breatheCounter == 7) then
		p.breatheCounter = p.breatheCounter + 1		

	elseif(p.breatheCounter == 8) then
		p.breatheCounter = p.breatheCounter + 1		

		p.leftArmGroup.rotation = p.leftArmGroup.rotation - .3

		p.torsoGroup.y = p.torsoGroup.y + .5
		p.torsoGroup.rotation = p.torsoGroup.rotation + .0

		p.rightArmGroup.rotation = p.rightArmGroup.rotation - .8

		p.head.y = p.head.y - .1
		p.head.x = p.head.x - .0
		p.head.rotation = p.head.rotation - .1

	elseif(p.breatheCounter == 9) then
		p.breatheCounter = p.breatheCounter + 1		

	elseif(p.breatheCounter == 10) then
		p.breatheCounter = p.breatheCounter + 1		

		p.leftArmGroup.rotation = p.leftArmGroup.rotation - .7

		p.torsoGroup.y = p.torsoGroup.y + .5
		p.torsoGroup.rotation = p.torsoGroup.rotation + .0

		p.rightArmGroup.rotation = p.rightArmGroup.rotation - 1.2

		p.head.y = p.head.y - .13
		p.head.x = p.head.x - .0
		p.head.rotation = p.head.rotation - .1

	elseif(p.breatheCounter == 11) then
		p.breatheCounter = p.breatheCounter + 1		

	elseif(p.breatheCounter == 12) then
		p.breatheCounter = p.breatheCounter + 1		

		p.leftArmGroup.rotation = p.leftArmGroup.rotation - 1.5

		p.torsoGroup.y = p.torsoGroup.y + .4
		p.torsoGroup.rotation = p.torsoGroup.rotation + .0

		p.rightArmGroup.rotation = p.rightArmGroup.rotation - 2.0

		p.head.y = p.head.y - .13
		p.head.x = p.head.x - .0
		p.head.rotation = p.head.rotation - .1


-- halway position on the way down in speed

	elseif(p.breatheCounter == 13) then
		p.breatheCounter = p.breatheCounter + 1		

	elseif(p.breatheCounter == 14) then
		p.breatheCounter = p.breatheCounter + 1

		p.leftArmGroup.rotation = p.leftArmGroup.rotation - 1.5

		p.torsoGroup.y = p.torsoGroup.y + .3
		p.torsoGroup.rotation = p.torsoGroup.rotation + .6

		p.rightArmGroup.rotation = p.rightArmGroup.rotation - 2.0

		p.head.y = p.head.y - .1
		p.head.x = p.head.x - .1
		p.head.rotation = p.head.rotation - .1

	elseif(p.breatheCounter == 15) then
		p.breatheCounter = p.breatheCounter + 1		

	elseif(p.breatheCounter == 16) then
		p.breatheCounter = p.breatheCounter + 1

		p.leftArmGroup.rotation = p.leftArmGroup.rotation - .7

		p.torsoGroup.y = p.torsoGroup.y + .3

		p.torsoGroup.rotation = p.torsoGroup.rotation + .6

		p.rightArmGroup.rotation = p.rightArmGroup.rotation - 1.2

		p.head.y = p.head.y - .1
		p.head.x = p.head.x - .1
		p.head.rotation = p.head.rotation - .1

	elseif(p.breatheCounter == 17) then
		p.breatheCounter = p.breatheCounter + 1		

	elseif(p.breatheCounter == 18) then
		p.breatheCounter = p.breatheCounter + 1

		p.leftArmGroup.rotation = p.leftArmGroup.rotation - .3

		p.torsoGroup.y = p.torsoGroup.y + .0
		p.torsoGroup.rotation = p.torsoGroup.rotation + .6

		p.rightArmGroup.rotation = p.rightArmGroup.rotation - .8

		p.head.y = p.head.y - .07
		p.head.x = p.head.x - .1
		p.head.rotation = p.head.rotation - .1

	elseif(p.breatheCounter == 19) then
		p.breatheCounter = p.breatheCounter + 1		

	elseif(p.breatheCounter == 20) then
		p.breatheCounter = p.breatheCounter + 1

		p.leftArmGroup.rotation = p.leftArmGroup.rotation - .0

		p.torsoGroup.y = p.torsoGroup.y + .0

		p.torsoGroup.rotation = p.torsoGroup.rotation + .6

		p.rightArmGroup.rotation = p.rightArmGroup.rotation - .4

		p.head.y = p.head.y - .1
		p.head.x = p.head.x - .1
		p.head.rotation = p.head.rotation - .03

--11 rock buttom here starting to going up

	elseif(p.breatheCounter == 21) then
		p.breatheCounter = p.breatheCounter + 1		

	elseif(p.breatheCounter == 22) then
		p.breatheCounter = p.breatheCounter + 1

		p.leftArmGroup.rotation = p.leftArmGroup.rotation + .0

		p.torsoGroup.y = p.torsoGroup.y + .0
		p.torsoGroup.rotation = p.torsoGroup.rotation + .6

		p.rightArmGroup.rotation = p.rightArmGroup.rotation + .4

		p.head.y = p.head.y - .07
		p.head.x = p.head.x - .03
		p.head.rotation = p.head.rotation - .07

	elseif(p.breatheCounter == 23) then
		p.breatheCounter = p.breatheCounter + 1		

	elseif(p.breatheCounter == 24) then
		p.breatheCounter = p.breatheCounter + 1

		p.leftArmGroup.rotation = p.leftArmGroup.rotation + .3

		p.torsoGroup.y = p.torsoGroup.y - .5
		p.torsoGroup.rotation = p.torsoGroup.rotation - .0

		p.rightArmGroup.rotation = p.rightArmGroup.rotation + .8

		p.head.y = p.head.y + .13
		p.head.x = p.head.x - .04
		p.head.rotation = p.head.rotation + .1

	elseif(p.breatheCounter == 25) then
		p.breatheCounter = p.breatheCounter + 1		

	elseif(p.breatheCounter == 26) then
		p.breatheCounter = p.breatheCounter + 1

		p.leftArmGroup.rotation = p.leftArmGroup.rotation + .7

		p.torsoGroup.y = p.torsoGroup.y - .5
		p.torsoGroup.rotation = p.torsoGroup.rotation - .0

		p.rightArmGroup.rotation = p.rightArmGroup.rotation + 1.2

		p.head.y = p.head.y + .13
		p.head.x = p.head.x + .0
		p.head.rotation = p.head.rotation + .1

	elseif(p.breatheCounter == 27) then
		p.breatheCounter = p.breatheCounter + 1		

	elseif(p.breatheCounter == 28) then
		p.breatheCounter = p.breatheCounter + 1

		p.leftArmGroup.rotation = p.leftArmGroup.rotation + 1.5

		p.torsoGroup.y = p.torsoGroup.y - .5
		p.torsoGroup.rotation = p.torsoGroup.rotation - .5

		p.rightArmGroup.rotation = p.rightArmGroup.rotation + 2.0

		p.head.y = p.head.y + .1
		p.head.x = p.head.x + .0
		p.head.rotation = p.head.rotation + .1

-- halfway from going up here

	elseif(p.breatheCounter == 29) then
		p.breatheCounter = p.breatheCounter + 1		

	elseif(p.breatheCounter == 30) then
		p.breatheCounter = p.breatheCounter + 1		

		p.leftArmGroup.rotation = p.leftArmGroup.rotation + 1.5

		p.torsoGroup.y = p.torsoGroup.y - .5
		p.torsoGroup.rotation = p.torsoGroup.rotation - .5

		p.rightArmGroup.rotation = p.rightArmGroup.rotation + 2.0

		p.head.y = p.head.y + .2
		p.head.x = p.head.x + .1
		p.head.rotation = p.head.rotation + .1

	elseif(p.breatheCounter == 31) then
		p.breatheCounter = p.breatheCounter + 1		

	elseif(p.breatheCounter == 32) then
		p.breatheCounter = 1

		p.leftArmGroup.rotation = p.leftArmGroup.rotation + .7

		p.torsoGroup.y = p.torsoGroup.y - .0
		p.torsoGroup.rotation = p.torsoGroup.rotation - .5

		p.rightArmGroup.rotation = p.rightArmGroup.rotation + 1.2

		p.head.y = p.head.y + .07
		p.head.x = p.head.x + .1
		p.head.rotation = p.head.rotation + .1

	end


end


function colorGuybreathe()

	if(b.breatheCounter == 1) then
		b.breatheCounter = b.breatheCounter + 1

	elseif(b.breatheCounter == 2) then
		b.breatheCounter = b.breatheCounter + 1

		b.leftArmGroup.rotation = b.leftArmGroup.rotation + .3

		b.torsoGroup.y = b.torsoGroup.y - .0
		b.torsoGroup.rotation = b.torsoGroup.rotation - .5

		b.rightArmGroup.rotation = b.rightArmGroup.rotation + .8

		moveColorBody("head", .1, .07, .1)
		
	elseif(b.breatheCounter == 3) then
		b.breatheCounter = b.breatheCounter + 1		
		
	elseif(b.breatheCounter == 4) then
		b.breatheCounter = b.breatheCounter + 1		

		b.leftArmGroup.rotation = b.leftArmGroup.rotation + .0

		b.torsoGroup.y = b.torsoGroup.y - .0
		b.torsoGroup.rotation = b.torsoGroup.rotation - .5
		
		b.rightArmGroup.rotation = b.rightArmGroup.rotation + .4

		moveColorBody("head", .1, .07, .1)
		

-- at the very top starting to go down from here

	elseif(b.breatheCounter == 5) then
		b.breatheCounter = b.breatheCounter + 1		

	elseif(b.breatheCounter == 6) then
		b.breatheCounter = b.breatheCounter + 1		

		b.leftArmGroup.rotation = b.leftArmGroup.rotation - .0

		b.torsoGroup.y = b.torsoGroup.y - .0
		b.torsoGroup.rotation = b.torsoGroup.rotation - .5

		b.rightArmGroup.rotation = b.rightArmGroup.rotation - .4

		moveColorBody("head", .07, .03, 0)
		
	elseif(b.breatheCounter == 7) then
		b.breatheCounter = b.breatheCounter + 1		
		
	elseif(b.breatheCounter == 8) then
		b.breatheCounter = b.breatheCounter + 1		

		b.leftArmGroup.rotation = b.leftArmGroup.rotation - .3

		b.torsoGroup.y = b.torsoGroup.y + .5
		b.torsoGroup.rotation = b.torsoGroup.rotation + .0

		b.rightArmGroup.rotation = b.rightArmGroup.rotation - .8

		moveColorBody("head", 0, -.1, -.1)
		
	elseif(b.breatheCounter == 9) then
		b.breatheCounter = b.breatheCounter + 1		
		
	elseif(b.breatheCounter == 10) then
		b.breatheCounter = b.breatheCounter + 1		

		b.leftArmGroup.rotation = b.leftArmGroup.rotation - .7

		b.torsoGroup.y = b.torsoGroup.y + .5
		b.torsoGroup.rotation = b.torsoGroup.rotation + .0

		b.rightArmGroup.rotation = b.rightArmGroup.rotation - 1.2

		moveColorBody("head", 0, -.13, -.1)
		
	elseif(b.breatheCounter == 11) then
		b.breatheCounter = b.breatheCounter + 1		
		
	elseif(b.breatheCounter == 12) then
		b.breatheCounter = b.breatheCounter + 1		

		b.leftArmGroup.rotation = b.leftArmGroup.rotation - 1.5

		b.torsoGroup.y = b.torsoGroup.y + .4
		b.torsoGroup.rotation = b.torsoGroup.rotation + .0

		b.rightArmGroup.rotation = b.rightArmGroup.rotation - 2.0

		moveColorBody("head", 0, -.13, -.1)
		

-- halway position on the way down in speed

	elseif(b.breatheCounter == 13) then
		b.breatheCounter = b.breatheCounter + 1

	elseif(b.breatheCounter == 14) then
		b.breatheCounter = b.breatheCounter + 1

		b.leftArmGroup.rotation = b.leftArmGroup.rotation - 1.5

		b.torsoGroup.y = b.torsoGroup.y + .3
		b.torsoGroup.rotation = b.torsoGroup.rotation + .6

		b.rightArmGroup.rotation = b.rightArmGroup.rotation - 2.0

		moveColorBody("head", -.1, -.1, -.1)
		
	elseif(b.breatheCounter == 15) then
		b.breatheCounter = b.breatheCounter + 1

	elseif(b.breatheCounter == 16) then
		b.breatheCounter = b.breatheCounter + 1

		b.leftArmGroup.rotation = b.leftArmGroup.rotation - .7

		b.torsoGroup.y = b.torsoGroup.y + .3

		b.torsoGroup.rotation = b.torsoGroup.rotation + .6

		b.rightArmGroup.rotation = b.rightArmGroup.rotation - 1.2

		moveColorBody("head", -.1, -.1, -.1)
		
	elseif(b.breatheCounter == 17) then
		b.breatheCounter = b.breatheCounter + 1

	elseif(b.breatheCounter == 18) then
		b.breatheCounter = b.breatheCounter + 1

		b.leftArmGroup.rotation = b.leftArmGroup.rotation - .3

		b.torsoGroup.y = b.torsoGroup.y + .0
		b.torsoGroup.rotation = b.torsoGroup.rotation + .6

		b.rightArmGroup.rotation = b.rightArmGroup.rotation - .8

		moveColorBody("head", -.1, -.07, -.1)
		
	elseif(b.breatheCounter == 19) then
		b.breatheCounter = b.breatheCounter + 1

	elseif(b.breatheCounter == 20) then
		b.breatheCounter = b.breatheCounter + 1

		b.leftArmGroup.rotation = b.leftArmGroup.rotation - .0

		b.torsoGroup.y = b.torsoGroup.y + .0

		b.torsoGroup.rotation = b.torsoGroup.rotation + .6

		b.rightArmGroup.rotation = b.rightArmGroup.rotation - .4

		moveColorBody("head", -.1, -.1, -.03)
		
--11 rock buttom here starting to going up

	elseif(b.breatheCounter == 21) then
		b.breatheCounter = b.breatheCounter + 1

	elseif(b.breatheCounter == 22) then
		b.breatheCounter = b.breatheCounter + 1

		b.leftArmGroup.rotation = b.leftArmGroup.rotation + .0

		b.torsoGroup.y = b.torsoGroup.y + .0
		b.torsoGroup.rotation = b.torsoGroup.rotation + .6

		b.rightArmGroup.rotation = b.rightArmGroup.rotation + .4

		moveColorBody("head", -.03, -.07, -.07)

	elseif(b.breatheCounter == 23) then
		b.breatheCounter = b.breatheCounter + 1

	elseif(b.breatheCounter == 24) then
		b.breatheCounter = b.breatheCounter + 1

		b.leftArmGroup.rotation = b.leftArmGroup.rotation + .3

		b.torsoGroup.y = b.torsoGroup.y - .5
		b.torsoGroup.rotation = b.torsoGroup.rotation - .0

		b.rightArmGroup.rotation = b.rightArmGroup.rotation + .8

		moveColorBody("head", -.04, .13, .1)
		
	elseif(b.breatheCounter == 25) then
		b.breatheCounter = b.breatheCounter + 1

	elseif(b.breatheCounter == 26) then
		b.breatheCounter = b.breatheCounter + 1

		b.leftArmGroup.rotation = b.leftArmGroup.rotation + .7

		b.torsoGroup.y = b.torsoGroup.y - .5
		b.torsoGroup.rotation = b.torsoGroup.rotation - .0

		b.rightArmGroup.rotation = b.rightArmGroup.rotation + 1.2

		moveColorBody("head", 0, .13, .1)
		
	elseif(b.breatheCounter == 27) then
		b.breatheCounter = b.breatheCounter + 1

	elseif(b.breatheCounter == 28) then
		b.breatheCounter = b.breatheCounter + 1

		b.leftArmGroup.rotation = b.leftArmGroup.rotation + 1.5

		b.torsoGroup.y = b.torsoGroup.y - .5
		b.torsoGroup.rotation = b.torsoGroup.rotation - .5

		b.rightArmGroup.rotation = b.rightArmGroup.rotation + 2.0

		moveColorBody("head", 0, .1, .1)
		
-- halfway from going up here

	elseif(b.breatheCounter == 29) then
		b.breatheCounter = b.breatheCounter + 1		

	elseif(b.breatheCounter == 30) then
		b.breatheCounter = b.breatheCounter + 1		

		b.leftArmGroup.rotation = b.leftArmGroup.rotation + 1.5

		b.torsoGroup.y = b.torsoGroup.y - .5
		b.torsoGroup.rotation = b.torsoGroup.rotation - .5

		b.rightArmGroup.rotation = b.rightArmGroup.rotation + 2.0

		moveColorBody("head", .1, .2, .1)
		
	elseif(b.breatheCounter == 31) then
		b.breatheCounter = b.breatheCounter + 1		

	elseif(b.breatheCounter == 32) then
		b.breatheCounter = 1

		b.leftArmGroup.rotation = b.leftArmGroup.rotation + .7

		b.torsoGroup.y = b.torsoGroup.y - .0
		b.torsoGroup.rotation = b.torsoGroup.rotation - .5

		b.rightArmGroup.rotation = b.rightArmGroup.rotation + 1.2

		moveColorBody("head", .1, .07, .1)
		

	end


end 


function walk()

-- 1st quarter
		
	if(walkCounter == 1) then
		walkCounter = walkCounter + 1
		
		moveBody("leftLeg", 0, 0, 12)
		moveBody("rightLeg", 0, 0, -12)
		
		--leftLeg.rotation = leftLeg.rotation + 12
		--rightLeg.rotation = rightLeg.rotation - 12
		
		leftArmGroup.rotation = leftArmGroup.rotation - .3
		rightArmGroup.rotation = rightArmGroup.rotation + .3
				
		torsoGroup.y = torsoGroup.y + .5
		torsoGroup.rotation = torsoGroup.rotation  + .5

		moveBody("head", 0, 0, .23)
		
		--head.y = head.y - .0
		--head.rotation = head.rotation + .23


	elseif(walkCounter == 2) then
		walkCounter = walkCounter + 1		

		moveBody("leftLeg", 0, 0, 12)
		moveBody("rightLeg", 0, 0, -12)

		--leftLeg.rotation = leftLeg.rotation + 12
		--rightLeg.rotation = rightLeg.rotation - 12

		leftArmGroup.rotation = leftArmGroup.rotation - .3
		rightArmGroup.rotation = rightArmGroup.rotation + .3

		torsoGroup.y = torsoGroup.y + .5
		torsoGroup.rotation = torsoGroup.rotation  + .5

		moveBody("head", 0, .17, .23)
		
		--head.y = head.y + .17
		--head.rotation = head.rotation + .23


	elseif(walkCounter == 3) then
		walkCounter = walkCounter + 1		

		moveBody("leftLeg", 0, 0, 12)
		moveBody("rightLeg", 0, 0, -12)

		--leftLeg.rotation = leftLeg.rotation + 12
		--rightLeg.rotation = rightLeg.rotation - 12

		leftArmGroup.rotation = leftArmGroup.rotation - .3
		rightArmGroup.rotation = rightArmGroup.rotation + .3

		torsoGroup.y = torsoGroup.y + .5
		torsoGroup.rotation = torsoGroup.rotation + .5

		moveBody("head", 0, .17, .23)
		
		--head.y = head.y + .17
		--head.rotation = head.rotation + .23


	elseif(walkCounter == 4) then
		walkCounter = walkCounter + 1		

		moveBody("leftLeg", 0, 0, 12)
		moveBody("rightLeg", 0, 0, -12)

		--leftLeg.rotation = leftLeg.rotation + 12
		--rightLeg.rotation = rightLeg.rotation - 12

		leftArmGroup.rotation = leftArmGroup.rotation - .3
		rightArmGroup.rotation = rightArmGroup.rotation + .3

		torsoGroup.y = torsoGroup.y + .5
		torsoGroup.rotation = torsoGroup.rotation + .5

		moveBody("head", 0, .17, .23)
		
		--head.y = head.y + .17
		--head.rotation = head.rotation + .23


-- 2nd quarter


	elseif(walkCounter == 5) then
		walkCounter = walkCounter + 1		

		moveBody("leftLeg", 0, 0, -12)
		moveBody("rightLeg", 0, 0, 12)
		
		--leftLeg.rotation = leftLeg.rotation - 12
		--rightLeg.rotation = rightLeg.rotation + 12

		leftArmGroup.rotation = leftArmGroup.rotation + .3
		rightArmGroup.rotation = rightArmGroup.rotation - .3

		torsoGroup.y = torsoGroup.y - .5
		torsoGroup.rotation = torsoGroup.rotation - .5

		moveBody("head", 0, 0, -.23)
		
		--head.y = head.y + .0
		--head.rotation = head.rotation - .23


	elseif(walkCounter == 6) then
		walkCounter = walkCounter + 1		

		moveBody("leftLeg", 0, 0, -12)
		moveBody("rightLeg", 0, 0, 12)
		
		--leftLeg.rotation = leftLeg.rotation - 12
		--rightLeg.rotation = rightLeg.rotation + 12

		leftArmGroup.rotation = leftArmGroup.rotation + .3
		rightArmGroup.rotation = rightArmGroup.rotation - .3

		torsoGroup.y = torsoGroup.y - .5
		torsoGroup.rotation = torsoGroup.rotation - .5

		moveBody("head", 0, -.17, -.23)
		
		--head.y = head.y - .17
		--head.rotation = head.rotation - .23


	elseif(walkCounter == 7) then
		walkCounter = walkCounter + 1

		moveBody("leftLeg", 0, 0, -12)
		moveBody("rightLeg", 0, 0, 12)
		
		--leftLeg.rotation = leftLeg.rotation - 12
		--rightLeg.rotation = rightLeg.rotation + 12

		leftArmGroup.rotation = leftArmGroup.rotation + .3
		rightArmGroup.rotation = rightArmGroup.rotation - .3

		torsoGroup.y = torsoGroup.y - .5
		torsoGroup.rotation = torsoGroup.rotation - .5

		moveBody("head", 0, -.17, -.23)
		
		--head.y = head.y - .17
		--head.rotation = head.rotation - .23


	elseif(walkCounter == 8) then
		walkCounter = walkCounter + 1

		moveBody("leftLeg", 0, 0, -12)
		moveBody("rightLeg", 0, 0, 12)
		
		--leftLeg.rotation = leftLeg.rotation - 12
		--rightLeg.rotation = rightLeg.rotation + 12

		leftArmGroup.rotation = leftArmGroup.rotation + .3
		rightArmGroup.rotation = rightArmGroup.rotation - .3

		torsoGroup.y = torsoGroup.y - .5
		torsoGroup.rotation = torsoGroup.rotation - .5

		moveBody("head", 0, -.17, -.23)
		
		--head.y = head.y - .17
		--head.rotation = head.rotation - .23


-- 3rd quarter

	elseif(walkCounter == 9) then
		walkCounter = walkCounter + 1

		moveBody("leftLeg", 0, 0, -10)
		moveBody("rightLeg", 0, 0, 10)
		
		--leftLeg.rotation = leftLeg.rotation - 10
		--rightLeg.rotation = rightLeg.rotation + 10

		leftArmGroup.rotation = leftArmGroup.rotation + .3
		rightArmGroup.rotation = rightArmGroup.rotation - .3

		torsoGroup.y = torsoGroup.y + .5
		torsoGroup.rotation = torsoGroup.rotation + .5

		moveBody("head", 0, 0, .23)
		
		--head.y = head.y - .0
		--head.rotation = head.rotation + .23


	elseif(walkCounter == 10) then
		walkCounter = walkCounter + 1

		moveBody("leftLeg", 0, 0, -10)
		moveBody("rightLeg", 0, 0, 10)
		
		--leftLeg.rotation = leftLeg.rotation - 10
		--rightLeg.rotation = rightLeg.rotation + 10

		leftArmGroup.rotation = leftArmGroup.rotation + .3
		rightArmGroup.rotation = rightArmGroup.rotation - .3

		torsoGroup.y = torsoGroup.y + .5
		torsoGroup.rotation = torsoGroup.rotation + .5

		moveBody("head", 0, .17, .23)
		
		--head.y = head.y + .17
		--head.rotation = head.rotation + .23


	elseif(walkCounter == 11) then
		walkCounter = walkCounter + 1

		moveBody("leftLeg", 0, 0, -10)
		moveBody("rightLeg", 0, 0, 10)
		
		--leftLeg.rotation = leftLeg.rotation - 10
		--rightLeg.rotation = rightLeg.rotation + 10

		leftArmGroup.rotation = leftArmGroup.rotation + .3
		rightArmGroup.rotation = rightArmGroup.rotation - .3

		torsoGroup.y = torsoGroup.y + .5
		torsoGroup.rotation = torsoGroup.rotation + .5

		moveBody("head", 0, .17, .23)
		
		--head.y = head.y + .17
		--head.rotation = head.rotation + .23


	elseif(walkCounter == 12) then
		walkCounter = walkCounter + 1

		moveBody("leftLeg", 0, 0, -10)
		moveBody("rightLeg", 0, 0, 10)
		
		--leftLeg.rotation = leftLeg.rotation - 10
		--rightLeg.rotation = rightLeg.rotation + 10

		leftArmGroup.rotation = leftArmGroup.rotation + .3
		rightArmGroup.rotation = rightArmGroup.rotation - .3

		torsoGroup.y = torsoGroup.y + .5
		torsoGroup.rotation = torsoGroup.rotation + .5

		moveBody("head", 0, .17, .23)
		
		--head.y = head.y + .17
		--head.rotation = head.rotation + .23


-- 4th quarter


	elseif(walkCounter == 13) then
		walkCounter = walkCounter + 1

		moveBody("leftLeg", 0, 0, 10)
		moveBody("rightLeg", 0, 0, -10)
		
		--leftLeg.rotation = leftLeg.rotation + 10
		--rightLeg.rotation = rightLeg.rotation - 10

		leftArmGroup.rotation = leftArmGroup.rotation - .3
		rightArmGroup.rotation = rightArmGroup.rotation + .3

		torsoGroup.y = torsoGroup.y - .5
		torsoGroup.rotation = torsoGroup.rotation - .5

		moveBody("head", 0, 0, -.23)
		
		--head.y = head.y + .0
		--head.rotation = head.rotation - .23


	elseif(walkCounter == 14) then
		walkCounter = walkCounter + 1

		moveBody("leftLeg", 0, 0, 10)
		moveBody("rightLeg", 0, 0, -10)
		
		--leftLeg.rotation = leftLeg.rotation + 10
		--rightLeg.rotation = rightLeg.rotation - 10

		leftArmGroup.rotation = leftArmGroup.rotation - .3
		rightArmGroup.rotation = rightArmGroup.rotation + .3

		torsoGroup.y = torsoGroup.y - .5
		torsoGroup.rotation = torsoGroup.rotation - .5

		moveBody("head", 0, -.17, -.23)
		
		--head.y = head.y - .17
		--head.rotation = head.rotation - .23


	elseif(walkCounter == 15) then
		walkCounter = walkCounter + 1

		moveBody("leftLeg", 0, 0, 10)
		moveBody("rightLeg", 0, 0, -10)
		
		--leftLeg.rotation = leftLeg.rotation + 10
		--rightLeg.rotation = rightLeg.rotation - 10

		leftArmGroup.rotation = leftArmGroup.rotation - .3
		rightArmGroup.rotation = rightArmGroup.rotation + .3

		torsoGroup.y = torsoGroup.y - .5
		torsoGroup.rotation = torsoGroup.rotation - .5

		moveBody("head", 0, -.17, -.23)
		
		--head.y = head.y - .17
		--head.rotation = head.rotation - .23


	elseif(walkCounter == 16) then
		walkCounter = 1

		moveBody("leftLeg", 0, 0, 10)
		moveBody("rightLeg", 0, 0, -10)
		
		--leftLeg.rotation = leftLeg.rotation + 10
		--rightLeg.rotation = rightLeg.rotation - 10

		leftArmGroup.rotation = leftArmGroup.rotation - .3
		rightArmGroup.rotation = rightArmGroup.rotation + .3

		torsoGroup.y = torsoGroup.y - .5
		torsoGroup.rotation = torsoGroup.rotation - .5

		moveBody("head", 0, -.17, -.23)
		
		--head.y = head.y - .17
		--head.rotation = head.rotation - .23

	end

	
end


function otherGuyWalk(p)

-- 1st quarter
		
	if(p.walkCounter == 1) then
		p.walkCounter = p.walkCounter + 1

		p.leftLeg.rotation = p.leftLeg.rotation + 12
		p.rightLeg.rotation = p.rightLeg.rotation - 12
		
		p.leftArmGroup.rotation = p.leftArmGroup.rotation - .3
		p.rightArmGroup.rotation = p.rightArmGroup.rotation + .3
				
		p.torsoGroup.y = p.torsoGroup.y + .5
		p.torsoGroup.rotation = p.torsoGroup.rotation  + .5

		p.head.y = p.head.y - .0
		p.head.rotation = p.head.rotation + .23


	elseif(p.walkCounter == 2) then
		p.walkCounter = p.walkCounter + 1		

		p.leftLeg.rotation = p.leftLeg.rotation + 12
		p.rightLeg.rotation = p.rightLeg.rotation - 12

		p.leftArmGroup.rotation = p.leftArmGroup.rotation - .3
		p.rightArmGroup.rotation = p.rightArmGroup.rotation + .3

		p.torsoGroup.y = p.torsoGroup.y + .5
		p.torsoGroup.rotation = p.torsoGroup.rotation  + .5

		p.head.y = p.head.y + .17
		p.head.rotation = p.head.rotation + .23


	elseif(p.walkCounter == 3) then
		p.walkCounter = p.walkCounter + 1		

		p.leftLeg.rotation = p.leftLeg.rotation + 12
		p.rightLeg.rotation = p.rightLeg.rotation - 12

		p.leftArmGroup.rotation = p.leftArmGroup.rotation - .3
		p.rightArmGroup.rotation = p.rightArmGroup.rotation + .3

		p.torsoGroup.y = p.torsoGroup.y + .5
		p.torsoGroup.rotation = p.torsoGroup.rotation + .5

		p.head.y = p.head.y + .17
		p.head.rotation = p.head.rotation + .23


	elseif(p.walkCounter == 4) then
		p.walkCounter = p.walkCounter + 1		

		p.leftLeg.rotation = p.leftLeg.rotation + 12
		p.rightLeg.rotation = p.rightLeg.rotation - 12

		p.leftArmGroup.rotation = p.leftArmGroup.rotation - .3
		p.rightArmGroup.rotation = p.rightArmGroup.rotation + .3

		p.torsoGroup.y = p.torsoGroup.y + .5
		p.torsoGroup.rotation = p.torsoGroup.rotation + .5

		p.head.y = p.head.y + .17
		p.head.rotation = p.head.rotation + .23


-- 2nd quarter


	elseif(p.walkCounter == 5) then
		p.walkCounter = p.walkCounter + 1		

		p.leftLeg.rotation = p.leftLeg.rotation - 12
		p.rightLeg.rotation = p.rightLeg.rotation + 12

		p.leftArmGroup.rotation = p.leftArmGroup.rotation + .3
		p.rightArmGroup.rotation = p.rightArmGroup.rotation - .3

		p.torsoGroup.y = p.torsoGroup.y - .5
		p.torsoGroup.rotation = p.torsoGroup.rotation - .5

		p.head.y = p.head.y + .0
		p.head.rotation = p.head.rotation - .23


	elseif(p.walkCounter == 6) then
		p.walkCounter = p.walkCounter + 1		

		p.leftLeg.rotation = p.leftLeg.rotation - 12
		p.rightLeg.rotation = p.rightLeg.rotation + 12

		p.leftArmGroup.rotation = p.leftArmGroup.rotation + .3
		p.rightArmGroup.rotation = p.rightArmGroup.rotation - .3

		p.torsoGroup.y = p.torsoGroup.y - .5
		p.torsoGroup.rotation = p.torsoGroup.rotation - .5

		p.head.y = p.head.y - .17
		p.head.rotation = p.head.rotation - .23


	elseif(p.walkCounter == 7) then
		p.walkCounter = p.walkCounter + 1

		p.leftLeg.rotation = p.leftLeg.rotation - 12
		p.rightLeg.rotation = p.rightLeg.rotation + 12

		p.leftArmGroup.rotation = p.leftArmGroup.rotation + .3
		p.rightArmGroup.rotation = p.rightArmGroup.rotation - .3

		p.torsoGroup.y = p.torsoGroup.y - .5
		p.torsoGroup.rotation = p.torsoGroup.rotation - .5

		p.head.y = p.head.y - .17
		p.head.rotation = p.head.rotation - .23


	elseif(p.walkCounter == 8) then
		p.walkCounter = p.walkCounter + 1

		p.leftLeg.rotation = p.leftLeg.rotation - 12
		p.rightLeg.rotation = p.rightLeg.rotation + 12

		p.leftArmGroup.rotation = p.leftArmGroup.rotation + .3
		p.rightArmGroup.rotation = p.rightArmGroup.rotation - .3

		p.torsoGroup.y = p.torsoGroup.y - .5
		p.torsoGroup.rotation = p.torsoGroup.rotation - .5

		p.head.y = p.head.y - .17
		p.head.rotation = p.head.rotation - .23


-- 3rd quarter

	elseif(p.walkCounter == 9) then
		p.walkCounter = p.walkCounter + 1

		p.leftLeg.rotation = p.leftLeg.rotation - 10
		p.rightLeg.rotation = p.rightLeg.rotation + 10

		p.leftArmGroup.rotation = p.leftArmGroup.rotation + .3
		p.rightArmGroup.rotation = p.rightArmGroup.rotation - .3

		p.torsoGroup.y = p.torsoGroup.y + .5
		p.torsoGroup.rotation = p.torsoGroup.rotation + .5

		p.head.y = p.head.y - .0
		p.head.rotation = p.head.rotation + .23


	elseif(p.walkCounter == 10) then
		p.walkCounter = p.walkCounter + 1

		p.leftLeg.rotation = p.leftLeg.rotation - 10
		p.rightLeg.rotation = p.rightLeg.rotation + 10

		p.leftArmGroup.rotation = p.leftArmGroup.rotation + .3
		p.rightArmGroup.rotation = p.rightArmGroup.rotation - .3

		p.torsoGroup.y = p.torsoGroup.y + .5
		p.torsoGroup.rotation = p.torsoGroup.rotation + .5

		p.head.y = p.head.y + .17
		p.head.rotation = p.head.rotation + .23


	elseif(p.walkCounter == 11) then
		p.walkCounter = p.walkCounter + 1

		p.leftLeg.rotation = p.leftLeg.rotation - 10
		p.rightLeg.rotation = p.rightLeg.rotation + 10

		p.leftArmGroup.rotation = p.leftArmGroup.rotation + .3
		p.rightArmGroup.rotation = p.rightArmGroup.rotation - .3

		p.torsoGroup.y = p.torsoGroup.y + .5
		p.torsoGroup.rotation = p.torsoGroup.rotation + .5

		p.head.y = p.head.y + .17
		p.head.rotation = p.head.rotation + .23


	elseif(p.walkCounter == 12) then
		p.walkCounter = p.walkCounter + 1

		p.leftLeg.rotation = p.leftLeg.rotation - 10
		p.rightLeg.rotation = p.rightLeg.rotation + 10

		p.leftArmGroup.rotation = p.leftArmGroup.rotation + .3
		p.rightArmGroup.rotation = p.rightArmGroup.rotation - .3

		p.torsoGroup.y = p.torsoGroup.y + .5
		p.torsoGroup.rotation = p.torsoGroup.rotation + .5

		p.head.y = p.head.y + .17
		p.head.rotation = p.head.rotation + .23


-- 4th quarter


	elseif(p.walkCounter == 13) then
		p.walkCounter = p.walkCounter + 1

		p.leftLeg.rotation = p.leftLeg.rotation + 10
		p.rightLeg.rotation = p.rightLeg.rotation - 10

		p.leftArmGroup.rotation = p.leftArmGroup.rotation - .3
		p.rightArmGroup.rotation = p.rightArmGroup.rotation + .3

		p.torsoGroup.y = p.torsoGroup.y - .5
		p.torsoGroup.rotation = p.torsoGroup.rotation - .5

		p.head.y = p.head.y + .0
		p.head.rotation = p.head.rotation - .23


	elseif(p.walkCounter == 14) then
		p.walkCounter = p.walkCounter + 1

		p.leftLeg.rotation = p.leftLeg.rotation + 10
		p.rightLeg.rotation = p.rightLeg.rotation - 10

		p.leftArmGroup.rotation = p.leftArmGroup.rotation - .3
		p.rightArmGroup.rotation = p.rightArmGroup.rotation + .3

		p.torsoGroup.y = p.torsoGroup.y - .5
		p.torsoGroup.rotation = p.torsoGroup.rotation - .5

		p.head.y = p.head.y - .17
		p.head.rotation = p.head.rotation - .23


	elseif(p.walkCounter == 15) then
		p.walkCounter = p.walkCounter + 1

		p.leftLeg.rotation = p.leftLeg.rotation + 10
		p.rightLeg.rotation = p.rightLeg.rotation - 10

		p.leftArmGroup.rotation = p.leftArmGroup.rotation - .3
		p.rightArmGroup.rotation = p.rightArmGroup.rotation + .3

		p.torsoGroup.y = p.torsoGroup.y - .5
		p.torsoGroup.rotation = p.torsoGroup.rotation - .5

		p.head.y = p.head.y - .17
		p.head.rotation = p.head.rotation - .23


	elseif(p.walkCounter == 16) then
		p.walkCounter = 1

		p.leftLeg.rotation = p.leftLeg.rotation + 10
		p.rightLeg.rotation = p.rightLeg.rotation - 10

		p.leftArmGroup.rotation = p.leftArmGroup.rotation - .3
		p.rightArmGroup.rotation = p.rightArmGroup.rotation + .3

		p.torsoGroup.y = p.torsoGroup.y - .5
		p.torsoGroup.rotation = p.torsoGroup.rotation - .5

		p.head.y = p.head.y - .17
		p.head.rotation = p.head.rotation - .23


	end

end


function antiWalk()
	
	if (walkCounter == 2) then

		moveBody("leftLeg", 0, 0, -12)
		moveBody("rightLeg", 0, 0, 12)
		
		--leftLeg.rotation = leftLeg.rotation - 12
		--rightLeg.rotation = rightLeg.rotation + 12

		leftArmGroup.rotation = leftArmGroup.rotation + .3
		rightArmGroup.rotation = rightArmGroup.rotation - .3

		torsoGroup.y = torsoGroup.y - .5
		torsoGroup.rotation = torsoGroup.rotation  - .5

		moveBody("head", 0, 0, -.23)
		
		--head.y = head.y + .0
		--head.rotation = head.rotation - .23
	
		walkCounter = 1
		moveSide()
	elseif (walkCounter == 3) then

		moveBody("leftLeg", 0, 0, -12)
		moveBody("rightLeg", 0, 0, 12)
	
		--leftLeg.rotation = leftLeg.rotation - 12
		--rightLeg.rotation = rightLeg.rotation + 12

		leftArmGroup.rotation = leftArmGroup.rotation + .3
		rightArmGroup.rotation = rightArmGroup.rotation - .3

		torsoGroup.y = torsoGroup.y - .5
		torsoGroup.rotation = torsoGroup.rotation  - .5

		moveBody("head", 0, -.17, -.23)
		
		--head.y = head.y - .17
		--head.rotation = head.rotation - .23
		
		walkCounter = walkCounter - 1
		moveSide()
	elseif (walkCounter == 4) then
	
		moveBody("leftLeg", 0, 0, -12)
		moveBody("rightLeg", 0, 0, 12)
		
		--leftLeg.rotation = leftLeg.rotation - 12
		--rightLeg.rotation = rightLeg.rotation + 12

		leftArmGroup.rotation = leftArmGroup.rotation + .3
		rightArmGroup.rotation = rightArmGroup.rotation - .3

		torsoGroup.y = torsoGroup.y - .5
		torsoGroup.rotation = torsoGroup.rotation - .5

		moveBody("head", 0, -.17, -.23)
		
		--head.y = head.y - .17
		--head.rotation = head.rotation - .23
	
		walkCounter = walkCounter - 1
		moveSide()
	elseif (walkCounter == 5) then
	
		walk()
	elseif (walkCounter == 6) then
	
		walk()
	elseif (walkCounter == 7) then
	
		walk()
	elseif (walkCounter == 8) then
	
		walk()
	elseif (walkCounter == 9) then
		
		-- nothing here
	elseif (walkCounter == 10) then
	
		moveBody("leftLeg", 0, 0, 10)
		moveBody("rightLeg", 0, 0, -10)

		--leftLeg.rotation = leftLeg.rotation + 10
		--rightLeg.rotation = rightLeg.rotation - 10

		leftArmGroup.rotation = leftArmGroup.rotation - .3
		rightArmGroup.rotation = rightArmGroup.rotation + .3

		torsoGroup.y = torsoGroup.y - .5
		torsoGroup.rotation = torsoGroup.rotation - .5

		moveBody("head", 0, 0, -.23)
		
		--head.y = head.y + .0
		--head.rotation = head.rotation - .23

		walkCounter = walkCounter - 1	
		moveSide()
	elseif (walkCounter == 11) then
		
		moveBody("leftLeg", 0, 0, 10)
		moveBody("rightLeg", 0, 0, -10)
		
		--leftLeg.rotation = leftLeg.rotation + 10
		--rightLeg.rotation = rightLeg.rotation - 10

		leftArmGroup.rotation = leftArmGroup.rotation - .3
		rightArmGroup.rotation = rightArmGroup.rotation + .3

		torsoGroup.y = torsoGroup.y - .5
		torsoGroup.rotation = torsoGroup.rotation - .5

		moveBody("head", 0, -.17, -.23)
		
		--head.y = head.y - .17
		--head.rotation = head.rotation - .23

		walkCounter = walkCounter - 1		
		moveSide()
	elseif (walkCounter == 12) then
	
		moveBody("leftLeg", 0, 0, 10)
		moveBody("rightLeg", 0, 0, -10)
		
		--leftLeg.rotation = leftLeg.rotation + 10
		--rightLeg.rotation = rightLeg.rotation - 10

		leftArmGroup.rotation = leftArmGroup.rotation - .3
		rightArmGroup.rotation = rightArmGroup.rotation + .3

		torsoGroup.y = torsoGroup.y - .5
		torsoGroup.rotation = torsoGroup.rotation - .5

		moveBody("head", 0, -.17, -.23)
		
		--head.y = head.y - .17
		--head.rotation = head.rotation - .23
	
		walkCounter = walkCounter - 1		
		moveSide()
	elseif (walkCounter == 13) then

		walk()
	elseif (walkCounter == 14) then
	
		walk()
	elseif (walkCounter == 15) then

		walk()		
	elseif (walkCounter == 16) then
		
		walk()
	elseif (walkCounter == 1) then	
	
		-- nothing here
	end

end


function otherGuyAntiWalk(p)
	
	if (p.walkCounter == 2) then

		p.leftLeg.rotation = p.leftLeg.rotation - 12
		p.rightLeg.rotation = p.rightLeg.rotation + 12

		p.leftArmGroup.rotation = p.leftArmGroup.rotation + .3
		p.rightArmGroup.rotation = p.rightArmGroup.rotation - .3

		p.torsoGroup.y = p.torsoGroup.y - .5
		p.torsoGroup.rotation = p.torsoGroup.rotation  - .5

		p.head.y = p.head.y + .0
		p.head.rotation = p.head.rotation - .23
	
		p.walkCounter = 1
		
	elseif (p.walkCounter == 3) then

		p.leftLeg.rotation = p.leftLeg.rotation - 12
		p.rightLeg.rotation = p.rightLeg.rotation + 12

		p.leftArmGroup.rotation = p.leftArmGroup.rotation + .3
		p.rightArmGroup.rotation = p.rightArmGroup.rotation - .3

		p.torsoGroup.y = p.torsoGroup.y - .5
		p.torsoGroup.rotation = p.torsoGroup.rotation  - .5

		p.head.y = p.head.y - .17
		p.head.rotation = p.head.rotation - .23
		
		p.walkCounter = p.walkCounter - 1
		
	elseif (p.walkCounter == 4) then
	
		p.leftLeg.rotation = p.leftLeg.rotation - 12
		p.rightLeg.rotation = p.rightLeg.rotation + 12

		p.leftArmGroup.rotation = p.leftArmGroup.rotation + .3
		p.rightArmGroup.rotation = p.rightArmGroup.rotation - .3

		p.torsoGroup.y = p.torsoGroup.y - .5
		p.torsoGroup.rotation = p.torsoGroup.rotation - .5

		p.head.y = p.head.y - .17
		p.head.rotation = p.head.rotation - .23
	
		p.walkCounter = p.walkCounter - 1
		
	elseif (p.walkCounter == 5) then
	
		otherGuyWalk(p)
	elseif (p.walkCounter == 6) then
	
		otherGuyWalk(p)
	elseif (p.walkCounter == 7) then
	
		otherGuyWalk(p)
	elseif (p.walkCounter == 8) then
	
		otherGuyWalk(p)
	elseif (p.walkCounter == 9) then
		
		-- nothing here
	elseif (p.walkCounter == 10) then
	
		p.leftLeg.rotation = p.leftLeg.rotation + 10
		p.rightLeg.rotation = p.rightLeg.rotation - 10

		p.leftArmGroup.rotation = p.leftArmGroup.rotation - .3
		p.rightArmGroup.rotation = p.rightArmGroup.rotation + .3

		p.torsoGroup.y = p.torsoGroup.y - .5
		p.torsoGroup.rotation = p.torsoGroup.rotation - .5

		p.head.y = p.head.y + .0
		p.head.rotation = p.head.rotation - .23

		p.walkCounter = p.walkCounter - 1	
		
	elseif (p.walkCounter == 11) then

		p.leftLeg.rotation = p.leftLeg.rotation + 10
		p.rightLeg.rotation = p.rightLeg.rotation - 10

		p.leftArmGroup.rotation = p.leftArmGroup.rotation - .3
		p.rightArmGroup.rotation = p.rightArmGroup.rotation + .3

		p.torsoGroup.y = p.torsoGroup.y - .5
		p.torsoGroup.rotation = p.torsoGroup.rotation - .5

		p.head.y = p.head.y - .17
		p.head.rotation = p.head.rotation - .23

		p.walkCounter = p.walkCounter - 1		
		
	elseif (p.walkCounter == 12) then
	
		p.leftLeg.rotation = p.leftLeg.rotation + 10
		p.rightLeg.rotation = p.rightLeg.rotation - 10

		p.leftArmGroup.rotation = p.leftArmGroup.rotation - .3
		p.rightArmGroup.rotation = p.rightArmGroup.rotation + .3

		p.torsoGroup.y = p.torsoGroup.y - .5
		p.torsoGroup.rotation = p.torsoGroup.rotation - .5

		p.head.y = p.head.y - .17
		p.head.rotation = p.head.rotation - .23
	
		p.walkCounter = p.walkCounter - 1		
		
	elseif (p.walkCounter == 13) then

		otherGuyWalk(p)
	elseif (p.walkCounter == 14) then
	
		otherGuyWalk(p)
	elseif (p.walkCounter == 15) then

		otherGuyWalk(p)		
	elseif (p.walkCounter == 16) then
		
		otherGuyWalk(p)
	elseif (p.walkCounter == 1) then	
	
		-- nothing here
	end

end


function leanForward()

	if (leanForwardCounter == 7) then
		torsoGroup.rotation = torsoGroup.rotation + .3
		leanForwardCounter = 8
	end
	if (leanForwardCounter == 6) then
		torsoGroup.rotation = torsoGroup.rotation + .3
		leanForwardCounter = 7
	end
	if (leanForwardCounter == 5) then
		torsoGroup.rotation = torsoGroup.rotation + .3
		leanForwardCounter = 6
	end
	if (leanForwardCounter == 4) then
		torsoGroup.rotation = torsoGroup.rotation + .3
		leanForwardCounter = 5
	end
	if (leanForwardCounter == 3) then
		torsoGroup.rotation = torsoGroup.rotation + .3
		leanForwardCounter = 4
	end
	if (leanForwardCounter == 2) then
		torsoGroup.rotation = torsoGroup.rotation + .3
		leanForwardCounter = 3
	end
	if (leanForwardCounter == 1) then
		torsoGroup.rotation = torsoGroup.rotation + .3
		leanForwardCounter = 2
	end
	if (leanForwardCounter == 0) then
		torsoGroup.rotation = torsoGroup.rotation + .3
		leanForwardCounter = 1
	end

end


function antiLeanForward()

	if (leanForwardCounter == 1) then
		torsoGroup.rotation = torsoGroup.rotation - .3
		leanForwardCounter = 0
	end
	if (leanForwardCounter == 2) then
		torsoGroup.rotation = torsoGroup.rotation - .3
		leanForwardCounter = 1
	end
	if (leanForwardCounter == 3) then
		torsoGroup.rotation = torsoGroup.rotation - .3
		leanForwardCounter = 2
	end
	if (leanForwardCounter == 4) then
		torsoGroup.rotation = torsoGroup.rotation - .3
		leanForwardCounter = 3
	end
	if (leanForwardCounter == 5) then
		torsoGroup.rotation = torsoGroup.rotation - .3
		leanForwardCounter = 4
	end
	if (leanForwardCounter == 6) then
		torsoGroup.rotation = torsoGroup.rotation - .3
		leanForwardCounter = 5
	end
	if (leanForwardCounter == 7) then
		torsoGroup.rotation = torsoGroup.rotation - .3
		leanForwardCounter = 6
	end
	if (leanForwardCounter == 8) then
		torsoGroup.rotation = torsoGroup.rotation - .3
		leanForwardCounter = 7
	end

end


function updateHealthBar(p)
			
	if (g.myGuyShieldGold.isPurchased == 1) then
		healthBarBackground.x = 75
	else
		healthBarBackground.x = 48
	end
		
	healthBarTop1.x = v.playerHealth + 2
	
	if (v.playerHealth + 2 - 34 > -7) then
		healthBarTop2.x = v.playerHealth + 2 - 34
	else
		healthBarTop2.x = -7
	end

	if (v.playerHealth + 2 - 34 -34 > -7) then
		healthBarTop3.x = v.playerHealth + 2 - 34 - 34
	else
		healthBarTop3.x = -7
	end

	if (v.playerHealth + 2 - 34 - 34 - 34 > -7) then
		healthBarTop4.x = v.playerHealth + 2 - 34 - 34 - 34
	else
		healthBarTop4.x = -7
	end

	
	healthBarTop1Cover.x = healthBarTop1.x
	healthBarTop2Cover.x = healthBarTop2.x
	healthBarTop3Cover.x = healthBarTop3.x
	healthBarTop4Cover.x = healthBarTop4.x
	
	if (v.healthChanged == 1 or v.healthChanged == 3) then
		healthBarTop1Cover.isVisible = true
		healthBarTop2Cover.isVisible = true
		healthBarTop3Cover.isVisible = true
		healthBarTop4Cover.isVisible = true
	elseif (v.healthChanged == 2 or v.healthChanged == 4) then
		healthBarTop1Cover.isVisible = false
		healthBarTop2Cover.isVisible = false
		healthBarTop3Cover.isVisible = false
		healthBarTop4Cover.isVisible = false
	end
	
	v.healthChanged = v.healthChanged + 1
	
	if (v.healthChanged == 5) then
		v.healthChanged = 0
	end
	
	if (p == false) then
		healthBarTop1Cover.isVisible = false
		healthBarTop2Cover.isVisible = false
		healthBarTop3Cover.isVisible = false
		healthBarTop4Cover.isVisible = false
	end
	
end 


function writeScreenCash(p, q)

	if (q == nil) then
		if (v.soundOn == 1) then
			audio.play(a.coinsSound, 13)
		end
	end

	c.cashCoin.num = 8
	
	hideCashNumbers()
	
	local pString = tostring(p)
	local pChar = nil
	for i = 1, string.len(pString) do
		pChar = string.sub(pString, i, i)
		
		if (pChar == "1") then
			cashNumbers[1][i].isVisible = true
			cashNumbers[1][i].x = 14 * i
		elseif (pChar == "2") then
			cashNumbers[2][i].isVisible = true
			cashNumbers[2][i].x = 14 * i
		elseif (pChar == "3") then
			cashNumbers[3][i].isVisible = true
			cashNumbers[3][i].x = 14 * i
		elseif (pChar == "4") then
			cashNumbers[4][i].isVisible = true
			cashNumbers[4][i].x = 14 * i
		elseif (pChar == "5") then
			cashNumbers[5][i].isVisible = true
			cashNumbers[5][i].x = 14 * i
		elseif (pChar == "6") then
			cashNumbers[6][i].isVisible = true
			cashNumbers[6][i].x = 14 * i
		elseif (pChar == "7") then
			cashNumbers[7][i].isVisible = true
			cashNumbers[7][i].x = 14 * i
		elseif (pChar == "8") then
			cashNumbers[8][i].isVisible = true
			cashNumbers[8][i].x = 14 * i
		elseif (pChar == "9") then
			cashNumbers[9][i].isVisible = true
			cashNumbers[9][i].x = 14 * i
		elseif (pChar == "0") then
			cashNumbers[10][i].isVisible = true
			cashNumbers[10][i].x = 14 * i
		end
		
	end
	
	
end


function writeSumCash(p)

	hideSumNumbers()
	
	local pString = tostring(p)
	local pChar = nil
	for i = 1, string.len(pString) do
		pChar = string.sub(pString, i, i)
		
		if (pChar == "1") then
			sumNumbers[1][i].isVisible = true
			sumNumbers[1][i].x = 14 * i
		elseif (pChar == "2") then
			sumNumbers[2][i].isVisible = true
			sumNumbers[2][i].x = 14 * i
		elseif (pChar == "3") then
			sumNumbers[3][i].isVisible = true
			sumNumbers[3][i].x = 14 * i
		elseif (pChar == "4") then
			sumNumbers[4][i].isVisible = true
			sumNumbers[4][i].x = 14 * i
		elseif (pChar == "5") then
			sumNumbers[5][i].isVisible = true
			sumNumbers[5][i].x = 14 * i
		elseif (pChar == "6") then
			sumNumbers[6][i].isVisible = true
			sumNumbers[6][i].x = 14 * i
		elseif (pChar == "7") then
			sumNumbers[7][i].isVisible = true
			sumNumbers[7][i].x = 14 * i
		elseif (pChar == "8") then
			sumNumbers[8][i].isVisible = true
			sumNumbers[8][i].x = 14 * i
		elseif (pChar == "9") then
			sumNumbers[9][i].isVisible = true
			sumNumbers[9][i].x = 14 * i
		elseif (pChar == "0") then
			sumNumbers[10][i].isVisible = true
			sumNumbers[10][i].x = 14 * i
		end
		
	end
	
	
end


function writeScreenAmmo(p)

	if (p == nil) then
		ammoDisplayGroup.isVisible = false
	else
		ammoDisplayGroup.isVisible = true
		
		hideAmmoNumbers()
		
		ammoX.isVisible = true
		ammoX.x = 0
		ammoX.y = 13
				
		local pString = tostring(p)
		local pChar = nil
		for i = 1, string.len(pString) do
			pChar = string.sub(pString, i, i)
			
			if (pChar == "1") then
				ammoNumbers[1][i].isVisible = true
				ammoNumbers[1][i].x = 14 * i
			elseif (pChar == "2") then
				ammoNumbers[2][i].isVisible = true
				ammoNumbers[2][i].x = 14 * i
			elseif (pChar == "3") then
				ammoNumbers[3][i].isVisible = true
				ammoNumbers[3][i].x = 14 * i
			elseif (pChar == "4") then
				ammoNumbers[4][i].isVisible = true
				ammoNumbers[4][i].x = 14 * i
			elseif (pChar == "5") then
				ammoNumbers[5][i].isVisible = true
				ammoNumbers[5][i].x = 14 * i
			elseif (pChar == "6") then
				ammoNumbers[6][i].isVisible = true
				ammoNumbers[6][i].x = 14 * i
			elseif (pChar == "7") then
				ammoNumbers[7][i].isVisible = true
				ammoNumbers[7][i].x = 14 * i
			elseif (pChar == "8") then
				ammoNumbers[8][i].isVisible = true
				ammoNumbers[8][i].x = 14 * i
			elseif (pChar == "9") then
				ammoNumbers[9][i].isVisible = true
				ammoNumbers[9][i].x = 14 * i
			elseif (pChar == "0") then
				ammoNumbers[10][i].isVisible = true
				ammoNumbers[10][i].x = 14 * i
			end
			
		end
	end
	
	
	
end


function otherGuysSideing()

	if (m1.sideing == 5) then
		m1.myGuy.x = m1.myGuy.x - 25 * m1.myGuy.xScale
		m1.myGuy.y = m1.myGuy.y - 6
	elseif (m1.sideing == 4) then
		m1.myGuy.x = m1.myGuy.x - 25 * m1.myGuy.xScale
		m1.myGuy.y = m1.myGuy.y - 6	
	elseif (m1.sideing == 3) then
		m1.myGuy.x = m1.myGuy.x - 25 * m1.myGuy.xScale
	elseif (m1.sideing == 2) then
		m1.myGuy.x = m1.myGuy.x - 25 * m1.myGuy.xScale
		m1.myGuy.y = m1.myGuy.y + 6
	elseif (m1.sideing == 1) then
		m1.myGuy.x = m1.myGuy.x - 25 * m1.myGuy.xScale
		m1.myGuy.y = m1.myGuy.y + 6	
	end
	if (m1.sideing > 0) then
		m1.sideing = m1.sideing - 1
	end
	
	if (m2.sideing == 5) then
		m2.myGuy.x = m2.myGuy.x - 25 * m2.myGuy.xScale
		m2.myGuy.y = m2.myGuy.y - 6
	elseif (m2.sideing == 4) then
		m2.myGuy.x = m2.myGuy.x - 25 * m2.myGuy.xScale
		m2.myGuy.y = m2.myGuy.y - 6	
	elseif (m2.sideing == 3) then
		m2.myGuy.x = m2.myGuy.x - 25 * m2.myGuy.xScale
	elseif (m2.sideing == 2) then
		m2.myGuy.x = m2.myGuy.x - 25 * m2.myGuy.xScale
		m2.myGuy.y = m2.myGuy.y + 6
	elseif (m2.sideing == 1) then
		m2.myGuy.x = m2.myGuy.x - 25 * m2.myGuy.xScale
		m2.myGuy.y = m2.myGuy.y + 6	
	end
	if (m2.sideing > 0) then
		m2.sideing = m2.sideing - 1
	end
	
	if (m3.sideing == 5) then
		m3.myGuy.x = m3.myGuy.x - 25 * m3.myGuy.xScale
		m3.myGuy.y = m3.myGuy.y - 6
	elseif (m3.sideing == 4) then
		m3.myGuy.x = m3.myGuy.x - 25 * m3.myGuy.xScale
		m3.myGuy.y = m3.myGuy.y - 6	
	elseif (m3.sideing == 3) then
		m3.myGuy.x = m3.myGuy.x - 25 * m3.myGuy.xScale
	elseif (m3.sideing == 2) then
		m3.myGuy.x = m3.myGuy.x - 25 * m3.myGuy.xScale
		m3.myGuy.y = m3.myGuy.y + 6
	elseif (m3.sideing == 1) then
		m3.myGuy.x = m3.myGuy.x - 25 * m3.myGuy.xScale
		m3.myGuy.y = m3.myGuy.y + 6	
	end
	if (m3.sideing > 0) then
		m3.sideing = m3.sideing - 1
	end
	
	

end


function weaponMeetOtherGuy(p)

	if (p == "arrowStart") then

		if (m1.inShotRange == 1 and m1.playerHealth > 0 and (g.arrowDouble.x < m1.myGuy.x + 51 and g.arrowDouble.x > m1.myGuy.x - 51)) then
				if (g.arrowGold.isPurchased == 1) then
					m1.playerHurt = 110
				elseif (g.arrow3.isPurchased == 1) then
					m1.playerHurt = 70
				elseif (g.arrow2.isPurchased == 1) then
					m1.playerHurt = 60
				elseif (g.arrow1.isPurchased == 1) then
					m1.playerHurt = 55
				end
			m1.playerHealth = m1.playerHealth - m1.playerHurt
			m1.torsoGroup.rotation = m1.torsoGroup.rotation - 4
			m1.myGuy.x = m1.myGuy.x - 3 * m1.myGuy.xScale
			m1.splash01.isVisible = true
			g.arrowDouble.isVisible = false
			v.weaponMeetCounterOne = 3

			--if (v.soundOn == 1) then
				--audio.play(a.thud1, 14)
			--end
			
		elseif (m2.inShotRange == 1 and m2.playerHealth > 0 and (g.arrowDouble.x < m2.myGuy.x + 51 and g.arrowDouble.x > m2.myGuy.x - 51)) then
				if (g.arrowGold.isPurchased == 1) then
					m2.playerHurt = 110
				elseif (g.arrow3.isPurchased == 1) then
					m2.playerHurt = 70
				elseif (g.arrow2.isPurchased == 1) then
					m2.playerHurt = 60
				elseif (g.arrow1.isPurchased == 1) then
					m2.playerHurt = 55
				end
			m2.playerHealth = m2.playerHealth - m2.playerHurt
			m2.torsoGroup.rotation = m2.torsoGroup.rotation - 4
			m2.myGuy.x = m2.myGuy.x - 3 * m2.myGuy.xScale
			m2.splash01.isVisible = true
			g.arrowDouble.isVisible = false
			v.weaponMeetCounterOne = 3

			--if (v.soundOn == 1) then
				--audio.play(a.thud2, 15)
			--end

		elseif (m3.inShotRange == 1 and m3.playerHealth > 0 and (g.arrowDouble.x < m3.myGuy.x + 51 and g.arrowDouble.x > m3.myGuy.x - 51)) then
				if (g.arrowGold.isPurchased == 1) then
					m3.playerHurt = 110
				elseif (g.arrow3.isPurchased == 1) then
					m3.playerHurt = 70
				elseif (g.arrow2.isPurchased == 1) then
					m3.playerHurt = 60
				elseif (g.arrow1.isPurchased == 1) then
					m3.playerHurt = 55
				end
			m3.playerHealth = m3.playerHealth - m3.playerHurt
			m3.torsoGroup.rotation = m3.torsoGroup.rotation - 4
			m3.myGuy.x = m3.myGuy.x - 3 * m3.myGuy.xScale
			m3.splash01.isVisible = true
			g.arrowDouble.isVisible = false
			v.weaponMeetCounterOne = 3
		
			--if (v.soundOn == 1) then
				--audio.play(a.thud3, 16)
			--end

		elseif(m1.playerHealth > 0 and m1.myGuy.x >=  -40 - _XB and m1.myGuy.x <= 520 + _XB and (g.arrowDouble.x < m1.myGuy.x + 51 and g.arrowDouble.x > m1.myGuy.x - 51)) then
				if (g.arrowGold.isPurchased == 1) then
					m1.playerHurt = 110
				elseif (g.arrow3.isPurchased == 1) then
					m1.playerHurt = 70
				elseif (g.arrow2.isPurchased == 1) then
					m1.playerHurt = 60
				elseif (g.arrow1.isPurchased == 1) then
					m1.playerHurt = 55
				end
			m1.playerHealth = m1.playerHealth - m1.playerHurt
			m1.torsoGroup.rotation = m1.torsoGroup.rotation - 4
			m1.myGuy.x = m1.myGuy.x - 3 * m1.myGuy.xScale
			m1.splash01.isVisible = true
			g.arrowDouble.isVisible = false
			v.weaponMeetCounterOne = 3
			
			--if (v.soundOn == 1) then
				--audio.play(a.thud1, 14)
			--end
			
		elseif(m2.playerHealth > 0 and m2.myGuy.x >=  -40 - _XB and m2.myGuy.x <= 520 + _XB and (g.arrowDouble.x < m2.myGuy.x + 51 and g.arrowDouble.x > m2.myGuy.x - 51)) then
				if (g.arrowGold.isPurchased == 1) then
					m2.playerHurt = 110
				elseif (g.arrow3.isPurchased == 1) then
					m2.playerHurt = 70
				elseif (g.arrow2.isPurchased == 1) then
					m2.playerHurt = 60
				elseif (g.arrow1.isPurchased == 1) then
					m2.playerHurt = 55
				end
			m2.playerHealth = m2.playerHealth - m2.playerHurt
			m2.torsoGroup.rotation = m2.torsoGroup.rotation - 4
			m2.myGuy.x = m2.myGuy.x - 3 * m2.myGuy.xScale
			m2.splash01.isVisible = true
			g.arrowDouble.isVisible = false
			v.weaponMeetCounterOne = 3

			--if (v.soundOn == 1) then
				--audio.play(a.thud2, 15)
			--end

		elseif(m3.playerHealth > 0 and m3.myGuy.x >=  -40 - _XB and m3.myGuy.x <= 520 + _XB and (g.arrowDouble.x < m3.myGuy.x + 51 and g.arrowDouble.x > m3.myGuy.x - 51)) then
				if (g.arrowGold.isPurchased == 1) then
					m3.playerHurt = 110
				elseif (g.arrow3.isPurchased == 1) then
					m3.playerHurt = 70
				elseif (g.arrow2.isPurchased == 1) then
					m3.playerHurt = 60
				elseif (g.arrow1.isPurchased == 1) then
					m3.playerHurt = 55
				end
			m3.playerHealth = m3.playerHealth - m3.playerHurt
			m3.torsoGroup.rotation = m3.torsoGroup.rotation - 4
			m3.myGuy.x = m3.myGuy.x - 3 * m3.myGuy.xScale
			m3.splash01.isVisible = true
			g.arrowDouble.isVisible = false
			v.weaponMeetCounterOne = 3

			--if (v.soundOn == 1) then
				--audio.play(a.thud3, 16)
			--end

		end
	
	elseif (p == "arrowFinish") then
	
		v.weaponMeetCounterOne = v.weaponMeetCounterOne - 1

		if (v.weaponMeetCounterOne == 0 ) then
		
			if (m1.playerHurt > 0) then
				m1.playerHurt = 0
				m1.torsoGroup.rotation = m1.torsoGroup.rotation + 4
				isAttackOne = 28
				if (m1.playerHealth > 0) then
					m1.splash01.isVisible = false
				end
			end
			if (m2.playerHurt > 0) then
				m2.playerHurt = 0
				m2.torsoGroup.rotation = m2.torsoGroup.rotation + 4
				isAttackOne = 28
				if (m2.playerHealth > 0) then
					m2.splash01.isVisible = false
				end
			end
			if (m3.playerHurt > 0) then
				m3.playerHurt = 0
				m3.torsoGroup.rotation = m3.torsoGroup.rotation + 4
				isAttackOne = 28
				if (m3.playerHealth > 0) then
					m3.splash01.isVisible = false
				end
			end		
		
		end
	
	end

	
	if (p == "tomahawkLeftStart") then

		if (m1.inShotRange == 1 and m1.playerHealth > 0 and (g.tomahawkLeftDouble.x < m1.myGuy.x + 31 and g.tomahawkLeftDouble.x > m1.myGuy.x - 31)) then
				if (g.tomahawkGoldLeft.isPurchased == 1) then
					m1.playerHurt = 110
				elseif (g.tomahawk3Left.isPurchased == 1) then
					m1.playerHurt = 100
				elseif (g.tomahawk2Left.isPurchased == 1) then
					m1.playerHurt = 90
				elseif (g.tomahawk1Left.isPurchased == 1) then
					m1.playerHurt = 80
				end
			m1.playerHealth = m1.playerHealth - m1.playerHurt
			m1.torsoGroup.rotation = m1.torsoGroup.rotation - 4
			m1.myGuy.x = m1.myGuy.x - 3 * m1.myGuy.xScale
			m1.splash01.isVisible = true
			g.tomahawkLeftDouble.isVisible = false
			v.weaponMeetCounterOne = 3
			
			--if (v.soundOn == 1) then
				--audio.play(a.thud1, 14)
			--end
			
		elseif (m2.inShotRange == 1 and m2.playerHealth > 0 and (g.tomahawkLeftDouble.x < m2.myGuy.x + 31 and g.tomahawkLeftDouble.x > m2.myGuy.x - 31)) then
				if (g.tomahawkGoldLeft.isPurchased == 1) then
					m2.playerHurt = 110
				elseif (g.tomahawk3Left.isPurchased == 1) then
					m2.playerHurt = 100
				elseif (g.tomahawk2Left.isPurchased == 1) then
					m2.playerHurt = 90
				elseif (g.tomahawk1Left.isPurchased == 1) then
					m2.playerHurt = 80
				end
			m2.playerHealth = m2.playerHealth - m2.playerHurt
			m2.torsoGroup.rotation = m2.torsoGroup.rotation - 4
			m2.myGuy.x = m2.myGuy.x - 3 * m2.myGuy.xScale
			m2.splash01.isVisible = true
			g.tomahawkLeftDouble.isVisible = false
			v.weaponMeetCounterOne = 3
			
			--if (v.soundOn == 1) then
				--audio.play(a.thud2, 15)
			--end
			
		elseif (m3.inShotRange == 1 and m3.playerHealth > 0 and (g.tomahawkLeftDouble.x < m3.myGuy.x + 31 and g.tomahawkLeftDouble.x > m3.myGuy.x - 31)) then
				if (g.tomahawkGoldLeft.isPurchased == 1) then
					m3.playerHurt = 110
				elseif (g.tomahawk3Left.isPurchased == 1) then
					m3.playerHurt = 100
				elseif (g.tomahawk2Left.isPurchased == 1) then
					m3.playerHurt = 90
				elseif (g.tomahawk1Left.isPurchased == 1) then
					m3.playerHurt = 80
				end
			m3.playerHealth = m3.playerHealth - m3.playerHurt
			m3.torsoGroup.rotation = m3.torsoGroup.rotation - 4
			m3.myGuy.x = m3.myGuy.x - 3 * m3.myGuy.xScale
			m3.splash01.isVisible = true
			g.tomahawkLeftDouble.isVisible = false
			v.weaponMeetCounterOne = 3
			
			--if (v.soundOn == 1) then
				--audio.play(a.thud3, 16)
			--end
			
		elseif(m1.playerHealth > 0 and m1.myGuy.x >=  -40 - _XB and m1.myGuy.x <= 520 + _XB and (g.tomahawkLeftDouble.x < m1.myGuy.x + 51 and g.tomahawkLeftDouble.x > m1.myGuy.x - 51)) then
				if (g.tomahawkGoldLeft.isPurchased == 1) then
					m1.playerHurt = 110
				elseif (g.tomahawk3Left.isPurchased == 1) then
					m1.playerHurt = 100
				elseif (g.tomahawk2Left.isPurchased == 1) then
					m1.playerHurt = 90
				elseif (g.tomahawk1Left.isPurchased == 1) then
					m1.playerHurt = 80
				end
			m1.playerHealth = m1.playerHealth - m1.playerHurt
			m1.torsoGroup.rotation = m1.torsoGroup.rotation - 4
			m1.myGuy.x = m1.myGuy.x - 3 * m1.myGuy.xScale
			m1.splash01.isVisible = true
			g.tomahawkLeftDouble.isVisible = false
			v.weaponMeetCounterOne = 3
			
			--if (v.soundOn == 1) then
				--audio.play(a.thud1, 14)
			--end
			
		elseif(m2.playerHealth > 0 and m2.myGuy.x >=  -40 - _XB and m2.myGuy.x <= 520 + _XB and (g.tomahawkLeftDouble.x < m2.myGuy.x + 51 and g.tomahawkLeftDouble.x > m2.myGuy.x - 51)) then
				if (g.tomahawkGoldLeft.isPurchased == 1) then
					m2.playerHurt = 110
				elseif (g.tomahawk3Left.isPurchased == 1) then
					m2.playerHurt = 100
				elseif (g.tomahawk2Left.isPurchased == 1) then
					m2.playerHurt = 90
				elseif (g.tomahawk1Left.isPurchased == 1) then
					m2.playerHurt = 80
				end
			m2.playerHealth = m2.playerHealth - m2.playerHurt
			m2.torsoGroup.rotation = m2.torsoGroup.rotation - 4
			m2.myGuy.x = m2.myGuy.x - 3 * m2.myGuy.xScale
			m2.splash01.isVisible = true
			g.tomahawkLeftDouble.isVisible = false
			v.weaponMeetCounterOne = 3
			
			--if (v.soundOn == 1) then
				--audio.play(a.thud2, 15)
			--end
			
		elseif(m3.playerHealth > 0 and m3.myGuy.x >=  -40 - _XB and m3.myGuy.x <= 520 + _XB and (g.tomahawkLeftDouble.x < m3.myGuy.x + 51 and g.tomahawkLeftDouble.x > m3.myGuy.x - 51)) then
				if (g.tomahawkGoldLeft.isPurchased == 1) then
					m3.playerHurt = 110
				elseif (g.tomahawk3Left.isPurchased == 1) then
					m3.playerHurt = 100
				elseif (g.tomahawk2Left.isPurchased == 1) then
					m3.playerHurt = 90
				elseif (g.tomahawk1Left.isPurchased == 1) then
					m3.playerHurt = 80
				end
			m3.playerHealth = m3.playerHealth - m3.playerHurt
			m3.torsoGroup.rotation = m3.torsoGroup.rotation - 4
			m3.myGuy.x = m3.myGuy.x - 3 * m3.myGuy.xScale
			m3.splash01.isVisible = true
			g.tomahawkLeftDouble.isVisible = false
			v.weaponMeetCounterOne = 3

			--if (v.soundOn == 1) then
				--audio.play(a.thud3, 16)
			--end
			
		end
	
	elseif (p == "tomahawkLeftFinish") then
	
		v.weaponMeetCounterOne = v.weaponMeetCounterOne - 1

		if (v.weaponMeetCounterOne == 0 ) then
		
			if (m1.playerHurt > 0) then
				m1.playerHurt = 0
				m1.torsoGroup.rotation = m1.torsoGroup.rotation + 4
				isAttackOne = 21
				if (m1.playerHealth > 0) then
					m1.splash01.isVisible = false
				end
			end
			if (m2.playerHurt > 0) then
				m2.playerHurt = 0
				m2.torsoGroup.rotation = m2.torsoGroup.rotation + 4
				isAttackOne = 21
				if (m2.playerHealth > 0) then
					m2.splash01.isVisible = false
				end
			end
			if (m3.playerHurt > 0) then
				m3.playerHurt = 0
				m3.torsoGroup.rotation = m3.torsoGroup.rotation + 4
				isAttackOne = 21
				if (m3.playerHealth > 0) then
					m3.splash01.isVisible = false
				end
			end		
		
		end
	
	end


	if (p == "tomahawkRightStart") then

		if (m1.inShotRange == 1 and m1.playerHealth > 0 and (g.tomahawkRightDouble.x < m1.myGuy.x + 31 and g.tomahawkRightDouble.x > m1.myGuy.x - 31)) then
				if (g.tomahawkGoldLeft.isPurchased == 1) then
					m1.playerHurt = 110
				elseif (g.tomahawk3Left.isPurchased == 1) then
					m1.playerHurt = 100
				elseif (g.tomahawk2Left.isPurchased == 1) then
					m1.playerHurt = 90
				elseif (g.tomahawk1Left.isPurchased == 1) then
					m1.playerHurt = 80
				end
			m1.playerHealth = m1.playerHealth - m1.playerHurt
			m1.torsoGroup.rotation = m1.torsoGroup.rotation - 4
			m1.myGuy.x = m1.myGuy.x - 3 * m1.myGuy.xScale
			m1.splash01.isVisible = true
			g.tomahawkRightDouble.isVisible = false
			v.weaponMeetCounterTwo = 3
			
			--if (v.soundOn == 1) then
				--audio.play(a.thud1, 14)
			--end
			
		elseif (m2.inShotRange == 1 and m2.playerHealth > 0 and (g.tomahawkRightDouble.x < m2.myGuy.x + 31 and g.tomahawkRightDouble.x > m2.myGuy.x - 31)) then
				if (g.tomahawkGoldLeft.isPurchased == 1) then
					m2.playerHurt = 110
				elseif (g.tomahawk3Left.isPurchased == 1) then
					m2.playerHurt = 100
				elseif (g.tomahawk2Left.isPurchased == 1) then
					m2.playerHurt = 90
				elseif (g.tomahawk1Left.isPurchased == 1) then
					m2.playerHurt = 80
				end
			m2.playerHealth = m2.playerHealth - m2.playerHurt
			m2.torsoGroup.rotation = m2.torsoGroup.rotation - 4
			m2.myGuy.x = m2.myGuy.x - 3 * m2.myGuy.xScale
			m2.splash01.isVisible = true
			g.tomahawkRightDouble.isVisible = false
			v.weaponMeetCounterTwo = 3
			
			--if (v.soundOn == 1) then
				--audio.play(a.thud2, 15)
			--end
			
		elseif (m3.inShotRange == 1 and m3.playerHealth > 0 and (g.tomahawkRightDouble.x < m3.myGuy.x + 31 and g.tomahawkRightDouble.x > m3.myGuy.x - 31)) then
				if (g.tomahawkGoldLeft.isPurchased == 1) then
					m3.playerHurt = 110
				elseif (g.tomahawk3Left.isPurchased == 1) then
					m3.playerHurt = 100
				elseif (g.tomahawk2Left.isPurchased == 1) then
					m3.playerHurt = 90
				elseif (g.tomahawk1Left.isPurchased == 1) then
					m3.playerHurt = 80
				end
			m3.playerHealth = m3.playerHealth - m3.playerHurt
			m3.torsoGroup.rotation = m3.torsoGroup.rotation - 4
			m3.myGuy.x = m3.myGuy.x - 3 * m3.myGuy.xScale
			m3.splash01.isVisible = true
			g.tomahawkRightDouble.isVisible = false
			v.weaponMeetCounterTwo = 3

			--if (v.soundOn == 1) then
				--audio.play(a.thud3, 16)
			--end
			
		elseif(m1.playerHealth > 0 and m1.myGuy.x >=  -40 - _XB and m1.myGuy.x <= 520 + _XB and (g.tomahawkRightDouble.x < m1.myGuy.x + 51 and g.tomahawkRightDouble.x > m1.myGuy.x - 51)) then
				if (g.tomahawkGoldLeft.isPurchased == 1) then
					m1.playerHurt = 110
				elseif (g.tomahawk3Left.isPurchased == 1) then
					m1.playerHurt = 100
				elseif (g.tomahawk2Left.isPurchased == 1) then
					m1.playerHurt = 90
				elseif (g.tomahawk1Left.isPurchased == 1) then
					m1.playerHurt = 80
				end
			m1.playerHealth = m1.playerHealth - m1.playerHurt
			m1.torsoGroup.rotation = m1.torsoGroup.rotation - 4
			m1.myGuy.x = m1.myGuy.x - 3 * m1.myGuy.xScale
			m1.splash01.isVisible = true
			g.tomahawkRightDouble.isVisible = false
			v.weaponMeetCounterTwo = 3
			
			--if (v.soundOn == 1) then
				--audio.play(a.thud1, 14)
			--end
			
		elseif(m2.playerHealth > 0 and m2.myGuy.x >=  -40 - _XB and m2.myGuy.x <= 520 + _XB and (g.tomahawkRightDouble.x < m2.myGuy.x + 51 and g.tomahawkRightDouble.x > m2.myGuy.x - 51)) then
				if (g.tomahawkGoldLeft.isPurchased == 1) then
					m2.playerHurt = 110
				elseif (g.tomahawk3Left.isPurchased == 1) then
					m2.playerHurt = 100
				elseif (g.tomahawk2Left.isPurchased == 1) then
					m2.playerHurt = 90
				elseif (g.tomahawk1Left.isPurchased == 1) then
					m2.playerHurt = 80
				end
			m2.playerHealth = m2.playerHealth - m2.playerHurt
			m2.torsoGroup.rotation = m2.torsoGroup.rotation - 4
			m2.myGuy.x = m2.myGuy.x - 3 * m2.myGuy.xScale
			m2.splash01.isVisible = true
			g.tomahawkRightDouble.isVisible = false
			v.weaponMeetCounterTwo = 3
			
			--if (v.soundOn == 1) then
				--audio.play(a.thud2, 15)
			--end
			
		elseif(m3.playerHealth > 0 and m3.myGuy.x >=  -40 - _XB and m3.myGuy.x <= 520 + _XB and (g.tomahawkRightDouble.x < m3.myGuy.x + 51 and g.tomahawkRightDouble.x > m3.myGuy.x - 51)) then
				if (g.tomahawkGoldLeft.isPurchased == 1) then
					m3.playerHurt = 110
				elseif (g.tomahawk3Left.isPurchased == 1) then
					m3.playerHurt = 100
				elseif (g.tomahawk2Left.isPurchased == 1) then
					m3.playerHurt = 90
				elseif (g.tomahawk1Left.isPurchased == 1) then
					m3.playerHurt = 80
				end
			m3.playerHealth = m3.playerHealth - m3.playerHurt
			m3.torsoGroup.rotation = m3.torsoGroup.rotation - 4
			m3.myGuy.x = m3.myGuy.x - 3 * m3.myGuy.xScale
			m3.splash01.isVisible = true
			g.tomahawkRightDouble.isVisible = false
			v.weaponMeetCounterTwo = 3

			--if (v.soundOn == 1) then
				--audio.play(a.thud3, 16)
			--end
			
		end
	
	elseif (p == "tomahawkRightFinish") then
	
		v.weaponMeetCounterTwo = v.weaponMeetCounterTwo - 1

		if (v.weaponMeetCounterTwo == 0 ) then
		
			if (m1.playerHurt > 0) then
				m1.playerHurt = 0
				m1.torsoGroup.rotation = m1.torsoGroup.rotation + 4
				isAttackTwo = 21
				if (m1.playerHealth > 0) then
					m1.splash01.isVisible = false
				end
			end
			if (m2.playerHurt > 0) then
				m2.playerHurt = 0
				m2.torsoGroup.rotation = m2.torsoGroup.rotation + 4
				isAttackTwo = 21
				if (m2.playerHealth > 0) then
					m2.splash01.isVisible = false
				end
			end
			if (m3.playerHurt > 0) then
				m3.playerHurt = 0
				m3.torsoGroup.rotation = m3.torsoGroup.rotation + 4
				isAttackTwo = 21
				if (m3.playerHealth > 0) then
					m3.splash01.isVisible = false
				end
			end		
		
		end
	
	end

	
	if (p == "knifeLeftStart") then

		if (m1.inShotRange == 1 and m1.playerHealth > 0 and (g.knifeLeftDouble.x < m1.myGuy.x + 31 and g.knifeLeftDouble.x > m1.myGuy.x - 31)) then
				if (g.knifeGoldLeft.isPurchased == 1) then
					m1.playerHurt = 110
				elseif (g.knife3Left.isPurchased == 1) then
					m1.playerHurt = 90
				elseif (g.knife2Left.isPurchased == 1) then
					m1.playerHurt = 80
				elseif (g.knife1Left.isPurchased == 1) then
					m1.playerHurt = 70
				end
			m1.playerHealth = m1.playerHealth - m1.playerHurt
			m1.torsoGroup.rotation = m1.torsoGroup.rotation - 4
			m1.myGuy.x = m1.myGuy.x - 3 * m1.myGuy.xScale
			m1.splash01.isVisible = true
			g.knifeLeftDouble.isVisible = false
			v.weaponMeetCounterOne = 3
			
			--if (v.soundOn == 1) then
				--audio.play(a.thud1, 14)
			--end
			
		elseif (m2.inShotRange == 1 and m2.playerHealth > 0 and (g.knifeLeftDouble.x < m2.myGuy.x + 31 and g.knifeLeftDouble.x > m2.myGuy.x - 31)) then
				if (g.knifeGoldLeft.isPurchased == 1) then
					m2.playerHurt = 110
				elseif (g.knife3Left.isPurchased == 1) then
					m2.playerHurt = 90
				elseif (g.knife2Left.isPurchased == 1) then
					m2.playerHurt = 80
				elseif (g.knife1Left.isPurchased == 1) then
					m2.playerHurt = 70
				end
			m2.playerHealth = m2.playerHealth - m2.playerHurt
			m2.torsoGroup.rotation = m2.torsoGroup.rotation - 4
			m2.myGuy.x = m2.myGuy.x - 3 * m2.myGuy.xScale
			m2.splash01.isVisible = true
			g.knifeLeftDouble.isVisible = false
			v.weaponMeetCounterOne = 3
			
			--if (v.soundOn == 1) then
				--audio.play(a.thud2, 15)
			--end
			
		elseif (m3.inShotRange == 1 and m3.playerHealth > 0 and (g.knifeLeftDouble.x < m3.myGuy.x + 31 and g.knifeLeftDouble.x > m3.myGuy.x - 31)) then
				if (g.knifeGoldLeft.isPurchased == 1) then
					m3.playerHurt = 110
				elseif (g.knife3Left.isPurchased == 1) then
					m3.playerHurt = 90
				elseif (g.knife2Left.isPurchased == 1) then
					m3.playerHurt = 80
				elseif (g.knife1Left.isPurchased == 1) then
					m3.playerHurt = 70
				end
			m3.playerHealth = m3.playerHealth - m3.playerHurt
			m3.torsoGroup.rotation = m3.torsoGroup.rotation - 4
			m3.myGuy.x = m3.myGuy.x - 3 * m3.myGuy.xScale
			m3.splash01.isVisible = true
			g.knifeLeftDouble.isVisible = false
			v.weaponMeetCounterOne = 3

			--if (v.soundOn == 1) then
				--audio.play(a.thud3, 16)
			--end

		elseif(m1.playerHealth > 0 and m1.myGuy.x >=  -40 - _XB and m1.myGuy.x <= 520 + _XB and (g.knifeLeftDouble.x < m1.myGuy.x + 51 and g.knifeLeftDouble.x > m1.myGuy.x - 51)) then
				if (g.knifeGoldLeft.isPurchased == 1) then
					m1.playerHurt = 110
				elseif (g.knife3Left.isPurchased == 1) then
					m1.playerHurt = 90
				elseif (g.knife2Left.isPurchased == 1) then
					m1.playerHurt = 80
				elseif (g.knife1Left.isPurchased == 1) then
					m1.playerHurt = 70
				end
			m1.playerHealth = m1.playerHealth - m1.playerHurt
			m1.torsoGroup.rotation = m1.torsoGroup.rotation - 4
			m1.myGuy.x = m1.myGuy.x - 3 * m1.myGuy.xScale
			m1.splash01.isVisible = true
			g.knifeLeftDouble.isVisible = false
			v.weaponMeetCounterOne = 3
			
			--if (v.soundOn == 1) then
				--audio.play(a.thud1, 14)
			--end
			
		elseif(m2.playerHealth > 0 and m2.myGuy.x >=  -40 - _XB and m2.myGuy.x <= 520 + _XB and (g.knifeLeftDouble.x < m2.myGuy.x + 51 and g.knifeLeftDouble.x > m2.myGuy.x - 51)) then
				if (g.knifeGoldLeft.isPurchased == 1) then
					m2.playerHurt = 110
				elseif (g.knife3Left.isPurchased == 1) then
					m2.playerHurt = 90
				elseif (g.knife2Left.isPurchased == 1) then
					m2.playerHurt = 80
				elseif (g.knife1Left.isPurchased == 1) then
					m2.playerHurt = 70
				end
			m2.playerHealth = m2.playerHealth - m2.playerHurt
			m2.torsoGroup.rotation = m2.torsoGroup.rotation - 4
			m2.myGuy.x = m2.myGuy.x - 3 * m2.myGuy.xScale
			m2.splash01.isVisible = true
			g.knifeLeftDouble.isVisible = false
			v.weaponMeetCounterOne = 3
			
			--if (v.soundOn == 1) then
				--audio.play(a.thud2, 15)
			--end
			
		elseif(m3.playerHealth > 0 and m3.myGuy.x >=  -40 - _XB and m3.myGuy.x <= 520 + _XB and (g.knifeLeftDouble.x < m3.myGuy.x + 51 and g.knifeLeftDouble.x > m3.myGuy.x - 51)) then
				if (g.knifeGoldLeft.isPurchased == 1) then
					m3.playerHurt = 110
				elseif (g.knife3Left.isPurchased == 1) then
					m3.playerHurt = 90
				elseif (g.knife2Left.isPurchased == 1) then
					m3.playerHurt = 80
				elseif (g.knife1Left.isPurchased == 1) then
					m3.playerHurt = 70
				end
			m3.playerHealth = m3.playerHealth - m3.playerHurt
			m3.torsoGroup.rotation = m3.torsoGroup.rotation - 4
			m3.myGuy.x = m3.myGuy.x - 3 * m3.myGuy.xScale
			m3.splash01.isVisible = true
			g.knifeLeftDouble.isVisible = false
			v.weaponMeetCounterOne = 3			

			--if (v.soundOn == 1) then
				--audio.play(a.thud3, 16)
			--end
			
		end
	
	elseif (p == "knifeLeftFinish") then
	
		v.weaponMeetCounterOne = v.weaponMeetCounterOne - 1

		if (v.weaponMeetCounterOne == 0 ) then
		
			if (m1.playerHurt > 0) then
				m1.playerHurt = 0
				m1.torsoGroup.rotation = m1.torsoGroup.rotation + 4
				isAttackOne = 21
				if (m1.playerHealth > 0) then
					m1.splash01.isVisible = false
				end
			end
			if (m2.playerHurt > 0) then
				m2.playerHurt = 0
				m2.torsoGroup.rotation = m2.torsoGroup.rotation + 4
				isAttackOne = 21
				if (m2.playerHealth > 0) then
					m2.splash01.isVisible = false
				end
			end
			if (m3.playerHurt > 0) then
				m3.playerHurt = 0
				m3.torsoGroup.rotation = m3.torsoGroup.rotation + 4
				isAttackOne = 21
				if (m3.playerHealth > 0) then
					m3.splash01.isVisible = false
				end
			end		
		
		end
	
	end


	if (p == "knifeRightStart") then

		if (m1.inShotRange == 1 and m1.playerHealth > 0 and (g.knifeRightDouble.x < m1.myGuy.x + 31 and g.knifeRightDouble.x > m1.myGuy.x - 31)) then
				if (g.knifeGoldLeft.isPurchased == 1) then
					m1.playerHurt = 110
				elseif (g.knife3Left.isPurchased == 1) then
					m1.playerHurt = 90
				elseif (g.knife2Left.isPurchased == 1) then
					m1.playerHurt = 80
				elseif (g.knife1Left.isPurchased == 1) then
					m1.playerHurt = 70
				end
			m1.playerHealth = m1.playerHealth - m1.playerHurt
			m1.torsoGroup.rotation = m1.torsoGroup.rotation - 4
			m1.myGuy.x = m1.myGuy.x - 3 * m1.myGuy.xScale
			m1.splash01.isVisible = true
			g.knifeRightDouble.isVisible = false
			v.weaponMeetCounterTwo = 3
			
			--if (v.soundOn == 1) then
				--audio.play(a.thud1, 14)
			--end
			
		elseif (m2.inShotRange == 1 and m2.playerHealth > 0 and (g.knifeRightDouble.x < m2.myGuy.x + 31 and g.knifeRightDouble.x > m2.myGuy.x - 31)) then
				if (g.knifeGoldLeft.isPurchased == 1) then
					m2.playerHurt = 110
				elseif (g.knife3Left.isPurchased == 1) then
					m2.playerHurt = 90
				elseif (g.knife2Left.isPurchased == 1) then
					m2.playerHurt = 80
				elseif (g.knife1Left.isPurchased == 1) then
					m2.playerHurt = 70
				end
			m2.playerHealth = m2.playerHealth - m2.playerHurt
			m2.torsoGroup.rotation = m2.torsoGroup.rotation - 4
			m2.myGuy.x = m2.myGuy.x - 3 * m2.myGuy.xScale
			m2.splash01.isVisible = true
			g.knifeRightDouble.isVisible = false
			v.weaponMeetCounterTwo = 3
			
			--if (v.soundOn == 1) then
				--audio.play(a.thud2, 15)
			--end
			
		elseif (m3.inShotRange == 1 and m3.playerHealth > 0 and (g.knifeRightDouble.x < m3.myGuy.x + 31 and g.knifeRightDouble.x > m3.myGuy.x - 31)) then
				if (g.knifeGoldLeft.isPurchased == 1) then
					m3.playerHurt = 110
				elseif (g.knife3Left.isPurchased == 1) then
					m3.playerHurt = 90
				elseif (g.knife2Left.isPurchased == 1) then
					m3.playerHurt = 80
				elseif (g.knife1Left.isPurchased == 1) then
					m3.playerHurt = 70
				end
			m3.playerHealth = m3.playerHealth - m3.playerHurt
			m3.torsoGroup.rotation = m3.torsoGroup.rotation - 4
			m3.myGuy.x = m3.myGuy.x - 3 * m3.myGuy.xScale
			m3.splash01.isVisible = true
			g.knifeRightDouble.isVisible = false
			v.weaponMeetCounterTwo = 3

			--if (v.soundOn == 1) then
				--audio.play(a.thud3, 16)
			--end

		elseif(m1.playerHealth > 0 and m1.myGuy.x >=  -40 - _XB and m1.myGuy.x <= 520 + _XB and (g.knifeRightDouble.x < m1.myGuy.x + 51 and g.knifeRightDouble.x > m1.myGuy.x - 51)) then
				if (g.knifeGoldLeft.isPurchased == 1) then
					m1.playerHurt = 110
				elseif (g.knife3Left.isPurchased == 1) then
					m1.playerHurt = 90
				elseif (g.knife2Left.isPurchased == 1) then
					m1.playerHurt = 80
				elseif (g.knife1Left.isPurchased == 1) then
					m1.playerHurt = 70
				end
			m1.playerHealth = m1.playerHealth - m1.playerHurt
			m1.torsoGroup.rotation = m1.torsoGroup.rotation - 4
			m1.myGuy.x = m1.myGuy.x - 3 * m1.myGuy.xScale
			m1.splash01.isVisible = true
			g.knifeRightDouble.isVisible = false
			v.weaponMeetCounterTwo = 3
			
			--if (v.soundOn == 1) then
				--audio.play(a.thud1, 14)
			--end
			
		elseif(m2.playerHealth > 0 and m2.myGuy.x >=  -40 - _XB and m2.myGuy.x <= 520 + _XB and (g.knifeRightDouble.x < m2.myGuy.x + 51 and g.knifeRightDouble.x > m2.myGuy.x - 51)) then
				if (g.knifeGoldLeft.isPurchased == 1) then
					m2.playerHurt = 110
				elseif (g.knife3Left.isPurchased == 1) then
					m2.playerHurt = 90
				elseif (g.knife2Left.isPurchased == 1) then
					m2.playerHurt = 80
				elseif (g.knife1Left.isPurchased == 1) then
					m2.playerHurt = 70
				end
			m2.playerHealth = m2.playerHealth - m2.playerHurt
			m2.torsoGroup.rotation = m2.torsoGroup.rotation - 4
			m2.myGuy.x = m2.myGuy.x - 3 * m2.myGuy.xScale
			m2.splash01.isVisible = true
			g.knifeRightDouble.isVisible = false
			v.weaponMeetCounterTwo = 3
			
			--if (v.soundOn == 1) then
				--audio.play(a.thud2, 15)
			--end
			
		elseif(m3.playerHealth > 0 and m3.myGuy.x >=  -40 - _XB and m3.myGuy.x <= 520 + _XB and (g.knifeRightDouble.x < m3.myGuy.x + 51 and g.knifeRightDouble.x > m3.myGuy.x - 51)) then
				if (g.knifeGoldLeft.isPurchased == 1) then
					m3.playerHurt = 110
				elseif (g.knife3Left.isPurchased == 1) then
					m3.playerHurt = 90
				elseif (g.knife2Left.isPurchased == 1) then
					m3.playerHurt = 80
				elseif (g.knife1Left.isPurchased == 1) then
					m3.playerHurt = 70
				end
			m3.playerHealth = m3.playerHealth - m3.playerHurt
			m3.torsoGroup.rotation = m3.torsoGroup.rotation - 4
			m3.myGuy.x = m3.myGuy.x - 3 * m3.myGuy.xScale
			m3.splash01.isVisible = true
			g.knifeRightDouble.isVisible = false
			v.weaponMeetCounterTwo = 3			

			--if (v.soundOn == 1) then
				--audio.play(a.thud3, 16)
			--end
			
		end
	
	elseif (p == "knifeRightFinish") then
	
		v.weaponMeetCounterTwo = v.weaponMeetCounterTwo - 1

		if (v.weaponMeetCounterTwo == 0 ) then
		
			if (m1.playerHurt > 0) then
				m1.playerHurt = 0
				m1.torsoGroup.rotation = m1.torsoGroup.rotation + 4
				isAttackTwo = 21
				if (m1.playerHealth > 0) then
					m1.splash01.isVisible = false
				end
			end
			if (m2.playerHurt > 0) then
				m2.playerHurt = 0
				m2.torsoGroup.rotation = m2.torsoGroup.rotation + 4
				isAttackTwo = 21
				if (m2.playerHealth > 0) then
					m2.splash01.isVisible = false
				end
			end
			if (m3.playerHurt > 0) then
				m3.playerHurt = 0
				m3.torsoGroup.rotation = m3.torsoGroup.rotation + 4
				isAttackTwo = 21
				if (m3.playerHealth > 0) then
					m3.splash01.isVisible = false
				end
			end		
		
		end
	
	end	


	if (p == "granadeStart") then

		if (m1.inShotRange == 1 and m1.playerHealth > 0 and (g.granadeDouble.x < m1.myGuy.x + 51 and g.granadeDouble.x > m1.myGuy.x - 51)) then
			if (g.granadeGold.isPurchased == 1) then
				m1.playerHurt = 220
				m1.sideing = 5
			elseif (g.granade1.isPurchased == 1) then
				m1.playerHurt = 200
				m1.sideing = 4
			end
			m1.playerHealth = m1.playerHealth - m1.playerHurt
			exp01.x = m1.myGuy.x
			exp01.y = m1.myGuy.y - 30
			exp01.isVisible = true
			m1.splash01.isVisible = true
			g.granadeDouble.isVisible = false
			v.weaponMeetCounterOne = 3
			if (v.soundOn == 1) then
				audio.play(a.granadeExplosion, 6)
			end
		elseif (m2.inShotRange == 1 and m2.playerHealth > 0 and (g.granadeDouble.x < m2.myGuy.x + 51 and g.granadeDouble.x > m2.myGuy.x - 51)) then
			if (g.granadeGold.isPurchased == 1) then
				m2.playerHurt = 220
				m2.sideing = 5
			elseif (g.granade1.isPurchased == 1) then
				m2.playerHurt = 200
				m2.sideing = 4
			end
			m2.playerHealth = m2.playerHealth - m2.playerHurt
			exp01.x = m2.myGuy.x
			exp01.y = m2.myGuy.y - 30
			exp01.isVisible = true
			m2.splash01.isVisible = true
			g.granadeDouble.isVisible = false
			v.weaponMeetCounterOne = 3
			if (v.soundOn == 1) then
				audio.play(a.granadeExplosion, 6)
			end
		elseif (m3.inShotRange == 1 and m3.playerHealth > 0 and (g.granadeDouble.x < m3.myGuy.x + 51 and g.granadeDouble.x > m3.myGuy.x - 51)) then
			if (g.granadeGold.isPurchased == 1) then
				m3.playerHurt = 220
				m3.sideing = 5
			elseif (g.granade1.isPurchased == 1) then
				m3.playerHurt = 200
				m3.sideing = 4
			end
			m3.playerHealth = m3.playerHealth - m3.playerHurt
			exp01.x = m3.myGuy.x
			exp01.y = m3.myGuy.y - 30
			exp01.isVisible = true
			m3.splash01.isVisible = true
			g.granadeDouble.isVisible = false
			v.weaponMeetCounterOne = 3
			if (v.soundOn == 1) then
				audio.play(a.granadeExplosion, 6)
			end
				
		
		elseif(m1.playerHealth > 0 and m1.myGuy.x >=  -40 - _XB and m1.myGuy.x <= 520 + _XB and (g.granadeDouble.x < m1.myGuy.x + 51 and g.granadeDouble.x > m1.myGuy.x - 51)) then
			if (g.granadeGold.isPurchased == 1) then
				m1.playerHurt = 220
				m1.sideing = 5
			elseif (g.granade1.isPurchased == 1) then
				m1.playerHurt = 200
				m1.sideing = 4
			end
			m1.playerHealth = m1.playerHealth - m1.playerHurt
			exp01.x = m1.myGuy.x
			exp01.y = m1.myGuy.y - 30
			exp01.isVisible = true
			m1.splash01.isVisible = true
			g.granadeDouble.isVisible = false
			v.weaponMeetCounterOne = 3
			if (v.soundOn == 1) then
				audio.play(a.granadeExplosion, 6)
			end
		elseif(m2.playerHealth > 0 and m2.myGuy.x >=  -40 - _XB and m2.myGuy.x <= 520 + _XB and (g.granadeDouble.x < m2.myGuy.x + 51 and g.granadeDouble.x > m2.myGuy.x - 51)) then
			if (g.granadeGold.isPurchased == 1) then
				m2.playerHurt = 220
				m2.sideing = 5
			elseif (g.granade1.isPurchased == 1) then
				m2.playerHurt = 200
				m2.sideing = 4
			end
			m2.playerHealth = m2.playerHealth - m2.playerHurt
			exp01.x = m2.myGuy.x
			exp01.y = m2.myGuy.y - 30
			exp01.isVisible = true
			m2.splash01.isVisible = true
			g.granadeDouble.isVisible = false
			v.weaponMeetCounterOne = 3
			if (v.soundOn == 1) then
				audio.play(a.granadeExplosion, 6)
			end
		elseif(m3.playerHealth > 0 and m3.myGuy.x >=  -40 - _XB and m3.myGuy.x <= 520 + _XB and (g.granadeDouble.x < m3.myGuy.x + 51 and g.granadeDouble.x > m3.myGuy.x - 51)) then
			if (g.granadeGold.isPurchased == 1) then
				m3.playerHurt = 220
				m3.sideing = 5
			elseif (g.granade1.isPurchased == 1) then
				m3.playerHurt = 200
				m3.sideing = 4
			end
			m3.playerHealth = m3.playerHealth - m3.playerHurt
			exp01.x = m3.myGuy.x
			exp01.y = m3.myGuy.y - 30
			exp01.isVisible = true
			m3.splash01.isVisible = true
			g.granadeDouble.isVisible = false
			v.weaponMeetCounterOne = 3		
			if (v.soundOn == 1) then
				audio.play(a.granadeExplosion, 6)
			end
					
		end
	
	elseif (p == "granadeFinish") then
	
		v.weaponMeetCounterOne = v.weaponMeetCounterOne - 1

		if (v.weaponMeetCounterOne == 0 ) then
		
			if (m1.playerHurt > 0) then
				m1.playerHurt = 0
				isAttackFour = 18
				exp01.isVisible = false
				if (m1.playerHealth > 0) then
					m1.splash01.isVisible = false
				end
			end
			if (m2.playerHurt > 0) then
				m2.playerHurt = 0
				isAttackFour = 18
				exp01.isVisible = false
				if (m2.playerHealth > 0) then
					m2.splash01.isVisible = false
				end
			end
			if (m3.playerHurt > 0) then
				m3.playerHurt = 0
				isAttackFour = 18
				exp01.isVisible = false			
				if (m3.playerHealth > 0) then
					m3.splash01.isVisible = false
				end
			end		
		
		end
	
	end

end

	
function doAttack()
	
	if (m1.inKickRange == 1 or m2.inKickRange == 1 or m3.inKickRange == 1) then
		--print (isAttackOne)
	end
	
	if (activeWeapon == "machete" or activeWeapon == "battleAxe" or activeWeapon == "mace" or activeWeapon == "macheteGold") then
		if(isAttackThree == 33) then
			if (v.soundOn == 1) then
				audio.play(a.swingMix1, 6)
			end
			leftArmGroup.rotation = leftArmGroup.rotation - 18
			rightArmGroup.rotation = rightArmGroup.rotation + 12
			torsoGroup.rotation = torsoGroup.rotation - 3.75
			isAttackThree = isAttackThree - 1
			g.mace1.rotation = g.mace1.rotation - 5
			g.machete1.rotation = g.machete1.rotation - 1.5
			g.macheteGold.rotation = g.macheteGold.rotation - 1.5
			g.battleAxe1.rotation = g.battleAxe1.rotation - 5
			
		elseif(isAttackThree == 32) then			

			leftArmGroup.rotation = leftArmGroup.rotation - 18
			rightArmGroup.rotation = rightArmGroup.rotation + 10
			isAttackThree = isAttackThree - 1
			g.mace1.rotation = g.mace1.rotation - 5
			g.machete1.rotation = g.machete1.rotation - 1.5
			g.macheteGold.rotation = g.macheteGold.rotation - 1.5
			g.battleAxe1.rotation = g.battleAxe1.rotation - 5

		elseif(isAttackThree == 31) then
			leftArmGroup.rotation = leftArmGroup.rotation + 18
			rightArmGroup.rotation = rightArmGroup.rotation + 8
			isAttackThree = isAttackThree - 1
			g.mace1.rotation = g.mace1.rotation + 5
			g.machete1.rotation = g.machete1.rotation + 1.5
			g.macheteGold.rotation = g.macheteGold.rotation + 1.5
			g.battleAxe1.rotation = g.battleAxe1.rotation + 5

		elseif(isAttackThree == 30) then
			leftArmGroup.rotation = leftArmGroup.rotation + 18
			rightArmGroup.rotation = rightArmGroup.rotation + 6
			torsoGroup.rotation = torsoGroup.rotation + 3.75
			isAttackThree = isAttackThree - 1
			g.mace1.rotation = g.mace1.rotation + 5
			g.machete1.rotation = g.machete1.rotation + 1.5
			g.macheteGold.rotation = g.macheteGold.rotation + 1.5
			g.battleAxe1.rotation = g.battleAxe1.rotation + 5


			if (m1.inSwordRange == 1 and m1.playerHealth > 0) then
				if (g.macheteGold.isPurchased == 1) then
					m1.playerHurt = 240
				elseif (g.machete1.isPurchased == 1) then
					m1.playerHurt = 200
				elseif (g.mace1.isPurchased == 1) then
					m1.playerHurt = 160
				elseif (g.battleAxe1.isPurchased == 1) then
					m1.playerHurt = 120
				end

				m1.playerHealth = m1.playerHealth - m1.playerHurt
				m1.torsoGroup.rotation = m1.torsoGroup.rotation - 4
				m1.myGuy.x = m1.myGuy.x - 3 * m1.myGuy.xScale
				m1.splash01.isVisible = true
				
				m1.myGuy.x = m1.myGuy.x - 15 * m1.myGuy.xScale
				m1.myGuy.y = m1.myGuy.y - 6
				
				--if (v.soundOn == 1) then
					--audio.play(a.thud1, 14)
				--end
				
			elseif (m2.inSwordRange == 1 and m2.playerHealth > 0) then
				if (g.macheteGold.isPurchased == 1) then
					m2.playerHurt = 240
				elseif (g.machete1.isPurchased == 1) then
					m2.playerHurt = 200
				elseif (g.mace1.isPurchased == 1) then
					m2.playerHurt = 160
				elseif (g.battleAxe1.isPurchased == 1) then
					m2.playerHurt = 120
				end

				m2.playerHealth = m2.playerHealth - m2.playerHurt
				m2.torsoGroup.rotation = m2.torsoGroup.rotation - 4
				m2.myGuy.x = m2.myGuy.x - 3 * m2.myGuy.xScale
				m2.splash01.isVisible = true
				
				m2.myGuy.x = m2.myGuy.x - 15 * m2.myGuy.xScale
				m2.myGuy.y = m2.myGuy.y - 6

				--if (v.soundOn == 1) then
					--audio.play(a.thud2, 15)
				--end
				
			elseif (m3.inSwordRange == 1 and m3.playerHealth > 0) then
				if (g.macheteGold.isPurchased == 1) then
					m3.playerHurt = 240
				elseif (g.machete1.isPurchased == 1) then
					m3.playerHurt = 200
				elseif (g.mace1.isPurchased == 1) then
					m3.playerHurt = 160
				elseif (g.battleAxe1.isPurchased == 1) then
					m3.playerHurt = 120
				end

				m3.playerHealth = m3.playerHealth - m3.playerHurt
				m3.torsoGroup.rotation = m3.torsoGroup.rotation - 4
				m3.myGuy.x = m3.myGuy.x - 3 * m3.myGuy.xScale
				m3.splash01.isVisible = true
				
				m3.myGuy.x = m3.myGuy.x - 15 * m3.myGuy.xScale
				m3.myGuy.y = m3.myGuy.y - 6

				--if (v.soundOn == 1) then
					--audio.play(a.thud3, 16)
				--end
				
			end
		elseif(isAttackThree == 29) then
			leftArmGroup.rotation = leftArmGroup.rotation + 18
			rightArmGroup.rotation = rightArmGroup.rotation + 4
			torsoGroup.rotation = torsoGroup.rotation + 3.75
			isAttackThree = isAttackThree - 1
			g.mace1.rotation = g.mace1.rotation + 5
			g.machete1.rotation = g.machete1.rotation + 1.5
			g.macheteGold.rotation = g.macheteGold.rotation + 1.5
			g.battleAxe1.rotation = g.battleAxe1.rotation + 5
			if (m1.splash01.isVisible == true and math.abs(m1.myGuy.rotation) < 20) then
				m1.myGuy.x = m1.myGuy.x - 15 * m1.myGuy.xScale
			end
			if (m2.splash01.isVisible == true and math.abs(m2.myGuy.rotation) < 20) then
				m2.myGuy.x = m2.myGuy.x - 15 * m2.myGuy.xScale
			end
			if (m3.splash01.isVisible == true and math.abs(m3.myGuy.rotation) < 20) then
				m3.myGuy.x = m3.myGuy.x - 15 * m3.myGuy.xScale
			end
		elseif(isAttackThree == 28) then
			leftArmGroup.rotation = leftArmGroup.rotation + 18
			rightArmGroup.rotation = rightArmGroup.rotation - 4
			torsoGroup.rotation = torsoGroup.rotation + 3.75
			isAttackThree = isAttackThree - 1
			g.mace1.rotation = g.mace1.rotation + 5
			g.machete1.rotation = g.machete1.rotation + 1.5
			g.macheteGold.rotation = g.macheteGold.rotation + 1.5
			g.battleAxe1.rotation = g.battleAxe1.rotation + 5
			if (m1.splash01.isVisible == true and math.abs(m1.myGuy.rotation) < 20) then
				m1.myGuy.x = m1.myGuy.x - 15 * m1.myGuy.xScale
				m1.myGuy.y = m1.myGuy.y + 6
			end
			if (m2.splash01.isVisible == true and math.abs(m2.myGuy.rotation) < 20) then
				m2.myGuy.x = m2.myGuy.x - 15 * m2.myGuy.xScale
				m2.myGuy.y = m2.myGuy.y + 6
			end
			if (m3.splash01.isVisible == true and math.abs(m3.myGuy.rotation) < 20) then
				m3.myGuy.x = m3.myGuy.x - 15 * m3.myGuy.xScale
				m3.myGuy.y = m3.myGuy.y + 6
			end

		elseif(isAttackThree == 27) then
			leftArmGroup.rotation = leftArmGroup.rotation + 18
			rightArmGroup.rotation = rightArmGroup.rotation - 6
			torsoGroup.rotation = torsoGroup.rotation + 3.75
			isAttackThree = isAttackThree - 1
			g.mace1.rotation = g.mace1.rotation + 5
			g.machete1.rotation = g.machete1.rotation + 1.5
			g.macheteGold.rotation = g.macheteGold.rotation + 1.5
			g.battleAxe1.rotation = g.battleAxe1.rotation + 5

		elseif(isAttackThree == 26) then
			leftArmGroup.rotation = leftArmGroup.rotation - 18
			rightArmGroup.rotation = rightArmGroup.rotation - 8
			torsoGroup.rotation = torsoGroup.rotation - 3.75
			isAttackThree = isAttackThree - 1
			g.mace1.rotation = g.mace1.rotation - 5
			g.machete1.rotation = g.machete1.rotation - 1.5
			g.macheteGold.rotation = g.macheteGold.rotation - 1.5
			g.battleAxe1.rotation = g.battleAxe1.rotation - 5
			if (m1.playerHurt > 0) then
				m1.playerHurt = 0
				m1.torsoGroup.rotation = m1.torsoGroup.rotation + 4
				if (m1.playerHealth > 0) then
					m1.splash01.isVisible = false
				end
			end
			if (m2.playerHurt > 0) then
				m2.playerHurt = 0
				m2.torsoGroup.rotation = m2.torsoGroup.rotation + 4
				if (m2.playerHealth > 0) then
					m2.splash01.isVisible = false
				end
			end
			if (m3.playerHurt > 0) then
				m3.playerHurt = 0
				m3.torsoGroup.rotation = m3.torsoGroup.rotation + 4
				if (m3.playerHealth > 0) then
					m3.splash01.isVisible = false
				end
			end
		elseif(isAttackThree == 25) then
			leftArmGroup.rotation = leftArmGroup.rotation - 18
			rightArmGroup.rotation = rightArmGroup.rotation - 10
			torsoGroup.rotation = torsoGroup.rotation - 3.75
			isAttackThree = isAttackThree - 1
			g.mace1.rotation = g.mace1.rotation - 5
			g.machete1.rotation = g.machete1.rotation - 1.5
			g.macheteGold.rotation = g.macheteGold.rotation - 1.5
			g.battleAxe1.rotation = g.battleAxe1.rotation - 5
		elseif(isAttackThree == 24) then
			leftArmGroup.rotation = leftArmGroup.rotation - 18
			rightArmGroup.rotation = rightArmGroup.rotation - 12
			torsoGroup.rotation = torsoGroup.rotation - 3.75
			isAttackThree = isAttackThree - 1
			g.mace1.rotation = g.mace1.rotation - 5
			g.machete1.rotation = g.machete1.rotation - 1.5
			g.macheteGold.rotation = g.macheteGold.rotation - 1.5
			g.battleAxe1.rotation = g.battleAxe1.rotation - 5


			isAttackThree = 1
			
			isWeaponsChange = 1
			v.changeWeaponTo = v.changeWeaponFrom
			v.changeWeaponFrom = nil
		end
		

	elseif (activeWeapon == "tomahawkLeft") then

		if(isAttackOne == 33) then
			if (v.soundOn == 1) then
				audio.play(a.tomahawkMix1, 6)
			end
			tomahawkAmmo = tomahawkAmmo - 1
			writeScreenAmmo(tomahawkAmmo)		
			
			leftArmGroup.rotation = leftArmGroup.rotation - 25
			torsoGroup.rotation = torsoGroup.rotation - .75
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 32) then
			leftArmGroup.rotation = leftArmGroup.rotation - 25
			torsoGroup.rotation = torsoGroup.rotation - .75
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 31) then
			leftArmGroup.rotation = leftArmGroup.rotation - 25
			torsoGroup.rotation = torsoGroup.rotation - .75
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 30) then
			leftArmGroup.rotation = leftArmGroup.rotation + 25
			torsoGroup.rotation = torsoGroup.rotation + .75
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 29) then
			leftArmGroup.rotation = leftArmGroup.rotation + 25
			torsoGroup.rotation = torsoGroup.rotation + .75
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 28) then
			leftArmGroup.rotation = leftArmGroup.rotation + 25
			torsoGroup.rotation = torsoGroup.rotation + .75

			g.tomahawkLeft.isVisible = false
			
			g.tomahawkLeftDouble.rotation = 0
			g.tomahawkLeftDouble.x = myGuy.x
			g.tomahawkLeftDouble.y = myGuy.y - 20
			
			tomahawkLeftDoubleDirection = myGuy.xScale
			
			g.tomahawkLeftDouble.rotation =  g.tomahawkLeftDouble.rotation + 60 * tomahawkLeftDoubleDirection
			g.tomahawkLeftDouble.x = g.tomahawkLeftDouble.x + 50 * tomahawkLeftDoubleDirection
			
			g.tomahawkLeftDouble.isVisible = true
					
			isAttackOne = isAttackOne - 1
			
			if (g.tomahawkLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("tomahawkLeftStart")
			end
			
		elseif(isAttackOne == 27) then
			g.tomahawkLeftDouble.rotation =  g.tomahawkLeftDouble.rotation + 60 * tomahawkLeftDoubleDirection
			g.tomahawkLeftDouble.x = g.tomahawkLeftDouble.x + 45 * tomahawkLeftDoubleDirection
		
			isAttackOne = isAttackOne - 1
			
			if (g.tomahawkLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("tomahawkLeftStart")
			else
				weaponMeetOtherGuy("tomahawkLeftFinish")
			end			
		elseif(isAttackOne == 26) then
			g.tomahawkLeftDouble.rotation =  g.tomahawkLeftDouble.rotation + 60 * tomahawkLeftDoubleDirection
			g.tomahawkLeftDouble.x = g.tomahawkLeftDouble.x + 45 * tomahawkLeftDoubleDirection

			isAttackOne = isAttackOne - 1
			if (g.tomahawkLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("tomahawkLeftStart")
			else
				weaponMeetOtherGuy("tomahawkLeftFinish")
			end			
		elseif(isAttackOne == 25) then
			g.tomahawkLeftDouble.rotation =  g.tomahawkLeftDouble.rotation + 60 * tomahawkLeftDoubleDirection
			g.tomahawkLeftDouble.x = g.tomahawkLeftDouble.x + 45 * tomahawkLeftDoubleDirection

			isAttackOne = isAttackOne - 1
			if (g.tomahawkLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("tomahawkLeftStart")
			else
				weaponMeetOtherGuy("tomahawkLeftFinish")
			end			
		elseif(isAttackOne == 24) then
			g.tomahawkLeftDouble.rotation =  g.tomahawkLeftDouble.rotation + 60 * tomahawkLeftDoubleDirection
			g.tomahawkLeftDouble.x = g.tomahawkLeftDouble.x + 45 * tomahawkLeftDoubleDirection

			isAttackOne = isAttackOne - 1
			if (g.tomahawkLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("tomahawkLeftStart")
			else
				weaponMeetOtherGuy("tomahawkLeftFinish")
			end			
		elseif(isAttackOne == 23) then
			g.tomahawkLeftDouble.rotation =  g.tomahawkLeftDouble.rotation + 60 * tomahawkLeftDoubleDirection
			g.tomahawkLeftDouble.x = g.tomahawkLeftDouble.x + 45 * tomahawkLeftDoubleDirection
			
			isAttackOne = isAttackOne - 1
			if (g.tomahawkLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("tomahawkLeftStart")
			else
				weaponMeetOtherGuy("tomahawkLeftFinish")
			end			
		elseif(isAttackOne == 22) then
			g.tomahawkLeftDouble.rotation =  g.tomahawkLeftDouble.rotation + 60 * tomahawkLeftDoubleDirection
			g.tomahawkLeftDouble.x = g.tomahawkLeftDouble.x + 45 * tomahawkLeftDoubleDirection
			
			isAttackOne = isAttackOne - 1
			if (g.tomahawkLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("tomahawkLeftStart")
			else
				weaponMeetOtherGuy("tomahawkLeftFinish")
			end			
		elseif(isAttackOne == 21) then
		
			if(tomahawkAmmo == 0) then
				isWeaponsChange = 2
			end
			
			g.tomahawkLeftDouble.isVisible = false
			if (v.playerHealth > 0 and tomahawkAmmo > 0) then
				g.tomahawkLeft.isVisible = true
			end
						
			v.weaponMeetCounterOne = 1
			weaponMeetOtherGuy("tomahawkLeftFinish")
			
			isAttackOne = 1
		end

	
	elseif (activeWeapon == "knifeLeft") then

		if(isAttackOne == 33) then
			if (v.soundOn == 1) then
				audio.play(a.knifeMix1, 6)
			end
			knifeAmmo = knifeAmmo - 1
			writeScreenAmmo(knifeAmmo)			

			leftArmGroup.rotation = leftArmGroup.rotation - 25
			torsoGroup.rotation = torsoGroup.rotation - .75
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 32) then
			leftArmGroup.rotation = leftArmGroup.rotation - 25
			torsoGroup.rotation = torsoGroup.rotation - .75
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 31) then
			leftArmGroup.rotation = leftArmGroup.rotation - 25
			torsoGroup.rotation = torsoGroup.rotation - .75
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 30) then
			leftArmGroup.rotation = leftArmGroup.rotation + 25
			torsoGroup.rotation = torsoGroup.rotation + .75
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 29) then
			leftArmGroup.rotation = leftArmGroup.rotation + 25
			torsoGroup.rotation = torsoGroup.rotation + .75
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 28) then
			leftArmGroup.rotation = leftArmGroup.rotation + 25
			torsoGroup.rotation = torsoGroup.rotation + .75

			g.knifeLeft.isVisible = false
			
			g.knifeLeftDouble.rotation = 0
			g.knifeLeftDouble.x = myGuy.x
			g.knifeLeftDouble.y = myGuy.y - 20
			
			knifeLeftDoubleDirection = myGuy.xScale
			
			g.knifeLeftDouble.rotation =  g.knifeLeftDouble.rotation + 60 * knifeLeftDoubleDirection
			g.knifeLeftDouble.x = g.knifeLeftDouble.x + 50 * knifeLeftDoubleDirection
			
			g.knifeLeftDouble.isVisible = true
					
			isAttackOne = isAttackOne - 1
			
			if (g.knifeLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("knifeLeftStart")
			end
			
		elseif(isAttackOne == 27) then
			g.knifeLeftDouble.rotation =  g.knifeLeftDouble.rotation + 60 * knifeLeftDoubleDirection
			g.knifeLeftDouble.x = g.knifeLeftDouble.x + 45 * knifeLeftDoubleDirection
		
			isAttackOne = isAttackOne - 1
			if (g.knifeLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("knifeLeftStart")
			else
				weaponMeetOtherGuy("knifeLeftFinish")
			end			
		elseif(isAttackOne == 26) then
			g.knifeLeftDouble.rotation =  g.knifeLeftDouble.rotation + 60 * knifeLeftDoubleDirection
			g.knifeLeftDouble.x = g.knifeLeftDouble.x + 45 * knifeLeftDoubleDirection
			
			isAttackOne = isAttackOne - 1
			if (g.knifeLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("knifeLeftStart")
			else
				weaponMeetOtherGuy("knifeLeftFinish")
			end			
		elseif(isAttackOne == 25) then
			g.knifeLeftDouble.rotation =  g.knifeLeftDouble.rotation + 60 * knifeLeftDoubleDirection
			g.knifeLeftDouble.x = g.knifeLeftDouble.x + 45 * knifeLeftDoubleDirection
			
			isAttackOne = isAttackOne - 1
			if (g.knifeLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("knifeLeftStart")
			else
				weaponMeetOtherGuy("knifeLeftFinish")
			end			
		elseif(isAttackOne == 24) then
			g.knifeLeftDouble.rotation =  g.knifeLeftDouble.rotation + 60 * knifeLeftDoubleDirection
			g.knifeLeftDouble.x = g.knifeLeftDouble.x + 45 * knifeLeftDoubleDirection
			
			isAttackOne = isAttackOne - 1
			if (g.knifeLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("knifeLeftStart")
			else
				weaponMeetOtherGuy("knifeLeftFinish")
			end			
		elseif(isAttackOne == 23) then
			g.knifeLeftDouble.rotation =  g.knifeLeftDouble.rotation + 60 * knifeLeftDoubleDirection
			g.knifeLeftDouble.x = g.knifeLeftDouble.x + 45 * knifeLeftDoubleDirection
			
			isAttackOne = isAttackOne - 1
			if (g.knifeLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("knifeLeftStart")
			else
				weaponMeetOtherGuy("knifeLeftFinish")
			end			
		elseif(isAttackOne == 22) then
			g.knifeLeftDouble.rotation =  g.knifeLeftDouble.rotation + 60 * knifeLeftDoubleDirection
			g.knifeLeftDouble.x = g.knifeLeftDouble.x + 45 * knifeLeftDoubleDirection
			
			isAttackOne = isAttackOne - 1
			if (g.knifeLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("knifeLeftStart")
			else
				weaponMeetOtherGuy("knifeLeftFinish")
			end			
		elseif(isAttackOne == 21) then
		
			if(knifeAmmo == 0) then
				isWeaponsChange = 2
			end
			
			g.knifeLeftDouble.isVisible = false
			if (v.playerHealth > 0 and knifeAmmo > 0) then
				g.knifeLeft.isVisible = true
			end
			
			v.weaponMeetCounterOne = 1
			weaponMeetOtherGuy("knifeLeftFinish")			
			
			isAttackOne = 1
			
		end
	
	
	elseif (activeWeapon == "tomahawkRight") then

		if(isAttackOne == 33) then
			if (v.soundOn == 1) then
				audio.play(a.tomahawkMix1, 6)
			end
			tomahawkAmmo = tomahawkAmmo - 1
			writeScreenAmmo(tomahawkAmmo)			

			leftArmGroup.rotation = leftArmGroup.rotation - 25
			torsoGroup.rotation = torsoGroup.rotation - .75
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 32) then
			leftArmGroup.rotation = leftArmGroup.rotation - 25
			torsoGroup.rotation = torsoGroup.rotation - .75
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 31) then
			leftArmGroup.rotation = leftArmGroup.rotation - 25
			torsoGroup.rotation = torsoGroup.rotation - .75
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 30) then
			leftArmGroup.rotation = leftArmGroup.rotation + 25
			torsoGroup.rotation = torsoGroup.rotation + .75
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 29) then
			leftArmGroup.rotation = leftArmGroup.rotation + 25
			torsoGroup.rotation = torsoGroup.rotation + .75
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 28) then
			leftArmGroup.rotation = leftArmGroup.rotation + 25
			torsoGroup.rotation = torsoGroup.rotation + .75

			g.tomahawkLeft.isVisible = false
			
			g.tomahawkLeftDouble.rotation = 0
			g.tomahawkLeftDouble.x = myGuy.x
			g.tomahawkLeftDouble.y = myGuy.y - 20
			
			tomahawkLeftDoubleDirection = myGuy.xScale
			
			g.tomahawkLeftDouble.rotation =  g.tomahawkLeftDouble.rotation + 60 * tomahawkLeftDoubleDirection
			g.tomahawkLeftDouble.x = g.tomahawkLeftDouble.x + 50 * tomahawkLeftDoubleDirection
			
			g.tomahawkLeftDouble.isVisible = true
					
			isAttackOne = isAttackOne - 1

			if (g.tomahawkLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("tomahawkLeftStart")
			end
			
		elseif(isAttackOne == 27) then
			g.tomahawkLeftDouble.rotation =  g.tomahawkLeftDouble.rotation + 60 * tomahawkLeftDoubleDirection
			g.tomahawkLeftDouble.x = g.tomahawkLeftDouble.x + 45 * tomahawkLeftDoubleDirection
		
			isAttackOne = isAttackOne - 1
			if (g.tomahawkLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("tomahawkLeftStart")
			else
				weaponMeetOtherGuy("tomahawkLeftFinish")
			end			
		elseif(isAttackOne == 26) then
			g.tomahawkLeftDouble.rotation =  g.tomahawkLeftDouble.rotation + 60 * tomahawkLeftDoubleDirection
			g.tomahawkLeftDouble.x = g.tomahawkLeftDouble.x + 45 * tomahawkLeftDoubleDirection

			isAttackOne = isAttackOne - 1
			if (g.tomahawkLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("tomahawkLeftStart")
			else
				weaponMeetOtherGuy("tomahawkLeftFinish")
			end			
		elseif(isAttackOne == 25) then
			g.tomahawkLeftDouble.rotation =  g.tomahawkLeftDouble.rotation + 60 * tomahawkLeftDoubleDirection
			g.tomahawkLeftDouble.x = g.tomahawkLeftDouble.x + 45 * tomahawkLeftDoubleDirection

			isAttackOne = isAttackOne - 1
			if (g.tomahawkLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("tomahawkLeftStart")
			else
				weaponMeetOtherGuy("tomahawkLeftFinish")
			end			
		elseif(isAttackOne == 24) then
			g.tomahawkLeftDouble.rotation =  g.tomahawkLeftDouble.rotation + 60 * tomahawkLeftDoubleDirection
			g.tomahawkLeftDouble.x = g.tomahawkLeftDouble.x + 45 * tomahawkLeftDoubleDirection

			isAttackOne = isAttackOne - 1
			if (g.tomahawkLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("tomahawkLeftStart")
			else
				weaponMeetOtherGuy("tomahawkLeftFinish")
			end			
		elseif(isAttackOne == 23) then
			g.tomahawkLeftDouble.rotation =  g.tomahawkLeftDouble.rotation + 60 * tomahawkLeftDoubleDirection
			g.tomahawkLeftDouble.x = g.tomahawkLeftDouble.x + 45 * tomahawkLeftDoubleDirection
			
			isAttackOne = isAttackOne - 1
			if (g.tomahawkLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("tomahawkLeftStart")
			else
				weaponMeetOtherGuy("tomahawkLeftFinish")
			end			
		elseif(isAttackOne == 22) then
			g.tomahawkLeftDouble.rotation =  g.tomahawkLeftDouble.rotation + 60 * tomahawkLeftDoubleDirection
			g.tomahawkLeftDouble.x = g.tomahawkLeftDouble.x + 45 * tomahawkLeftDoubleDirection
			
			isAttackOne = isAttackOne - 1
			if (g.tomahawkLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("tomahawkLeftStart")
			else
				weaponMeetOtherGuy("tomahawkLeftFinish")
			end			
		elseif(isAttackOne == 21) then
	
			g.tomahawkLeftDouble.isVisible = false
			if (v.playerHealth > 0) then
				g.tomahawkLeft.isVisible = true
			end
						
			if(tomahawkAmmo == 1) then
				isWeaponsChange = 1
				v.changeWeaponTo = "tomahawkLeft"
				
				if (v.moveIntoTent ~= 1) then
					g.tomahawkLeft.isVisible = false
				end
				
			end
			
			v.weaponMeetCounterOne = 1
			weaponMeetOtherGuy("tomahawkLeftFinish")			
			
			isAttackOne = 1
			
		end

	
	
		if(isAttackTwo == 33) then
				if (v.soundOn == 1) then
					audio.play(a.tomahawkMix1, 6)
				end
				tomahawkAmmo = tomahawkAmmo - 1
				writeScreenAmmo(tomahawkAmmo)			

				rightArmGroup.rotation = rightArmGroup.rotation - 25
				torsoGroup.rotation = torsoGroup.rotation - .75
				isAttackTwo = isAttackTwo - 1
			elseif(isAttackTwo == 32) then
				rightArmGroup.rotation = rightArmGroup.rotation - 25
				torsoGroup.rotation = torsoGroup.rotation - .75
				isAttackTwo = isAttackTwo - 1
			elseif(isAttackTwo == 31) then
				rightArmGroup.rotation = rightArmGroup.rotation - 25
				torsoGroup.rotation = torsoGroup.rotation - .75
				isAttackTwo = isAttackTwo - 1
			elseif(isAttackTwo == 30) then
				rightArmGroup.rotation = rightArmGroup.rotation + 25
				torsoGroup.rotation = torsoGroup.rotation + .75
				isAttackTwo = isAttackTwo - 1
			elseif(isAttackTwo == 29) then
				rightArmGroup.rotation = rightArmGroup.rotation + 25
				torsoGroup.rotation = torsoGroup.rotation + .75
				isAttackTwo = isAttackTwo - 1
			elseif(isAttackTwo == 28) then
				rightArmGroup.rotation = rightArmGroup.rotation + 25
				torsoGroup.rotation = torsoGroup.rotation + .75

				g.tomahawkRight.isVisible = false
				
				g.tomahawkRightDouble.rotation = 0
				g.tomahawkRightDouble.x = myGuy.x - 20
				g.tomahawkRightDouble.y = myGuy.y - 20
				
				tomahawkRightDoubleDirection = myGuy.xScale
				
				g.tomahawkRightDouble.rotation =  g.tomahawkRightDouble.rotation + 60 * tomahawkRightDoubleDirection
				g.tomahawkRightDouble.x = g.tomahawkRightDouble.x + 50 * tomahawkRightDoubleDirection
				
				g.tomahawkRightDouble.isVisible = true
						
				isAttackTwo = isAttackTwo - 1
				
				if (g.tomahawkRightDouble.isVisible == true) then
					weaponMeetOtherGuy("tomahawkRightStart")
				end
				
			elseif(isAttackTwo == 27) then
				g.tomahawkRightDouble.rotation =  g.tomahawkRightDouble.rotation + 60 * tomahawkRightDoubleDirection
				g.tomahawkRightDouble.x = g.tomahawkRightDouble.x + 45 * tomahawkRightDoubleDirection
			
				isAttackTwo = isAttackTwo - 1
				if (g.tomahawkRightDouble.isVisible == true) then
					weaponMeetOtherGuy("tomahawkRightStart")
				else
					weaponMeetOtherGuy("tomahawkRightFinish")
				end
			elseif(isAttackTwo == 26) then
				g.tomahawkRightDouble.rotation =  g.tomahawkRightDouble.rotation + 60 * tomahawkRightDoubleDirection
				g.tomahawkRightDouble.x = g.tomahawkRightDouble.x + 45 * tomahawkRightDoubleDirection
			
				isAttackTwo = isAttackTwo - 1
				if (g.tomahawkRightDouble.isVisible == true) then
					weaponMeetOtherGuy("tomahawkRightStart")
				else
					weaponMeetOtherGuy("tomahawkRightFinish")
				end
			elseif(isAttackTwo == 25) then
				g.tomahawkRightDouble.rotation =  g.tomahawkRightDouble.rotation + 60 * tomahawkRightDoubleDirection
				g.tomahawkRightDouble.x = g.tomahawkRightDouble.x + 45 * tomahawkRightDoubleDirection
			
				isAttackTwo = isAttackTwo - 1
				if (g.tomahawkRightDouble.isVisible == true) then
					weaponMeetOtherGuy("tomahawkRightStart")
				else
					weaponMeetOtherGuy("tomahawkRightFinish")
				end
			elseif(isAttackTwo == 24) then
				g.tomahawkRightDouble.rotation =  g.tomahawkRightDouble.rotation + 60 * tomahawkRightDoubleDirection
				g.tomahawkRightDouble.x = g.tomahawkRightDouble.x + 45 * tomahawkRightDoubleDirection
			
				isAttackTwo = isAttackTwo - 1
				if (g.tomahawkRightDouble.isVisible == true) then
					weaponMeetOtherGuy("tomahawkRightStart")
				else
					weaponMeetOtherGuy("tomahawkRightFinish")
				end
			elseif(isAttackTwo == 23) then
				g.tomahawkRightDouble.rotation =  g.tomahawkRightDouble.rotation + 60 * tomahawkRightDoubleDirection
				g.tomahawkRightDouble.x = g.tomahawkRightDouble.x + 45 * tomahawkRightDoubleDirection
			
				isAttackTwo = isAttackTwo - 1
				if (g.tomahawkRightDouble.isVisible == true) then
					weaponMeetOtherGuy("tomahawkRightStart")
				else
					weaponMeetOtherGuy("tomahawkRightFinish")
				end
			elseif(isAttackTwo == 22) then
				g.tomahawkRightDouble.rotation =  g.tomahawkRightDouble.rotation + 60 * tomahawkRightDoubleDirection
				g.tomahawkRightDouble.x = g.tomahawkRightDouble.x + 45 * tomahawkRightDoubleDirection
			
				isAttackTwo = isAttackTwo - 1
				if (g.tomahawkRightDouble.isVisible == true) then
					weaponMeetOtherGuy("tomahawkRightStart")
				else
					weaponMeetOtherGuy("tomahawkRightFinish")
				end
			elseif(isAttackTwo == 21) then
			
				g.tomahawkRightDouble.isVisible = false
				if (v.playerHealth > 0) then
					g.tomahawkRight.isVisible = true
				end
								
				if(tomahawkAmmo == 1) then
					isWeaponsChange = 1
					v.changeWeaponTo = "tomahawkLeft"

					if (v.moveIntoTent ~= 1) then
						g.tomahawkRight.isVisible = false
					end
					
				end				
				v.weaponMeetCounterTwo = 1
				weaponMeetOtherGuy("tomahawkRightFinish")			
				
				isAttackTwo = 1

			end
	
	
	elseif (activeWeapon == "knifeRight") then

		if(isAttackOne == 33) then
			if (v.soundOn == 1) then
				audio.play(a.knifeMix1, 6)
			end
			knifeAmmo = knifeAmmo - 1
			writeScreenAmmo(knifeAmmo)			
	
			leftArmGroup.rotation = leftArmGroup.rotation - 25
			torsoGroup.rotation = torsoGroup.rotation - .75
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 32) then
			leftArmGroup.rotation = leftArmGroup.rotation - 25
			torsoGroup.rotation = torsoGroup.rotation - .75
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 31) then
			leftArmGroup.rotation = leftArmGroup.rotation - 25
			torsoGroup.rotation = torsoGroup.rotation - .75
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 30) then
			leftArmGroup.rotation = leftArmGroup.rotation + 25
			torsoGroup.rotation = torsoGroup.rotation + .75
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 29) then
			leftArmGroup.rotation = leftArmGroup.rotation + 25
			torsoGroup.rotation = torsoGroup.rotation + .75
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 28) then
			leftArmGroup.rotation = leftArmGroup.rotation + 25
			torsoGroup.rotation = torsoGroup.rotation + .75

			g.knifeLeft.isVisible = false
			
			g.knifeLeftDouble.rotation = 0
			g.knifeLeftDouble.x = myGuy.x
			g.knifeLeftDouble.y = myGuy.y - 20
			
			knifeLeftDoubleDirection = myGuy.xScale
			
			g.knifeLeftDouble.rotation =  g.knifeLeftDouble.rotation + 60 * knifeLeftDoubleDirection
			g.knifeLeftDouble.x = g.knifeLeftDouble.x + 50 * knifeLeftDoubleDirection
			
			g.knifeLeftDouble.isVisible = true
					
			isAttackOne = isAttackOne - 1

			if (g.knifeLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("knifeLeftStart")
			end			
			
		elseif(isAttackOne == 27) then
			g.knifeLeftDouble.rotation =  g.knifeLeftDouble.rotation + 60 * knifeLeftDoubleDirection
			g.knifeLeftDouble.x = g.knifeLeftDouble.x + 45 * knifeLeftDoubleDirection
		
			isAttackOne = isAttackOne - 1
			if (g.knifeLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("knifeLeftStart")
			else
				weaponMeetOtherGuy("knifeLeftFinish")
			end			
		elseif(isAttackOne == 26) then
			g.knifeLeftDouble.rotation =  g.knifeLeftDouble.rotation + 60 * knifeLeftDoubleDirection
			g.knifeLeftDouble.x = g.knifeLeftDouble.x + 45 * knifeLeftDoubleDirection
			
			isAttackOne = isAttackOne - 1
			if (g.knifeLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("knifeLeftStart")
			else
				weaponMeetOtherGuy("knifeLeftFinish")
			end			
		elseif(isAttackOne == 25) then
			g.knifeLeftDouble.rotation =  g.knifeLeftDouble.rotation + 60 * knifeLeftDoubleDirection
			g.knifeLeftDouble.x = g.knifeLeftDouble.x + 45 * knifeLeftDoubleDirection
			
			isAttackOne = isAttackOne - 1
			if (g.knifeLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("knifeLeftStart")
			else
				weaponMeetOtherGuy("knifeLeftFinish")
			end			
		elseif(isAttackOne == 24) then
			g.knifeLeftDouble.rotation =  g.knifeLeftDouble.rotation + 60 * knifeLeftDoubleDirection
			g.knifeLeftDouble.x = g.knifeLeftDouble.x + 45 * knifeLeftDoubleDirection
			
			isAttackOne = isAttackOne - 1
			if (g.knifeLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("knifeLeftStart")
			else
				weaponMeetOtherGuy("knifeLeftFinish")
			end			
		elseif(isAttackOne == 23) then
			g.knifeLeftDouble.rotation =  g.knifeLeftDouble.rotation + 60 * knifeLeftDoubleDirection
			g.knifeLeftDouble.x = g.knifeLeftDouble.x + 45 * knifeLeftDoubleDirection
			
			isAttackOne = isAttackOne - 1
			if (g.knifeLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("knifeLeftStart")
			else
				weaponMeetOtherGuy("knifeLeftFinish")
			end			
		elseif(isAttackOne == 22) then
			g.knifeLeftDouble.rotation =  g.knifeLeftDouble.rotation + 60 * knifeLeftDoubleDirection
			g.knifeLeftDouble.x = g.knifeLeftDouble.x + 45 * knifeLeftDoubleDirection
			
			isAttackOne = isAttackOne - 1
			if (g.knifeLeftDouble.isVisible == true) then
				weaponMeetOtherGuy("knifeLeftStart")
			else
				weaponMeetOtherGuy("knifeLeftFinish")
			end			
		elseif(isAttackOne == 21) then

			g.knifeLeftDouble.isVisible = false
			if (v.playerHealth > 0) then
				g.knifeLeft.isVisible = true
			end
			
			if(knifeAmmo == 1) then
				isWeaponsChange = 1
				v.changeWeaponTo = "knifeLeft"
				
				if (v.moveIntoTent ~= 1) then
					g.knifeLeft.isVisible = false
				end
			end
			
			v.weaponMeetCounterOne = 1
			weaponMeetOtherGuy("knifeLeftFinish")				
			
			isAttackOne = 1	
			
		end
	

		
		if(isAttackTwo == 33) then
				if (v.soundOn == 1) then
					audio.play(a.knifeMix1, 6)
				end
				knifeAmmo = knifeAmmo - 1
				writeScreenAmmo(knifeAmmo)			
		
				rightArmGroup.rotation = rightArmGroup.rotation - 25
				torsoGroup.rotation = torsoGroup.rotation - .75
				isAttackTwo = isAttackTwo - 1
			elseif(isAttackTwo == 32) then
				rightArmGroup.rotation = rightArmGroup.rotation - 25
				torsoGroup.rotation = torsoGroup.rotation - .75
				isAttackTwo = isAttackTwo - 1
			elseif(isAttackTwo == 31) then
				rightArmGroup.rotation = rightArmGroup.rotation - 25
				torsoGroup.rotation = torsoGroup.rotation - .75
				isAttackTwo = isAttackTwo - 1
			elseif(isAttackTwo == 30) then
				rightArmGroup.rotation = rightArmGroup.rotation + 25
				torsoGroup.rotation = torsoGroup.rotation + .75
				isAttackTwo = isAttackTwo - 1
			elseif(isAttackTwo == 29) then
				rightArmGroup.rotation = rightArmGroup.rotation + 25
				torsoGroup.rotation = torsoGroup.rotation + .75
				isAttackTwo = isAttackTwo - 1
			elseif(isAttackTwo == 28) then
				rightArmGroup.rotation = rightArmGroup.rotation + 25
				torsoGroup.rotation = torsoGroup.rotation + .75

				g.knifeRight.isVisible = false
				
				g.knifeRightDouble.rotation = 0
				g.knifeRightDouble.x = myGuy.x - 20
				g.knifeRightDouble.y = myGuy.y - 20
				
				knifeRightDoubleDirection = myGuy.xScale
				
				g.knifeRightDouble.rotation =  g.knifeRightDouble.rotation + 60 * knifeRightDoubleDirection
				g.knifeRightDouble.x = g.knifeRightDouble.x + 50 * knifeRightDoubleDirection
				
				g.knifeRightDouble.isVisible = true
						
				isAttackTwo = isAttackTwo - 1
				
				if (g.knifeRightDouble.isVisible == true) then
					weaponMeetOtherGuy("knifeRightStart")
				end
				
			elseif(isAttackTwo == 27) then
				g.knifeRightDouble.rotation =  g.knifeRightDouble.rotation + 60 * knifeRightDoubleDirection
				g.knifeRightDouble.x = g.knifeRightDouble.x + 45 * knifeRightDoubleDirection
			
				isAttackTwo = isAttackTwo - 1
				if (g.knifeRightDouble.isVisible == true) then
					weaponMeetOtherGuy("knifeRightStart")
				else
					weaponMeetOtherGuy("knifeRightFinish")
				end			
			elseif(isAttackTwo == 26) then
				g.knifeRightDouble.rotation =  g.knifeRightDouble.rotation + 60 * knifeRightDoubleDirection
				g.knifeRightDouble.x = g.knifeRightDouble.x + 45 * knifeRightDoubleDirection
			
				isAttackTwo = isAttackTwo - 1
				if (g.knifeRightDouble.isVisible == true) then
					weaponMeetOtherGuy("knifeRightStart")
				else
					weaponMeetOtherGuy("knifeRightFinish")
				end			
			elseif(isAttackTwo == 25) then
				g.knifeRightDouble.rotation =  g.knifeRightDouble.rotation + 60 * knifeRightDoubleDirection
				g.knifeRightDouble.x = g.knifeRightDouble.x + 45 * knifeRightDoubleDirection
			
				isAttackTwo = isAttackTwo - 1
				if (g.knifeRightDouble.isVisible == true) then
					weaponMeetOtherGuy("knifeRightStart")
				else
					weaponMeetOtherGuy("knifeRightFinish")
				end			
			elseif(isAttackTwo == 24) then
				g.knifeRightDouble.rotation =  g.knifeRightDouble.rotation + 60 * knifeRightDoubleDirection
				g.knifeRightDouble.x = g.knifeRightDouble.x + 45 * knifeRightDoubleDirection
			
				isAttackTwo = isAttackTwo - 1
				if (g.knifeRightDouble.isVisible == true) then
					weaponMeetOtherGuy("knifeRightStart")
				else
					weaponMeetOtherGuy("knifeRightFinish")
				end			
			elseif(isAttackTwo == 23) then
				g.knifeRightDouble.rotation =  g.knifeRightDouble.rotation + 60 * knifeRightDoubleDirection
				g.knifeRightDouble.x = g.knifeRightDouble.x + 45 * knifeRightDoubleDirection
			
				isAttackTwo = isAttackTwo - 1
				if (g.knifeRightDouble.isVisible == true) then
					weaponMeetOtherGuy("knifeRightStart")
				else
					weaponMeetOtherGuy("knifeRightFinish")
				end			
			elseif(isAttackTwo == 22) then
				g.knifeRightDouble.rotation =  g.knifeRightDouble.rotation + 60 * knifeRightDoubleDirection
				g.knifeRightDouble.x = g.knifeRightDouble.x + 45 * knifeRightDoubleDirection
			
				isAttackTwo = isAttackTwo - 1
				if (g.knifeRightDouble.isVisible == true) then
					weaponMeetOtherGuy("knifeRightStart")
				else
					weaponMeetOtherGuy("knifeRightFinish")
				end			
			elseif(isAttackTwo == 21) then
				
				g.knifeRightDouble.isVisible = false
				if (v.playerHealth > 0) then
					g.knifeRight.isVisible = true
				end
								
				if(knifeAmmo == 1) then
					isWeaponsChange = 1
					v.changeWeaponTo = "knifeLeft"
					
					if (v.moveIntoTent ~= 1) then
						g.knifeRight.isVisible = false
					end
					
				end

				v.weaponMeetCounterTwo = 1
				weaponMeetOtherGuy("knifeRightFinish")				
				
				isAttackTwo = 1		
				
			end
	
		
	
	elseif (activeWeapon == "pistolRight") then

		if(isAttackOne == 33) then
			if (v.soundOn == 1) then
				audio.play(a.pistolShot1, 6)
			end
			pistolAmmo = pistolAmmo - 1
			writeScreenAmmo(pistolAmmo)			
		
			leftArmGroup.rotation = leftArmGroup.rotation - 15
			leftArmGroup.x = leftArmGroup.x - 0
			torsoGroup.rotation = torsoGroup.rotation - 2
			
			moveBody("head", 0, 0, 2)

			--head.rotation = head.rotation + 2
			
			gunSmokeDirection = myGuy.xScale
			gunSmoke01.xScale = gunSmokeDirection
			
			gunSmoke01.rotation = 0
			if (g.pistol1Left.isVisible == true) then
				gunSmoke01.x, gunSmoke01.y = g.pistol1LeftDot:localToContent(0, 0)
				gunSmoke01.x = gunSmoke01.x + 22 * gunSmokeDirection
			elseif (g.pistol2Left.isVisible == true) then
				gunSmoke01.x, gunSmoke01.y = g.pistol2LeftDot:localToContent(0, 0)
				gunSmoke01.x = gunSmoke01.x + 22 * gunSmokeDirection
			elseif (g.pistol3Left.isVisible == true) then
				gunSmoke01.x, gunSmoke01.y = g.pistol3LeftDot:localToContent(0, 0)
				gunSmoke01.x = gunSmoke01.x + 22 * gunSmokeDirection		
			elseif (g.pistolGoldLeft.isVisible == true) then
				gunSmoke01.x, gunSmoke01.y = g.pistolGoldLeftDot:localToContent(0, 0)
				gunSmoke01.x = gunSmoke01.x + 22 * gunSmokeDirection						
			else
				gunSmoke01.x = 1000
				gunSmoke01.y = 1000
			end
			
			gunSmoke01.isVisible = true
			isAttackOne = isAttackOne - 1
			if (m1.inShotRange == 1 and m1.playerHealth > 0) then
				if (g.pistolGoldLeft.isPurchased == 1) then
					m1.playerHurt = 110
				elseif (g.pistol3Left.isPurchased == 1) then
					m1.playerHurt = 100
				elseif (g.pistol2Left.isPurchased == 1) then
					m1.playerHurt = 90
				elseif (g.pistol1Left.isPurchased == 1) then
					m1.playerHurt = 80
				end
				m1.playerHealth = m1.playerHealth - m1.playerHurt
				m1.torsoGroup.rotation = m1.torsoGroup.rotation - 4
				m1.myGuy.x = m1.myGuy.x - 3 * m1.myGuy.xScale
				m1.splash01.isVisible = true
			elseif (m2.inShotRange == 1 and m2.playerHealth > 0) then
				if (g.pistolGoldLeft.isPurchased == 1) then
					m2.playerHurt = 110
				elseif (g.pistol3Left.isPurchased == 1) then
					m2.playerHurt = 100
				elseif (g.pistol2Left.isPurchased == 1) then
					m2.playerHurt = 90
				elseif (g.pistol1Left.isPurchased == 1) then
					m2.playerHurt = 80
				end
				m2.playerHealth = m2.playerHealth - m2.playerHurt
				m2.torsoGroup.rotation = m2.torsoGroup.rotation - 4
				m2.myGuy.x = m2.myGuy.x - 3 * m2.myGuy.xScale
				m2.splash01.isVisible = true
			elseif (m3.inShotRange == 1 and m3.playerHealth > 0) then
				if (g.pistolGoldLeft.isPurchased == 1) then
					m3.playerHurt = 110
				elseif (g.pistol3Left.isPurchased == 1) then
					m3.playerHurt = 100
				elseif (g.pistol2Left.isPurchased == 1) then
					m3.playerHurt = 90
				elseif (g.pistol1Left.isPurchased == 1) then
					m3.playerHurt = 80
				end
				m3.playerHealth = m3.playerHealth - m3.playerHurt
				m3.torsoGroup.rotation = m3.torsoGroup.rotation - 4
				m3.myGuy.x = m3.myGuy.x - 3 * m3.myGuy.xScale
				m3.splash01.isVisible = true
			end
		elseif(isAttackOne == 32) then
		
			leftArmGroup.rotation = leftArmGroup.rotation + 0
			leftArmGroup.x = leftArmGroup.x - 1
			torsoGroup.rotation = torsoGroup.rotation - 2
			
			moveBody("head", 0, 0, 2)
			
			--head.rotation = head.rotation + 2
			
			gunSmoke01.isVisible = false
			
			gunSmoke02.xScale = gunSmokeDirection
			
			gunSmoke02.rotation = 0

			if (g.pistol1Left.isVisible == true) then
				gunSmoke02.x, gunSmoke02.y = g.pistol1LeftDot:localToContent(0, 0)
				gunSmoke02.x = gunSmoke02.x + 25 * gunSmokeDirection
			elseif (g.pistol2Left.isVisible == true) then
				gunSmoke02.x, gunSmoke02.y = g.pistol2LeftDot:localToContent(0, 0)
				gunSmoke02.x = gunSmoke02.x + 25 * gunSmokeDirection			
			elseif (g.pistol3Left.isVisible == true) then
				gunSmoke02.x, gunSmoke02.y = g.pistol3LeftDot:localToContent(0, 0)
				gunSmoke02.x = gunSmoke02.x + 25 * gunSmokeDirection						
			elseif (g.pistolGoldLeft.isVisible == true) then
				gunSmoke02.x, gunSmoke02.y = g.pistolGoldLeftDot:localToContent(0, 0)
				gunSmoke02.x = gunSmoke02.x + 25 * gunSmokeDirection						
			else
				gunSmoke02.x = 1000
				gunSmoke02.y = 1000
			end
			
			gunSmoke02.isVisible = true
			
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 31) then
			leftArmGroup.rotation = leftArmGroup.rotation + 0
			leftArmGroup.x = leftArmGroup.x - 1
			torsoGroup.rotation = torsoGroup.rotation - 2
			
			moveBody("head", 0, 0, 2)
			
			--head.rotation = head.rotation + 2
			
			gunSmoke02.isVisible = false
			
			gunSmoke03.xScale = gunSmokeDirection
			
			gunSmoke03.rotation = 0

			if (g.pistol1Left.isVisible == true) then
				gunSmoke03.x, gunSmoke03.y = g.pistol1LeftDot:localToContent(0, 0)
				gunSmoke03.x = gunSmoke03.x + 27 * gunSmokeDirection
			elseif (g.pistol2Left.isVisible == true) then
				gunSmoke03.x, gunSmoke03.y = g.pistol2LeftDot:localToContent(0, 0)
				gunSmoke03.x = gunSmoke03.x + 27 * gunSmokeDirection			
			elseif (g.pistol3Left.isVisible == true) then
				gunSmoke03.x, gunSmoke03.y = g.pistol3LeftDot:localToContent(0, 0)
				gunSmoke03.x = gunSmoke03.x + 27 * gunSmokeDirection						
			elseif (g.pistolGoldLeft.isVisible == true) then
				gunSmoke03.x, gunSmoke03.y = g.pistolGoldLeftDot:localToContent(0, 0)
				gunSmoke03.x = gunSmoke03.x + 27 * gunSmokeDirection						
			else
				gunSmoke03.x = 1000
				gunSmoke03.y = 1000
			end

			gunSmoke03.isVisible = true
			
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 30) then
			leftArmGroup.rotation = leftArmGroup.rotation + 0
			leftArmGroup.x = leftArmGroup.x + .5
			torsoGroup.rotation = torsoGroup.rotation + 2
			
			moveBody("head", 0, 0, -2)
			
			--head.rotation = head.rotation - 2
			
			gunSmoke03.isVisible = false
			
			isAttackOne = isAttackOne - 1
			if (m1.playerHurt > 0) then
				m1.playerHurt = 0
				m1.torsoGroup.rotation = m1.torsoGroup.rotation + 4
				if (m1.playerHealth > 0) then
					m1.splash01.isVisible = false
				end
			end
			if (m2.playerHurt > 0) then
				m2.playerHurt = 0
				m2.torsoGroup.rotation = m2.torsoGroup.rotation + 4
				if (m2.playerHealth > 0) then
					m2.splash01.isVisible = false
				end
			end
			if (m3.playerHurt > 0) then
				m3.playerHurt = 0
				m3.torsoGroup.rotation = m3.torsoGroup.rotation + 4
				if (m3.playerHealth > 0) then
					m3.splash01.isVisible = false
				end
			end		
		elseif(isAttackOne == 29) then
			leftArmGroup.rotation = leftArmGroup.rotation + 8
			leftArmGroup.x = leftArmGroup.x + .5
			torsoGroup.rotation = torsoGroup.rotation + 2
			
			moveBody("head", 0, 0, -2)
			
			--head.rotation = head.rotation - 2
			
			isAttackOne = isAttackOne - 1
		
		elseif(isAttackOne == 28) then
			leftArmGroup.rotation = leftArmGroup.rotation + 7
			leftArmGroup.x = leftArmGroup.x + 1
			torsoGroup.rotation = torsoGroup.rotation + 2
			
			moveBody("head", 0, 0, -2)
			
			--head.rotation = head.rotation - 2

			if (g.pistolGoldLeft.isPurchased == 1) then
				isAttackOne = 12
			else
				isAttackOne = isAttackOne - 1
			end
		elseif(isAttackOne == 27) then
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 26) then
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 25) then
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 24) then
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 23) then
			if (g.pistol3Left.isPurchased == 1) then
				isAttackOne = 12
			else
				isAttackOne = isAttackOne - 1
			end
		elseif(isAttackOne == 22) then
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 21) then
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 20) then
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 19) then
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 18) then
			if (g.pistol2Left.isPurchased == 1) then
				isAttackOne = 12
			else
				isAttackOne = isAttackOne - 1
			end
		elseif(isAttackOne == 17) then
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 16) then
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 15) then
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 14) then
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 13) then
			isAttackOne = isAttackOne - 1

		elseif(isAttackOne == 12) then
			
			if(pistolAmmo == 0) then
				isWeaponsChange = 2
			end
		
			isAttackOne = 1		
		end

		
		if(isAttackTwo == 33) then
			if (v.soundOn == 1) then
				audio.play(a.pistolShot1, 6)
			end
			pistolAmmo = pistolAmmo - 1
			writeScreenAmmo(pistolAmmo)			
		
			rightArmGroup.rotation = rightArmGroup.rotation - 15
			rightArmGroup.x = rightArmGroup.x - 0
			torsoGroup.rotation = torsoGroup.rotation - 2
			
			moveBody("head", 0, 0, 2)
			
			--head.rotation = head.rotation + 2
			
			gunSmokeDirection = myGuy.xScale
			gunSmoke01.xScale = gunSmokeDirection
			
			gunSmoke01.rotation = 0

			if (g.pistol1Left.isVisible == true) then
				gunSmoke01.x, gunSmoke01.y = g.pistol1RightDot:localToContent(0, 0)
				gunSmoke01.x = gunSmoke01.x + 22 * gunSmokeDirection
			elseif (g.pistol2Left.isVisible == true) then
				gunSmoke01.x, gunSmoke01.y = g.pistol2RightDot:localToContent(0, 0)
				gunSmoke01.x = gunSmoke01.x + 22 * gunSmokeDirection			
			elseif (g.pistol3Left.isVisible == true) then
				gunSmoke01.x, gunSmoke01.y = g.pistol3RightDot:localToContent(0, 0)
				gunSmoke01.x = gunSmoke01.x + 22 * gunSmokeDirection						
			elseif (g.pistolGoldLeft.isVisible == true) then
				gunSmoke01.x, gunSmoke01.y = g.pistolGoldRightDot:localToContent(0, 0)
				gunSmoke01.x = gunSmoke01.x + 22 * gunSmokeDirection						
			else
				gunSmoke01.x = 1000
				gunSmoke01.y = 1000
			end
			
			gunSmoke01.isVisible = true
			
			isAttackTwo = isAttackTwo - 1
			if (m1.inShotRange == 1 and m1.playerHealth > 0) then
				if (g.pistolGoldLeft.isPurchased == 1) then
					m1.playerHurt = 110
				elseif (g.pistol3Left.isPurchased == 1) then
					m1.playerHurt = 100
				elseif (g.pistol2Left.isPurchased == 1) then
					m1.playerHurt = 90
				elseif (g.pistol1Left.isPurchased == 1) then
					m1.playerHurt = 80
				end
				m1.playerHealth = m1.playerHealth - m1.playerHurt
				m1.torsoGroup.rotation = m1.torsoGroup.rotation - 4
				m1.myGuy.x = m1.myGuy.x - 3 * m1.myGuy.xScale
				m1.splash01.isVisible = true
			elseif (m2.inShotRange == 1 and m2.playerHealth > 0) then
				if (g.pistolGoldLeft.isPurchased == 1) then
					m2.playerHurt = 110
				elseif (g.pistol3Left.isPurchased == 1) then
					m2.playerHurt = 100
				elseif (g.pistol2Left.isPurchased == 1) then
					m2.playerHurt = 90
				elseif (g.pistol1Left.isPurchased == 1) then
					m2.playerHurt = 80
				end
				m2.playerHealth = m2.playerHealth - m2.playerHurt
				m2.torsoGroup.rotation = m2.torsoGroup.rotation - 4
				m2.myGuy.x = m2.myGuy.x - 3 * m2.myGuy.xScale
				m2.splash01.isVisible = true
			elseif (m3.inShotRange == 1 and m3.playerHealth > 0) then
				if (g.pistolGoldLeft.isPurchased == 1) then
					m3.playerHurt = 110
				elseif (g.pistol3Left.isPurchased == 1) then
					m3.playerHurt = 100
				elseif (g.pistol2Left.isPurchased == 1) then
					m3.playerHurt = 90
				elseif (g.pistol1Left.isPurchased == 1) then
					m3.playerHurt = 80
				end
				m3.playerHealth = m3.playerHealth - m3.playerHurt
				m3.torsoGroup.rotation = m3.torsoGroup.rotation - 4
				m3.myGuy.x = m3.myGuy.x - 3 * m3.myGuy.xScale
				m3.splash01.isVisible = true
			end
		elseif(isAttackTwo == 32) then
			rightArmGroup.rotation = rightArmGroup.rotation + 0
			rightArmGroup.x = rightArmGroup.x - 1
			torsoGroup.rotation = torsoGroup.rotation - 2
			
			moveBody("head", 0, 0, 2)
			
			--head.rotation = head.rotation + 2
			
			gunSmoke01.isVisible = false
			
			gunSmoke02.xScale = gunSmokeDirection
			
			gunSmoke02.rotation = 0

			if (g.pistol1Left.isVisible == true) then
				gunSmoke02.x, gunSmoke02.y = g.pistol1RightDot:localToContent(0, 0)
				gunSmoke02.x = gunSmoke02.x + 25 * gunSmokeDirection
			elseif (g.pistol2Left.isVisible == true) then
				gunSmoke02.x, gunSmoke02.y = g.pistol2RightDot:localToContent(0, 0)
				gunSmoke02.x = gunSmoke02.x + 25 * gunSmokeDirection			
			elseif (g.pistol3Left.isVisible == true) then
				gunSmoke02.x, gunSmoke02.y = g.pistol3RightDot:localToContent(0, 0)
				gunSmoke02.x = gunSmoke02.x + 25 * gunSmokeDirection						
			elseif (g.pistolGoldLeft.isVisible == true) then
				gunSmoke02.x, gunSmoke02.y = g.pistolGoldRightDot:localToContent(0, 0)
				gunSmoke02.x = gunSmoke02.x + 25 * gunSmokeDirection						
			else
				gunSmoke02.x = 1000
				gunSmoke02.y = 1000
			end
			
			gunSmoke02.isVisible = true
				
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 31) then
			rightArmGroup.rotation = rightArmGroup.rotation + 0
			rightArmGroup.x = rightArmGroup.x - 1
			torsoGroup.rotation = torsoGroup.rotation - 2
			
			moveBody("head", 0, 0, 2)
			
			--head.rotation = head.rotation + 2
			
			gunSmoke02.isVisible = false
			
			gunSmoke03.xScale = gunSmokeDirection
			
			gunSmoke03.rotation = 0
			
			if (g.pistol1Left.isVisible == true) then
				gunSmoke03.x, gunSmoke03.y = g.pistol1RightDot:localToContent(0, 0)
				gunSmoke03.x = gunSmoke03.x + 27 * gunSmokeDirection
			elseif (g.pistol2Left.isVisible == true) then
				gunSmoke03.x, gunSmoke03.y = g.pistol2RightDot:localToContent(0, 0)
				gunSmoke03.x = gunSmoke03.x + 27 * gunSmokeDirection			
			elseif (g.pistol3Left.isVisible == true) then
				gunSmoke03.x, gunSmoke03.y = g.pistol3RightDot:localToContent(0, 0)
				gunSmoke03.x = gunSmoke03.x + 27 * gunSmokeDirection						
			elseif (g.pistolGoldLeft.isVisible == true) then
				gunSmoke03.x, gunSmoke03.y = g.pistolGoldRightDot:localToContent(0, 0)
				gunSmoke03.x = gunSmoke03.x + 27 * gunSmokeDirection						
			else
				gunSmoke03.x = 1000
				gunSmoke03.y = 1000
			end
			
			gunSmoke03.isVisible = true
						
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 30) then
			rightArmGroup.rotation = rightArmGroup.rotation + 0
			rightArmGroup.x = rightArmGroup.x + .5
			torsoGroup.rotation = torsoGroup.rotation + 2
			
			moveBody("head", 0, 0, -2)
			
			--head.rotation = head.rotation - 2
			
			gunSmoke03.isVisible = false
			
			isAttackTwo = isAttackTwo - 1
			if (m1.playerHurt > 0) then
				m1.playerHurt = 0
				m1.torsoGroup.rotation = m1.torsoGroup.rotation + 4
				if (m1.playerHealth > 0) then
					m1.splash01.isVisible = false
				end
			end
			if (m2.playerHurt > 0) then
				m2.playerHurt = 0
				m2.torsoGroup.rotation = m2.torsoGroup.rotation + 4
				if (m2.playerHealth > 0) then
					m2.splash01.isVisible = false
				end
			end
			if (m3.playerHurt > 0) then
				m3.playerHurt = 0
				m3.torsoGroup.rotation = m3.torsoGroup.rotation + 4
				if (m3.playerHealth > 0) then
					m3.splash01.isVisible = false
				end
			end		
		elseif(isAttackTwo == 29) then
			rightArmGroup.rotation = rightArmGroup.rotation + 8
			rightArmGroup.x = rightArmGroup.x + .5
			torsoGroup.rotation = torsoGroup.rotation + 2
			
			moveBody("head", 0, 0, -2)
			
			--head.rotation = head.rotation - 2
			
			isAttackTwo = isAttackTwo - 1

		elseif(isAttackTwo == 28) then
			rightArmGroup.rotation = rightArmGroup.rotation + 7
			rightArmGroup.x = rightArmGroup.x + 1
			torsoGroup.rotation = torsoGroup.rotation + 2
			
			moveBody("head", 0, 0, -2)
			
			--head.rotation = head.rotation - 2

			if (g.pistolGoldLeft.isPurchased == 1) then
				isAttackTwo = 12
			else
				isAttackTwo = isAttackTwo - 1
			end
		elseif(isAttackTwo == 27) then
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 26) then
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 25) then
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 24) then
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 23) then
			if (g.pistol3Left.isPurchased == 1) then
				isAttackTwo = 12
			else
				isAttackTwo = isAttackTwo - 1
			end
		elseif(isAttackTwo == 22) then
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 21) then
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 20) then
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 19) then
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 18) then
			if (g.pistol2Left.isPurchased == 1) then
				isAttackTwo = 12
			else
				isAttackTwo = isAttackTwo - 1
			end
		elseif(isAttackTwo == 17) then
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 16) then
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 15) then
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 14) then
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 13) then
			isAttackTwo = isAttackTwo - 1
			
		elseif(isAttackTwo == 12) then
						
			if(pistolAmmo == 0) then
				isWeaponsChange = 2
			end
		
			isAttackTwo = 1		
		end
	
	
	elseif (activeWeapon == "rifleRight") then
		
		if(isAttackOne == 33) then
			if (v.soundOn == 1) then
				audio.play(a.rifleShot1, 6)
			end
			rifleAmmo = rifleAmmo  - 1
			writeScreenAmmo(rifleAmmo)			
		
			leftArmGroup.rotation = leftArmGroup.rotation - 15
			leftArmGroup.x = leftArmGroup.x - 0
			torsoGroup.rotation = torsoGroup.rotation - 2
			
			moveBody("head", 0, 0, 2)
			
			--head.rotation = head.rotation + 2
			
			gunSmokeDirection = myGuy.xScale
			gunSmoke01.xScale = gunSmokeDirection
			
			gunSmoke01.rotation = 0
			if (g.rifle1Left.isVisible == true) then
				gunSmoke01.x, gunSmoke01.y = g.rifle1LeftDot:localToContent(0, 0)
				gunSmoke01.x = gunSmoke01.x + 22 * gunSmokeDirection
			elseif (g.rifle2Left.isVisible == true) then
				gunSmoke01.x, gunSmoke01.y = g.rifle2LeftDot:localToContent(0, 0)
				gunSmoke01.x = gunSmoke01.x + 22 * gunSmokeDirection
			elseif (g.rifle3Left.isVisible == true) then
				gunSmoke01.x, gunSmoke01.y = g.rifle3LeftDot:localToContent(0, 0)
				gunSmoke01.x = gunSmoke01.x + 22 * gunSmokeDirection		
			elseif (g.rifleGoldLeft.isVisible == true) then
				gunSmoke01.x, gunSmoke01.y = g.rifleGoldLeftDot:localToContent(0, 0)
				gunSmoke01.x = gunSmoke01.x + 22 * gunSmokeDirection						
			else
				gunSmoke01.x = 1000
				gunSmoke01.y = 1000
			end
			
			gunSmoke01.isVisible = true
			
			isAttackOne = isAttackOne - 1
			if (m1.inShotRange == 1 and m1.playerHealth > 0) then
				if (g.rifleGoldLeft.isPurchased == 1) then
					m1.playerHurt = 120
				elseif (g.rifle3Left.isPurchased == 1) then
					m1.playerHurt = 110
				elseif (g.rifle2Left.isPurchased == 1) then
					m1.playerHurt = 100
				elseif (g.rifle1Left.isPurchased == 1) then
					m1.playerHurt = 90
				end
				m1.playerHealth = m1.playerHealth - m1.playerHurt
				m1.torsoGroup.rotation = m1.torsoGroup.rotation - 4
				m1.myGuy.x = m1.myGuy.x - 3 * m1.myGuy.xScale
				m1.splash01.isVisible = true
			elseif (m2.inShotRange == 1 and m2.playerHealth > 0) then
				if (g.rifleGoldLeft.isPurchased == 1) then
					m2.playerHurt = 120
				elseif (g.rifle3Left.isPurchased == 1) then
					m2.playerHurt = 110
				elseif (g.rifle2Left.isPurchased == 1) then
					m2.playerHurt = 100
				elseif (g.rifle1Left.isPurchased == 1) then
					m2.playerHurt = 90
				end
				m2.playerHealth = m2.playerHealth - m2.playerHurt
				m2.torsoGroup.rotation = m2.torsoGroup.rotation - 4
				m2.myGuy.x = m2.myGuy.x - 3 * m2.myGuy.xScale
				m2.splash01.isVisible = true
			elseif (m3.inShotRange == 1 and m3.playerHealth > 0) then
				if (g.rifleGoldLeft.isPurchased == 1) then
					m3.playerHurt = 120
				elseif (g.rifle3Left.isPurchased == 1) then
					m3.playerHurt = 110
				elseif (g.rifle2Left.isPurchased == 1) then
					m3.playerHurt = 100
				elseif (g.rifle1Left.isPurchased == 1) then
					m3.playerHurt = 90
				end
				m3.playerHealth = m3.playerHealth - m3.playerHurt
				m3.torsoGroup.rotation = m3.torsoGroup.rotation - 4
				m3.myGuy.x = m3.myGuy.x - 3 * m3.myGuy.xScale
				m3.splash01.isVisible = true
			end
		elseif(isAttackOne == 32) then
			leftArmGroup.rotation = leftArmGroup.rotation + 0
			leftArmGroup.x = leftArmGroup.x - 1
			torsoGroup.rotation = torsoGroup.rotation - 2
			
			moveBody("head", 0, 0, 2)
			
			--head.rotation = head.rotation + 2
			
			gunSmoke01.isVisible = false
			
			gunSmoke02.xScale = gunSmokeDirection
			
			gunSmoke02.rotation = 0
			
			if (g.rifle1Left.isVisible == true) then
				gunSmoke02.x, gunSmoke02.y = g.rifle1LeftDot:localToContent(0, 0)
				gunSmoke02.x = gunSmoke02.x + 25 * gunSmokeDirection
			elseif (g.rifle2Left.isVisible == true) then
				gunSmoke02.x, gunSmoke02.y = g.rifle2LeftDot:localToContent(0, 0)
				gunSmoke02.x = gunSmoke02.x + 25 * gunSmokeDirection			
			elseif (g.rifle3Left.isVisible == true) then
				gunSmoke02.x, gunSmoke02.y = g.rifle3LeftDot:localToContent(0, 0)
				gunSmoke02.x = gunSmoke02.x + 25 * gunSmokeDirection						
			elseif (g.rifleGoldLeft.isVisible == true) then
				gunSmoke02.x, gunSmoke02.y = g.rifleGoldLeftDot:localToContent(0, 0)
				gunSmoke02.x = gunSmoke02.x + 25 * gunSmokeDirection						
			else
				gunSmoke02.x = 1000
				gunSmoke02.y = 1000
			end
			
			gunSmoke02.isVisible = true
			
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 31) then
			leftArmGroup.rotation = leftArmGroup.rotation + 0
			leftArmGroup.x = leftArmGroup.x - 1
			torsoGroup.rotation = torsoGroup.rotation - 2
			
			moveBody("head", 0, 0, 2)
			
			--head.rotation = head.rotation + 2
			
			gunSmoke02.isVisible = false
			
			gunSmoke03.xScale = gunSmokeDirection
			
			gunSmoke03.rotation = 0

			if (g.rifle1Left.isVisible == true) then
				gunSmoke03.x, gunSmoke03.y = g.rifle1LeftDot:localToContent(0, 0)
				gunSmoke03.x = gunSmoke03.x + 27 * gunSmokeDirection
			elseif (g.rifle2Left.isVisible == true) then
				gunSmoke03.x, gunSmoke03.y = g.rifle2LeftDot:localToContent(0, 0)
				gunSmoke03.x = gunSmoke03.x + 27 * gunSmokeDirection			
			elseif (g.rifle3Left.isVisible == true) then
				gunSmoke03.x, gunSmoke03.y = g.rifle3LeftDot:localToContent(0, 0)
				gunSmoke03.x = gunSmoke03.x + 27 * gunSmokeDirection						
			elseif (g.rifleGoldLeft.isVisible == true) then
				gunSmoke03.x, gunSmoke03.y = g.rifleGoldLeftDot:localToContent(0, 0)
				gunSmoke03.x = gunSmoke03.x + 27 * gunSmokeDirection						
			else
				gunSmoke03.x = 1000
				gunSmoke03.y = 1000
			end
			
			gunSmoke03.isVisible = true
			
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 30) then
			leftArmGroup.rotation = leftArmGroup.rotation + 0
			leftArmGroup.x = leftArmGroup.x + .5
			torsoGroup.rotation = torsoGroup.rotation + 2
			
			moveBody("head", 0, 0, -2)
			
			--head.rotation = head.rotation - 2
			
			gunSmoke03.isVisible = false
			
			isAttackOne = isAttackOne - 1
			if (m1.playerHurt > 0) then
				m1.playerHurt = 0
				m1.torsoGroup.rotation = m1.torsoGroup.rotation + 4
				if (m1.playerHealth > 0) then
					m1.splash01.isVisible = false
				end
			end
			if (m2.playerHurt > 0) then
				m2.playerHurt = 0
				m2.torsoGroup.rotation = m2.torsoGroup.rotation + 4
				if (m2.playerHealth > 0) then
					m2.splash01.isVisible = false
				end
			end
			if (m3.playerHurt > 0) then
				m3.playerHurt = 0
				m3.torsoGroup.rotation = m3.torsoGroup.rotation + 4
				if (m3.playerHealth > 0) then
					m3.splash01.isVisible = false
				end
			end
		elseif(isAttackOne == 29) then
			leftArmGroup.rotation = leftArmGroup.rotation + 8
			leftArmGroup.x = leftArmGroup.x + .5
			torsoGroup.rotation = torsoGroup.rotation + 2
			
			moveBody("head", 0, 0, -2)
			
			--head.rotation = head.rotation - 2
			
			isAttackOne = isAttackOne - 1

		elseif(isAttackOne == 28) then
			leftArmGroup.rotation = leftArmGroup.rotation + 7
			leftArmGroup.x = leftArmGroup.x + 1
			torsoGroup.rotation = torsoGroup.rotation + 2
			
			moveBody("head", 0, 0, -2)
			
			--head.rotation = head.rotation - 2

			if (g.rifleGoldLeft.isPurchased == 1) then
				isAttackOne = 12
			else
				isAttackOne = isAttackOne - 1
			end
		elseif(isAttackOne == 27) then
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 26) then
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 25) then
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 24) then
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 23) then
			if (g.rifle3Left.isPurchased == 1) then
				isAttackOne = 12
			else
				isAttackOne = isAttackOne - 1
			end
		elseif(isAttackOne == 22) then
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 21) then
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 20) then
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 19) then
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 18) then
			if (g.rifle2Left.isPurchased == 1) then
				isAttackOne = 12
			else
				isAttackOne = isAttackOne - 1
			end
		elseif(isAttackOne == 17) then
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 16) then
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 15) then
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 14) then
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 13) then
			isAttackOne = isAttackOne - 1
			
		elseif(isAttackOne == 12) then
		
			if(rifleAmmo == 0) then
				isWeaponsChange = 2
			end
						
			isAttackOne = 1
		end
	
	
		if(isAttackTwo == 33) then
			if (v.soundOn == 1) then
				audio.play(a.rifleShot1, 6)
			end
			rifleAmmo = rifleAmmo - 1
			writeScreenAmmo(rifleAmmo)			
		
			rightArmGroup.rotation = rightArmGroup.rotation - 15
			rightArmGroup.x = rightArmGroup.x - 0
			torsoGroup.rotation = torsoGroup.rotation - 2
			
			moveBody("head", 0, 0, 2)
			
			--head.rotation = head.rotation + 2
			
			gunSmokeDirection = myGuy.xScale
			gunSmoke01.xScale = gunSmokeDirection
			
			gunSmoke01.rotation = 0
			
			if (g.rifle1Left.isVisible == true) then
				gunSmoke01.x, gunSmoke01.y = g.rifle1RightDot:localToContent(0, 0)
				gunSmoke01.x = gunSmoke01.x + 22 * gunSmokeDirection
			elseif (g.rifle2Left.isVisible == true) then
				gunSmoke01.x, gunSmoke01.y = g.rifle2RightDot:localToContent(0, 0)
				gunSmoke01.x = gunSmoke01.x + 22 * gunSmokeDirection			
			elseif (g.rifle3Left.isVisible == true) then
				gunSmoke01.x, gunSmoke01.y = g.rifle3RightDot:localToContent(0, 0)
				gunSmoke01.x = gunSmoke01.x + 22 * gunSmokeDirection						
			elseif (g.rifleGoldLeft.isVisible == true) then
				gunSmoke01.x, gunSmoke01.y = g.rifleGoldRightDot:localToContent(0, 0)
				gunSmoke01.x = gunSmoke01.x + 22 * gunSmokeDirection						
			else
				gunSmoke01.x = 1000
				gunSmoke01.y = 1000
			end
			
			gunSmoke01.isVisible = true
			
			isAttackTwo = isAttackTwo - 1
			if (m1.inShotRange == 1 and m1.playerHealth > 0) then
				if (g.rifleGoldLeft.isPurchased == 1) then
					m1.playerHurt = 120
				elseif (g.rifle3Left.isPurchased == 1) then
					m1.playerHurt = 110
				elseif (g.rifle2Left.isPurchased == 1) then
					m1.playerHurt = 100
				elseif (g.rifle1Left.isPurchased == 1) then
					m1.playerHurt = 90
				end
				m1.playerHealth = m1.playerHealth - m1.playerHurt
				m1.torsoGroup.rotation = m1.torsoGroup.rotation - 4
				m1.myGuy.x = m1.myGuy.x - 3 * m1.myGuy.xScale
				m1.splash01.isVisible = true
			elseif (m2.inShotRange == 1 and m2.playerHealth > 0) then
				if (g.rifleGoldLeft.isPurchased == 1) then
					m2.playerHurt = 120
				elseif (g.rifle3Left.isPurchased == 1) then
					m2.playerHurt = 110
				elseif (g.rifle2Left.isPurchased == 1) then
					m2.playerHurt = 100
				elseif (g.rifle1Left.isPurchased == 1) then
					m2.playerHurt = 90
				end
				m2.playerHealth = m2.playerHealth - m2.playerHurt
				m2.torsoGroup.rotation = m2.torsoGroup.rotation - 4
				m2.myGuy.x = m2.myGuy.x - 3 * m2.myGuy.xScale
				m2.splash01.isVisible = true
			elseif (m3.inShotRange == 1 and m3.playerHealth > 0) then
				if (g.rifleGoldLeft.isPurchased == 1) then
					m3.playerHurt = 120
				elseif (g.rifle3Left.isPurchased == 1) then
					m3.playerHurt = 110
				elseif (g.rifle2Left.isPurchased == 1) then
					m3.playerHurt = 100
				elseif (g.rifle1Left.isPurchased == 1) then
					m3.playerHurt = 90
				end
				m3.playerHealth = m3.playerHealth - m3.playerHurt
				m3.torsoGroup.rotation = m3.torsoGroup.rotation - 4
				m3.myGuy.x = m3.myGuy.x - 3 * m3.myGuy.xScale
				m3.splash01.isVisible = true
			end
		elseif(isAttackTwo == 32) then
			rightArmGroup.rotation = rightArmGroup.rotation + 0
			rightArmGroup.x = rightArmGroup.x - 1
			torsoGroup.rotation = torsoGroup.rotation - 2
			
			moveBody("head", 0, 0, 2)
			
			--head.rotation = head.rotation + 2
			
			gunSmoke01.isVisible = false
			
			gunSmoke02.xScale = gunSmokeDirection
			
			gunSmoke02.rotation = 0
			
			if (g.rifle1Left.isVisible == true) then
				gunSmoke02.x, gunSmoke02.y = g.rifle1RightDot:localToContent(0, 0)
				gunSmoke02.x = gunSmoke02.x + 25 * gunSmokeDirection
			elseif (g.rifle2Left.isVisible == true) then
				gunSmoke02.x, gunSmoke02.y = g.rifle2RightDot:localToContent(0, 0)
				gunSmoke02.x = gunSmoke02.x + 25 * gunSmokeDirection			
			elseif (g.rifle3Left.isVisible == true) then
				gunSmoke02.x, gunSmoke02.y = g.rifle3RightDot:localToContent(0, 0)
				gunSmoke02.x = gunSmoke02.x + 25 * gunSmokeDirection						
			elseif (g.rifleGoldLeft.isVisible == true) then
				gunSmoke02.x, gunSmoke02.y = g.rifleGoldRightDot:localToContent(0, 0)
				gunSmoke02.x = gunSmoke02.x + 25 * gunSmokeDirection						
			else
				gunSmoke02.x = 1000
				gunSmoke02.y = 1000
			end
		
			gunSmoke02.isVisible = true
			
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 31) then
			rightArmGroup.rotation = rightArmGroup.rotation + 0
			rightArmGroup.x = rightArmGroup.x - 1
			torsoGroup.rotation = torsoGroup.rotation - 2
			
			moveBody("head", 0, 0, 2)
			
			--head.rotation = head.rotation + 2
			
			gunSmoke02.isVisible = false
			
			gunSmoke03.xScale = gunSmokeDirection
			
			gunSmoke03.rotation = 0
			
			if (g.rifle1Left.isVisible == true) then
				gunSmoke03.x, gunSmoke03.y = g.rifle1RightDot:localToContent(0, 0)
				gunSmoke03.x = gunSmoke03.x + 27 * gunSmokeDirection
			elseif (g.rifle2Left.isVisible == true) then
				gunSmoke03.x, gunSmoke03.y = g.rifle2RightDot:localToContent(0, 0)
				gunSmoke03.x = gunSmoke03.x + 27 * gunSmokeDirection			
			elseif (g.rifle3Left.isVisible == true) then
				gunSmoke03.x, gunSmoke03.y = g.rifle3RightDot:localToContent(0, 0)
				gunSmoke03.x = gunSmoke03.x + 27 * gunSmokeDirection						
			elseif (g.rifleGoldLeft.isVisible == true) then
				gunSmoke03.x, gunSmoke03.y = g.rifleGoldRightDot:localToContent(0, 0)
				gunSmoke03.x = gunSmoke03.x + 27 * gunSmokeDirection						
			else
				gunSmoke03.x = 1000
				gunSmoke03.y = 1000
			end
			
			gunSmoke03.isVisible = true
			
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 30) then
			rightArmGroup.rotation = rightArmGroup.rotation + 0
			rightArmGroup.x = rightArmGroup.x + .5
			torsoGroup.rotation = torsoGroup.rotation + 2
			
			moveBody("head", 0, 0, -2)
			
			--head.rotation = head.rotation - 2
			
			gunSmoke03.isVisible = false
			
			isAttackTwo = isAttackTwo - 1
			if (m1.playerHurt > 0) then
				m1.playerHurt = 0
				m1.torsoGroup.rotation = m1.torsoGroup.rotation + 4
				if (m1.playerHealth > 0) then
					m1.splash01.isVisible = false
				end
			end
			if (m2.playerHurt > 0) then
				m2.playerHurt = 0
				m2.torsoGroup.rotation = m2.torsoGroup.rotation + 4
				if (m2.playerHealth > 0) then
					m2.splash01.isVisible = false
				end
			end
			if (m3.playerHurt > 0) then
				m3.playerHurt = 0
				m3.torsoGroup.rotation = m3.torsoGroup.rotation + 4
				if (m3.playerHealth > 0) then
					m3.splash01.isVisible = false
				end
			end
		elseif(isAttackTwo == 29) then
			rightArmGroup.rotation = rightArmGroup.rotation + 8
			rightArmGroup.x = rightArmGroup.x + .5
			torsoGroup.rotation = torsoGroup.rotation + 2
			
			moveBody("head", 0, 0, -2)
			
			--head.rotation = head.rotation - 2
			
			isAttackTwo = isAttackTwo - 1
			
		elseif(isAttackTwo == 28) then
			rightArmGroup.rotation = rightArmGroup.rotation + 7
			rightArmGroup.x = rightArmGroup.x + 1
			torsoGroup.rotation = torsoGroup.rotation + 2
			
			moveBody("head", 0, 0, -2)
			
			--head.rotation = head.rotation - 2

			if (g.rifleGoldLeft.isPurchased == 1) then
				isAttackTwo = 12
			else
				isAttackTwo = isAttackTwo - 1
			end
		elseif(isAttackTwo == 27) then
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 26) then
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 25) then
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 24) then
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 23) then
			if (g.rifle3Left.isPurchased == 1) then
				isAttackTwo = 12
			else
				isAttackTwo = isAttackTwo - 1
			end
		elseif(isAttackTwo == 22) then
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 21) then
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 20) then
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 19) then
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 18) then
			if (g.rifle2Left.isPurchased == 1) then
				isAttackTwo = 12
			else
				isAttackTwo = isAttackTwo - 1
			end
		elseif(isAttackTwo == 17) then
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 16) then
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 15) then
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 14) then
			isAttackTwo = isAttackTwo - 1
		elseif(isAttackTwo == 13) then
			isAttackTwo = isAttackTwo - 1
			
		elseif(isAttackTwo == 12) then
		
			if(rifleAmmo == 0) then
				isWeaponsChange = 2
			end
						
			isAttackTwo = 1
		end
	
			
	elseif (activeWeapon == "crossbow") then

		if(isAttackOne == 33) then
			if (v.soundOn == 1) then
				audio.play(a.crossbowMix1, 6)
			end
			crossbowAmmo = crossbowAmmo - 1
			writeScreenAmmo(crossbowAmmo)			
		
			leftArmGroup.rotation = leftArmGroup.rotation - 15
			leftArmGroup.x = leftArmGroup.x - 0
		
						
			isAttackOne = isAttackOne - 1
		elseif(isAttackOne == 32) then
			leftArmGroup.rotation = leftArmGroup.rotation + 0
			
			crossbowArrowDirection = myGuy.xScale
			g.arrowDouble.xScale = crossbowArrowDirection
			
			g.arrow.isVisible = false
			g.crossbowStringPulled.isVisible = false
			g.crossbowStringRelaxed.isVisible = true
			
			g.arrowDouble.rotation = 0
			g.arrowDouble.x = myGuy.x
			g.arrowDouble.y = myGuy.y - 20
			
			g.arrowDouble.x = g.arrowDouble.x + 80 * crossbowArrowDirection
						
			g.arrowDouble.isVisible = true
													
			isAttackOne = isAttackOne - 1
			
			if (g.arrowDouble.isVisible == true) then
				weaponMeetOtherGuy("arrowStart")
			end			
		elseif(isAttackOne == 31) then
			leftArmGroup.rotation = leftArmGroup.rotation + 0
			
			g.arrowDouble.x = g.arrowDouble.x + 75 * crossbowArrowDirection
			
			isAttackOne = isAttackOne - 1
			if (g.arrowDouble.isVisible == true) then
				weaponMeetOtherGuy("arrowStart")
			else
				weaponMeetOtherGuy("arrowFinish")
			end
		elseif(isAttackOne == 30) then
			leftArmGroup.rotation = leftArmGroup.rotation + 8
			
			g.arrowDouble.x = g.arrowDouble.x + 75 * crossbowArrowDirection
			
			isAttackOne = isAttackOne - 1
			if (g.arrowDouble.isVisible == true) then
				weaponMeetOtherGuy("arrowStart")
			else
				weaponMeetOtherGuy("arrowFinish")
			end
		elseif(isAttackOne == 29) then
			leftArmGroup.rotation = leftArmGroup.rotation + 7
			
			g.arrowDouble.x = g.arrowDouble.x + 75 * crossbowArrowDirection
			
			isAttackOne = isAttackOne - 1
			if (g.arrowDouble.isVisible == true) then
				weaponMeetOtherGuy("arrowStart")
			else
				weaponMeetOtherGuy("arrowFinish")
			end
	
		elseif(isAttackOne == 28) then
			
			if(crossbowAmmo == 0) then
				isWeaponsChange = 2
			end
			
			if (v.playerHealth > 0 and crossbowAmmo > 0) then
				g.arrow.isVisible = true
				g.crossbowStringPulled.isVisible = true
				g.crossbowStringRelaxed.isVisible = false
			end
			
			g.arrowDouble.isVisible = false
		
			v.weaponMeetCounterOne = 1
			weaponMeetOtherGuy("arrowFinish")
			
			isAttackOne = 1
			
		end
	
	elseif (activeWeapon == "granade") then

		if(isAttackFour == 33) then
			if (v.soundOn == 1) then
				audio.play(a.swingMix1, 6)
			end
			writeScreenAmmo(granadeAmmo)			
			granadeAmmo = granadeAmmo - 1			
		
			leftArmGroup.rotation = leftArmGroup.rotation + 35
			rightArmGroup.rotation = rightArmGroup.rotation + 4
			torsoGroup.rotation = torsoGroup.rotation + .75
			isAttackFour = isAttackFour - 1
		elseif(isAttackFour == 32) then
			leftArmGroup.rotation = leftArmGroup.rotation + 35
			rightArmGroup.rotation = rightArmGroup.rotation + 4
			torsoGroup.rotation = torsoGroup.rotation + .75
			isAttackFour = isAttackFour - 1
		elseif(isAttackFour == 31) then
			leftArmGroup.rotation = leftArmGroup.rotation + 35
			rightArmGroup.rotation = rightArmGroup.rotation + 4
			torsoGroup.rotation = torsoGroup.rotation + .75
			isAttackFour = isAttackFour - 1
		elseif(isAttackFour == 30) then
			leftArmGroup.rotation = leftArmGroup.rotation - 35
			rightArmGroup.rotation = rightArmGroup.rotation - 4
			torsoGroup.rotation = torsoGroup.rotation - .75
			isAttackFour = isAttackFour - 1
		elseif(isAttackFour == 29) then
			leftArmGroup.rotation = leftArmGroup.rotation - 35
			rightArmGroup.rotation = rightArmGroup.rotation - 4
			torsoGroup.rotation = torsoGroup.rotation - .75
			isAttackFour = isAttackFour - 1
		elseif(isAttackFour == 28) then
			leftArmGroup.rotation = leftArmGroup.rotation - 35
			rightArmGroup.rotation = rightArmGroup.rotation - 4
			torsoGroup.rotation = torsoGroup.rotation - .75

			g.granade.isVisible = false
			
			g.granadeDouble.rotation = 0
			g.granadeDouble.x = myGuy.x
			g.granadeDouble.y = myGuy.y - 30
			
			granadeDoubleDirection = myGuy.xScale
			
			g.granadeDouble.rotation =  g.granadeDouble.rotation + 60 * granadeDoubleDirection
			if (granadeDoubleDirection == 1) then
				g.granadeDouble.x = g.granadeDouble.x + 60 * granadeDoubleDirection
			else
				g.granadeDouble.x = g.granadeDouble.x + 90 * granadeDoubleDirection
			end
						
			g.granadeDouble.isVisible = true
					
			isAttackFour = isAttackFour - 1
			
			if (g.granadeDouble.isVisible == true) then
				weaponMeetOtherGuy("granadeStart")
			end			
			
			
		elseif(isAttackFour == 27) then
			g.granadeDouble.rotation =  g.granadeDouble.rotation + 20 * granadeDoubleDirection
			g.granadeDouble.x = g.granadeDouble.x + 36 * granadeDoubleDirection
					
			isAttackFour = isAttackFour - 1
			if (g.granadeDouble.isVisible == true) then
				weaponMeetOtherGuy("granadeStart")
			else
				weaponMeetOtherGuy("granadeFinish")
			end
		elseif(isAttackFour == 26) then
			g.granadeDouble.rotation =  g.granadeDouble.rotation +  20 * granadeDoubleDirection
			g.granadeDouble.x = g.granadeDouble.x + 36 * granadeDoubleDirection
						
			isAttackFour = isAttackFour - 1
			if (g.granadeDouble.isVisible == true) then
				weaponMeetOtherGuy("granadeStart")
			else
				weaponMeetOtherGuy("granadeFinish")
			end
		elseif(isAttackFour == 25) then
			g.granadeDouble.rotation =  g.granadeDouble.rotation + 20 * granadeDoubleDirection
			g.granadeDouble.x = g.granadeDouble.x + 36 * granadeDoubleDirection
						
			isAttackFour = isAttackFour - 1
			if (g.granadeDouble.isVisible == true) then
				weaponMeetOtherGuy("granadeStart")
			else
				weaponMeetOtherGuy("granadeFinish")
			end
		elseif(isAttackFour == 24) then
			g.granadeDouble.rotation =  g.granadeDouble.rotation + 20 * granadeDoubleDirection
			g.granadeDouble.x = g.granadeDouble.x + 36 * granadeDoubleDirection
						
			isAttackFour = isAttackFour - 1
			if (g.granadeDouble.isVisible == true) then
				weaponMeetOtherGuy("granadeStart")
			else
				weaponMeetOtherGuy("granadeFinish")
			end
		elseif(isAttackFour == 23) then
			g.granadeDouble.rotation =  g.granadeDouble.rotation + 20 * granadeDoubleDirection
			g.granadeDouble.x = g.granadeDouble.x + 36 * granadeDoubleDirection
			g.granadeDouble.y = g.granadeDouble.y + 2
			
			isAttackFour = isAttackFour - 1
			if (g.granadeDouble.isVisible == true) then
				weaponMeetOtherGuy("granadeStart")
			else
				weaponMeetOtherGuy("granadeFinish")
			end
		elseif(isAttackFour == 22) then
			g.granadeDouble.rotation =  g.granadeDouble.rotation + 20 * granadeDoubleDirection
			g.granadeDouble.x = g.granadeDouble.x + 36 * granadeDoubleDirection
			g.granadeDouble.y = g.granadeDouble.y + 2
			
			isAttackFour = isAttackFour - 1
			if (g.granadeDouble.isVisible == true) then
				weaponMeetOtherGuy("granadeStart")
			else
				weaponMeetOtherGuy("granadeFinish")
			end
		elseif(isAttackFour == 21) then
			g.granadeDouble.rotation =  g.granadeDouble.rotation + 20 * granadeDoubleDirection
			g.granadeDouble.x = g.granadeDouble.x + 36 * granadeDoubleDirection
			g.granadeDouble.y = g.granadeDouble.y + 3
			
			isAttackFour = isAttackFour - 1
			if (g.granadeDouble.isVisible == true) then
				weaponMeetOtherGuy("granadeStart")
			else
				weaponMeetOtherGuy("granadeFinish")
			end
		elseif(isAttackFour == 20) then
			g.granadeDouble.rotation =  g.granadeDouble.rotation + 20 * granadeDoubleDirection
			g.granadeDouble.x = g.granadeDouble.x + 36 * granadeDoubleDirection
			g.granadeDouble.y = g.granadeDouble.y + 4
			
			isAttackFour = isAttackFour - 1
			if (g.granadeDouble.isVisible == true) then
				weaponMeetOtherGuy("granadeStart")
			else
				weaponMeetOtherGuy("granadeFinish")
			end
		elseif(isAttackFour == 19) then
			g.granadeDouble.rotation =  g.granadeDouble.rotation + 20 * granadeDoubleDirection
			g.granadeDouble.x = g.granadeDouble.x + 36 * granadeDoubleDirection
			g.granadeDouble.y = g.granadeDouble.y + 4
			
			isAttackFour = isAttackFour - 1
			if (g.granadeDouble.isVisible == true) then
				weaponMeetOtherGuy("granadeStart")
			else
				weaponMeetOtherGuy("granadeFinish")
			end
		elseif(isAttackFour == 18) then
			
			g.granadeDouble.isVisible = false
			if (v.playerHealth > 0 and granadeAmmo > 0) then
				g.granade.isVisible = true
			end
						
			v.weaponMeetCounterOne = 1
			weaponMeetOtherGuy("granadeFinish")

			isAttackFour = 1

			isWeaponsChange = 1
			v.changeWeaponTo = v.changeWeaponFrom
			v.changeWeaponFrom = nil
			
			if(granadeAmmo == 0 and v.changeWeaponTo == "granade") then
				isWeaponsChange = 2
				v.changeWeaponTo = nil
			end			
			
		end
	
	end
	
end 


function otherGuysDoAttack(p)
	
	if (v.endOfLevel == 0) then
	
		if (p.activeWeapon == "sword" or p.activeWeapon == "battleAxe") then
			
			if(p.isAttackOne == 33) then
				if (v.soundOn == 1) then
					if (p == m1) then
						audio.play(a.swingMix2, 7)
					elseif (p == m2) then
						audio.play(a.swingMix3, 8)
					else
						audio.play(a.swingMix4, 9)
					end
				end
				p.leftArmGroup.rotation = p.leftArmGroup.rotation - 25
				p.torsoGroup.rotation = p.torsoGroup.rotation - .75
				p.isAttackOne = p.isAttackOne - 1
				p.sword.rotation = p.sword.rotation - 10
				p.battleAxe.rotation = p.battleAxe.rotation - 10
			elseif(p.isAttackOne == 32) then
				p.leftArmGroup.rotation = p.leftArmGroup.rotation + 25
				p.torsoGroup.rotation = p.torsoGroup.rotation - .75
				p.isAttackOne = p.isAttackOne - 1
				p.sword.rotation = p.sword.rotation + 10
				p.battleAxe.rotation = p.battleAxe.rotation + 10
				
				v.playerHurt = 2 * p.myGuy.xScale
				v.playerHealth = v.playerHealth - math.abs(v.playerHurt)
				updateHealthBar(v.playerHealth)
				v.myGuyHurtCounter = 3
											
			elseif(p.isAttackOne == 31) then
				p.leftArmGroup.rotation = p.leftArmGroup.rotation + 25
				p.torsoGroup.rotation = p.torsoGroup.rotation + .75
				p.isAttackOne = p.isAttackOne - 1
				p.sword.rotation = p.sword.rotation + 10
				p.battleAxe.rotation = p.battleAxe.rotation + 10
			elseif(p.isAttackOne == 30) then
				p.leftArmGroup.rotation = p.leftArmGroup.rotation + 25
				p.torsoGroup.rotation = p.torsoGroup.rotation + .75
				p.isAttackOne = p.isAttackOne - 1
				p.sword.rotation = p.sword.rotation + 10
				p.battleAxe.rotation = p.battleAxe.rotation + 10
			elseif(p.isAttackOne == 29) then
				p.leftArmGroup.rotation = p.leftArmGroup.rotation - 25
				p.torsoGroup.rotation = p.torsoGroup.rotation + .75
				p.isAttackOne = p.isAttackOne - 1
				p.sword.rotation = p.sword.rotation - 10
				p.battleAxe.rotation = p.battleAxe.rotation - 10
			elseif(p.isAttackOne == 28) then
				p.leftArmGroup.rotation = p.leftArmGroup.rotation - 25
				p.torsoGroup.rotation = p.torsoGroup.rotation - .75
				p.isAttackOne = p.isAttackOne - 1
				p.sword.rotation = p.sword.rotation - 10
				p.battleAxe.rotation = p.battleAxe.rotation - 10
			elseif(p.isAttackOne == 27) then			
				p.isAttackOne = p.isAttackOne - 1
			elseif(p.isAttackOne == 26) then			
				p.isAttackOne = p.isAttackOne - 1
			elseif(p.isAttackOne == 25) then			
				p.isAttackOne = p.isAttackOne - 1
			elseif(p.isAttackOne == 24) then			
				p.isAttackOne = 1			
			end
	
	
		elseif (p.activeWeapon == "alabard") then

			if(p.isAttackOne == 33) then
				if (v.soundOn == 1) then
					if (p == m1) then
						audio.play(a.alabardMix1, 7)
					elseif (p == m2) then
						audio.play(a.alabardMix1, 8)
					else
						audio.play(a.alabardMix1, 9)	
					end
				end
				p.leftArmGroup.rotation = p.leftArmGroup.rotation - 7
				p.leftArmGroup.x = p.leftArmGroup.x + .7
				p.torsoGroup.rotation = p.torsoGroup.rotation + 2
				p.isAttackOne = p.isAttackOne - 1
				p.alabard.rotation = p.alabard.rotation + 7
				p.alabard.x = p.alabard.x + 1
			elseif(p.isAttackOne == 32) then
				p.leftArmGroup.rotation = p.leftArmGroup.rotation - 7
				p.leftArmGroup.x = p.leftArmGroup.x + .7
				p.torsoGroup.rotation = p.torsoGroup.rotation + 2
				p.isAttackOne = p.isAttackOne - 1
				p.alabard.rotation = p.alabard.rotation + 7
				p.alabard.x = p.alabard.x + 1
				
				v.playerHurt = 2 * p.myGuy.xScale
				v.playerHealth = v.playerHealth - math.abs(v.playerHurt)
				updateHealthBar(v.playerHealth)
				v.myGuyHurtCounter = 3
								
			elseif(p.isAttackOne == 31) then
				p.leftArmGroup.rotation = p.leftArmGroup.rotation - 7
				p.leftArmGroup.x = p.leftArmGroup.x + .7
				p.torsoGroup.rotation = p.torsoGroup.rotation + 2
				p.isAttackOne = p.isAttackOne - 1
				p.alabard.rotation = p.alabard.rotation + 7
				p.alabard.x = p.alabard.x + 1
			elseif(p.isAttackOne == 30) then
				p.leftArmGroup.rotation = p.leftArmGroup.rotation + 7
				p.leftArmGroup.x = p.leftArmGroup.x - .7
				p.torsoGroup.rotation = p.torsoGroup.rotation - 2
				p.isAttackOne = p.isAttackOne - 1
				p.alabard.rotation = p.alabard.rotation - 7
				p.alabard.x = p.alabard.x - 1
			elseif(p.isAttackOne == 29) then
				p.leftArmGroup.rotation = p.leftArmGroup.rotation + 7
				p.leftArmGroup.x = p.leftArmGroup.x - .7
				p.torsoGroup.rotation = p.torsoGroup.rotation - 2
				p.isAttackOne = p.isAttackOne - 1
				p.alabard.rotation = p.alabard.rotation - 7
				p.alabard.x = p.alabard.x - 1
			elseif(p.isAttackOne == 28) then
				p.leftArmGroup.rotation = p.leftArmGroup.rotation + 7
				p.leftArmGroup.x = p.leftArmGroup.x - .7
				p.torsoGroup.rotation = p.torsoGroup.rotation - 2
				p.alabard.rotation = p.alabard.rotation - 7
				p.isAttackOne = p.isAttackOne - 1
				p.alabard.x = p.alabard.x - 1
			elseif(p.isAttackOne == 27) then			
				p.isAttackOne = p.isAttackOne - 1
			elseif(p.isAttackOne == 26) then			
				p.isAttackOne = p.isAttackOne - 1
			elseif(p.isAttackOne == 25) then			
				p.isAttackOne = p.isAttackOne - 1
			elseif(p.isAttackOne == 24) then			
				p.isAttackOne = p.isAttackOne - 1
			elseif(p.isAttackOne == 23) then			
				p.isAttackOne = p.isAttackOne - 1
			elseif(p.isAttackOne == 22) then			
				p.isAttackOne = p.isAttackOne - 1
			elseif(p.isAttackOne == 21) then			
				p.isAttackOne = 1
			end		
		
		elseif (p.activeWeapon == "pistol") then

			if(p.isAttackOne == 33) then
				if (v.soundOn == 1) then
					if (p == m1) then
						audio.play(a.pistolShot2, 7)
					elseif (p == m2) then
						audio.play(a.pistolShot3, 8)
					else
						audio.play(a.pistolShot4, 9)
					end
				end
				p.leftArmGroup.rotation = p.leftArmGroup.rotation - 15
				p.leftArmGroup.x = p.leftArmGroup.x - 0
				p.torsoGroup.rotation = p.torsoGroup.rotation - 2
				p.head.rotation = p.head.rotation + 2
				
				p.gunSmokeDirection = p.myGuy.xScale
				p.gunSmoke01.xScale = p.gunSmokeDirection
				
				p.gunSmoke01.rotation = 0
				p.gunSmoke01.x = p.myGuy.x + 97 * p.gunSmokeDirection
				p.gunSmoke01.y = p.myGuy.y - 18
				
				p.gunSmoke01.isVisible = true
				
				p.isAttackOne = p.isAttackOne - 1
				
				v.playerHurt = 1 * p.myGuy.xScale
				v.playerHealth = v.playerHealth - math.abs(v.playerHurt)
				updateHealthBar(v.playerHealth)
				v.myGuyHurtCounter = 3
								
			elseif(p.isAttackOne == 32) then
				p.leftArmGroup.rotation = p.leftArmGroup.rotation + 0
				p.leftArmGroup.x = p.leftArmGroup.x - 1
				p.torsoGroup.rotation = p.torsoGroup.rotation - 2
				p.head.rotation = p.head.rotation + 2
				
				p.gunSmoke01.isVisible = false
				
				p.gunSmoke02.xScale = p.gunSmokeDirection
				
				p.gunSmoke02.rotation = 0
				p.gunSmoke02.x = p.myGuy.x + 100 * p.gunSmokeDirection
				p.gunSmoke02.y = p.myGuy.y - 20
				
				p.gunSmoke02.isVisible = true
				
				p.isAttackOne = p.isAttackOne - 1
			elseif(p.isAttackOne == 31) then
				p.leftArmGroup.rotation = p.leftArmGroup.rotation + 0
				p.leftArmGroup.x = p.leftArmGroup.x - 1
				p.torsoGroup.rotation = p.torsoGroup.rotation - 2
				p.head.rotation = p.head.rotation + 2
				
				p.gunSmoke02.isVisible = false
				
				p.gunSmoke03.xScale = p.gunSmokeDirection
				
				p.gunSmoke03.rotation = 0
				p.gunSmoke03.x = p.myGuy.x + 98 * p.gunSmokeDirection
				p.gunSmoke03.y = p.myGuy.y - 18
				
				p.gunSmoke03.isVisible = true
							
				p.isAttackOne = p.isAttackOne - 1
			elseif(p.isAttackOne == 30) then
				p.leftArmGroup.rotation = p.leftArmGroup.rotation + 0
				p.leftArmGroup.x = p.leftArmGroup.x + .5
				p.torsoGroup.rotation = p.torsoGroup.rotation + 2
				p.head.rotation = p.head.rotation - 2
				
				p.gunSmoke03.isVisible = false
				
				p.isAttackOne = p.isAttackOne - 1
			elseif(p.isAttackOne == 29) then
				p.leftArmGroup.rotation = p.leftArmGroup.rotation + 8
				p.leftArmGroup.x = p.leftArmGroup.x + .5
				p.torsoGroup.rotation = p.torsoGroup.rotation + 2
				p.head.rotation = p.head.rotation - 2
				
				p.isAttackOne = p.isAttackOne - 1
			elseif(p.isAttackOne == 28) then
				p.leftArmGroup.rotation = p.leftArmGroup.rotation + 7
				p.leftArmGroup.x = p.leftArmGroup.x + 1
				p.torsoGroup.rotation = p.torsoGroup.rotation + 2
				p.head.rotation = p.head.rotation - 2
								
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 27) then
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 26) then
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 25) then
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 24) then
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 23) then
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 22) then
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 21) then
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 20) then
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 19) then
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 18) then
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 17) then
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 16) then
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 15) then
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 14) then
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 13) then
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 12) then
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 11) then
				p.isAttackOne = 1		
			end
		
		
		elseif (p.activeWeapon == "rifle") then

			if(p.isAttackOne == 33) then
				if (v.soundOn == 1) then
					if (p == m1) then
						audio.play(a.rifleShot2, 7)
					elseif (p == m2) then
						audio.play(a.rifleShot3, 8)
					else
						audio.play(a.rifleShot4, 9)
					end
				end
				p.leftArmGroup.rotation = p.leftArmGroup.rotation - 15
				p.leftArmGroup.x = p.leftArmGroup.x - 0
				p.torsoGroup.rotation = p.torsoGroup.rotation - 2
				p.head.rotation = p.head.rotation + 2
				
				p.gunSmokeDirection = p.myGuy.xScale
				p.gunSmoke01.xScale = p.gunSmokeDirection
				
				p.gunSmoke01.rotation = 0
				p.gunSmoke01.x = p.myGuy.x + 120 * p.gunSmokeDirection
				p.gunSmoke01.y = p.myGuy.y - 14
				
				p.gunSmoke01.isVisible = true
				
				p.isAttackOne = p.isAttackOne - 1
				
				v.playerHurt = 1 * p.myGuy.xScale
				v.playerHealth = v.playerHealth - math.abs(v.playerHurt)
				updateHealthBar(v.playerHealth)
				v.myGuyHurtCounter = 3
				
			elseif(p.isAttackOne == 32) then
				p.leftArmGroup.rotation = p.leftArmGroup.rotation + 0
				p.leftArmGroup.x = p.leftArmGroup.x - 1
				p.torsoGroup.rotation = p.torsoGroup.rotation - 2
				p.head.rotation = p.head.rotation + 2
				
				p.gunSmoke01.isVisible = false
				
				p.gunSmoke02.xScale = p.gunSmokeDirection
				
				p.gunSmoke02.rotation = 0
				p.gunSmoke02.x = p.myGuy.x + 123 * p.gunSmokeDirection
				p.gunSmoke02.y = p.myGuy.y - 20
				
				p.gunSmoke02.isVisible = true
				
				p.isAttackOne = p.isAttackOne - 1
			elseif(p.isAttackOne == 31) then
				p.leftArmGroup.rotation = p.leftArmGroup.rotation + 0
				p.leftArmGroup.x = p.leftArmGroup.x - 1
				p.torsoGroup.rotation = p.torsoGroup.rotation - 2
				p.head.rotation = p.head.rotation + 2
				
				p.gunSmoke02.isVisible = false
				
				p.gunSmoke03.xScale = p.gunSmokeDirection
				
				p.gunSmoke03.rotation = 0
				p.gunSmoke03.x = p.myGuy.x + 123 * p.gunSmokeDirection
				p.gunSmoke03.y = p.myGuy.y - 18
				
				p.gunSmoke03.isVisible = true
				
				p.isAttackOne = p.isAttackOne - 1
			elseif(p.isAttackOne == 30) then
				p.leftArmGroup.rotation = p.leftArmGroup.rotation + 0
				p.leftArmGroup.x = p.leftArmGroup.x + .5
				p.torsoGroup.rotation = p.torsoGroup.rotation + 2
				p.head.rotation = p.head.rotation - 2
				
				p.gunSmoke03.isVisible = false
				
				p.isAttackOne = p.isAttackOne - 1
			elseif(p.isAttackOne == 29) then
				p.leftArmGroup.rotation = p.leftArmGroup.rotation + 8
				p.leftArmGroup.x = p.leftArmGroup.x + .5
				p.torsoGroup.rotation = p.torsoGroup.rotation + 2
				p.head.rotation = p.head.rotation - 2
				
				p.isAttackOne = p.isAttackOne - 1
			elseif(p.isAttackOne == 28) then
			
				p.leftArmGroup.rotation = p.leftArmGroup.rotation + 7
				p.leftArmGroup.x = p.leftArmGroup.x + 1
				p.torsoGroup.rotation = p.torsoGroup.rotation + 2
				p.head.rotation = p.head.rotation - 2
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 27) then
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 26) then
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 25) then
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 24) then
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 23) then
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 22) then
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 21) then
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 20) then
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 19) then
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 18) then
				p.isAttackOne = p.isAttackOne - 1		
			elseif(p.isAttackOne == 17) then
				p.isAttackOne = 1
			end
		
		end
	
	end
	
end


function button(e)

	if(e.phase == "began") then
		if(e.x >= leftButton.x - 32 and e.x <= leftButton.x + 32 and e.y >= leftButton.y - 45 and e.y <= leftButton.y + 45) then
			leftButtonDown = 1
			rightButtonDown = 0
			eID = e.id
		end		
	end

	if(e.phase == "began") then
		if(e.x >= rightButton.x - 32 and e.x <= rightButton.x + 32 and e.y >= rightButton.y - 45 and e.y <= rightButton.y + 45) then
			rightButtonDown = 1
			leftButtonDown = 0
			eID = e.id
		end		
	end

		
	if(e.phase == "ended") then
		if(e.x >= leftButton.x - 32 and e.x <= leftButton.x + 32 and e.y >= leftButton.y - 45 and e.y <= leftButton.y + 45) then
			leftButtonDown = 0
		end
		
		if(e.x >= rightButton.x - 32 and e.x <= rightButton.x + 32 and e.y >= rightButton.y - 45 and e.y <= rightButton.y + 45) then
			rightButtonDown = 0
		end
		
		if (eID == e.id) then
			if(e.x > rightButton.x + 52 or e.y < leftButton.y - 65) then
				leftButtonDown = 0
				rightButtonDown = 0
			end
		end
		
	end

	if(e.phase == "moved") then
		
		if(e.x >= leftButton.x - 52 and e.x <= leftButton.x + 52 and e.y >= leftButton.y - 65 and e.y <= leftButton.y + 65) then
			leftButtonDown = 0
			rightButtonDown = 0
			
			eID = e.id
		end
		
		if(e.x >= leftButton.x - 32 and e.x <= leftButton.x + 32 and e.y >= leftButton.y - 45 and e.y <= leftButton.y + 45) then
			leftButtonDown = 1
			rightButtonDown = 0
			
		
		end
		
	end

	
	if(e.phase == "moved") then

		if(e.x >= rightButton.x - 52 and e.x <= rightButton.x + 52 and e.y >= rightButton.y - 65 and e.y <= rightButton.y + 65) then
			rightButtonDown = 0
			leftButtonDown = 0
		
			eID = e.id
		end		
	
		if(e.x >= rightButton.x - 32 and e.x <= rightButton.x + 32 and e.y >= rightButton.y - 45 and e.y <= rightButton.y + 45) then
			rightButtonDown = 1
			leftButtonDown = 0
			
		end	
		
			
	end
	
	
	if(e.phase == "cancelled") then
		rightButtonDown = 0
		leftButtonDown = 0
	end	
	
end


function playGameListener(e)
	
	if (e.phase == "began") then
		b.playEn.xScale = 1.2
		b.playEn.yScale = 1.2
		b.playSp.xScale = 1.2
		b.playSp.yScale = 1.2
		display.getCurrentStage():setFocus(e.target, e.id)
		if (v.soundOn == 1) then
			audio.play(a.clickSoundMenu, 12)
		end
	end
	
	if (e.phase == "ended") then
		activeScreen = "select colors"
		b.playEn.xScale = 1
		b.playEn.yScale = 1
		b.playSp.xScale = 1
		b.playSp.yScale = 1
		display.getCurrentStage():setFocus(e.target, nil)
		audio.stop(5) --finaleMusic
		audio.rewind(5)
		audio.setVolume( 1, { channel = 5 } )
	end
end


function yesButtonListener(e)
	
	--if (e.phase == "ended" and activeScreen == "menu") then
	--	os.exit()		
	--end

	if (e.phase == "began") then
		b.yesButtonEn.xScale = 1.2
		b.yesButtonEn.yScale = 1.2
		b.yesButtonSp.xScale = 1.2
		b.yesButtonSp.yScale = 1.2
		display.getCurrentStage():setFocus(e.target, e.id)
		
	end

	
	if (e.phase == "ended" and activeScreen == "game") then
		
		b.yesButtonEn.xScale = 1
		b.yesButtonEn.yScale = 1
		b.yesButtonSp.xScale = 1
		b.yesButtonSp.yScale = 1
		display.getCurrentStage():setFocus(e.target, nil)

		v.isPaused = false
		maskScreenDisplayGroup.isVisible = false
		menuMaskScreen.isVisible = false
		menuMaskScreen.alpha = 0
		b.returnToMenuEn.isVisible = false
		b.returnToMenuSp.isVisible = false
		b.yesButtonEn.isVisible = false
		b.yesButtonSp.isVisible = false
		b.noButton.isVisible = false
		activeScreen = "menu"
		
		pauseButton.xScale = 1
		pauseButton.yScale = 1
		
		audio.stop(1) --soundTrack
		audio.rewind(1)

		audio.stop(5) --finaleMusic
		audio.rewind(5)
		
		audio.stop(4) --deathMusic
		audio.rewind(4)
		
		if (v.changeWeaponFrom ~= nil) then
			activeWeapon = v.changeWeaponFrom
		end
		
		b.menuInCounter = 1
	end

end


function noButtonListener(e)

	if (e.phase == "began") then
		b.noButton.xScale = 1.2
		b.noButton.yScale = 1.2
		display.getCurrentStage():setFocus(e.target, e.id)
		
	end


	if (e.phase == "ended") then
		
		b.noButton.xScale = 1
		b.noButton.yScale = 1
		display.getCurrentStage():setFocus(e.target, nil)

		v.isPaused = false
		maskScreenDisplayGroup.isVisible = false
		menuMaskScreen.isVisible = false
		menuMaskScreen.alpha = 0
		b.returnToMenuEn.isVisible = false
		b.returnToMenuSp.isVisible = false
		--reallyWantToQuit.isVisible = false
		b.yesButtonEn.isVisible = false
		b.yesButtonSp.isVisible = false
		b.noButton.isVisible = false
		b.yesButtonEn:removeEventListener("touch", yesButtonListener)
		b.yesButtonSp:removeEventListener("touch", yesButtonListener)
		b.noButton:removeEventListener("touch", noButtonListener)
		isWeaponsChange = 0
		leftButtonDown = 0
		rightButtonDown = 0
		attackButtonDown = 0
		swingButtonDown = 0
		granadeButtonDown = 0
		
		pauseButton.xScale = 1
		pauseButton.yScale = 1
		
		audio.resume(a.soundTrack01)
		audio.resume(a.deathMusic)
		audio.resume(a.finaleMusic)
		

	end
end


function pauseButtonListener(e)

	if (v.everPlayed == 2) then
		if (e.phase == "began") then
			
			pauseButton.xScale = 1.2
			pauseButton.yScale = 1.2
--		end


--		if (e.phase == "ended") then
		
			v.isPaused = true
			maskScreenDisplayGroup.isVisible = true
			menuMaskScreen.isVisible = true
			menuMaskScreen.alpha = .5
			if (b.enOrSp == 2) then
				b.returnToMenuSp.isVisible = true
				b.returnToMenuEn.isVisible = false
				b.yesButtonSp.isVisible = true			
				b.yesButtonEn.isVisible = false
				b.noButton.isVisible = true
			else
				b.returnToMenuEn.isVisible = true
				b.returnToMenuSp.isVisible = false
				b.yesButtonEn.isVisible = true			
				b.yesButtonSp.isVisible = false
				b.noButton.isVisible = true
			end
			b.yesButtonEn:addEventListener("touch", yesButtonListener)
			b.yesButtonSp:addEventListener("touch", yesButtonListener)
			b.noButton:addEventListener("touch", noButtonListener)
			
			audio.pause(a.soundTrack01)
			audio.pause(a.deathMusic)
			audio.pause(a.finaleMusic)
		end
	end
end

-- THIS FUNCTION IS ANDROID ONLY
function onKeyHardwareListener(e)
	if (e.phase == "up" and e.keyName == "back" and activeScreen == "game") then
		v.isPaused = true
		maskScreenDisplayGroup.isVisible = true
		menuMaskScreen.isVisible = true
		menuMaskScreen.alpha = .5
		if (b.enOrSp == 2) then
			b.returnToMenuSp.isVisible = true
			b.returnToMenuEn.isVisible = false
			b.yesButtonSp.isVisible = true			
			b.yesButtonEn.isVisible = false
			b.noButton.isVisible = true
		else
			b.returnToMenuEn.isVisible = true
			b.returnToMenuSp.isVisible = false
			b.yesButtonEn.isVisible = true			
			b.yesButtonSp.isVisible = false
			b.noButton.isVisible = true
		end
		b.yesButtonEn:addEventListener("touch", yesButtonListener)
		b.yesButtonSp:addEventListener("touch", yesButtonListener)
		b.noButton:addEventListener("touch", noButtonListener)
		audio.pause(a.soundTrack01)
		audio.pause(a.deathMusic)
		audio.pause(a.finaleMusic)

		return true
	end

	if (e.phase == "up" and e.keyName == "back" and activeScreen == "options") then
--		activeScreen = "menu"
		return true
	end

	if (e.phase == "up" and e.keyName == "back" and activeScreen == "select colors" and v.everPlayed == 2) then
--		activeScreen = "menu"
		return true
	end

	if (e.phase == "up" and e.keyName == "back" and activeScreen == "select level" and v.everPlayed == 2) then
--		activeScreen = "select colors"
		return true
	end
--]]
	if (e.phase == "up" and e.keyName == "back" and activeScreen == "menu") then
		--[[menuMaskScreen.isVisible = true
		maskScreenDisplayGroup.isVisible = true
		reallyWantToQuit.isVisible = true
		yesButton.isVisible = true
		noButton.isVisible = true
		playGame:removeEventListener("touch", playGameListener)
		options:removeEventListener("touch", optionsListener)
		yesButton:addEventListener("touch", yesButtonListener)
		noButton:addEventListener("touch", noButtonListener)
		return true--]]
		return false -- it will quit w/o a notice
	end
	
	
end


function optionsReturnButtonListener(e)
	
	if (e.phase == "began") then
		b.optionsReturnButtonEn.xScale = 1.2
		b.optionsReturnButtonEn.yScale = 1.2
		b.optionsReturnButtonSp.xScale = 1.2
		b.optionsReturnButtonSp.yScale = 1.2
		display.getCurrentStage():setFocus(e.target, e.id)
		if (v.soundOn == 1) then
			audio.play(a.clickSoundMenu, 12)
		end
	end
	
	
	if (e.phase == "ended") then
		activeScreen = "menu"
		b.optionsReturnButtonEn.xScale = 1
		b.optionsReturnButtonEn.yScale = 1
		b.optionsReturnButtonSp.xScale = 1
		b.optionsReturnButtonSp.yScale = 1
		display.getCurrentStage():setFocus(e.target, nil)
	end
end


function englishEnEventListener(e)

	if (e.phase == "began") then
		b.englishEn.xScale = 1.2
		b.englishEn.yScale = 1.2
		display.getCurrentStage():setFocus(e.target, e.id)
		if (v.soundOn == 1) then
			audio.play(a.clickSoundMenu, 12)
		end
	end

	
	if (e.phase == "ended") then
		b.englishEn.xScale = 1
		b.englishEn.yScale = 1
		display.getCurrentStage():setFocus(e.target, nil)
		b.enOrSp = 1
		b.spanishSp.alpha = .5
		b.englishEn.alpha = 1
		b.optionsReturnButtonEn.isVisible = true
		b.optionsReturnButtonSp.isVisible = false		
		b.exitSp.isVisible = false
		b.exitEn.isVisible = true
		
		saveFileHandling("save")
	end
	
end


function spanishSpEventListener(e)

	if (e.phase == "began") then
		b.spanishSp.xScale = 1.2
		b.spanishSp.yScale = 1.2
		display.getCurrentStage():setFocus(e.target, e.id)
		if (v.soundOn == 1) then
			audio.play(a.clickSoundMenu, 12)
		end
	end

	
	if (e.phase == "ended") then
		b.spanishSp.xScale = 1
		b.spanishSp.yScale = 1
		display.getCurrentStage():setFocus(e.target, nil)
		b.enOrSp = 2
		b.englishEn.alpha = .5
		b.spanishSp.alpha = 1
		b.optionsReturnButtonSp.isVisible = true
		b.optionsReturnButtonEn.isVisible = false		
		b.exitSp.isVisible = true
		b.exitEn.isVisible = false
		
		saveFileHandling("save")
	end


end


function exitEnEventListener(e)

	if (e.phase == "began") then
		b.exitEn.xScale = 1.2
		b.exitEn.yScale = 1.2
		display.getCurrentStage():setFocus(e.target, e.id)
		
	end

	
	if (e.phase == "ended") then
		b.exitEn.xScale = 1
		b.exitEn.yScale = 1
		display.getCurrentStage():setFocus(e.target, nil)
		os.exit()
	end
end


function exitSpEventListener(e)

	if (e.phase == "began") then
		b.exitSp.xScale = 1.2
		b.exitSp.yScale = 1.2
		display.getCurrentStage():setFocus(e.target, e.id)
		
	end

	
	if (e.phase == "ended") then
		b.exitSp.xScale = 1
		b.exitSp.yScale = 1
		display.getCurrentStage():setFocus(e.target, nil)
		os.exit()
	end

end


function toggleSpeaker(e)

	if (e.phase == "began") then
		if (v.soundOn == 1) then
			v.soundOn = 0
			b.speakerOff.isVisible = true
		else
			v.soundOn = 1
			b.speakerOff.isVisible = false
		end
		saveFileHandling("save")
	end
	
end


function toggleMusic(e)

	if (e.phase == "began") then
		if (v.musicOn == 1) then
			v.musicOn = 0
			b.musicOff.isVisible = true
			audio.stop(3)
		else
			v.musicOn = 1
			b.musicOff.isVisible = false
			audio.play(a.menuMusic, { channel = 3, loops = -1})	
		end
		saveFileHandling("save")
	end
	
end


function optionsListener(e)
	
	if (e.phase == "began") then
		b.optionsEn.xScale = 1.2
		b.optionsEn.yScale = 1.2
		b.optionsSp.xScale = 1.2
		b.optionsSp.yScale = 1.2
		display.getCurrentStage():setFocus(e.target, e.id)
		if (v.soundOn == 1) then
			audio.play(a.clickSoundMenu, 12)
		end
	end
	
	if (e.phase == "ended") then
		activeScreen = "options"
		b.optionsEn.xScale = 1
		b.optionsEn.yScale = 1
		b.optionsSp.xScale = 1
		b.optionsSp.yScale = 1
		display.getCurrentStage():setFocus(e.target, nil)
	end
end


function exitColorsListener(e)

	if (e.phase == "began") then
		b.selectColorsExit.xScale = 1.2
		b.selectColorsExit.yScale = 1.2
		display.getCurrentStage():setFocus(e.target, e.id)
		if (v.soundOn == 1) then
			audio.play(a.clickSoundMenu, 12)
		end
		
	end

	if (e.phase == "ended") then
		activeScreen = "select level"
		b.selectColorsExit.xScale = 1
		b.selectColorsExit.yScale = 1
		display.getCurrentStage():setFocus(e.target, nil)
		saveFileHandling("save")
	end

end


function updateColorsScreen()

	-- HEAD
	
	b.head1.isVisible = false
	b.head2.isVisible = false
	b.head3.isVisible = false
	b.head4.isVisible = false
	b.head5.isVisible = false
	b.head6.isVisible = false
	b.head7.isVisible = false
	b.head8.isVisible = false
	b.head9.isVisible = false
	b.head10.isVisible = false
	b.head11.isVisible = false
	b.head12.isVisible = false
	b.head13.isVisible = false
	b.head14.isVisible = false
	b.head15.isVisible = false

	if (h.cHead1 == 1) then
		b.head7.isVisible = true
		b.head9.isVisible = true
		b.head7.alpha = 1
		b.head9.alpha = .75
	elseif (h.cHead1 == 2) then
		b.head7.isVisible = true
		b.head9.isVisible = true
		b.head7.alpha = 1
		b.head9.alpha = .50
	elseif (h.cHead1 == 3) then
		b.head7.isVisible = true
		b.head9.isVisible = true
		b.head7.alpha = 1
		b.head9.alpha = .30
	elseif (h.cHead1 == 4) then
		b.head5.isVisible = true
		b.head9.isVisible = true
		b.head5.alpha = 1
		b.head9.alpha = .35
	elseif (h.cHead1 == 5) then
		b.head5.isVisible = true
		b.head9.isVisible = true
		b.head5.alpha = 1
		b.head9.alpha = .47
	elseif (h.cHead1 == 6) then
		b.head5.isVisible = true
		b.head9.isVisible = true
		b.head5.alpha = 1
		b.head9.alpha = .65
	elseif (h.cHead1 == 7) then
		b.head1.isVisible = true
		b.head5.isVisible = true
		b.head1.alpha = 1
		b.head5.alpha = .50
	elseif (h.cHead1 == 8) then
		b.head1.isVisible = true
		b.head5.isVisible = true
		b.head1.alpha = 1
		b.head5.alpha = .25
	elseif (h.cHead1 == 9) then
		b.head1.isVisible = true
		b.head3.isVisible = true
		b.head1.alpha = 1
		b.head3.alpha = .25
	elseif (h.cHead1 == 10) then
		b.head1.isVisible = true
		b.head3.isVisible = true
		b.head1.alpha = 1
		b.head3.alpha = .50
	elseif (h.cHead1 == 11) then
		b.head5.isVisible = true
		b.head7.isVisible = true
		b.head5.alpha = 1
		b.head7.alpha = .50
	elseif (h.cHead1 == 12) then
		b.head5.isVisible = true
		b.head5.isVisible = true
		b.head5.alpha = 1
		b.head5.alpha = 1
	elseif (h.cHead1 == 13) then
		b.head3.isVisible = true
		b.head5.isVisible = true
		b.head3.alpha = 1
		b.head5.alpha = .58
	elseif (h.cHead1 == 14) then
		b.head3.isVisible = true
		b.head5.isVisible = true
		b.head3.alpha = 1
		b.head5.alpha = .26
	elseif (h.cHead1 == 15) then
		b.head1.isVisible = true
		b.head7.isVisible = true
		b.head1.alpha = 1
		b.head7.alpha = .50
	elseif (h.cHead1 == 16) then
		b.head1.isVisible = true
		b.head1.isVisible = true
		b.head1.alpha = 1
		b.head1.alpha = 1
	elseif (h.cHead1 == 17) then
		b.head1.isVisible = true
		b.head9.isVisible = true
		b.head1.alpha = 1
		b.head9.alpha = .40
	elseif (h.cHead1 == 18) then
		b.head1.isVisible = true
		b.head9.isVisible = true
		b.head1.alpha = 1
		b.head9.alpha = .80
	elseif (h.cHead1 == 19) then
		b.head9.isVisible = true
		b.head9.isVisible = true
		b.head9.alpha = 1
		b.head9.alpha = 1
	elseif (h.cHead1 == 20) then
		b.head3.isVisible = true
		b.head9.isVisible = true
		b.head3.alpha = 1
		b.head9.alpha = .50
	elseif (h.cHead1 == 21) then
		b.head7.isVisible = true
		b.head7.isVisible = true
		b.head7.alpha = 1
		b.head7.alpha = 1
	elseif (h.cHead1 == 22) then
		b.head3.isVisible = true
		b.head7.isVisible = true
		b.head3.alpha = 1
		b.head7.alpha = .75
	elseif (h.cHead1 == 23) then
		b.head3.isVisible = true
		b.head7.isVisible = true
		b.head3.alpha = 1
		b.head7.alpha = .55
	elseif (h.cHead1 == 24) then
		b.head3.isVisible = true
		b.head7.isVisible = true
		b.head3.alpha = 1
		b.head7.alpha = .48
	elseif (h.cHead1 == 25) then
		b.head3.isVisible = true
		b.head7.isVisible = true
		b.head3.alpha = 1
		b.head7.alpha = .20
	elseif (h.cHead1 == 26) then
		b.head3.isVisible = true
		b.head3.isVisible = true
		b.head3.alpha = 1
		b.head3.alpha = 1
	end

	
	if (h.cHead2 == 1) then
		b.head8.isVisible = true
		b.head10.isVisible = true
		b.head8.alpha = 1
		b.head10.alpha = .75
	elseif (h.cHead2 == 2) then
		b.head8.isVisible = true
		b.head10.isVisible = true
		b.head8.alpha = 1
		b.head10.alpha = .50
	elseif (h.cHead2 == 3) then
		b.head8.isVisible = true
		b.head10.isVisible = true
		b.head8.alpha = 1
		b.head10.alpha = .30
	elseif (h.cHead2 == 4) then
		b.head6.isVisible = true
		b.head10.isVisible = true
		b.head6.alpha = 1
		b.head10.alpha = .35
	elseif (h.cHead2 == 5) then
		b.head6.isVisible = true
		b.head10.isVisible = true
		b.head6.alpha = 1
		b.head10.alpha = .47
	elseif (h.cHead2 == 6) then
		b.head6.isVisible = true
		b.head10.isVisible = true
		b.head6.alpha = 1
		b.head10.alpha = .65
	elseif (h.cHead2 == 7) then
		b.head2.isVisible = true
		b.head6.isVisible = true
		b.head2.alpha = 1
		b.head6.alpha = .50
	elseif (h.cHead2 == 8) then
		b.head2.isVisible = true
		b.head6.isVisible = true
		b.head2.alpha = 1
		b.head6.alpha = .25
	elseif (h.cHead2 == 9) then
		b.head2.isVisible = true
		b.head4.isVisible = true
		b.head2.alpha = 1
		b.head4.alpha = .25
	elseif (h.cHead2 == 10) then
		b.head2.isVisible = true
		b.head4.isVisible = true
		b.head2.alpha = 1
		b.head4.alpha = .50
	elseif (h.cHead2 == 11) then
		b.head6.isVisible = true
		b.head8.isVisible = true
		b.head6.alpha = 1
		b.head8.alpha = .50
	elseif (h.cHead2 == 12) then
		b.head6.isVisible = true
		b.head6.isVisible = true
		b.head6.alpha = 1
		b.head6.alpha = 1
	elseif (h.cHead2 == 13) then
		b.head4.isVisible = true
		b.head6.isVisible = true
		b.head4.alpha = 1
		b.head6.alpha = .58
	elseif (h.cHead2 == 14) then
		b.head4.isVisible = true
		b.head6.isVisible = true
		b.head4.alpha = 1
		b.head6.alpha = .26
	elseif (h.cHead2 == 15) then
		b.head2.isVisible = true
		b.head8.isVisible = true
		b.head2.alpha = 1
		b.head8.alpha = .50
	elseif (h.cHead2 == 16) then
		b.head2.isVisible = true
		b.head2.isVisible = true
		b.head2.alpha = 1
		b.head2.alpha = 1
	elseif (h.cHead2 == 17) then
		b.head2.isVisible = true
		b.head10.isVisible = true
		b.head2.alpha = 1
		b.head10.alpha = .40
	elseif (h.cHead2 == 18) then
		b.head2.isVisible = true
		b.head10.isVisible = true
		b.head2.alpha = 1
		b.head10.alpha = .80
	elseif (h.cHead2 == 19) then
		b.head10.isVisible = true
		b.head10.isVisible = true
		b.head10.alpha = 1
		b.head10.alpha = 1
	elseif (h.cHead2 == 20) then
		b.head4.isVisible = true
		b.head10.isVisible = true
		b.head4.alpha = 1
		b.head10.alpha = .50
	elseif (h.cHead2 == 21) then
		b.head8.isVisible = true
		b.head8.isVisible = true
		b.head8.alpha = 1
		b.head8.alpha = 1
	elseif (h.cHead2 == 22) then
		b.head4.isVisible = true
		b.head8.isVisible = true
		b.head4.alpha = 1
		b.head8.alpha = .75
	elseif (h.cHead2 == 23) then
		b.head4.isVisible = true
		b.head8.isVisible = true
		b.head4.alpha = 1
		b.head8.alpha = .55
	elseif (h.cHead2 == 24) then
		b.head4.isVisible = true
		b.head8.isVisible = true
		b.head4.alpha = 1
		b.head8.alpha = .48
	elseif (h.cHead2 == 25) then
		b.head4.isVisible = true
		b.head8.isVisible = true
		b.head4.alpha = 1
		b.head8.alpha = .20
	elseif (h.cHead2 == 26) then
		b.head4.isVisible = true
		b.head4.isVisible = true
		b.head4.alpha = 1
		b.head4.alpha = 1
	end
	
	
	if (h.cBroadway == 1) then
		b.head12.isVisible = true
		b.head12.alpha = 1
		b.broadway.alpha = 1
	else
		b.head11.isVisible = true
		b.head11.alpha = 1	
		b.broadway.alpha = .5
	end

	if (h.cVegas == 1) then
		b.head13.isVisible = true
		b.head13.alpha = 1
		b.head14.isVisible = true
		b.head14.alpha = 1
		b.head15.isVisible = true
		b.head15.alpha = 1
		b.lasVegas.alpha = 1
	else
		b.lasVegas.alpha = .5
	end


	-- TORSO
	
	b.torso2.isVisible = false
	b.torso3.isVisible = false
	b.torso4.isVisible = false
	b.torso5.isVisible = false
	b.torso6.isVisible = false
	
	b.neck2.isVisible = false
	b.neck3.isVisible = false
	b.neck4.isVisible = false
	b.neck5.isVisible = false
	b.neck6.isVisible = false
	
	b.belt2.isVisible = false
	b.belt3.isVisible = false
	b.belt4.isVisible = false
	b.belt5.isVisible = false
	b.belt6.isVisible = false
	
	
	if (h.cTorso1 == 1) then
		b.torso5.isVisible = true
		b.torso6.isVisible = true
		b.torso5.alpha = 1
		b.torso6.alpha = .75
	elseif (h.cTorso1 == 2) then
		b.torso5.isVisible = true
		b.torso6.isVisible = true
		b.torso5.alpha = 1
		b.torso6.alpha = .50
	elseif (h.cTorso1 == 3) then
		b.torso5.isVisible = true
		b.torso6.isVisible = true
		b.torso5.alpha = 1
		b.torso6.alpha = .30
	elseif (h.cTorso1 == 4) then
		b.torso4.isVisible = true
		b.torso6.isVisible = true
		b.torso4.alpha = 1
		b.torso6.alpha = .35
	elseif (h.cTorso1 == 5) then
		b.torso4.isVisible = true
		b.torso6.isVisible = true
		b.torso4.alpha = 1
		b.torso6.alpha = .47
	elseif (h.cTorso1 == 6) then
		b.torso4.isVisible = true
		b.torso6.isVisible = true
		b.torso4.alpha = 1
		b.torso6.alpha = .65
	elseif (h.cTorso1 == 7) then
		b.torso2.isVisible = true
		b.torso4.isVisible = true
		b.torso2.alpha = 1
		b.torso4.alpha = .50
	elseif (h.cTorso1 == 8) then
		b.torso2.isVisible = true
		b.torso4.isVisible = true
		b.torso2.alpha = 1
		b.torso4.alpha = .25
	elseif (h.cTorso1 == 9) then
		b.torso2.isVisible = true
		b.torso3.isVisible = true
		b.torso2.alpha = 1
		b.torso3.alpha = .25
	elseif (h.cTorso1 == 10) then
		b.torso2.isVisible = true
		b.torso3.isVisible = true
		b.torso2.alpha = 1
		b.torso3.alpha = .50
	elseif (h.cTorso1 == 11) then
		b.torso4.isVisible = true
		b.torso5.isVisible = true
		b.torso4.alpha = 1
		b.torso5.alpha = .50
	elseif (h.cTorso1 == 12) then
		b.torso4.isVisible = true
		b.torso4.isVisible = true
		b.torso4.alpha = 1
		b.torso4.alpha = 1
	elseif (h.cTorso1 == 13) then
		b.torso3.isVisible = true
		b.torso4.isVisible = true
		b.torso3.alpha = 1
		b.torso4.alpha = .58
	elseif (h.cTorso1 == 14) then
		b.torso3.isVisible = true
		b.torso4.isVisible = true
		b.torso3.alpha = 1
		b.torso4.alpha = .26
	elseif (h.cTorso1 == 15) then
		b.torso2.isVisible = true
		b.torso5.isVisible = true
		b.torso2.alpha = 1
		b.torso5.alpha = .50
	elseif (h.cTorso1 == 16) then
		b.torso2.isVisible = true
		b.torso2.isVisible = true
		b.torso2.alpha = 1
		b.torso2.alpha = 1
	elseif (h.cTorso1 == 17) then
		b.torso2.isVisible = true
		b.torso6.isVisible = true
		b.torso2.alpha = 1
		b.torso6.alpha = .40
	elseif (h.cTorso1 == 18) then
		b.torso2.isVisible = true
		b.torso6.isVisible = true
		b.torso2.alpha = 1
		b.torso6.alpha = .80
	elseif (h.cTorso1 == 19) then
		b.torso6.isVisible = true
		b.torso6.isVisible = true
		b.torso6.alpha = 1
		b.torso6.alpha = 1
	elseif (h.cTorso1 == 20) then
		b.torso3.isVisible = true
		b.torso6.isVisible = true
		b.torso3.alpha = 1
		b.torso6.alpha = .50
	elseif (h.cTorso1 == 21) then
		b.torso5.isVisible = true
		b.torso5.isVisible = true
		b.torso5.alpha = 1
		b.torso5.alpha = 1
	elseif (h.cTorso1 == 22) then
		b.torso3.isVisible = true
		b.torso5.isVisible = true
		b.torso3.alpha = 1
		b.torso5.alpha = .75
	elseif (h.cTorso1 == 23) then
		b.torso3.isVisible = true
		b.torso5.isVisible = true
		b.torso3.alpha = 1
		b.torso5.alpha = .55
	elseif (h.cTorso1 == 24) then
		b.torso3.isVisible = true
		b.torso5.isVisible = true
		b.torso3.alpha = 1
		b.torso5.alpha = .48
	elseif (h.cTorso1 == 25) then
		b.torso3.isVisible = true
		b.torso5.isVisible = true
		b.torso3.alpha = 1
		b.torso5.alpha = .20
	elseif (h.cTorso1 == 26) then
		b.torso3.isVisible = true
		b.torso3.isVisible = true
		b.torso3.alpha = 1
		b.torso3.alpha = 1
	end

	
	if (h.cTorso2 == 1) then
		b.neck5.isVisible = true
		b.neck6.isVisible = true
		b.neck5.alpha = 1
		b.neck6.alpha = .75
	elseif (h.cTorso2 == 2) then
		b.neck5.isVisible = true
		b.neck6.isVisible = true
		b.neck5.alpha = 1
		b.neck6.alpha = .50
	elseif (h.cTorso2 == 3) then
		b.neck5.isVisible = true
		b.neck6.isVisible = true
		b.neck5.alpha = 1
		b.neck6.alpha = .30
	elseif (h.cTorso2 == 4) then
		b.neck4.isVisible = true
		b.neck6.isVisible = true
		b.neck4.alpha = 1
		b.neck6.alpha = .35
	elseif (h.cTorso2 == 5) then
		b.neck4.isVisible = true
		b.neck6.isVisible = true
		b.neck4.alpha = 1
		b.neck6.alpha = .47
	elseif (h.cTorso2 == 6) then
		b.neck4.isVisible = true
		b.neck6.isVisible = true
		b.neck4.alpha = 1
		b.neck6.alpha = .65
	elseif (h.cTorso2 == 7) then
		b.neck2.isVisible = true
		b.neck4.isVisible = true
		b.neck2.alpha = 1
		b.neck4.alpha = .50
	elseif (h.cTorso2 == 8) then
		b.neck2.isVisible = true
		b.neck4.isVisible = true
		b.neck2.alpha = 1
		b.neck4.alpha = .25
	elseif (h.cTorso2 == 9) then
		b.neck2.isVisible = true
		b.neck3.isVisible = true
		b.neck2.alpha = 1
		b.neck3.alpha = .25
	elseif (h.cTorso2 == 10) then
		b.neck2.isVisible = true
		b.neck3.isVisible = true
		b.neck2.alpha = 1
		b.neck3.alpha = .50
	elseif (h.cTorso2 == 11) then
		b.neck4.isVisible = true
		b.neck5.isVisible = true
		b.neck4.alpha = 1
		b.neck5.alpha = .50
	elseif (h.cTorso2 == 12) then
		b.neck4.isVisible = true
		b.neck4.isVisible = true
		b.neck4.alpha = 1
		b.neck4.alpha = 1
	elseif (h.cTorso2 == 13) then
		b.neck3.isVisible = true
		b.neck4.isVisible = true
		b.neck3.alpha = 1
		b.neck4.alpha = .58
	elseif (h.cTorso2 == 14) then
		b.neck3.isVisible = true
		b.neck4.isVisible = true
		b.neck3.alpha = 1
		b.neck4.alpha = .26
	elseif (h.cTorso2 == 15) then
		b.neck2.isVisible = true
		b.neck5.isVisible = true
		b.neck2.alpha = 1
		b.neck5.alpha = .50
	elseif (h.cTorso2 == 16) then
		b.neck2.isVisible = true
		b.neck2.isVisible = true
		b.neck2.alpha = 1
		b.neck2.alpha = 1
	elseif (h.cTorso2 == 17) then
		b.neck2.isVisible = true
		b.neck6.isVisible = true
		b.neck2.alpha = 1
		b.neck6.alpha = .40
	elseif (h.cTorso2 == 18) then
		b.neck2.isVisible = true
		b.neck6.isVisible = true
		b.neck2.alpha = 1
		b.neck6.alpha = .80
	elseif (h.cTorso2 == 19) then
		b.neck6.isVisible = true
		b.neck6.isVisible = true
		b.neck6.alpha = 1
		b.neck6.alpha = 1
	elseif (h.cTorso2 == 20) then
		b.neck3.isVisible = true
		b.neck6.isVisible = true
		b.neck3.alpha = 1
		b.neck6.alpha = .50
	elseif (h.cTorso2 == 21) then
		b.neck5.isVisible = true
		b.neck5.isVisible = true
		b.neck5.alpha = 1
		b.neck5.alpha = 1
	elseif (h.cTorso2 == 22) then
		b.neck3.isVisible = true
		b.neck5.isVisible = true
		b.neck3.alpha = 1
		b.neck5.alpha = .75
	elseif (h.cTorso2 == 23) then
		b.neck3.isVisible = true
		b.neck5.isVisible = true
		b.neck3.alpha = 1
		b.neck5.alpha = .55
	elseif (h.cTorso2 == 24) then
		b.neck3.isVisible = true
		b.neck5.isVisible = true
		b.neck3.alpha = 1
		b.neck5.alpha = .48
	elseif (h.cTorso2 == 25) then
		b.neck3.isVisible = true
		b.neck5.isVisible = true
		b.neck3.alpha = 1
		b.neck5.alpha = .20
	elseif (h.cTorso2 == 26) then
		b.neck3.isVisible = true
		b.neck3.isVisible = true
		b.neck3.alpha = 1
		b.neck3.alpha = 1
	end

	
	if (h.cTorso2 == 1) then
		b.belt5.isVisible = true
		b.belt6.isVisible = true
		b.belt5.alpha = 1
		b.belt6.alpha = .75
	elseif (h.cTorso2 == 2) then
		b.belt5.isVisible = true
		b.belt6.isVisible = true
		b.belt5.alpha = 1
		b.belt6.alpha = .50
	elseif (h.cTorso2 == 3) then
		b.belt5.isVisible = true
		b.belt6.isVisible = true
		b.belt5.alpha = 1
		b.belt6.alpha = .30
	elseif (h.cTorso2 == 4) then
		b.belt4.isVisible = true
		b.belt6.isVisible = true
		b.belt4.alpha = 1
		b.belt6.alpha = .35
	elseif (h.cTorso2 == 5) then
		b.belt4.isVisible = true
		b.belt6.isVisible = true
		b.belt4.alpha = 1
		b.belt6.alpha = .47
	elseif (h.cTorso2 == 6) then
		b.belt4.isVisible = true
		b.belt6.isVisible = true
		b.belt4.alpha = 1
		b.belt6.alpha = .65
	elseif (h.cTorso2 == 7) then
		b.belt2.isVisible = true
		b.belt4.isVisible = true
		b.belt2.alpha = 1
		b.belt4.alpha = .50
	elseif (h.cTorso2 == 8) then
		b.belt2.isVisible = true
		b.belt4.isVisible = true
		b.belt2.alpha = 1
		b.belt4.alpha = .25
	elseif (h.cTorso2 == 9) then
		b.belt2.isVisible = true
		b.belt3.isVisible = true
		b.belt2.alpha = 1
		b.belt3.alpha = .25
	elseif (h.cTorso2 == 10) then
		b.belt2.isVisible = true
		b.belt3.isVisible = true
		b.belt2.alpha = 1
		b.belt3.alpha = .50
	elseif (h.cTorso2 == 11) then
		b.belt4.isVisible = true
		b.belt5.isVisible = true
		b.belt4.alpha = 1
		b.belt5.alpha = .50
	elseif (h.cTorso2 == 12) then
		b.belt4.isVisible = true
		b.belt4.isVisible = true
		b.belt4.alpha = 1
		b.belt4.alpha = 1
	elseif (h.cTorso2 == 13) then
		b.belt3.isVisible = true
		b.belt4.isVisible = true
		b.belt3.alpha = 1
		b.belt4.alpha = .58
	elseif (h.cTorso2 == 14) then
		b.belt3.isVisible = true
		b.belt4.isVisible = true
		b.belt3.alpha = 1
		b.belt4.alpha = .26
	elseif (h.cTorso2 == 15) then
		b.belt2.isVisible = true
		b.belt5.isVisible = true
		b.belt2.alpha = 1
		b.belt5.alpha = .50
	elseif (h.cTorso2 == 16) then
		b.belt2.isVisible = true
		b.belt2.isVisible = true
		b.belt2.alpha = 1
		b.belt2.alpha = 1
	elseif (h.cTorso2 == 17) then
		b.belt2.isVisible = true
		b.belt6.isVisible = true
		b.belt2.alpha = 1
		b.belt6.alpha = .40
	elseif (h.cTorso2 == 18) then
		b.belt2.isVisible = true
		b.belt6.isVisible = true
		b.belt2.alpha = 1
		b.belt6.alpha = .80
	elseif (h.cTorso2 == 19) then
		b.belt6.isVisible = true
		b.belt6.isVisible = true
		b.belt6.alpha = 1
		b.belt6.alpha = 1
	elseif (h.cTorso2 == 20) then
		b.belt3.isVisible = true
		b.belt6.isVisible = true
		b.belt3.alpha = 1
		b.belt6.alpha = .50
	elseif (h.cTorso2 == 21) then
		b.belt5.isVisible = true
		b.belt5.isVisible = true
		b.belt5.alpha = 1
		b.belt5.alpha = 1
	elseif (h.cTorso2 == 22) then
		b.belt3.isVisible = true
		b.belt5.isVisible = true
		b.belt3.alpha = 1
		b.belt5.alpha = .75
	elseif (h.cTorso2 == 23) then
		b.belt3.isVisible = true
		b.belt5.isVisible = true
		b.belt3.alpha = 1
		b.belt5.alpha = .55
	elseif (h.cTorso2 == 24) then
		b.belt3.isVisible = true
		b.belt5.isVisible = true
		b.belt3.alpha = 1
		b.belt5.alpha = .48
	elseif (h.cTorso2 == 25) then
		b.belt3.isVisible = true
		b.belt5.isVisible = true
		b.belt3.alpha = 1
		b.belt5.alpha = .20
	elseif (h.cTorso2 == 26) then
		b.belt3.isVisible = true
		b.belt3.isVisible = true
		b.belt3.alpha = 1
		b.belt3.alpha = 1
	end


	
	-- ARMS/LEGS
	
	b.leftArm1.isVisible = true
	b.leftArm2.isVisible = false
	b.leftArm3.isVisible = false
	b.leftArm4.isVisible = false
	b.leftArm5.isVisible = false
	b.leftArm6.isVisible = false
	
	b.rightArm1.isVisible = true
	b.rightArm2.isVisible = false
	b.rightArm3.isVisible = false
	b.rightArm4.isVisible = false
	b.rightArm5.isVisible = false
	b.rightArm6.isVisible = false

	b.leftLeg1.isVisible = true
	b.leftLeg2.isVisible = false
	b.leftLeg3.isVisible = false
	b.leftLeg4.isVisible = false
	b.leftLeg5.isVisible = false
	b.leftLeg6.isVisible = false
	
	b.rightLeg1.isVisible = true
	b.rightLeg2.isVisible = false
	b.rightLeg3.isVisible = false
	b.rightLeg4.isVisible = false
	b.rightLeg5.isVisible = false
	b.rightLeg6.isVisible = false
	
	

	if (h.cArms == 1) then
		b.leftArm5.isVisible = true
		b.leftArm6.isVisible = true
		b.leftArm5.alpha = 1
		b.leftArm6.alpha = .75
	elseif (h.cArms == 2) then
		b.leftArm5.isVisible = true
		b.leftArm6.isVisible = true
		b.leftArm5.alpha = 1
		b.leftArm6.alpha = .50
	elseif (h.cArms == 3) then
		b.leftArm5.isVisible = true
		b.leftArm6.isVisible = true
		b.leftArm5.alpha = 1
		b.leftArm6.alpha = .30
	elseif (h.cArms == 4) then
		b.leftArm4.isVisible = true
		b.leftArm6.isVisible = true
		b.leftArm4.alpha = 1
		b.leftArm6.alpha = .35
	elseif (h.cArms == 5) then
		b.leftArm4.isVisible = true
		b.leftArm6.isVisible = true
		b.leftArm4.alpha = 1
		b.leftArm6.alpha = .47
	elseif (h.cArms == 6) then
		b.leftArm4.isVisible = true
		b.leftArm6.isVisible = true
		b.leftArm4.alpha = 1
		b.leftArm6.alpha = .65
	elseif (h.cArms == 7) then
		b.leftArm2.isVisible = true
		b.leftArm4.isVisible = true
		b.leftArm2.alpha = 1
		b.leftArm4.alpha = .50
	elseif (h.cArms == 8) then
		b.leftArm2.isVisible = true
		b.leftArm4.isVisible = true
		b.leftArm2.alpha = 1
		b.leftArm4.alpha = .25
	elseif (h.cArms == 9) then
		b.leftArm2.isVisible = true
		b.leftArm3.isVisible = true
		b.leftArm2.alpha = 1
		b.leftArm3.alpha = .25
	elseif (h.cArms == 10) then
		b.leftArm2.isVisible = true
		b.leftArm3.isVisible = true
		b.leftArm2.alpha = 1
		b.leftArm3.alpha = .50
	elseif (h.cArms == 11) then
		b.leftArm4.isVisible = true
		b.leftArm5.isVisible = true
		b.leftArm4.alpha = 1
		b.leftArm5.alpha = .50
	elseif (h.cArms == 12) then
		b.leftArm4.isVisible = true
		b.leftArm4.isVisible = true
		b.leftArm4.alpha = 1
		b.leftArm4.alpha = 1
	elseif (h.cArms == 13) then
		b.leftArm3.isVisible = true
		b.leftArm4.isVisible = true
		b.leftArm3.alpha = 1
		b.leftArm4.alpha = .58
	elseif (h.cArms == 14) then
		b.leftArm3.isVisible = true
		b.leftArm4.isVisible = true
		b.leftArm3.alpha = 1
		b.leftArm4.alpha = .26
	elseif (h.cArms == 15) then
		b.leftArm2.isVisible = true
		b.leftArm5.isVisible = true
		b.leftArm2.alpha = 1
		b.leftArm5.alpha = .50
	elseif (h.cArms == 16) then
		b.leftArm2.isVisible = true
		b.leftArm2.isVisible = true
		b.leftArm2.alpha = 1
		b.leftArm2.alpha = 1
	elseif (h.cArms == 17) then
		b.leftArm2.isVisible = true
		b.leftArm6.isVisible = true
		b.leftArm2.alpha = 1
		b.leftArm6.alpha = .40
	elseif (h.cArms == 18) then
		b.leftArm2.isVisible = true
		b.leftArm6.isVisible = true
		b.leftArm2.alpha = 1
		b.leftArm6.alpha = .80
	elseif (h.cArms == 19) then
		b.leftArm6.isVisible = true
		b.leftArm6.isVisible = true
		b.leftArm6.alpha = 1
		b.leftArm6.alpha = 1
	elseif (h.cArms == 20) then
		b.leftArm3.isVisible = true
		b.leftArm6.isVisible = true
		b.leftArm3.alpha = 1
		b.leftArm6.alpha = .50
	elseif (h.cArms == 21) then
		b.leftArm5.isVisible = true
		b.leftArm5.isVisible = true
		b.leftArm5.alpha = 1
		b.leftArm5.alpha = 1
	elseif (h.cArms == 22) then
		b.leftArm3.isVisible = true
		b.leftArm5.isVisible = true
		b.leftArm3.alpha = 1
		b.leftArm5.alpha = .75
	elseif (h.cArms == 23) then
		b.leftArm3.isVisible = true
		b.leftArm5.isVisible = true
		b.leftArm3.alpha = 1
		b.leftArm5.alpha = .55
	elseif (h.cArms == 24) then
		b.leftArm3.isVisible = true
		b.leftArm5.isVisible = true
		b.leftArm3.alpha = 1
		b.leftArm5.alpha = .48
	elseif (h.cArms == 25) then
		b.leftArm3.isVisible = true
		b.leftArm5.isVisible = true
		b.leftArm3.alpha = 1
		b.leftArm5.alpha = .20
	elseif (h.cArms == 26) then
		b.leftArm3.isVisible = true
		b.leftArm3.isVisible = true
		b.leftArm3.alpha = 1
		b.leftArm3.alpha = 1
	end

	if (h.cArms == 1) then
		b.rightArm5.isVisible = true
		b.rightArm6.isVisible = true
		b.rightArm5.alpha = 1
		b.rightArm6.alpha = .75
	elseif (h.cArms == 2) then
		b.rightArm5.isVisible = true
		b.rightArm6.isVisible = true
		b.rightArm5.alpha = 1
		b.rightArm6.alpha = .50
	elseif (h.cArms == 3) then
		b.rightArm5.isVisible = true
		b.rightArm6.isVisible = true
		b.rightArm5.alpha = 1
		b.rightArm6.alpha = .30
	elseif (h.cArms == 4) then
		b.rightArm4.isVisible = true
		b.rightArm6.isVisible = true
		b.rightArm4.alpha = 1
		b.rightArm6.alpha = .35
	elseif (h.cArms == 5) then
		b.rightArm4.isVisible = true
		b.rightArm6.isVisible = true
		b.rightArm4.alpha = 1
		b.rightArm6.alpha = .47
	elseif (h.cArms == 6) then
		b.rightArm4.isVisible = true
		b.rightArm6.isVisible = true
		b.rightArm4.alpha = 1
		b.rightArm6.alpha = .65
	elseif (h.cArms == 7) then
		b.rightArm2.isVisible = true
		b.rightArm4.isVisible = true
		b.rightArm2.alpha = 1
		b.rightArm4.alpha = .50
	elseif (h.cArms == 8) then
		b.rightArm2.isVisible = true
		b.rightArm4.isVisible = true
		b.rightArm2.alpha = 1
		b.rightArm4.alpha = .25
	elseif (h.cArms == 9) then
		b.rightArm2.isVisible = true
		b.rightArm3.isVisible = true
		b.rightArm2.alpha = 1
		b.rightArm3.alpha = .25
	elseif (h.cArms == 10) then
		b.rightArm2.isVisible = true
		b.rightArm3.isVisible = true
		b.rightArm2.alpha = 1
		b.rightArm3.alpha = .50
	elseif (h.cArms == 11) then
		b.rightArm4.isVisible = true
		b.rightArm5.isVisible = true
		b.rightArm4.alpha = 1
		b.rightArm5.alpha = .50
	elseif (h.cArms == 12) then
		b.rightArm4.isVisible = true
		b.rightArm4.isVisible = true
		b.rightArm4.alpha = 1
		b.rightArm4.alpha = 1
	elseif (h.cArms == 13) then
		b.rightArm3.isVisible = true
		b.rightArm4.isVisible = true
		b.rightArm3.alpha = 1
		b.rightArm4.alpha = .58
	elseif (h.cArms == 14) then
		b.rightArm3.isVisible = true
		b.rightArm4.isVisible = true
		b.rightArm3.alpha = 1
		b.rightArm4.alpha = .26
	elseif (h.cArms == 15) then
		b.rightArm2.isVisible = true
		b.rightArm5.isVisible = true
		b.rightArm2.alpha = 1
		b.rightArm5.alpha = .50
	elseif (h.cArms == 16) then
		b.rightArm2.isVisible = true
		b.rightArm2.isVisible = true
		b.rightArm2.alpha = 1
		b.rightArm2.alpha = 1
	elseif (h.cArms == 17) then
		b.rightArm2.isVisible = true
		b.rightArm6.isVisible = true
		b.rightArm2.alpha = 1
		b.rightArm6.alpha = .40
	elseif (h.cArms == 18) then
		b.rightArm2.isVisible = true
		b.rightArm6.isVisible = true
		b.rightArm2.alpha = 1
		b.rightArm6.alpha = .80
	elseif (h.cArms == 19) then
		b.rightArm6.isVisible = true
		b.rightArm6.isVisible = true
		b.rightArm6.alpha = 1
		b.rightArm6.alpha = 1
	elseif (h.cArms == 20) then
		b.rightArm3.isVisible = true
		b.rightArm6.isVisible = true
		b.rightArm3.alpha = 1
		b.rightArm6.alpha = .50
	elseif (h.cArms == 21) then
		b.rightArm5.isVisible = true
		b.rightArm5.isVisible = true
		b.rightArm5.alpha = 1
		b.rightArm5.alpha = 1
	elseif (h.cArms == 22) then
		b.rightArm3.isVisible = true
		b.rightArm5.isVisible = true
		b.rightArm3.alpha = 1
		b.rightArm5.alpha = .75
	elseif (h.cArms == 23) then
		b.rightArm3.isVisible = true
		b.rightArm5.isVisible = true
		b.rightArm3.alpha = 1
		b.rightArm5.alpha = .55
	elseif (h.cArms == 24) then
		b.rightArm3.isVisible = true
		b.rightArm5.isVisible = true
		b.rightArm3.alpha = 1
		b.rightArm5.alpha = .48
	elseif (h.cArms == 25) then
		b.rightArm3.isVisible = true
		b.rightArm5.isVisible = true
		b.rightArm3.alpha = 1
		b.rightArm5.alpha = .20
	elseif (h.cArms == 26) then
		b.rightArm3.isVisible = true
		b.rightArm3.isVisible = true
		b.rightArm3.alpha = 1
		b.rightArm3.alpha = 1
	end
	

	if (h.cLegs == 1) then
		b.leftLeg5.isVisible = true
		b.leftLeg6.isVisible = true
		b.leftLeg5.alpha = 1
		b.leftLeg6.alpha = .75
	elseif (h.cLegs == 2) then
		b.leftLeg5.isVisible = true
		b.leftLeg6.isVisible = true
		b.leftLeg5.alpha = 1
		b.leftLeg6.alpha = .50
	elseif (h.cLegs == 3) then
		b.leftLeg5.isVisible = true
		b.leftLeg6.isVisible = true
		b.leftLeg5.alpha = 1
		b.leftLeg6.alpha = .30
	elseif (h.cLegs == 4) then
		b.leftLeg4.isVisible = true
		b.leftLeg6.isVisible = true
		b.leftLeg4.alpha = 1
		b.leftLeg6.alpha = .35
	elseif (h.cLegs == 5) then
		b.leftLeg4.isVisible = true
		b.leftLeg6.isVisible = true
		b.leftLeg4.alpha = 1
		b.leftLeg6.alpha = .47
	elseif (h.cLegs == 6) then
		b.leftLeg4.isVisible = true
		b.leftLeg6.isVisible = true
		b.leftLeg4.alpha = 1
		b.leftLeg6.alpha = .65
	elseif (h.cLegs == 7) then
		b.leftLeg2.isVisible = true
		b.leftLeg4.isVisible = true
		b.leftLeg2.alpha = 1
		b.leftLeg4.alpha = .50
	elseif (h.cLegs == 8) then
		b.leftLeg2.isVisible = true
		b.leftLeg4.isVisible = true
		b.leftLeg2.alpha = 1
		b.leftLeg4.alpha = .25
	elseif (h.cLegs == 9) then
		b.leftLeg2.isVisible = true
		b.leftLeg3.isVisible = true
		b.leftLeg2.alpha = 1
		b.leftLeg3.alpha = .25
	elseif (h.cLegs == 10) then
		b.leftLeg2.isVisible = true
		b.leftLeg3.isVisible = true
		b.leftLeg2.alpha = 1
		b.leftLeg3.alpha = .50
	elseif (h.cLegs == 11) then
		b.leftLeg4.isVisible = true
		b.leftLeg5.isVisible = true
		b.leftLeg4.alpha = 1
		b.leftLeg5.alpha = .50
	elseif (h.cLegs == 12) then
		b.leftLeg4.isVisible = true
		b.leftLeg4.isVisible = true
		b.leftLeg4.alpha = 1
		b.leftLeg4.alpha = 1
	elseif (h.cLegs == 13) then
		b.leftLeg3.isVisible = true
		b.leftLeg4.isVisible = true
		b.leftLeg3.alpha = 1
		b.leftLeg4.alpha = .58
	elseif (h.cLegs == 14) then
		b.leftLeg3.isVisible = true
		b.leftLeg4.isVisible = true
		b.leftLeg3.alpha = 1
		b.leftLeg4.alpha = .26
	elseif (h.cLegs == 15) then
		b.leftLeg2.isVisible = true
		b.leftLeg5.isVisible = true
		b.leftLeg2.alpha = 1
		b.leftLeg5.alpha = .50
	elseif (h.cLegs == 16) then
		b.leftLeg2.isVisible = true
		b.leftLeg2.isVisible = true
		b.leftLeg2.alpha = 1
		b.leftLeg2.alpha = 1
	elseif (h.cLegs == 17) then
		b.leftLeg2.isVisible = true
		b.leftLeg6.isVisible = true
		b.leftLeg2.alpha = 1
		b.leftLeg6.alpha = .40
	elseif (h.cLegs == 18) then
		b.leftLeg2.isVisible = true
		b.leftLeg6.isVisible = true
		b.leftLeg2.alpha = 1
		b.leftLeg6.alpha = .80
	elseif (h.cLegs == 19) then
		b.leftLeg6.isVisible = true
		b.leftLeg6.isVisible = true
		b.leftLeg6.alpha = 1
		b.leftLeg6.alpha = 1
	elseif (h.cLegs == 20) then
		b.leftLeg3.isVisible = true
		b.leftLeg6.isVisible = true
		b.leftLeg3.alpha = 1
		b.leftLeg6.alpha = .50
	elseif (h.cLegs == 21) then
		b.leftLeg5.isVisible = true
		b.leftLeg5.isVisible = true
		b.leftLeg5.alpha = 1
		b.leftLeg5.alpha = 1
	elseif (h.cLegs == 22) then
		b.leftLeg3.isVisible = true
		b.leftLeg5.isVisible = true
		b.leftLeg3.alpha = 1
		b.leftLeg5.alpha = .75
	elseif (h.cLegs == 23) then
		b.leftLeg3.isVisible = true
		b.leftLeg5.isVisible = true
		b.leftLeg3.alpha = 1
		b.leftLeg5.alpha = .55
	elseif (h.cLegs == 24) then
		b.leftLeg3.isVisible = true
		b.leftLeg5.isVisible = true
		b.leftLeg3.alpha = 1
		b.leftLeg5.alpha = .48
	elseif (h.cLegs == 25) then
		b.leftLeg3.isVisible = true
		b.leftLeg5.isVisible = true
		b.leftLeg3.alpha = 1
		b.leftLeg5.alpha = .20
	elseif (h.cLegs == 26) then
		b.leftLeg3.isVisible = true
		b.leftLeg3.isVisible = true
		b.leftLeg3.alpha = 1
		b.leftLeg3.alpha = 1
	end

	
	
	if (h.cLegs == 1) then
		b.rightLeg5.isVisible = true
		b.rightLeg6.isVisible = true
		b.rightLeg5.alpha = 1
		b.rightLeg6.alpha = .75
	elseif (h.cLegs == 2) then
		b.rightLeg5.isVisible = true
		b.rightLeg6.isVisible = true
		b.rightLeg5.alpha = 1
		b.rightLeg6.alpha = .50
	elseif (h.cLegs == 3) then
		b.rightLeg5.isVisible = true
		b.rightLeg6.isVisible = true
		b.rightLeg5.alpha = 1
		b.rightLeg6.alpha = .30
	elseif (h.cLegs == 4) then
		b.rightLeg4.isVisible = true
		b.rightLeg6.isVisible = true
		b.rightLeg4.alpha = 1
		b.rightLeg6.alpha = .35
	elseif (h.cLegs == 5) then
		b.rightLeg4.isVisible = true
		b.rightLeg6.isVisible = true
		b.rightLeg4.alpha = 1
		b.rightLeg6.alpha = .47
	elseif (h.cLegs == 6) then
		b.rightLeg4.isVisible = true
		b.rightLeg6.isVisible = true
		b.rightLeg4.alpha = 1
		b.rightLeg6.alpha = .65
	elseif (h.cLegs == 7) then
		b.rightLeg2.isVisible = true
		b.rightLeg4.isVisible = true
		b.rightLeg2.alpha = 1
		b.rightLeg4.alpha = .50
	elseif (h.cLegs == 8) then
		b.rightLeg2.isVisible = true
		b.rightLeg4.isVisible = true
		b.rightLeg2.alpha = 1
		b.rightLeg4.alpha = .25
	elseif (h.cLegs == 9) then
		b.rightLeg2.isVisible = true
		b.rightLeg3.isVisible = true
		b.rightLeg2.alpha = 1
		b.rightLeg3.alpha = .25
	elseif (h.cLegs == 10) then
		b.rightLeg2.isVisible = true
		b.rightLeg3.isVisible = true
		b.rightLeg2.alpha = 1
		b.rightLeg3.alpha = .50
	elseif (h.cLegs == 11) then
		b.rightLeg4.isVisible = true
		b.rightLeg5.isVisible = true
		b.rightLeg4.alpha = 1
		b.rightLeg5.alpha = .50
	elseif (h.cLegs == 12) then
		b.rightLeg4.isVisible = true
		b.rightLeg4.isVisible = true
		b.rightLeg4.alpha = 1
		b.rightLeg4.alpha = 1
	elseif (h.cLegs == 13) then
		b.rightLeg3.isVisible = true
		b.rightLeg4.isVisible = true
		b.rightLeg3.alpha = 1
		b.rightLeg4.alpha = .58
	elseif (h.cLegs == 14) then
		b.rightLeg3.isVisible = true
		b.rightLeg4.isVisible = true
		b.rightLeg3.alpha = 1
		b.rightLeg4.alpha = .26
	elseif (h.cLegs == 15) then
		b.rightLeg2.isVisible = true
		b.rightLeg5.isVisible = true
		b.rightLeg2.alpha = 1
		b.rightLeg5.alpha = .50
	elseif (h.cLegs == 16) then
		b.rightLeg2.isVisible = true
		b.rightLeg2.isVisible = true
		b.rightLeg2.alpha = 1
		b.rightLeg2.alpha = 1
	elseif (h.cLegs == 17) then
		b.rightLeg2.isVisible = true
		b.rightLeg6.isVisible = true
		b.rightLeg2.alpha = 1
		b.rightLeg6.alpha = .40
	elseif (h.cLegs == 18) then
		b.rightLeg2.isVisible = true
		b.rightLeg6.isVisible = true
		b.rightLeg2.alpha = 1
		b.rightLeg6.alpha = .80
	elseif (h.cLegs == 19) then
		b.rightLeg6.isVisible = true
		b.rightLeg6.isVisible = true
		b.rightLeg6.alpha = 1
		b.rightLeg6.alpha = 1
	elseif (h.cLegs == 20) then
		b.rightLeg3.isVisible = true
		b.rightLeg6.isVisible = true
		b.rightLeg3.alpha = 1
		b.rightLeg6.alpha = .50
	elseif (h.cLegs == 21) then
		b.rightLeg5.isVisible = true
		b.rightLeg5.isVisible = true
		b.rightLeg5.alpha = 1
		b.rightLeg5.alpha = 1
	elseif (h.cLegs == 22) then
		b.rightLeg3.isVisible = true
		b.rightLeg5.isVisible = true
		b.rightLeg3.alpha = 1
		b.rightLeg5.alpha = .75
	elseif (h.cLegs == 23) then
		b.rightLeg3.isVisible = true
		b.rightLeg5.isVisible = true
		b.rightLeg3.alpha = 1
		b.rightLeg5.alpha = .55
	elseif (h.cLegs == 24) then
		b.rightLeg3.isVisible = true
		b.rightLeg5.isVisible = true
		b.rightLeg3.alpha = 1
		b.rightLeg5.alpha = .48
	elseif (h.cLegs == 25) then
		b.rightLeg3.isVisible = true
		b.rightLeg5.isVisible = true
		b.rightLeg3.alpha = 1
		b.rightLeg5.alpha = .20
	elseif (h.cLegs == 26) then
		b.rightLeg3.isVisible = true
		b.rightLeg3.isVisible = true
		b.rightLeg3.alpha = 1
		b.rightLeg3.alpha = 1
	end
	

	
	
	-- COLOR SQUARES
	

	--b.colorSquare111.isVisible = false
	b.colorSquare111.alpha = .01
	b.colorSquare112.isVisible = false
	b.colorSquare113.isVisible = false
	b.colorSquare114.isVisible = false
	b.colorSquare115.isVisible = false
	
	--b.colorSquare121.isVisible = false
	b.colorSquare121.alpha = .01
	b.colorSquare122.isVisible = false
	b.colorSquare123.isVisible = false
	b.colorSquare124.isVisible = false
	b.colorSquare125.isVisible = false
	
	--b.colorSquare211.isVisible = false
	b.colorSquare211.alpha = .01
	b.colorSquare212.isVisible = false
	b.colorSquare213.isVisible = false
	b.colorSquare214.isVisible = false
	b.colorSquare215.isVisible = false
	
	--b.colorSquare221.isVisible = false
	b.colorSquare221.alpha = .01
	b.colorSquare222.isVisible = false
	b.colorSquare223.isVisible = false
	b.colorSquare224.isVisible = false
	b.colorSquare225.isVisible = false
	
	--b.colorSquare311.isVisible = false
	b.colorSquare311.alpha = .01
	b.colorSquare312.isVisible = false
	b.colorSquare313.isVisible = false
	b.colorSquare314.isVisible = false
	b.colorSquare315.isVisible = false
	
	--b.colorSquare321.isVisible = false
	b.colorSquare321.alpha = .01
	b.colorSquare322.isVisible = false
	b.colorSquare323.isVisible = false
	b.colorSquare324.isVisible = false
	b.colorSquare325.isVisible = false
	
	b.colorSquareX.isVisible = true
	
	
	
	if (h.cHead1 == 1) then
		b.colorSquare114.isVisible = true
		b.colorSquare115.isVisible = true
		b.colorSquare114.alpha = 1
		b.colorSquare115.alpha = .75
	elseif (h.cHead1 == 2) then
		b.colorSquare114.isVisible = true
		b.colorSquare115.isVisible = true
		b.colorSquare114.alpha = 1
		b.colorSquare115.alpha = .50
	elseif (h.cHead1 == 3) then
		b.colorSquare114.isVisible = true
		b.colorSquare115.isVisible = true
		b.colorSquare114.alpha = 1
		b.colorSquare115.alpha = .30
	elseif (h.cHead1 == 4) then
		b.colorSquare113.isVisible = true
		b.colorSquare115.isVisible = true
		b.colorSquare113.alpha = 1
		b.colorSquare115.alpha = .35
	elseif (h.cHead1 == 5) then
		b.colorSquare113.isVisible = true
		b.colorSquare115.isVisible = true
		b.colorSquare113.alpha = 1
		b.colorSquare115.alpha = .47
	elseif (h.cHead1 == 6) then
		b.colorSquare113.isVisible = true
		b.colorSquare115.isVisible = true
		b.colorSquare113.alpha = 1
		b.colorSquare115.alpha = .65
	elseif (h.cHead1 == 7) then
		b.colorSquare111.isVisible = true
		b.colorSquare113.isVisible = true
		b.colorSquare111.alpha = 1
		b.colorSquare113.alpha = .50
	elseif (h.cHead1 == 8) then
		b.colorSquare111.isVisible = true
		b.colorSquare113.isVisible = true
		b.colorSquare111.alpha = 1
		b.colorSquare113.alpha = .25
	elseif (h.cHead1 == 9) then
		b.colorSquare111.isVisible = true
		b.colorSquare112.isVisible = true
		b.colorSquare111.alpha = 1
		b.colorSquare112.alpha = .25
	elseif (h.cHead1 == 10) then
		b.colorSquare111.isVisible = true
		b.colorSquare112.isVisible = true
		b.colorSquare111.alpha = 1
		b.colorSquare112.alpha = .50
	elseif (h.cHead1 == 11) then
		b.colorSquare113.isVisible = true
		b.colorSquare114.isVisible = true
		b.colorSquare113.alpha = 1
		b.colorSquare114.alpha = .50
	elseif (h.cHead1 == 12) then
		b.colorSquare113.isVisible = true
		b.colorSquare113.isVisible = true
		b.colorSquare113.alpha = 1
		b.colorSquare113.alpha = 1
	elseif (h.cHead1 == 13) then
		b.colorSquare112.isVisible = true
		b.colorSquare113.isVisible = true
		b.colorSquare112.alpha = 1
		b.colorSquare113.alpha = .58
	elseif (h.cHead1 == 14) then
		b.colorSquare112.isVisible = true
		b.colorSquare113.isVisible = true
		b.colorSquare112.alpha = 1
		b.colorSquare113.alpha = .36
	elseif (h.cHead1 == 15) then
		b.colorSquare111.isVisible = true
		b.colorSquare114.isVisible = true
		b.colorSquare111.alpha = 1
		b.colorSquare114.alpha = .50
	elseif (h.cHead1 == 16) then
		b.colorSquare111.isVisible = true
		b.colorSquare111.isVisible = true
		b.colorSquare111.alpha = 1
		b.colorSquare111.alpha = 1
	elseif (h.cHead1 == 17) then
		b.colorSquare111.isVisible = true
		b.colorSquare115.isVisible = true
		b.colorSquare111.alpha = 1
		b.colorSquare115.alpha = .40
	elseif (h.cHead1 == 18) then
		b.colorSquare111.isVisible = true
		b.colorSquare115.isVisible = true
		b.colorSquare111.alpha = 1
		b.colorSquare115.alpha = .80
	elseif (h.cHead1 == 19) then
		b.colorSquare115.isVisible = true
		b.colorSquare115.isVisible = true
		b.colorSquare115.alpha = 1
		b.colorSquare115.alpha = 1
	elseif (h.cHead1 == 20) then
		b.colorSquare112.isVisible = true
		b.colorSquare115.isVisible = true
		b.colorSquare112.alpha = 1
		b.colorSquare115.alpha = .50
	elseif (h.cHead1 == 21) then
		b.colorSquare114.isVisible = true
		b.colorSquare114.isVisible = true
		b.colorSquare114.alpha = 1
		b.colorSquare114.alpha = 1
	elseif (h.cHead1 == 22) then
		b.colorSquare112.isVisible = true
		b.colorSquare114.isVisible = true
		b.colorSquare112.alpha = 1
		b.colorSquare114.alpha = .75
	elseif (h.cHead1 == 23) then
		b.colorSquare112.isVisible = true
		b.colorSquare114.isVisible = true
		b.colorSquare112.alpha = 1
		b.colorSquare114.alpha = .55
	elseif (h.cHead1 == 24) then
		b.colorSquare112.isVisible = true
		b.colorSquare114.isVisible = true
		b.colorSquare112.alpha = 1
		b.colorSquare114.alpha = .38
	elseif (h.cHead1 == 25) then
		b.colorSquare112.isVisible = true
		b.colorSquare114.isVisible = true
		b.colorSquare112.alpha = 1
		b.colorSquare114.alpha = .20
	elseif (h.cHead1 == 26) then
		b.colorSquare112.isVisible = true
		b.colorSquare112.isVisible = true
		b.colorSquare112.alpha = 1
		b.colorSquare112.alpha = 1
	end



	if (h.cHead2 == 1) then
		b.colorSquare124.isVisible = true
		b.colorSquare125.isVisible = true
		b.colorSquare124.alpha = 1
		b.colorSquare125.alpha = .75
	elseif (h.cHead2 == 2) then
		b.colorSquare124.isVisible = true
		b.colorSquare125.isVisible = true
		b.colorSquare124.alpha = 1
		b.colorSquare125.alpha = .50
	elseif (h.cHead2 == 3) then
		b.colorSquare124.isVisible = true
		b.colorSquare125.isVisible = true
		b.colorSquare124.alpha = 1
		b.colorSquare125.alpha = .30
	elseif (h.cHead2 == 4) then
		b.colorSquare123.isVisible = true
		b.colorSquare125.isVisible = true
		b.colorSquare123.alpha = 1
		b.colorSquare125.alpha = .35
	elseif (h.cHead2 == 5) then
		b.colorSquare123.isVisible = true
		b.colorSquare125.isVisible = true
		b.colorSquare123.alpha = 1
		b.colorSquare125.alpha = .47
	elseif (h.cHead2 == 6) then
		b.colorSquare123.isVisible = true
		b.colorSquare125.isVisible = true
		b.colorSquare123.alpha = 1
		b.colorSquare125.alpha = .65
	elseif (h.cHead2 == 7) then
		b.colorSquare121.isVisible = true
		b.colorSquare123.isVisible = true
		b.colorSquare121.alpha = 1
		b.colorSquare123.alpha = .50
	elseif (h.cHead2 == 8) then
		b.colorSquare121.isVisible = true
		b.colorSquare123.isVisible = true
		b.colorSquare121.alpha = 1
		b.colorSquare123.alpha = .25
	elseif (h.cHead2 == 9) then
		b.colorSquare121.isVisible = true
		b.colorSquare122.isVisible = true
		b.colorSquare121.alpha = 1
		b.colorSquare122.alpha = .25
	elseif (h.cHead2 == 10) then
		b.colorSquare121.isVisible = true
		b.colorSquare122.isVisible = true
		b.colorSquare121.alpha = 1
		b.colorSquare122.alpha = .50
	elseif (h.cHead2 == 11) then
		b.colorSquare123.isVisible = true
		b.colorSquare124.isVisible = true
		b.colorSquare123.alpha = 1
		b.colorSquare124.alpha = .50
	elseif (h.cHead2 == 12) then
		b.colorSquare123.isVisible = true
		b.colorSquare123.isVisible = true
		b.colorSquare123.alpha = 1
		b.colorSquare123.alpha = 1
	elseif (h.cHead2 == 13) then
		b.colorSquare122.isVisible = true
		b.colorSquare123.isVisible = true
		b.colorSquare122.alpha = 1
		b.colorSquare123.alpha = .58
	elseif (h.cHead2 == 14) then
		b.colorSquare122.isVisible = true
		b.colorSquare123.isVisible = true
		b.colorSquare122.alpha = 1
		b.colorSquare123.alpha = .36
	elseif (h.cHead2 == 15) then
		b.colorSquare121.isVisible = true
		b.colorSquare124.isVisible = true
		b.colorSquare121.alpha = 1
		b.colorSquare124.alpha = .50
	elseif (h.cHead2 == 16) then
		b.colorSquare121.isVisible = true
		b.colorSquare121.isVisible = true
		b.colorSquare121.alpha = 1
		b.colorSquare121.alpha = 1
	elseif (h.cHead2 == 17) then
		b.colorSquare121.isVisible = true
		b.colorSquare125.isVisible = true
		b.colorSquare121.alpha = 1
		b.colorSquare125.alpha = .40
	elseif (h.cHead2 == 18) then
		b.colorSquare121.isVisible = true
		b.colorSquare125.isVisible = true
		b.colorSquare121.alpha = 1
		b.colorSquare125.alpha = .80
	elseif (h.cHead2 == 19) then
		b.colorSquare125.isVisible = true
		b.colorSquare125.isVisible = true
		b.colorSquare125.alpha = 1
		b.colorSquare125.alpha = 1
	elseif (h.cHead2 == 20) then
		b.colorSquare122.isVisible = true
		b.colorSquare125.isVisible = true
		b.colorSquare122.alpha = 1
		b.colorSquare125.alpha = .50
	elseif (h.cHead2 == 21) then
		b.colorSquare124.isVisible = true
		b.colorSquare124.isVisible = true
		b.colorSquare124.alpha = 1
		b.colorSquare124.alpha = 1
	elseif (h.cHead2 == 22) then
		b.colorSquare122.isVisible = true
		b.colorSquare124.isVisible = true
		b.colorSquare122.alpha = 1
		b.colorSquare124.alpha = .75
	elseif (h.cHead2 == 23) then
		b.colorSquare122.isVisible = true
		b.colorSquare124.isVisible = true
		b.colorSquare122.alpha = 1
		b.colorSquare124.alpha = .55
	elseif (h.cHead2 == 24) then
		b.colorSquare122.isVisible = true
		b.colorSquare124.isVisible = true
		b.colorSquare122.alpha = 1
		b.colorSquare124.alpha = .38
	elseif (h.cHead2 == 25) then
		b.colorSquare122.isVisible = true
		b.colorSquare124.isVisible = true
		b.colorSquare122.alpha = 1
		b.colorSquare124.alpha = .20
	elseif (h.cHead2 == 26) then
		b.colorSquare122.isVisible = true
		b.colorSquare122.isVisible = true
		b.colorSquare122.alpha = 1
		b.colorSquare122.alpha = 1
	end
	
	
	
	if (h.cTorso1 == 1) then
		b.colorSquare214.isVisible = true
		b.colorSquare215.isVisible = true
		b.colorSquare214.alpha = 1
		b.colorSquare215.alpha = .75
	elseif (h.cTorso1 == 2) then
		b.colorSquare214.isVisible = true
		b.colorSquare215.isVisible = true
		b.colorSquare214.alpha = 1
		b.colorSquare215.alpha = .50
	elseif (h.cTorso1 == 3) then
		b.colorSquare214.isVisible = true
		b.colorSquare215.isVisible = true
		b.colorSquare214.alpha = 1
		b.colorSquare215.alpha = .30
	elseif (h.cTorso1 == 4) then
		b.colorSquare213.isVisible = true
		b.colorSquare215.isVisible = true
		b.colorSquare213.alpha = 1
		b.colorSquare215.alpha = .35
	elseif (h.cTorso1 == 5) then
		b.colorSquare213.isVisible = true
		b.colorSquare215.isVisible = true
		b.colorSquare213.alpha = 1
		b.colorSquare215.alpha = .47
	elseif (h.cTorso1 == 6) then
		b.colorSquare213.isVisible = true
		b.colorSquare215.isVisible = true
		b.colorSquare213.alpha = 1
		b.colorSquare215.alpha = .65
	elseif (h.cTorso1 == 7) then
		b.colorSquare211.isVisible = true
		b.colorSquare213.isVisible = true
		b.colorSquare211.alpha = 1
		b.colorSquare213.alpha = .50
	elseif (h.cTorso1 == 8) then
		b.colorSquare211.isVisible = true
		b.colorSquare213.isVisible = true
		b.colorSquare211.alpha = 1
		b.colorSquare213.alpha = .25
	elseif (h.cTorso1 == 9) then
		b.colorSquare211.isVisible = true
		b.colorSquare212.isVisible = true
		b.colorSquare211.alpha = 1
		b.colorSquare212.alpha = .25
	elseif (h.cTorso1 == 10) then
		b.colorSquare211.isVisible = true
		b.colorSquare212.isVisible = true
		b.colorSquare211.alpha = 1
		b.colorSquare212.alpha = .50
	elseif (h.cTorso1 == 11) then
		b.colorSquare213.isVisible = true
		b.colorSquare214.isVisible = true
		b.colorSquare213.alpha = 1
		b.colorSquare214.alpha = .50
	elseif (h.cTorso1 == 12) then
		b.colorSquare213.isVisible = true
		b.colorSquare213.isVisible = true
		b.colorSquare213.alpha = 1
		b.colorSquare213.alpha = 1
	elseif (h.cTorso1 == 13) then
		b.colorSquare212.isVisible = true
		b.colorSquare213.isVisible = true
		b.colorSquare212.alpha = 1
		b.colorSquare213.alpha = .58
	elseif (h.cTorso1 == 14) then
		b.colorSquare212.isVisible = true
		b.colorSquare213.isVisible = true
		b.colorSquare212.alpha = 1
		b.colorSquare213.alpha = .36
	elseif (h.cTorso1 == 15) then
		b.colorSquare211.isVisible = true
		b.colorSquare214.isVisible = true
		b.colorSquare211.alpha = 1
		b.colorSquare214.alpha = .50
	elseif (h.cTorso1 == 16) then
		b.colorSquare211.isVisible = true
		b.colorSquare211.isVisible = true
		b.colorSquare211.alpha = 1
		b.colorSquare211.alpha = 1
	elseif (h.cTorso1 == 17) then
		b.colorSquare211.isVisible = true
		b.colorSquare215.isVisible = true
		b.colorSquare211.alpha = 1
		b.colorSquare215.alpha = .40
	elseif (h.cTorso1 == 18) then
		b.colorSquare211.isVisible = true
		b.colorSquare215.isVisible = true
		b.colorSquare211.alpha = 1
		b.colorSquare215.alpha = .80
	elseif (h.cTorso1 == 19) then
		b.colorSquare215.isVisible = true
		b.colorSquare215.isVisible = true
		b.colorSquare215.alpha = 1
		b.colorSquare215.alpha = 1
	elseif (h.cTorso1 == 20) then
		b.colorSquare212.isVisible = true
		b.colorSquare215.isVisible = true
		b.colorSquare212.alpha = 1
		b.colorSquare215.alpha = .50
	elseif (h.cTorso1 == 21) then
		b.colorSquare214.isVisible = true
		b.colorSquare214.isVisible = true
		b.colorSquare214.alpha = 1
		b.colorSquare214.alpha = 1
	elseif (h.cTorso1 == 22) then
		b.colorSquare212.isVisible = true
		b.colorSquare214.isVisible = true
		b.colorSquare212.alpha = 1
		b.colorSquare214.alpha = .75
	elseif (h.cTorso1 == 23) then
		b.colorSquare212.isVisible = true
		b.colorSquare214.isVisible = true
		b.colorSquare212.alpha = 1
		b.colorSquare214.alpha = .55
	elseif (h.cTorso1 == 24) then
		b.colorSquare212.isVisible = true
		b.colorSquare214.isVisible = true
		b.colorSquare212.alpha = 1
		b.colorSquare214.alpha = .38
	elseif (h.cTorso1 == 25) then
		b.colorSquare212.isVisible = true
		b.colorSquare214.isVisible = true
		b.colorSquare212.alpha = 1
		b.colorSquare214.alpha = .20
	elseif (h.cTorso1 == 26) then
		b.colorSquare212.isVisible = true
		b.colorSquare212.isVisible = true
		b.colorSquare212.alpha = 1
		b.colorSquare212.alpha = 1
	end



	if (h.cTorso2 == 1) then
		b.colorSquare224.isVisible = true
		b.colorSquare225.isVisible = true
		b.colorSquare224.alpha = 1
		b.colorSquare225.alpha = .75
	elseif (h.cTorso2 == 2) then
		b.colorSquare224.isVisible = true
		b.colorSquare225.isVisible = true
		b.colorSquare224.alpha = 1
		b.colorSquare225.alpha = .50
	elseif (h.cTorso2 == 3) then
		b.colorSquare224.isVisible = true
		b.colorSquare225.isVisible = true
		b.colorSquare224.alpha = 1
		b.colorSquare225.alpha = .30
	elseif (h.cTorso2 == 4) then
		b.colorSquare223.isVisible = true
		b.colorSquare225.isVisible = true
		b.colorSquare223.alpha = 1
		b.colorSquare225.alpha = .35
	elseif (h.cTorso2 == 5) then
		b.colorSquare223.isVisible = true
		b.colorSquare225.isVisible = true
		b.colorSquare223.alpha = 1
		b.colorSquare225.alpha = .47
	elseif (h.cTorso2 == 6) then
		b.colorSquare223.isVisible = true
		b.colorSquare225.isVisible = true
		b.colorSquare223.alpha = 1
		b.colorSquare225.alpha = .65
	elseif (h.cTorso2 == 7) then
		b.colorSquare221.isVisible = true
		b.colorSquare223.isVisible = true
		b.colorSquare221.alpha = 1
		b.colorSquare223.alpha = .50
	elseif (h.cTorso2 == 8) then
		b.colorSquare221.isVisible = true
		b.colorSquare223.isVisible = true
		b.colorSquare221.alpha = 1
		b.colorSquare223.alpha = .25
	elseif (h.cTorso2 == 9) then
		b.colorSquare221.isVisible = true
		b.colorSquare222.isVisible = true
		b.colorSquare221.alpha = 1
		b.colorSquare222.alpha = .25
	elseif (h.cTorso2 == 10) then
		b.colorSquare221.isVisible = true
		b.colorSquare222.isVisible = true
		b.colorSquare221.alpha = 1
		b.colorSquare222.alpha = .50
	elseif (h.cTorso2 == 11) then
		b.colorSquare223.isVisible = true
		b.colorSquare224.isVisible = true
		b.colorSquare223.alpha = 1
		b.colorSquare224.alpha = .50
	elseif (h.cTorso2 == 12) then
		b.colorSquare223.isVisible = true
		b.colorSquare223.isVisible = true
		b.colorSquare223.alpha = 1
		b.colorSquare223.alpha = 1
	elseif (h.cTorso2 == 13) then
		b.colorSquare222.isVisible = true
		b.colorSquare223.isVisible = true
		b.colorSquare222.alpha = 1
		b.colorSquare223.alpha = .58
	elseif (h.cTorso2 == 14) then
		b.colorSquare222.isVisible = true
		b.colorSquare223.isVisible = true
		b.colorSquare222.alpha = 1
		b.colorSquare223.alpha = .36
	elseif (h.cTorso2 == 15) then
		b.colorSquare221.isVisible = true
		b.colorSquare224.isVisible = true
		b.colorSquare221.alpha = 1
		b.colorSquare224.alpha = .50
	elseif (h.cTorso2 == 16) then
		b.colorSquare221.isVisible = true
		b.colorSquare221.isVisible = true
		b.colorSquare221.alpha = 1
		b.colorSquare221.alpha = 1
	elseif (h.cTorso2 == 17) then
		b.colorSquare221.isVisible = true
		b.colorSquare225.isVisible = true
		b.colorSquare221.alpha = 1
		b.colorSquare225.alpha = .40
	elseif (h.cTorso2 == 18) then
		b.colorSquare221.isVisible = true
		b.colorSquare225.isVisible = true
		b.colorSquare221.alpha = 1
		b.colorSquare225.alpha = .80
	elseif (h.cTorso2 == 19) then
		b.colorSquare225.isVisible = true
		b.colorSquare225.isVisible = true
		b.colorSquare225.alpha = 1
		b.colorSquare225.alpha = 1
	elseif (h.cTorso2 == 20) then
		b.colorSquare222.isVisible = true
		b.colorSquare225.isVisible = true
		b.colorSquare222.alpha = 1
		b.colorSquare225.alpha = .50
	elseif (h.cTorso2 == 21) then
		b.colorSquare224.isVisible = true
		b.colorSquare224.isVisible = true
		b.colorSquare224.alpha = 1
		b.colorSquare224.alpha = 1
	elseif (h.cTorso2 == 22) then
		b.colorSquare222.isVisible = true
		b.colorSquare224.isVisible = true
		b.colorSquare222.alpha = 1
		b.colorSquare224.alpha = .75
	elseif (h.cTorso2 == 23) then
		b.colorSquare222.isVisible = true
		b.colorSquare224.isVisible = true
		b.colorSquare222.alpha = 1
		b.colorSquare224.alpha = .55
	elseif (h.cTorso2 == 24) then
		b.colorSquare222.isVisible = true
		b.colorSquare224.isVisible = true
		b.colorSquare222.alpha = 1
		b.colorSquare224.alpha = .38
	elseif (h.cTorso2 == 25) then
		b.colorSquare222.isVisible = true
		b.colorSquare224.isVisible = true
		b.colorSquare222.alpha = 1
		b.colorSquare224.alpha = .20
	elseif (h.cTorso2 == 26) then
		b.colorSquare222.isVisible = true
		b.colorSquare222.isVisible = true
		b.colorSquare222.alpha = 1
		b.colorSquare222.alpha = 1
	end
	

	if (h.cArms == 1) then
		b.colorSquare314.isVisible = true
		b.colorSquare315.isVisible = true
		b.colorSquare314.alpha = 1
		b.colorSquare315.alpha = .75
	elseif (h.cArms == 2) then
		b.colorSquare314.isVisible = true
		b.colorSquare315.isVisible = true
		b.colorSquare314.alpha = 1
		b.colorSquare315.alpha = .50
	elseif (h.cArms == 3) then
		b.colorSquare314.isVisible = true
		b.colorSquare315.isVisible = true
		b.colorSquare314.alpha = 1
		b.colorSquare315.alpha = .30
	elseif (h.cArms == 4) then
		b.colorSquare313.isVisible = true
		b.colorSquare315.isVisible = true
		b.colorSquare313.alpha = 1
		b.colorSquare315.alpha = .35
	elseif (h.cArms == 5) then
		b.colorSquare313.isVisible = true
		b.colorSquare315.isVisible = true
		b.colorSquare313.alpha = 1
		b.colorSquare315.alpha = .47
	elseif (h.cArms == 6) then
		b.colorSquare313.isVisible = true
		b.colorSquare315.isVisible = true
		b.colorSquare313.alpha = 1
		b.colorSquare315.alpha = .65
	elseif (h.cArms == 7) then
		b.colorSquare311.isVisible = true
		b.colorSquare313.isVisible = true
		b.colorSquare311.alpha = 1
		b.colorSquare313.alpha = .50
	elseif (h.cArms == 8) then
		b.colorSquare311.isVisible = true
		b.colorSquare313.isVisible = true
		b.colorSquare311.alpha = 1
		b.colorSquare313.alpha = .25
	elseif (h.cArms == 9) then
		b.colorSquare311.isVisible = true
		b.colorSquare312.isVisible = true
		b.colorSquare311.alpha = 1
		b.colorSquare312.alpha = .25
	elseif (h.cArms == 10) then
		b.colorSquare311.isVisible = true
		b.colorSquare312.isVisible = true
		b.colorSquare311.alpha = 1
		b.colorSquare312.alpha = .50
	elseif (h.cArms == 11) then
		b.colorSquare313.isVisible = true
		b.colorSquare314.isVisible = true
		b.colorSquare313.alpha = 1
		b.colorSquare314.alpha = .50
	elseif (h.cArms == 12) then
		b.colorSquare313.isVisible = true
		b.colorSquare313.isVisible = true
		b.colorSquare313.alpha = 1
		b.colorSquare313.alpha = 1
	elseif (h.cArms == 13) then
		b.colorSquare312.isVisible = true
		b.colorSquare313.isVisible = true
		b.colorSquare312.alpha = 1
		b.colorSquare313.alpha = .58
	elseif (h.cArms == 14) then
		b.colorSquare312.isVisible = true
		b.colorSquare313.isVisible = true
		b.colorSquare312.alpha = 1
		b.colorSquare313.alpha = .36
	elseif (h.cArms == 15) then
		b.colorSquare311.isVisible = true
		b.colorSquare314.isVisible = true
		b.colorSquare311.alpha = 1
		b.colorSquare314.alpha = .50
	elseif (h.cArms == 16) then
		b.colorSquare311.isVisible = true
		b.colorSquare311.isVisible = true
		b.colorSquare311.alpha = 1
		b.colorSquare311.alpha = 1
	elseif (h.cArms == 17) then
		b.colorSquare311.isVisible = true
		b.colorSquare315.isVisible = true
		b.colorSquare311.alpha = 1
		b.colorSquare315.alpha = .40
	elseif (h.cArms == 18) then
		b.colorSquare311.isVisible = true
		b.colorSquare315.isVisible = true
		b.colorSquare311.alpha = 1
		b.colorSquare315.alpha = .80
	elseif (h.cArms == 19) then
		b.colorSquare315.isVisible = true
		b.colorSquare315.isVisible = true
		b.colorSquare315.alpha = 1
		b.colorSquare315.alpha = 1
	elseif (h.cArms == 20) then
		b.colorSquare312.isVisible = true
		b.colorSquare315.isVisible = true
		b.colorSquare312.alpha = 1
		b.colorSquare315.alpha = .50
	elseif (h.cArms == 21) then
		b.colorSquare314.isVisible = true
		b.colorSquare314.isVisible = true
		b.colorSquare314.alpha = 1
		b.colorSquare314.alpha = 1
	elseif (h.cArms == 22) then
		b.colorSquare312.isVisible = true
		b.colorSquare314.isVisible = true
		b.colorSquare312.alpha = 1
		b.colorSquare314.alpha = .75
	elseif (h.cArms == 23) then
		b.colorSquare312.isVisible = true
		b.colorSquare314.isVisible = true
		b.colorSquare312.alpha = 1
		b.colorSquare314.alpha = .55
	elseif (h.cArms == 24) then
		b.colorSquare312.isVisible = true
		b.colorSquare314.isVisible = true
		b.colorSquare312.alpha = 1
		b.colorSquare314.alpha = .38
	elseif (h.cArms == 25) then
		b.colorSquare312.isVisible = true
		b.colorSquare314.isVisible = true
		b.colorSquare312.alpha = 1
		b.colorSquare314.alpha = .20
	elseif (h.cArms == 26) then
		b.colorSquare312.isVisible = true
		b.colorSquare312.isVisible = true
		b.colorSquare312.alpha = 1
		b.colorSquare312.alpha = 1
	end



	if (h.cLegs == 1) then
		b.colorSquare324.isVisible = true
		b.colorSquare325.isVisible = true
		b.colorSquare324.alpha = 1
		b.colorSquare325.alpha = .75
	elseif (h.cLegs == 2) then
		b.colorSquare324.isVisible = true
		b.colorSquare325.isVisible = true
		b.colorSquare324.alpha = 1
		b.colorSquare325.alpha = .50
	elseif (h.cLegs == 3) then
		b.colorSquare324.isVisible = true
		b.colorSquare325.isVisible = true
		b.colorSquare324.alpha = 1
		b.colorSquare325.alpha = .30
	elseif (h.cLegs == 4) then
		b.colorSquare323.isVisible = true
		b.colorSquare325.isVisible = true
		b.colorSquare323.alpha = 1
		b.colorSquare325.alpha = .35
	elseif (h.cLegs == 5) then
		b.colorSquare323.isVisible = true
		b.colorSquare325.isVisible = true
		b.colorSquare323.alpha = 1
		b.colorSquare325.alpha = .47
	elseif (h.cLegs == 6) then
		b.colorSquare323.isVisible = true
		b.colorSquare325.isVisible = true
		b.colorSquare323.alpha = 1
		b.colorSquare325.alpha = .65
	elseif (h.cLegs == 7) then
		b.colorSquare321.isVisible = true
		b.colorSquare323.isVisible = true
		b.colorSquare321.alpha = 1
		b.colorSquare323.alpha = .50
	elseif (h.cLegs == 8) then
		b.colorSquare321.isVisible = true
		b.colorSquare323.isVisible = true
		b.colorSquare321.alpha = 1
		b.colorSquare323.alpha = .25
	elseif (h.cLegs == 9) then
		b.colorSquare321.isVisible = true
		b.colorSquare322.isVisible = true
		b.colorSquare321.alpha = 1
		b.colorSquare322.alpha = .25
	elseif (h.cLegs == 10) then
		b.colorSquare321.isVisible = true
		b.colorSquare322.isVisible = true
		b.colorSquare321.alpha = 1
		b.colorSquare322.alpha = .50
	elseif (h.cLegs == 11) then
		b.colorSquare323.isVisible = true
		b.colorSquare324.isVisible = true
		b.colorSquare323.alpha = 1
		b.colorSquare324.alpha = .50
	elseif (h.cLegs == 12) then
		b.colorSquare323.isVisible = true
		b.colorSquare323.isVisible = true
		b.colorSquare323.alpha = 1
		b.colorSquare323.alpha = 1
	elseif (h.cLegs == 13) then
		b.colorSquare322.isVisible = true
		b.colorSquare323.isVisible = true
		b.colorSquare322.alpha = 1
		b.colorSquare323.alpha = .58
	elseif (h.cLegs == 14) then
		b.colorSquare322.isVisible = true
		b.colorSquare323.isVisible = true
		b.colorSquare322.alpha = 1
		b.colorSquare323.alpha = .36
	elseif (h.cLegs == 15) then
		b.colorSquare321.isVisible = true
		b.colorSquare324.isVisible = true
		b.colorSquare321.alpha = 1
		b.colorSquare324.alpha = .50
	elseif (h.cLegs == 16) then
		b.colorSquare321.isVisible = true
		b.colorSquare321.isVisible = true
		b.colorSquare321.alpha = 1
		b.colorSquare321.alpha = 1
	elseif (h.cLegs == 17) then
		b.colorSquare321.isVisible = true
		b.colorSquare325.isVisible = true
		b.colorSquare321.alpha = 1
		b.colorSquare325.alpha = .40
	elseif (h.cLegs == 18) then
		b.colorSquare321.isVisible = true
		b.colorSquare325.isVisible = true
		b.colorSquare321.alpha = 1
		b.colorSquare325.alpha = .80
	elseif (h.cLegs == 19) then
		b.colorSquare325.isVisible = true
		b.colorSquare325.isVisible = true
		b.colorSquare325.alpha = 1
		b.colorSquare325.alpha = 1
	elseif (h.cLegs == 20) then
		b.colorSquare322.isVisible = true
		b.colorSquare325.isVisible = true
		b.colorSquare322.alpha = 1
		b.colorSquare325.alpha = .50
	elseif (h.cLegs == 21) then
		b.colorSquare324.isVisible = true
		b.colorSquare324.isVisible = true
		b.colorSquare324.alpha = 1
		b.colorSquare324.alpha = 1
	elseif (h.cLegs == 22) then
		b.colorSquare322.isVisible = true
		b.colorSquare324.isVisible = true
		b.colorSquare322.alpha = 1
		b.colorSquare324.alpha = .75
	elseif (h.cLegs == 23) then
		b.colorSquare322.isVisible = true
		b.colorSquare324.isVisible = true
		b.colorSquare322.alpha = 1
		b.colorSquare324.alpha = .55
	elseif (h.cLegs == 24) then
		b.colorSquare322.isVisible = true
		b.colorSquare324.isVisible = true
		b.colorSquare322.alpha = 1
		b.colorSquare324.alpha = .38
	elseif (h.cLegs == 25) then
		b.colorSquare322.isVisible = true
		b.colorSquare324.isVisible = true
		b.colorSquare322.alpha = 1
		b.colorSquare324.alpha = .20
	elseif (h.cLegs == 26) then
		b.colorSquare322.isVisible = true
		b.colorSquare322.isVisible = true
		b.colorSquare322.alpha = 1
		b.colorSquare322.alpha = 1
	end
	
	
	
	if (b.colorToBeSelected == 1) then
		b.colorSquareX.x = b.colorSquare111.x
		b.colorSquareX.y = b.colorSquare111.y
	elseif (b.colorToBeSelected == 2) then
		b.colorSquareX.x = b.colorSquare121.x
		b.colorSquareX.y = b.colorSquare121.y
	elseif (b.colorToBeSelected == 3) then
		b.colorSquareX.x = b.colorSquare211.x
		b.colorSquareX.y = b.colorSquare211.y
	elseif (b.colorToBeSelected == 4) then
		b.colorSquareX.x = b.colorSquare221.x
		b.colorSquareX.y = b.colorSquare221.y	
	elseif (b.colorToBeSelected == 5) then
		b.colorSquareX.x = b.colorSquare311.x
		b.colorSquareX.y = b.colorSquare311.y
	elseif (b.colorToBeSelected == 6) then
		b.colorSquareX.x = b.colorSquare321.x
		b.colorSquareX.y = b.colorSquare321.y	
	end
	
	
end


function pickTheColors(p)

	if (b.colorToBeSelected == 1) then
		h.cHead1 = p
	elseif (b.colorToBeSelected == 2) then
		h.cHead2 = p
	elseif (b.colorToBeSelected == 3) then
		h.cTorso1 = p
	elseif (b.colorToBeSelected == 4) then
		h.cTorso2 = p
	elseif (b.colorToBeSelected == 5) then
		h.cArms = p
	elseif (b.colorToBeSelected == 6) then
		h.cLegs = p
	end

end


function largeSquare(p)

	if (p == 1) then
	
		if (b.bigSquare == 1) then
		
			b.pickSquare011.xScale = 1
			b.pickSquare011.yScale = 1
			b.pickSquare012.xScale = 1
			b.pickSquare012.yScale = 1

			b.pickSquare021.xScale = 1
			b.pickSquare021.yScale = 1
			b.pickSquare022.xScale = 1
			b.pickSquare022.yScale = 1

			b.pickSquare031.xScale = 1
			b.pickSquare031.yScale = 1
			b.pickSquare032.xScale = 1
			b.pickSquare032.yScale = 1

			b.pickSquare041.xScale = 1
			b.pickSquare041.yScale = 1
			b.pickSquare042.xScale = 1
			b.pickSquare042.yScale = 1
			
			b.pickSquare051.xScale = 1
			b.pickSquare051.yScale = 1
			b.pickSquare052.xScale = 1
			b.pickSquare052.yScale = 1
			
			b.pickSquare061.xScale = 1
			b.pickSquare061.yScale = 1
			b.pickSquare062.xScale = 1
			b.pickSquare062.yScale = 1
			
			b.pickSquare071.xScale = 1
			b.pickSquare071.yScale = 1
			b.pickSquare072.xScale = 1
			b.pickSquare072.yScale = 1
			
			b.pickSquare081.xScale = 1
			b.pickSquare081.yScale = 1
			b.pickSquare082.xScale = 1
			b.pickSquare082.yScale = 1
			
			b.pickSquare091.xScale = 1
			b.pickSquare091.yScale = 1
			b.pickSquare092.xScale = 1
			b.pickSquare092.yScale = 1
			
			b.pickSquare101.xScale = 1
			b.pickSquare101.yScale = 1
			b.pickSquare102.xScale = 1
			b.pickSquare102.yScale = 1
			
			b.pickSquare111.xScale = 1
			b.pickSquare111.yScale = 1
			b.pickSquare112.xScale = 1
			b.pickSquare112.yScale = 1
			
			b.pickSquare121.xScale = 1
			b.pickSquare121.yScale = 1
			b.pickSquare122.xScale = 1
			b.pickSquare122.yScale = 1
			
			b.pickSquare131.xScale = 1
			b.pickSquare131.yScale = 1
			b.pickSquare132.xScale = 1
			b.pickSquare132.yScale = 1
			
			b.pickSquare141.xScale = 1
			b.pickSquare141.yScale = 1
			b.pickSquare142.xScale = 1
			b.pickSquare142.yScale = 1
			
			b.pickSquare151.xScale = 1
			b.pickSquare151.yScale = 1
			b.pickSquare152.xScale = 1
			b.pickSquare152.yScale = 1
			
			b.pickSquare161.xScale = 1
			b.pickSquare161.yScale = 1
			b.pickSquare162.xScale = 1
			b.pickSquare162.yScale = 1
			
			b.pickSquare171.xScale = 1
			b.pickSquare171.yScale = 1
			b.pickSquare172.xScale = 1
			b.pickSquare172.yScale = 1
			
			b.pickSquare181.xScale = 1
			b.pickSquare181.yScale = 1
			b.pickSquare182.xScale = 1
			b.pickSquare182.yScale = 1
			
			b.pickSquare191.xScale = 1
			b.pickSquare191.yScale = 1
			b.pickSquare192.xScale = 1
			b.pickSquare192.yScale = 1
			
			b.pickSquare201.xScale = 1
			b.pickSquare201.yScale = 1
			b.pickSquare202.xScale = 1
			b.pickSquare202.yScale = 1
			
			b.pickSquare211.xScale = 1
			b.pickSquare211.yScale = 1
			b.pickSquare212.xScale = 1
			b.pickSquare212.yScale = 1
			
			b.pickSquare221.xScale = 1
			b.pickSquare221.yScale = 1
			b.pickSquare222.xScale = 1
			b.pickSquare222.yScale = 1
			
			b.pickSquare231.xScale = 1
			b.pickSquare231.yScale = 1
			b.pickSquare232.xScale = 1
			b.pickSquare232.yScale = 1
			
			b.pickSquare241.xScale = 1
			b.pickSquare241.yScale = 1
			b.pickSquare242.xScale = 1
			b.pickSquare242.yScale = 1
			
			b.pickSquare251.xScale = 1
			b.pickSquare251.yScale = 1
			b.pickSquare252.xScale = 1
			b.pickSquare252.yScale = 1
			
			b.pickSquare261.xScale = 1
			b.pickSquare261.yScale = 1
			b.pickSquare262.xScale = 1
			b.pickSquare262.yScale = 1
			
			

		end

		if (b.bigSquare > 0) then
			b.bigSquare = b.bigSquare - 1
		end


	else
		p.xScale = 1.25
		p.yScale = 1.25
	end

end


function socialNetworkBtnTouch(e)

	if (e.target == b.facebookEn) then
	
		if (e.phase == "began") then
			b.facebookEn.xScale = 1.2
			b.facebookEn.yScale = 1.2
			display.getCurrentStage():setFocus(e.target, e.id)
			if (v.soundOn == 1) then
				audio.play(a.clickSoundMenu, 12)
			end
		end
		
		if (e.phase == "ended") then
			b.facebookEn.xScale = 1
			b.facebookEn.yScale = 1
			display.getCurrentStage():setFocus(e.target, nil)
			if (b.enOrSp == 2) then
				system.openURL("http://www.facebook.com/PlayAztecGold")
			else
				system.openURL("http://www.facebook.com/PlayAztecGold")
			end
		end
	end
end


function pColorSquareListener(e)
	
	if(v.isPaused == false) then

		if (e.phase == "began") then
		
			if (v.soundOn == 1) then
				audio.play(a.clickSoundMenu, 12)
			end

			if (e.target == b.pickSquare012) then
				pickTheColors(1)
				largeSquare(b.pickSquare011)
				largeSquare(b.pickSquare012)
				b.bigSquare = 10
			elseif(e.target == b.pickSquare022) then
				pickTheColors(2)
				largeSquare(b.pickSquare021)
				largeSquare(b.pickSquare022)
				b.bigSquare = 10
			elseif(e.target == b.pickSquare032) then
				pickTheColors(3)
				largeSquare(b.pickSquare031)
				largeSquare(b.pickSquare032)
				b.bigSquare = 10
			elseif(e.target == b.pickSquare042) then
				pickTheColors(4)
				largeSquare(b.pickSquare041)
				largeSquare(b.pickSquare042)
				b.bigSquare = 10
			elseif(e.target == b.pickSquare052) then
				pickTheColors(5)
				largeSquare(b.pickSquare051)
				largeSquare(b.pickSquare052)
				b.bigSquare = 10
			elseif(e.target == b.pickSquare062) then
				pickTheColors(6)
				largeSquare(b.pickSquare061)
				largeSquare(b.pickSquare062)
				b.bigSquare = 10
			elseif(e.target == b.pickSquare072) then
				pickTheColors(7)
				largeSquare(b.pickSquare071)
				largeSquare(b.pickSquare072)
				b.bigSquare = 10
			elseif(e.target == b.pickSquare082) then
				pickTheColors(8)
				largeSquare(b.pickSquare081)
				largeSquare(b.pickSquare082)
				b.bigSquare = 10
			elseif(e.target == b.pickSquare092) then
				pickTheColors(9)
				largeSquare(b.pickSquare091)
				largeSquare(b.pickSquare092)
				b.bigSquare = 10
			elseif(e.target == b.pickSquare102) then
				pickTheColors(10)
				largeSquare(b.pickSquare101)
				largeSquare(b.pickSquare102)
				b.bigSquare = 10
			elseif(e.target == b.pickSquare112) then
				pickTheColors(11)
				largeSquare(b.pickSquare111)
				largeSquare(b.pickSquare112)
				b.bigSquare = 10
			elseif(e.target == b.pickSquare122) then
				pickTheColors(12)
				largeSquare(b.pickSquare121)
				largeSquare(b.pickSquare122)
				b.bigSquare = 10
			elseif(e.target == b.pickSquare132) then
				pickTheColors(13)
				largeSquare(b.pickSquare131)
				largeSquare(b.pickSquare132)
				b.bigSquare = 10
			elseif(e.target == b.pickSquare142) then
				pickTheColors(14)
				largeSquare(b.pickSquare141)
				largeSquare(b.pickSquare142)
				b.bigSquare = 10
			elseif(e.target == b.pickSquare152) then
				pickTheColors(15)
				largeSquare(b.pickSquare151)
				largeSquare(b.pickSquare152)
				b.bigSquare = 10
			elseif(e.target == b.pickSquare162) then
				pickTheColors(16)
				largeSquare(b.pickSquare161)
				largeSquare(b.pickSquare162)
				b.bigSquare = 10
			elseif(e.target == b.pickSquare172) then
				pickTheColors(17)
				largeSquare(b.pickSquare171)
				largeSquare(b.pickSquare172)
				b.bigSquare = 10
			elseif(e.target == b.pickSquare182) then
				pickTheColors(18)
				largeSquare(b.pickSquare181)
				largeSquare(b.pickSquare182)
				b.bigSquare = 10
			elseif(e.target == b.pickSquare192) then
				pickTheColors(19)
				largeSquare(b.pickSquare191)
				largeSquare(b.pickSquare192)
				b.bigSquare = 10
			elseif(e.target == b.pickSquare202) then
				pickTheColors(20)
				largeSquare(b.pickSquare201)
				largeSquare(b.pickSquare202)
				b.bigSquare = 10
			elseif(e.target == b.pickSquare212) then
				pickTheColors(21)
				largeSquare(b.pickSquare211)
				largeSquare(b.pickSquare212)
				b.bigSquare = 10
			elseif(e.target == b.pickSquare222) then
				pickTheColors(22)
				largeSquare(b.pickSquare221)
				largeSquare(b.pickSquare222)
				b.bigSquare = 10
			elseif(e.target == b.pickSquare232) then
				pickTheColors(23)
				largeSquare(b.pickSquare231)
				largeSquare(b.pickSquare232)
				b.bigSquare = 10
			elseif(e.target == b.pickSquare242) then
				pickTheColors(24)
				largeSquare(b.pickSquare241)
				largeSquare(b.pickSquare242)
				b.bigSquare = 10
			elseif(e.target == b.pickSquare252) then
				pickTheColors(25)
				largeSquare(b.pickSquare251)
				largeSquare(b.pickSquare252)
				b.bigSquare = 10
			elseif(e.target == b.pickSquare262) then
				pickTheColors(26)
				largeSquare(b.pickSquare261)
				largeSquare(b.pickSquare262)
				b.bigSquare = 10
			elseif(e.target == b.broadway) then
				if (h.cBroadway == 0) then
					h.cBroadway = 1
					b.broadway.alpha = 1
				else
					h.cBroadway = 0
					b.broadway.alpha = .5
				end
			elseif(e.target == b.lasVegas) then
				if (h.cVegas == 0) then
					h.cVegas = 1
					b.lasVegas.alpha = 1
					h.t1 = 1
					h.t2 = 1
					h.t3 = 1
				else
					h.cVegas = 0
					b.lasVegas.alpha = .5
				end				
			elseif(e.target == b.colorSquare111) then
				b.colorToBeSelected = 1
			elseif(e.target == b.colorSquare112) then
				b.colorToBeSelected = 1
			elseif(e.target == b.colorSquare113) then
				b.colorToBeSelected = 1
			elseif(e.target == b.colorSquare114) then
				b.colorToBeSelected = 1
			elseif(e.target == b.colorSquare115) then
				b.colorToBeSelected = 1
			elseif(e.target == b.colorSquare121) then
				b.colorToBeSelected = 2
			elseif(e.target == b.colorSquare122) then
				b.colorToBeSelected = 2
			elseif(e.target == b.colorSquare123) then
				b.colorToBeSelected = 2
			elseif(e.target == b.colorSquare124) then
				b.colorToBeSelected = 2
			elseif(e.target == b.colorSquare125) then
				b.colorToBeSelected = 2
			elseif(e.target == b.colorSquare211) then
				b.colorToBeSelected = 3
			elseif(e.target == b.colorSquare212) then
				b.colorToBeSelected = 3
			elseif(e.target == b.colorSquare213) then
				b.colorToBeSelected = 3
			elseif(e.target == b.colorSquare214) then
				b.colorToBeSelected = 3
			elseif(e.target == b.colorSquare215) then
				b.colorToBeSelected = 3
			elseif(e.target == b.colorSquare221) then
				b.colorToBeSelected = 4
			elseif(e.target == b.colorSquare222) then
				b.colorToBeSelected = 4
			elseif(e.target == b.colorSquare223) then
				b.colorToBeSelected = 4
			elseif(e.target == b.colorSquare224) then
				b.colorToBeSelected = 4
			elseif(e.target == b.colorSquare225) then
				b.colorToBeSelected = 4
			elseif(e.target == b.colorSquare311) then
				b.colorToBeSelected = 5
			elseif(e.target == b.colorSquare312) then
				b.colorToBeSelected = 5
			elseif(e.target == b.colorSquare313) then
				b.colorToBeSelected = 5
			elseif(e.target == b.colorSquare314) then
				b.colorToBeSelected = 5
			elseif(e.target == b.colorSquare315) then
				b.colorToBeSelected = 5
			elseif(e.target == b.colorSquare321) then
				b.colorToBeSelected = 6
			elseif(e.target == b.colorSquare322) then
				b.colorToBeSelected = 6
			elseif(e.target == b.colorSquare323) then
				b.colorToBeSelected = 6
			elseif(e.target == b.colorSquare324) then
				b.colorToBeSelected = 6
			elseif(e.target == b.colorSquare325) then
				b.colorToBeSelected = 6
			end
		end

		updateColorsScreen()
		
	end
	
end


function addColorSquareListeners(p)

	if (p == 1) then
		
		b.pickSquare012:addEventListener("touch", pColorSquareListener)
		b.pickSquare022:addEventListener("touch", pColorSquareListener)
		b.pickSquare032:addEventListener("touch", pColorSquareListener)
		b.pickSquare042:addEventListener("touch", pColorSquareListener)
		b.pickSquare052:addEventListener("touch", pColorSquareListener)
		b.pickSquare062:addEventListener("touch", pColorSquareListener)
		b.pickSquare072:addEventListener("touch", pColorSquareListener)
		b.pickSquare082:addEventListener("touch", pColorSquareListener)
		b.pickSquare092:addEventListener("touch", pColorSquareListener)
		b.pickSquare102:addEventListener("touch", pColorSquareListener)
		b.pickSquare112:addEventListener("touch", pColorSquareListener)
		b.pickSquare122:addEventListener("touch", pColorSquareListener)
		b.pickSquare132:addEventListener("touch", pColorSquareListener)
		b.pickSquare142:addEventListener("touch", pColorSquareListener)
		b.pickSquare152:addEventListener("touch", pColorSquareListener)
		b.pickSquare162:addEventListener("touch", pColorSquareListener)
		b.pickSquare172:addEventListener("touch", pColorSquareListener)
		b.pickSquare182:addEventListener("touch", pColorSquareListener)
		b.pickSquare192:addEventListener("touch", pColorSquareListener)
		b.pickSquare202:addEventListener("touch", pColorSquareListener)
		b.pickSquare212:addEventListener("touch", pColorSquareListener)
		b.pickSquare222:addEventListener("touch", pColorSquareListener)
		b.pickSquare232:addEventListener("touch", pColorSquareListener)
		b.pickSquare242:addEventListener("touch", pColorSquareListener)
		b.pickSquare252:addEventListener("touch", pColorSquareListener)
		b.pickSquare262:addEventListener("touch", pColorSquareListener)
		b.broadway:addEventListener("touch", pColorSquareListener)
		b.lasVegas:addEventListener("touch", pColorSquareListener)
		
		
		b.colorSquare111:addEventListener("touch", pColorSquareListener)
--		b.colorSquare112:addEventListener("touch", pColorSquareListener)
--		b.colorSquare113:addEventListener("touch", pColorSquareListener)
--		b.colorSquare114:addEventListener("touch", pColorSquareListener)
--		b.colorSquare115:addEventListener("touch", pColorSquareListener)
			
		b.colorSquare211:addEventListener("touch", pColorSquareListener)
--		b.colorSquare212:addEventListener("touch", pColorSquareListener)
--		b.colorSquare213:addEventListener("touch", pColorSquareListener)
--		b.colorSquare214:addEventListener("touch", pColorSquareListener)
--		b.colorSquare215:addEventListener("touch", pColorSquareListener)
		
		b.colorSquare311:addEventListener("touch", pColorSquareListener)
--		b.colorSquare312:addEventListener("touch", pColorSquareListener)
--		b.colorSquare313:addEventListener("touch", pColorSquareListener)
--		b.colorSquare314:addEventListener("touch", pColorSquareListener)
--		b.colorSquare315:addEventListener("touch", pColorSquareListener)
			
		b.colorSquare121:addEventListener("touch", pColorSquareListener)
--		b.colorSquare122:addEventListener("touch", pColorSquareListener)
--		b.colorSquare123:addEventListener("touch", pColorSquareListener)
--		b.colorSquare124:addEventListener("touch", pColorSquareListener)
--		b.colorSquare125:addEventListener("touch", pColorSquareListener)
			
		b.colorSquare221:addEventListener("touch", pColorSquareListener)
--		b.colorSquare222:addEventListener("touch", pColorSquareListener)
--		b.colorSquare223:addEventListener("touch", pColorSquareListener)
--		b.colorSquare224:addEventListener("touch", pColorSquareListener)
--		b.colorSquare225:addEventListener("touch", pColorSquareListener)
		
		b.colorSquare321:addEventListener("touch", pColorSquareListener)
--		b.colorSquare322:addEventListener("touch", pColorSquareListener)
--		b.colorSquare323:addEventListener("touch", pColorSquareListener)
--		b.colorSquare324:addEventListener("touch", pColorSquareListener)
--		b.colorSquare325:addEventListener("touch", pColorSquareListener)
		
		
	else
		b.pickSquare012:removeEventListener("touch", pColorSquareListener)
		b.pickSquare022:removeEventListener("touch", pColorSquareListener)
		b.pickSquare032:removeEventListener("touch", pColorSquareListener)
		b.pickSquare042:removeEventListener("touch", pColorSquareListener)
		b.pickSquare052:removeEventListener("touch", pColorSquareListener)
		b.pickSquare062:removeEventListener("touch", pColorSquareListener)
		b.pickSquare072:removeEventListener("touch", pColorSquareListener)
		b.pickSquare082:removeEventListener("touch", pColorSquareListener)
		b.pickSquare092:removeEventListener("touch", pColorSquareListener)
		b.pickSquare102:removeEventListener("touch", pColorSquareListener)
		b.pickSquare112:removeEventListener("touch", pColorSquareListener)
		b.pickSquare122:removeEventListener("touch", pColorSquareListener)
		b.pickSquare132:removeEventListener("touch", pColorSquareListener)
		b.pickSquare142:removeEventListener("touch", pColorSquareListener)
		b.pickSquare152:removeEventListener("touch", pColorSquareListener)
		b.pickSquare162:removeEventListener("touch", pColorSquareListener)
		b.pickSquare172:removeEventListener("touch", pColorSquareListener)
		b.pickSquare182:removeEventListener("touch", pColorSquareListener)
		b.pickSquare192:removeEventListener("touch", pColorSquareListener)
		b.pickSquare202:removeEventListener("touch", pColorSquareListener)
		b.pickSquare212:removeEventListener("touch", pColorSquareListener)
		b.pickSquare222:removeEventListener("touch", pColorSquareListener)
		b.pickSquare232:removeEventListener("touch", pColorSquareListener)
		b.pickSquare242:removeEventListener("touch", pColorSquareListener)
		b.pickSquare252:removeEventListener("touch", pColorSquareListener)
		b.pickSquare262:removeEventListener("touch", pColorSquareListener)
		b.broadway:removeEventListener("touch", pColorSquareListener)
		b.lasVegas:removeEventListener("touch", pColorSquareListener)


		b.colorSquare111:removeEventListener("touch", pColorSquareListener)
		b.colorSquare112:removeEventListener("touch", pColorSquareListener)
		b.colorSquare113:removeEventListener("touch", pColorSquareListener)
		b.colorSquare114:removeEventListener("touch", pColorSquareListener)
		b.colorSquare115:removeEventListener("touch", pColorSquareListener)
			
		b.colorSquare211:removeEventListener("touch", pColorSquareListener)
		b.colorSquare212:removeEventListener("touch", pColorSquareListener)
		b.colorSquare213:removeEventListener("touch", pColorSquareListener)
		b.colorSquare214:removeEventListener("touch", pColorSquareListener)
		b.colorSquare215:removeEventListener("touch", pColorSquareListener)
		
		b.colorSquare311:removeEventListener("touch", pColorSquareListener)
		b.colorSquare312:removeEventListener("touch", pColorSquareListener)
		b.colorSquare313:removeEventListener("touch", pColorSquareListener)
		b.colorSquare314:removeEventListener("touch", pColorSquareListener)
		b.colorSquare315:removeEventListener("touch", pColorSquareListener)
			
		b.colorSquare121:removeEventListener("touch", pColorSquareListener)
		b.colorSquare122:removeEventListener("touch", pColorSquareListener)
		b.colorSquare123:removeEventListener("touch", pColorSquareListener)
		b.colorSquare124:removeEventListener("touch", pColorSquareListener)
		b.colorSquare125:removeEventListener("touch", pColorSquareListener)
			
		b.colorSquare221:removeEventListener("touch", pColorSquareListener)
		b.colorSquare222:removeEventListener("touch", pColorSquareListener)
		b.colorSquare223:removeEventListener("touch", pColorSquareListener)
		b.colorSquare224:removeEventListener("touch", pColorSquareListener)
		b.colorSquare225:removeEventListener("touch", pColorSquareListener)
		
		b.colorSquare321:removeEventListener("touch", pColorSquareListener)
		b.colorSquare322:removeEventListener("touch", pColorSquareListener)
		b.colorSquare323:removeEventListener("touch", pColorSquareListener)
		b.colorSquare324:removeEventListener("touch", pColorSquareListener)
		b.colorSquare325:removeEventListener("touch", pColorSquareListener)
		
	
	end

end


function levelStartWeaponsChange()

	if (rifleAmmo > 0) then
		activeWeapon = "rifleRight"
	elseif (pistolAmmo > 0) then
		activeWeapon = "pistolRight"
	elseif (tomahawkAmmo > 0) then
		if (tomahawkAmmo > 1) then
			activeWeapon = "tomahawkRight"
		else
			activeWeapon = "tomahawkLeft"
		end
	elseif (knifeAmmo > 0) then
		if (knifeAmmo > 1) then
			activeWeapon = "knifeRight"
		else
			activeWeapon = "knifeLeft"
		end
	elseif (crossbowAmmo > 0) then
		activeWeapon = "crossbow"
	else
		if (g.macheteGold.isPurchased == 1) then
			activeWeapon = "macheteGold"
		elseif (g.machete1.isPurchased == 1) then
			activeWeapon = "machete"
		elseif (g.mace1.isPurchased == 1) then
			activeWeapon = "mace"
		else
			activeWeapon = "battleAxe"
		end
	end
end


function levelOneButtonListener(e)

	if (e.phase == "began") then
		s.levelSelectButtonBackground1.xScale = 1.2
		s.levelSelectButtonBackground1.yScale = 1.2
		s.levelOneButton.xScale = 1.2
		s.levelOneButton.yScale = 1.2
		display.getCurrentStage():setFocus(e.target, e.id)
		if (v.soundOn == 1) then
			audio.play(a.clickSoundMenu, 12)
		end
		
	end


	if (e.phase == "ended") then
		activeScreen = "game"
		if (v.levelReached > 0 and v.levelReached < 6) then
			v.levelPlaying = v.levelReached
			
		else
			v.levelPlaying = 1
			
			g.arrow1.isPurchased = 1
			g.arrow2.isPurchased = 0
			g.arrow3.isPurchased = 0
			g.arrowGold.isPurchased = 0

			g.knife1Left.isPurchased = 0
			g.knife2Left.isPurchased = 0
			g.knife3Left.isPurchased = 0
			g.knifeGoldLeft.isPurchased = 0

			g.tomahawk1Left.isPurchased = 0
			g.tomahawk2Left.isPurchased = 0
			g.tomahawk3Left.isPurchased = 0
			g.tomahawkGoldLeft.isPurchased = 0

			g.pistol1Left.isPurchased = 0
			g.pistol2Left.isPurchased = 0
			g.pistol3Left.isPurchased = 0
			g.pistolGoldLeft.isPurchased = 0

			g.rifle1Left.isPurchased = 0
			g.rifle2Left.isPurchased = 0
			g.rifle3Left.isPurchased = 0
			g.rifleGoldLeft.isPurchased = 0


			g.battleAxe1.isPurchased = 1
			g.mace1.isPurchased = 0
			g.machete1.isPurchased = 0
			g.macheteGold.isPurchased = 0

			g.granade1.isPurchased = 1
			g.granadeGold.isPurchased = 0
			
			g.myGuyShield.isPurchased = 1
			g.myGuyShieldGold.isPurchased = 0
			
			crossbowAmmo = 150
			knifeAmmo = 0
			tomahawkAmmo = 0
			pistolAmmo = 0
			rifleAmmo = 0
			granadeAmmo = 3
			
			v.playerCash = 100			
			
			v.playerHealth = 100
			
			levelStartWeaponsChange()
			
		end

		s.levelSelectButtonBackground1.xScale = 1
		s.levelSelectButtonBackground1.yScale = 1
		s.levelOneButton.xScale = 1
		s.levelOneButton.yScale = 1
		display.getCurrentStage():setFocus(e.target, nil)
		audio.fadeOut({ channel = 3, time = 100 } )
		if (v.musicOn == 1) then
			audio.play(a.soundTrack01, { channel = 1, loops = -1, fadein = 500} )
		end
	end
end


function levelTwoButtonListener(e)
	if (s.levelTwoButtonMask.isVisible == false ) then
		
		if (e.phase == "began") then
			s.levelSelectButtonBackground2.xScale = 1.2
			s.levelSelectButtonBackground2.yScale = 1.2
			s.levelTwoButton.xScale = 1.2
			s.levelTwoButton.yScale = 1.2
			display.getCurrentStage():setFocus(e.target, e.id)
			if (v.soundOn == 1) then
				audio.play(a.clickSoundMenu, 12)
			end
			
		end
		
		
		if (e.phase == "ended") then
			activeScreen = "game"
			if (v.levelReached > 5 and v.levelReached < 11) then
				v.levelPlaying = v.levelReached
			else
				v.levelPlaying = 6
				
				g.arrow1.isPurchased = 1
				g.arrow2.isPurchased = 1
				g.arrow3.isPurchased = 1
				g.arrowGold.isPurchased = 1

				g.knife1Left.isPurchased = 0
				g.knife2Left.isPurchased = 0
				g.knife3Left.isPurchased = 0
				g.knifeGoldLeft.isPurchased = 0

				g.tomahawk1Left.isPurchased = 0
				g.tomahawk2Left.isPurchased = 0
				g.tomahawk3Left.isPurchased = 0
				g.tomahawkGoldLeft.isPurchased = 0

				g.pistol1Left.isPurchased = 0
				g.pistol2Left.isPurchased = 0
				g.pistol3Left.isPurchased = 0
				g.pistolGoldLeft.isPurchased = 0

				g.rifle1Left.isPurchased = 0
				g.rifle2Left.isPurchased = 0
				g.rifle3Left.isPurchased = 0
				g.rifleGoldLeft.isPurchased = 0


				g.battleAxe1.isPurchased = 1
				g.mace1.isPurchased = 0
				g.machete1.isPurchased = 0
				g.macheteGold.isPurchased = 0

				g.granade1.isPurchased = 1
				g.granadeGold.isPurchased = 0
				
				g.myGuyShield.isPurchased = 1
				g.myGuyShieldGold.isPurchased = 0
				
				crossbowAmmo = 150
				knifeAmmo = 0
				tomahawkAmmo = 0
				pistolAmmo = 0
				rifleAmmo = 0
				granadeAmmo = 6
				
				v.playerCash = 100			
				
				v.playerHealth = 100	

				levelStartWeaponsChange()
				
			end
			s.levelSelectButtonBackground2.xScale = 1
			s.levelSelectButtonBackground2.yScale = 1
			s.levelTwoButton.xScale = 1
			s.levelTwoButton.yScale = 1
			display.getCurrentStage():setFocus(e.target, nil)
			audio.fadeOut({ channel = 3, time = 100 } )
			if (v.musicOn == 1) then
				audio.play(a.soundTrack01, { channel = 1, loops = -1, fadein = 500} )
			end
		end
	end
end


function levelThreeButtonListener(e)
	if (s.levelThreeButtonMask.isVisible == false ) then

		if (e.phase == "began") then
			s.levelSelectButtonBackground3.xScale = 1.2
			s.levelSelectButtonBackground3.yScale = 1.2
			s.levelThreeButton.xScale = 1.2
			s.levelThreeButton.yScale = 1.2
			display.getCurrentStage():setFocus(e.target, e.id)
			if (v.soundOn == 1) then
				audio.play(a.clickSoundMenu, 12)
			end

		end


		if (e.phase == "ended") then
			activeScreen = "game"
			if (v.levelReached > 10 and v.levelReached < 16) then
				v.levelPlaying = v.levelReached
			else
				v.levelPlaying = 11
			
				g.arrow1.isPurchased = 1
				g.arrow2.isPurchased = 1
				g.arrow3.isPurchased = 1
				g.arrowGold.isPurchased = 1

				g.knife1Left.isPurchased = 1
				g.knife2Left.isPurchased = 1
				g.knife3Left.isPurchased = 1
				g.knifeGoldLeft.isPurchased = 1

				g.tomahawk1Left.isPurchased = 0
				g.tomahawk2Left.isPurchased = 0
				g.tomahawk3Left.isPurchased = 0
				g.tomahawkGoldLeft.isPurchased = 0

				g.pistol1Left.isPurchased = 0
				g.pistol2Left.isPurchased = 0
				g.pistol3Left.isPurchased = 0
				g.pistolGoldLeft.isPurchased = 0

				g.rifle1Left.isPurchased = 0
				g.rifle2Left.isPurchased = 0
				g.rifle3Left.isPurchased = 0
				g.rifleGoldLeft.isPurchased = 0


				g.battleAxe1.isPurchased = 1
				g.mace1.isPurchased = 1
				g.machete1.isPurchased = 0
				g.macheteGold.isPurchased = 0

				g.granade1.isPurchased = 1
				g.granadeGold.isPurchased = 0
				
				g.myGuyShield.isPurchased = 1
				g.myGuyShieldGold.isPurchased = 0
				
				crossbowAmmo = 150
				knifeAmmo = 150
				tomahawkAmmo = 0
				pistolAmmo = 0
				rifleAmmo = 0
				granadeAmmo = 9
				
				v.playerCash = 100							
				
				v.playerHealth = 100
				
				levelStartWeaponsChange()
				
			end

			s.levelSelectButtonBackground3.xScale = 1
			s.levelSelectButtonBackground3.yScale = 1
			s.levelThreeButton.xScale = 1
			s.levelThreeButton.yScale = 1
			display.getCurrentStage():setFocus(e.target, nil)
			audio.fadeOut({ channel = 3, time = 100 } )
			if (v.musicOn == 1) then
				audio.play(a.soundTrack01, { channel = 1, loops = -1, fadein = 500} )
			end

		end
	end
end


function levelFourButtonListener(e)
	if (s.levelFourButtonMask.isVisible == false ) then	

		if (e.phase == "began") then
			s.levelSelectButtonBackground4.xScale = 1.2
			s.levelSelectButtonBackground4.yScale = 1.2
			s.levelFourButton.xScale = 1.2
			s.levelFourButton.yScale = 1.2
			display.getCurrentStage():setFocus(e.target, e.id)
			if (v.soundOn == 1) then
				audio.play(a.clickSoundMenu, 12)
			end
			
		end


		if (e.phase == "ended") then
			activeScreen = "game"
			if (v.levelReached > 15 and v.levelReached < 21) then
				v.levelPlaying = v.levelReached
			else
				v.levelPlaying = 16
			
				g.arrow1.isPurchased = 1
				g.arrow2.isPurchased = 1
				g.arrow3.isPurchased = 1
				g.arrowGold.isPurchased = 1

				g.knife1Left.isPurchased = 1
				g.knife2Left.isPurchased = 1
				g.knife3Left.isPurchased = 1
				g.knifeGoldLeft.isPurchased = 1

				g.tomahawk1Left.isPurchased = 1
				g.tomahawk2Left.isPurchased = 1
				g.tomahawk3Left.isPurchased = 1
				g.tomahawkGoldLeft.isPurchased = 1

				g.pistol1Left.isPurchased = 0
				g.pistol2Left.isPurchased = 0
				g.pistol3Left.isPurchased = 0
				g.pistolGoldLeft.isPurchased = 0

				g.rifle1Left.isPurchased = 0
				g.rifle2Left.isPurchased = 0
				g.rifle3Left.isPurchased = 0
				g.rifleGoldLeft.isPurchased = 0


				g.battleAxe1.isPurchased = 1
				g.mace1.isPurchased = 1
				g.machete1.isPurchased = 0
				g.macheteGold.isPurchased = 0

				g.granade1.isPurchased = 1
				g.granadeGold.isPurchased = 0
				
				g.myGuyShield.isPurchased = 1
				g.myGuyShieldGold.isPurchased = 1
				
				crossbowAmmo = 150
				knifeAmmo = 150
				tomahawkAmmo = 150
				pistolAmmo = 0
				rifleAmmo = 0
				granadeAmmo = 12
				
				v.playerCash = 100							
			
				v.playerHealth = 127
				
				levelStartWeaponsChange()

			end

			s.levelSelectButtonBackground4.xScale = 1
			s.levelSelectButtonBackground4.yScale = 1
			s.levelFourButton.xScale = 1
			s.levelFourButton.yScale = 1
			display.getCurrentStage():setFocus(e.target, nil)
			audio.fadeOut({ channel = 3, time = 100 } )
			if (v.musicOn == 1) then
				audio.play(a.soundTrack01, { channel = 1, loops = -1, fadein = 500} )
			end

		end
	end
end


function levelFiveButtonListener(e)
	if (s.levelFiveButtonMask.isVisible == false ) then	

		if (e.phase == "began") then
			s.levelSelectButtonBackground5.xScale = 1.2
			s.levelSelectButtonBackground5.yScale = 1.2
			s.levelFiveButton.xScale = 1.2
			s.levelFiveButton.yScale = 1.2
			display.getCurrentStage():setFocus(e.target, e.id)
			if (v.soundOn == 1) then
				audio.play(a.clickSoundMenu, 12)
			end
			
		end


		if (e.phase == "ended") then
			activeScreen = "game"
			if (v.levelReached > 20 and v.levelReached < 26) then
				v.levelPlaying = v.levelReached
			else
				v.levelPlaying = 21
				
				g.arrow1.isPurchased = 1
				g.arrow2.isPurchased = 1
				g.arrow3.isPurchased = 1
				g.arrowGold.isPurchased = 1

				g.knife1Left.isPurchased = 1
				g.knife2Left.isPurchased = 1
				g.knife3Left.isPurchased = 1
				g.knifeGoldLeft.isPurchased = 1

				g.tomahawk1Left.isPurchased = 1
				g.tomahawk2Left.isPurchased = 1
				g.tomahawk3Left.isPurchased = 1
				g.tomahawkGoldLeft.isPurchased = 1

				g.pistol1Left.isPurchased = 1
				g.pistol2Left.isPurchased = 1
				g.pistol3Left.isPurchased = 1
				g.pistolGoldLeft.isPurchased = 1

				g.rifle1Left.isPurchased = 0
				g.rifle2Left.isPurchased = 0
				g.rifle3Left.isPurchased = 0
				g.rifleGoldLeft.isPurchased = 0


				g.battleAxe1.isPurchased = 1
				g.mace1.isPurchased = 1
				g.machete1.isPurchased = 1
				g.macheteGold.isPurchased = 0

				g.granade1.isPurchased = 1
				g.granadeGold.isPurchased = 0
				
				g.myGuyShield.isPurchased = 1
				g.myGuyShieldGold.isPurchased = 1
				
				crossbowAmmo = 150
				knifeAmmo = 150
				tomahawkAmmo = 150
				pistolAmmo = 100
				rifleAmmo = 0
				granadeAmmo = 15
				
				v.playerCash = 100							
				
				v.playerHealth = 127
				
				levelStartWeaponsChange()
				
			end

			s.levelSelectButtonBackground5.xScale = 1
			s.levelSelectButtonBackground5.yScale = 1
			s.levelFiveButton.xScale = 1
			s.levelFiveButton.yScale = 1
			display.getCurrentStage():setFocus(e.target, nil)
			audio.fadeOut({ channel = 3, time = 100 } )
			if (v.musicOn == 1) then
				audio.play(a.soundTrack01, { channel = 1, loops = -1, fadein = 500} )
			end

		end
	end
end


function levelSixButtonListener(e)
	if (s.levelSixButtonMask.isVisible == false ) then

		if (e.phase == "began") then
			s.levelSelectButtonBackground6.xScale = 1.2
			s.levelSelectButtonBackground6.yScale = 1.2
			s.levelSixButton.xScale = 1.2
			s.levelSixButton.yScale = 1.2
			display.getCurrentStage():setFocus(e.target, e.id)
			if (v.soundOn == 1) then
				audio.play(a.clickSoundMenu, 12)
			end
			
		end

		if (e.phase == "ended") then
			activeScreen = "game"
			if (v.levelReached > 25 and v.levelReached < 30) then
				v.levelPlaying = v.levelReached
			else
				v.levelPlaying = 26
				
				g.arrow1.isPurchased = 1
				g.arrow2.isPurchased = 1
				g.arrow3.isPurchased = 1
				g.arrowGold.isPurchased = 1

				g.knife1Left.isPurchased = 1
				g.knife2Left.isPurchased = 1
				g.knife3Left.isPurchased = 1
				g.knifeGoldLeft.isPurchased = 1

				g.tomahawk1Left.isPurchased = 1
				g.tomahawk2Left.isPurchased = 1
				g.tomahawk3Left.isPurchased = 1
				g.tomahawkGoldLeft.isPurchased = 1

				g.pistol1Left.isPurchased = 1
				g.pistol2Left.isPurchased = 1
				g.pistol3Left.isPurchased = 1
				g.pistolGoldLeft.isPurchased = 1

				g.rifle1Left.isPurchased = 1
				g.rifle2Left.isPurchased = 1
				g.rifle3Left.isPurchased = 1
				g.rifleGoldLeft.isPurchased = 1


				g.battleAxe1.isPurchased = 1
				g.mace1.isPurchased = 1
				g.machete1.isPurchased = 1
				g.macheteGold.isPurchased = 0

				g.granade1.isPurchased = 1
				g.granadeGold.isPurchased = 0
				
				g.myGuyShield.isPurchased = 1
				g.myGuyShieldGold.isPurchased = 1
				
				crossbowAmmo = 150
				knifeAmmo = 150
				tomahawkAmmo = 150
				pistolAmmo = 100
				rifleAmmo = 100
				granadeAmmo = 18
				
				v.playerCash = 100							
				
				v.playerHealth = 127
				
				levelStartWeaponsChange()
				
			end

			s.levelSelectButtonBackground6.xScale = 1
			s.levelSelectButtonBackground6.yScale = 1
			s.levelSixButton.xScale = 1
			s.levelSixButton.yScale = 1
			display.getCurrentStage():setFocus(e.target, nil)
			audio.fadeOut({ channel = 3, time = 100 } )
			if (v.musicOn == 1) then
				audio.play(a.soundTrack01, { channel = 1, loops = -1, fadein = 500} )
			end

		end
	end
end


function weaponsChangeNeeded(e)

	if (e.phase == "began") then
		if (v.soundOn == 1) then
			--audio.play(a.clickSoundMenu, 12)
		end
	end

	if (e.phase == "began" and v.playerHealth > 0 and v.everPlayed == 2 and isAttackThree == 1 and isAttackFour == 1) then
		isWeaponsChange = 1
	end
	
end


function weaponsChange(p)
	
	i.weaponsButtonBackground.num = 4
	
	local aw = activeWeapon
	
	if (p == "change" and v.changeWeaponTo == nil) then
		if(v.isPaused == false) then
			
		
			-- Change Weapons Here
			if (v.rightArmUp == 1) then
				v.rightArmUp = 0
				rightArmGroup.rotation = rightArmGroup.rotation + 90
			end
			
			activeWeapon = nil
			
			if (crossbowAmmo > 0 or knifeAmmo > 0 or tomahawkAmmo > 0 or pistolAmmo > 0 or rifleAmmo > 0) then
			
				repeat
				
					if (aw == "crossbow") then
						if (knifeAmmo > 0) then
							activeWeapon = "knifeLeft"
						else
							aw = "knifeLeft"
						end
					elseif (aw == "knifeLeft") then
						if (tomahawkAmmo > 0) then
							activeWeapon = "tomahawkLeft"
						else
							aw = "tomahawkLeft"
						end
					elseif (aw == "knifeRight") then
						if (tomahawkAmmo > 0) then
							activeWeapon = "tomahawkLeft"
						else
							aw = "tomahawkLeft"
						end
					elseif (aw == "tomahawkLeft") then
						if (pistolAmmo > 0) then
							activeWeapon = "pistolRight"
						else
							aw = "pistolRight"
						end
					elseif (aw == "tomahawkRight") then
						if (pistolAmmo > 0) then
							activeWeapon = "pistolRight"
						else
							aw = "pistolRight"
						end
					elseif (aw == "pistolRight") then
						if (rifleAmmo > 0) then
							activeWeapon = "rifleRight"
						else
							aw = "rifleRight"
						end
					elseif (aw == "rifleRight") then
						if (crossbowAmmo > 0) then
							activeWeapon = "crossbow"
						else
							aw = "crossbow"
						end
					else
						aw = "crossbow"
					end
					
				until activeWeapon ~= nil
			else
				if (g.macheteGold.isPurchased == 1) then
					activeWeapon = "macheteGold"
				elseif (g.machete1.isPurchased == 1) then
					activeWeapon = "machete"
				elseif (g.mace1.isPurchased == 1) then
					activeWeapon = "mace"
				else
					activeWeapon = "battleAxe"
				end
			end
			
		end
	
	end
	

	if (granadeAmmo == 0) then
		granadeButtonDarkMask.isVisible = true
	else
		granadeButtonDarkMask.isVisible = false
	end

	if (crossbowAmmo == 0 and knifeAmmo == 0 and tomahawkAmmo == 0 and pistolAmmo == 0 and rifleAmmo == 0) then
		attackButtonDarkMask.isVisible = true
	else
		attackButtonDarkMask.isVisible = false
	end

	
	if(v.isPaused == false) then

		if (v.rightArmUp == 1) then
			v.rightArmUp = 0
			rightArmGroup.rotation = rightArmGroup.rotation + 90
		end

		if (v.changeWeaponTo == "crossbow") then
			activeWeapon = "crossbow"
			v.changeWeaponTo = nil
		elseif (v.changeWeaponTo == "knifeLeft") then
			activeWeapon = "knifeLeft"
			v.changeWeaponTo = nil
		elseif (v.changeWeaponTo == "knifeRight") then
			activeWeapon = "knifeRight"
			v.changeWeaponTo = nil
		elseif (v.changeWeaponTo == "tomahawkLeft") then
			activeWeapon = "tomahawkLeft"
			v.changeWeaponTo = nil
		elseif (v.changeWeaponTo == "tomahawkRight") then
			activeWeapon = "tomahawkRight"
			v.changeWeaponTo = nil
		elseif (v.changeWeaponTo == "pistolRight") then
			activeWeapon = "pistolRight"
			v.changeWeaponTo = nil
		elseif (v.changeWeaponTo == "rifleRight") then
			activeWeapon = "rifleRight"
			v.changeWeaponTo = nil
		elseif (v.changeWeaponTo == "battleAxe") then
			activeWeapon = "battleAxe"
			v.changeWeaponTo = nil
		elseif (v.changeWeaponTo == "mace") then
			activeWeapon = "mace"
			v.changeWeaponTo = nil
		elseif (v.changeWeaponTo == "machete") then
			activeWeapon = "machete"
			v.changeWeaponTo = nil
		elseif (v.changeWeaponTo == "macheteGold") then
			activeWeapon = "macheteGold"
			v.changeWeaponTo = nil
		elseif (v.changeWeaponTo == "granade") then
			activeWeapon = "granade"
			v.changeWeaponTo = nil
		end
		
	end

	
	hideWeapons()
	
	i.arrow1Icon.isVisible = false
	i.arrow2Icon.isVisible = false
	i.arrow3Icon.isVisible = false
	i.arrowGoldIcon.isVisible = false
	
	i.knife1Icon.isVisible = false
	i.knife2Icon.isVisible = false
	i.knife3Icon.isVisible = false
	i.knifeGoldIcon.isVisible = false

	i.tomahawk1Icon.isVisible = false
	i.tomahawk2Icon.isVisible = false
	i.tomahawk3Icon.isVisible = false
	i.tomahawkGoldIcon.isVisible = false

	i.pistol1Icon.isVisible = false
	i.pistol2Icon.isVisible = false
	i.pistol3Icon.isVisible = false
	i.pistolGoldIcon.isVisible = false
	
	i.rifle1Icon.isVisible = false
	i.rifle2Icon.isVisible = false
	i.rifle3Icon.isVisible = false
	i.rifleGoldIcon.isVisible = false
	
	i.battleAxe1Icon.isVisible = false
	i.mace1Icon.isVisible = false
	i.machete1Icon.isVisible = false
	i.macheteGoldIcon.isVisible = false
	
	i.granade1Icon.isVisible = false
	i.granadeGoldIcon.isVisible = false

	if (activeWeapon == "crossbow") then
		writeScreenAmmo(crossbowAmmo)

		if (v.rightArmUp == 1) then
			v.rightArmUp = 0
			rightArmGroup.rotation = rightArmGroup.rotation + 90
		end
		if (g.myGuyShieldGold.isPurchased == 1) then
			g.shield11.isVisible = true
			g.shield12.isVisible = true
			g.shield21.isVisible = true
			g.shield22.isVisible = true
			g.shieldGold.isVisible = true
		else
			g.shield11.isVisible = true
			g.shield12.isVisible = true
			g.shield21.isVisible = true
			g.shield22.isVisible = true
		end

		g.arrow.isVisible = true
		g.crossbow.isVisible = true
		
		if (g.arrowGold.isPurchased == 1) then
			g.crossbowGold.isVisible = true
			g.arrowGold.isVisible = true
			g.arrowGoldDouble.isVisible = true
			i.arrowGoldIcon.isVisible = true
		elseif (g.arrow3.isPurchased == 1) then
			g.crossbow3.isVisible = true
			g.arrow3.isVisible = true
			g.arrow3Double.isVisible = true
			i.arrow3Icon.isVisible = true
		elseif (g.arrow2.isPurchased == 1) then
			g.crossbow2.isVisible = true
			g.arrow2.isVisible = true
			g.arrow2Double.isVisible = true
			i.arrow2Icon.isVisible = true
		elseif (g.arrow1.isPurchased == 1) then
			g.crossbow1.isVisible = true
			g.arrow1.isVisible = true
			g.arrow1Double.isVisible = true
			i.arrow1Icon.isVisible = true
		end		
		
		g.crossbowStringPulled.isVisible = true
	end	
	if (activeWeapon == "knifeLeft") then

		if (knifeAmmo > 1) then
			activeWeapon = "knifeRight"
			
		else
			writeScreenAmmo(knifeAmmo)
			
			if (v.rightArmUp == 1) then
				v.rightArmUp = 0
				rightArmGroup.rotation = rightArmGroup.rotation + 90
			end
			if (g.myGuyShieldGold.isPurchased == 1) then
				g.shield11.isVisible = true
				g.shield12.isVisible = true
				g.shield21.isVisible = true
				g.shield22.isVisible = true
				g.shieldGold.isVisible = true

			else
				g.shield11.isVisible = true
				g.shield12.isVisible = true
				g.shield21.isVisible = true
				g.shield22.isVisible = true

			end
				
			g.knifeLeft.isVisible = true
			if (g.knifeGoldLeft.isPurchased == 1) then
				g.knifeGoldLeft.isVisible = true
				g.knifeGoldLeftDouble.isVisible = true
				i.knifeGoldIcon.isVisible = true
			elseif (g.knife3Left.isPurchased == 1) then
				g.knife3Left.isVisible = true
				g.knife3LeftDouble.isVisible = true
				i.knife3Icon.isVisible = true
			elseif (g.knife2Left.isPurchased == 1) then
				g.knife2Left.isVisible = true
				g.knife2LeftDouble.isVisible = true
				i.knife2Icon.isVisible = true
			elseif (g.knife1Left.isPurchased == 1) then
				g.knife1Left.isVisible = true
				g.knife1LeftDouble.isVisible = true
				i.knife1Icon.isVisible = true
			end		
		end		
	end
	if (activeWeapon == "knifeRight") then
		
		writeScreenAmmo(knifeAmmo)
		if (v.rightArmUp == 0) then
			v.rightArmUp = 1
			rightArmGroup.rotation = rightArmGroup.rotation - 90
		end	
		
		g.knifeLeft.isVisible = true				
		g.knifeRight.isVisible = true				
		if (g.knifeGoldLeft.isPurchased == 1) then
			g.knifeGoldLeft.isVisible = true
			g.knifeGoldRight.isVisible = true
			g.knifeGoldLeftDouble.isVisible = true
			g.knifeGoldRightDouble.isVisible = true
			i.knifeGoldIcon.isVisible = true
		elseif (g.knife3Left.isPurchased == 1) then
			g.knife3Left.isVisible = true
			g.knife3Right.isVisible = true		
			g.knife3LeftDouble.isVisible = true
			g.knife3RightDouble.isVisible = true		
			i.knife3Icon.isVisible = true
		elseif (g.knife2Left.isPurchased == 1) then
			g.knife2Left.isVisible = true
			g.knife2Right.isVisible = true				
			g.knife2LeftDouble.isVisible = true
			g.knife2RightDouble.isVisible = true
			i.knife2Icon.isVisible = true
		elseif (g.knife1Left.isPurchased == 1) then
			g.knife1Left.isVisible = true
			g.knife1Right.isVisible = true				
			g.knife1LeftDouble.isVisible = true
			g.knife1RightDouble.isVisible = true
			i.knife1Icon.isVisible = true
		end		
	end
	if (activeWeapon == "tomahawkLeft") then

		if (tomahawkAmmo > 1) then
			activeWeapon = "tomahawkRight"
		else
			writeScreenAmmo(tomahawkAmmo)
			if (v.rightArmUp == 1) then
				v.rightArmUp = 0
				rightArmGroup.rotation = rightArmGroup.rotation + 90
			end
			if (g.myGuyShieldGold.isPurchased == 1) then
				g.shield11.isVisible = true
				g.shield12.isVisible = true
				g.shield21.isVisible = true
				g.shield22.isVisible = true
				g.shieldGold.isVisible = true
			else
				g.shield11.isVisible = true
				g.shield12.isVisible = true
				g.shield21.isVisible = true
				g.shield22.isVisible = true

			end
				
			g.tomahawkLeft.isVisible = true
			if (g.tomahawkGoldLeft.isPurchased == 1) then
				g.tomahawkGoldLeft.isVisible = true
				g.tomahawkGoldLeftDouble.isVisible = true
				i.tomahawkGoldIcon.isVisible = true
			elseif (g.tomahawk3Left.isPurchased == 1) then
				g.tomahawk3Left.isVisible = true
				g.tomahawk3LeftDouble.isVisible = true
				i.tomahawk3Icon.isVisible = true
			elseif (g.tomahawk2Left.isPurchased == 1) then
				g.tomahawk2Left.isVisible = true
				g.tomahawk2LeftDouble.isVisible = true
				i.tomahawk2Icon.isVisible = true
			elseif (g.tomahawk1Left.isPurchased == 1) then
				g.tomahawk1Left.isVisible = true
				g.tomahawk1LeftDouble.isVisible = true
				i.tomahawk1Icon.isVisible = true
			end		
		end
	end	
	if (activeWeapon == "tomahawkRight") then
		writeScreenAmmo(tomahawkAmmo)

		if (v.rightArmUp == 0) then
			v.rightArmUp = 1
			rightArmGroup.rotation = rightArmGroup.rotation - 90
		end	
		
		g.tomahawkLeft.isVisible = true				
		g.tomahawkRight.isVisible = true				
		if (g.tomahawkGoldLeft.isPurchased == 1) then
			g.tomahawkGoldLeft.isVisible = true
			g.tomahawkGoldRight.isVisible = true
			g.tomahawkGoldLeftDouble.isVisible = true
			g.tomahawkGoldRightDouble.isVisible = true
			i.tomahawkGoldIcon.isVisible = true
		elseif (g.tomahawk3Left.isPurchased == 1) then
			g.tomahawk3Left.isVisible = true
			g.tomahawk3Right.isVisible = true		
			g.tomahawk3LeftDouble.isVisible = true
			g.tomahawk3RightDouble.isVisible = true
			i.tomahawk3Icon.isVisible = true
		elseif (g.tomahawk2Left.isPurchased == 1) then
			g.tomahawk2Left.isVisible = true
			g.tomahawk2Right.isVisible = true				
			g.tomahawk2LeftDouble.isVisible = true
			g.tomahawk2RightDouble.isVisible = true
			i.tomahawk2Icon.isVisible = true
		elseif (g.tomahawk1Left.isPurchased == 1) then
			g.tomahawk1Left.isVisible = true
			g.tomahawk1Right.isVisible = true				
			g.tomahawk1LeftDouble.isVisible = true
			g.tomahawk1RightDouble.isVisible = true
			i.tomahawk1Icon.isVisible = true
		end		
	end	
	if (activeWeapon == "pistolRight") then
		writeScreenAmmo(pistolAmmo)

		if (v.rightArmUp == 0) then
			v.rightArmUp = 1
			rightArmGroup.rotation = rightArmGroup.rotation - 90
		end	
		
		g.pistolLeft.isVisible = true
		g.pistolRight.isVisible = true				
		if (g.pistolGoldLeft.isPurchased == 1) then
			g.pistolGoldLeft.isVisible = true
			g.pistolGoldRight.isVisible = true
			i.pistolGoldIcon.isVisible = true
		elseif (g.pistol3Left.isPurchased == 1) then
			g.pistol3Left.isVisible = true
			g.pistol3Right.isVisible = true	
			i.pistol3Icon.isVisible = true			
		elseif (g.pistol2Left.isPurchased == 1) then
			g.pistol2Left.isVisible = true
			g.pistol2Right.isVisible = true			
			i.pistol2Icon.isVisible = true						
		elseif (g.pistol1Left.isPurchased == 1) then
			g.pistol1Left.isVisible = true
			g.pistol1Right.isVisible = true				
			i.pistol1Icon.isVisible = true			
		end		
	end	
	if (activeWeapon == "rifleRight") then
		writeScreenAmmo(rifleAmmo)

		if (v.rightArmUp == 0) then
			v.rightArmUp = 1
			rightArmGroup.rotation = rightArmGroup.rotation - 90
		end

		g.rifleLeft.isVisible = true
		g.rifleRight.isVisible = true						
		if (g.rifleGoldLeft.isPurchased == 1) then
			g.rifleGoldLeft.isVisible = true
			g.rifleGoldRight.isVisible = true
			i.rifleGoldIcon.isVisible = true			
		elseif (g.rifle3Left.isPurchased == 1) then
			g.rifle3Left.isVisible = true
			g.rifle3Right.isVisible = true		
			i.rifle3Icon.isVisible = true			
		elseif (g.rifle2Left.isPurchased == 1) then
			g.rifle2Left.isVisible = true
			g.rifle2Right.isVisible = true			
			i.rifle2Icon.isVisible = true			
		elseif (g.rifle1Left.isPurchased == 1) then
			g.rifle1Left.isVisible = true
			g.rifle1Right.isVisible = true				
			i.rifle1Icon.isVisible = true			
		end
	end	
	if (activeWeapon == "macheteGold") then
		writeScreenAmmo(nil)

		if (v.rightArmUp == 1) then
			v.rightArmUp = 0
			rightArmGroup.rotation = rightArmGroup.rotation + 90
		end
		if (g.myGuyShieldGold.isPurchased == 1) then
			g.shield11.isVisible = true
			g.shield12.isVisible = true
			g.shield21.isVisible = true
			g.shield22.isVisible = true
			g.shieldGold.isVisible = true
		else
			g.shield11.isVisible = true
			g.shield12.isVisible = true
			g.shield21.isVisible = true
			g.shield22.isVisible = true

		end
		g.macheteGold.isVisible = true
		i.macheteGoldIcon.isVisible = true			
	end
	if (activeWeapon == "machete") then
		writeScreenAmmo(nil)

		if (v.rightArmUp == 1) then
			v.rightArmUp = 0
			rightArmGroup.rotation = rightArmGroup.rotation + 90
		end
		if (g.myGuyShieldGold.isPurchased == 1) then
			g.shield11.isVisible = true
			g.shield12.isVisible = true
			g.shield21.isVisible = true
			g.shield22.isVisible = true
			g.shieldGold.isVisible = true
		else
			g.shield11.isVisible = true
			g.shield12.isVisible = true
			g.shield21.isVisible = true
			g.shield22.isVisible = true

		end
		g.machete1.isVisible = true		
		i.machete1Icon.isVisible = true			
	end	
	if (activeWeapon == "mace") then
		writeScreenAmmo(nil)

		if (v.rightArmUp == 1) then
			v.rightArmUp = 0
			rightArmGroup.rotation = rightArmGroup.rotation + 90
		end
		if (g.myGuyShieldGold.isPurchased == 1) then
			g.shield11.isVisible = true
			g.shield12.isVisible = true
			g.shield21.isVisible = true
			g.shield22.isVisible = true
			g.shieldGold.isVisible = true
		else
			g.shield11.isVisible = true
			g.shield12.isVisible = true
			g.shield21.isVisible = true
			g.shield22.isVisible = true

		end
		g.mace1.isVisible = true		
		i.mace1Icon.isVisible = true			
	end	
	if (activeWeapon == "battleAxe") then
		writeScreenAmmo(nil)
		
		if (v.rightArmUp == 1) then
			v.rightArmUp = 0
			rightArmGroup.rotation = rightArmGroup.rotation + 90
		end
		if (g.myGuyShieldGold.isPurchased == 1) then
			g.shield11.isVisible = true
			g.shield12.isVisible = true
			g.shield21.isVisible = true
			g.shield22.isVisible = true
			g.shieldGold.isVisible = true
		else
			g.shield11.isVisible = true
			g.shield12.isVisible = true
			g.shield21.isVisible = true
			g.shield22.isVisible = true

		end
		
		g.battleAxe1.isVisible = true
		i.battleAxe1Icon.isVisible = true			
	end
	if (activeWeapon == "granade") then
		writeScreenAmmo(granadeAmmo)
		if (v.rightArmUp == 1) then
			v.rightArmUp = 0
			rightArmGroup.rotation = rightArmGroup.rotation + 90
		end
		if (g.myGuyShieldGold.isPurchased == 1) then
			g.shield11.isVisible = true
			g.shield12.isVisible = true
			g.shield21.isVisible = true
			g.shield22.isVisible = true
			g.shieldGold.isVisible = true
		else
			g.shield11.isVisible = true
			g.shield12.isVisible = true
			g.shield21.isVisible = true
			g.shield22.isVisible = true
			
		end
		
		g.granade.isVisible = true
		
		if (g.granadeGold.isPurchased == 1) then
			g.granadeGold.isVisible = true
			g.granadeGoldDouble.isVisible = true
			i.granadeGoldIcon.isVisible = true					
		else
			g.granade1.isVisible = true
			g.granade1Double.isVisible = true
			i.granade1Icon.isVisible = true
		end

	end
	
	isWeaponsChange = 0
	
end


function attackButtonListener(e)

	if (e.phase == "began" and v.isPaused == false and v.moveIntoTent < 23 and v.playerHealth > 0 and v.everPlayed == 2 and isAttackThree == 1 and isAttackFour == 1) then
	
		attackButtonMask.num = 4
		
		if (activeWeapon == "knifeRight") then
			if (knifeAmmo > 1) then
				if (leftNext) then
					if(isAttackOne == 1 and isAttackTwo < 27) then
						isAttackOne = 33
						leftNext = not leftNext
					end		
				else
					if(isAttackTwo == 1 and isAttackOne < 27) then
						isAttackTwo = 33
						leftNext = not leftNext			
					end		
				
				end
			end

		elseif (activeWeapon == "tomahawkRight") then
			if(tomahawkAmmo > 1) then
				if (leftNext) then
					if(isAttackOne == 1 and isAttackTwo < 27) then
						isAttackOne = 33
						leftNext = not leftNext
					end		
				else
					if(isAttackTwo == 1 and isAttackOne < 27) then
						isAttackTwo = 33
						leftNext = not leftNext			
					end		
				
				end
			end

		elseif(activeWeapon == "pistolRight") then
			if (pistolAmmo > 0) then
				if (leftNext) then
					if(isAttackOne == 1 and isAttackTwo < 30) then
						isAttackOne = 33
						leftNext = not leftNext
					end		
				else
					if(isAttackTwo == 1 and isAttackOne < 30) then
						isAttackTwo = 33
						leftNext = not leftNext			
					end		
				
				end
			end
		
		elseif(activeWeapon == "rifleRight" ) then
			if (rifleAmmo > 0) then
				if (leftNext) then
					if(isAttackOne == 1 and isAttackTwo < 30) then
						isAttackOne = 33
						leftNext = not leftNext
					end		
				else
					if(isAttackTwo == 1 and isAttackOne < 30) then
						isAttackTwo = 33
						leftNext = not leftNext			
					end		
				
				end
			end
		
		elseif(activeWeapon == "knifeLeft" ) then
			if (knifeAmmo > 0) then
				if(isAttackOne == 1) then
					isAttackOne = 33
				end
			end
		elseif(activeWeapon == "tomahawkLeft" ) then
			if (tomahawkAmmo > 0) then
				if(isAttackOne == 1) then
					isAttackOne = 33
				end
			end
		elseif(activeWeapon == "crossbow" ) then
			if (crossbowAmmo > 0) then
				if(isAttackOne == 1) then
					isAttackOne = 33
				end
			end
		end
		
	end

end


function swingButtonListener(e)

	if (e.phase == "began" and v.isPaused == false and v.moveIntoTent < 23 and v.playerHealth > 0 and v.everPlayed == 2 and isAttackOne == 1 and isAttackTwo ==1 and isAttackThree == 1 and isAttackFour == 1) then


		swingButtonMask.num = 4
		
		v.changeWeaponFrom = activeWeapon
		
		isWeaponsChange = 1
		if (g.macheteGold.isPurchased == 1) then
			v.changeWeaponTo = "macheteGold"
		elseif (g.machete1.isPurchased == 1) then
			v.changeWeaponTo = "machete"
		elseif (g.mace1.isPurchased == 1) then
			v.changeWeaponTo = "mace"
		else
			v.changeWeaponTo = "battleAxe"
		end
		

		if(isAttackThree == 1) then
			isAttackThree = 33
		end

	end

end


function granadeButtonListener(e)

	if (e.phase == "began") then
		granadeButtonMask.num = 4
	end

	if (e.phase == "began" and v.isPaused == false and v.moveIntoTent < 23 and v.playerHealth > 0 and v.everPlayed == 2 and isAttackOne == 1 and isAttackTwo == 1 and isAttackThree == 1 and isAttackFour == 1 and granadeAmmo > 0) then
	
		
		v.changeWeaponFrom = activeWeapon
						
		isWeaponsChange = 1
		v.changeWeaponTo = "granade"
		
		if(isAttackFour == 1) then
			isAttackFour = 33
		end
		
	end

end


function updateWeaponsWall()


	w.wArrow2.isVisible = false
	w.wArrow3.isVisible = false
	w.wArrowGold.isVisible = false
	
	w.wKnife1.isVisible = false
	w.wKnife2.isVisible = false
	w.wKnife3.isVisible = false
	w.wKnifeGold.isVisible = false

	w.wTomahawk1.isVisible = false
	w.wTomahawk2.isVisible = false
	w.wTomahawk3.isVisible = false
	w.wTomahawkGold.isVisible = false

	w.wPistol1.isVisible = false
	w.wPistol2.isVisible = false
	w.wPistol3.isVisible = false
	w.wPistolGold.isVisible = false

	w.wRifle1.isVisible = false
	w.wRifle2.isVisible = false
	w.wRifle3.isVisible = false
	w.wRifleGold.isVisible = false

	w.wMace1.isVisible = false
	w.wMachete1.isVisible = false

	w.wMacheteGold.isVisible = false

	w.wHealthPack.isVisible = false
	w.wHealthPackGold.isVisible = false
	
	w.wGranade1.isVisible = false
	w.wGranadeGold.isVisible = false
	
	
	w.wPriceTag450.isVisible = false
	w.wPriceTag200.isVisible = false
	w.wPriceTag550.isVisible = false
	w.wPriceTag6001.isVisible = false
	w.wPriceTag6002.isVisible = false
	w.wPriceTag7001.isVisible = false
	w.wPriceTag7002.isVisible = false
	w.wPriceTag800.isVisible = false
	w.wPriceTag250.isVisible = false
	w.wPriceTag850.isVisible = false
	w.wPriceTag950.isVisible = false
	w.wPriceTag10001.isVisible = false
	w.wPriceTag10002.isVisible = false
	w.wPriceTag1450.isVisible = false
	w.wPriceTag1100.isVisible = false
	w.wPriceTag1600.isVisible = false
	w.wPriceTag1250.isVisible = false
	w.wPriceTag1800.isVisible = false
	w.wPriceTag1750.isVisible = false
	w.wPriceTag1950.isVisible = false
	w.wPriceTag15001.isVisible = false
	w.wPriceTag15002.isVisible = false
	w.wPriceTag2100.isVisible = false
	w.wPriceTag2150.isVisible = false
	w.wPriceTag25001.isVisible = false
	w.wPriceTag25002.isVisible = false
	
	w.wAmmoTag1.isVisible = false
	w.wAmmoTag2.isVisible = false
	w.wAmmoTag3.isVisible = false
	w.wAmmoTag4.isVisible = false
	w.wAmmoTag5.isVisible = false

	
	if (g.arrowGold.isPurchased == 1) then
		w.wArrowGold.isVisible = true
		w.wAmmoTag1.isVisible = true
		w.wPriceTag10001.isVisible = true
	elseif (g.arrow3.isPurchased == 1) then
		w.wArrowGold.isVisible = true
		w.wPriceTag10001.isVisible = true
	elseif (g.arrow2.isPurchased == 1) then
		w.wArrow3.isVisible = true
		w.wPriceTag6001.isVisible = true
	elseif (g.arrow1.isPurchased == 1) then
		w.wArrow2.isVisible = true	
		w.wPriceTag450.isVisible = true
	end
	
	if (g.arrow1.isPurchased == 1) then
		w.wKnife1.isVisible = true
		w.wPriceTag550.isVisible = true	
	end


	if (g.knifeGoldLeft.isPurchased == 1) then
		w.wKnifeGold.isVisible = true
		w.wAmmoTag2.isVisible = true
		w.wPriceTag1250.isVisible = true
		w.wKnife1.isVisible = false
		w.wPriceTag550.isVisible = false
	elseif (g.knife3Left.isPurchased == 1) then
		w.wKnifeGold.isVisible = true
		w.wPriceTag1250.isVisible = true	
		w.wKnife1.isVisible = false
		w.wPriceTag550.isVisible = false		
	elseif (g.knife2Left.isPurchased == 1) then
		w.wKnife3.isVisible = true
		w.wPriceTag850.isVisible = true
		w.wKnife1.isVisible = false
		w.wPriceTag550.isVisible = false		
	elseif (g.knife1Left.isPurchased == 1) then
		w.wKnife2.isVisible = true
		w.wPriceTag7001.isVisible = true
		w.wKnife1.isVisible = false
		w.wPriceTag550.isVisible = false
	end

	if (g.knife1Left.isPurchased == 1) then
		w.wTomahawk1.isVisible = true
		w.wPriceTag800.isVisible = true
	end
	

	if (g.tomahawkGoldLeft.isPurchased == 1) then
		w.wTomahawkGold.isVisible = true
		w.wAmmoTag3.isVisible = true
		w.wPriceTag15001.isVisible = true	
		w.wTomahawk1.isVisible = false
		w.wPriceTag800.isVisible = false	
	elseif (g.tomahawk3Left.isPurchased == 1) then
		w.wTomahawkGold.isVisible = true
		w.wPriceTag15001.isVisible = true	
		w.wTomahawk1.isVisible = false
		w.wPriceTag800.isVisible = false	
	elseif (g.tomahawk2Left.isPurchased == 1) then
		w.wTomahawk3.isVisible = true
		w.wPriceTag1100.isVisible = true
		w.wTomahawk1.isVisible = false
		w.wPriceTag800.isVisible = false	
	elseif (g.tomahawk1Left.isPurchased == 1) then
		w.wTomahawk2.isVisible = true
		w.wPriceTag950.isVisible = true
		w.wTomahawk1.isVisible = false
		w.wPriceTag800.isVisible = false	
	end

	if (g.tomahawk1Left.isPurchased == 1) then
		w.wPistol1.isVisible = true
		w.wPriceTag1450.isVisible = true
	end

	
	if (g.pistolGoldLeft.isPurchased == 1) then
		w.wPistolGold.isVisible = true
		w.wAmmoTag4.isVisible = true
		w.wPriceTag2150.isVisible = true
		w.wPistol1.isVisible = false
		w.wPriceTag1450.isVisible = false
	elseif (g.pistol3Left.isPurchased == 1) then
		w.wPistolGold.isVisible = true
		w.wPriceTag2150.isVisible = true	
		w.wPistol1.isVisible = false
		w.wPriceTag1450.isVisible = false
	elseif (g.pistol2Left.isPurchased == 1) then
		w.wPistol3.isVisible = true
		w.wPriceTag1750.isVisible = true
		w.wPistol1.isVisible = false
		w.wPriceTag1450.isVisible = false
	elseif (g.pistol1Left.isPurchased == 1) then
		w.wPistol2.isVisible = true
		w.wPriceTag1600.isVisible = true
		w.wPistol1.isVisible = false
		w.wPriceTag1450.isVisible = false
	end
	
	if (g.pistol1Left.isPurchased == 1) then
		w.wRifle1.isVisible = true
		w.wPriceTag1800.isVisible = true	
	end

	
	if (g.rifleGoldLeft.isPurchased == 1) then
		w.wRifleGold.isVisible = true
		w.wAmmoTag5.isVisible = true
		w.wPriceTag25001.isVisible = true	
		w.wRifle1.isVisible = false
		w.wPriceTag1800.isVisible = false
	elseif (g.rifle3Left.isPurchased == 1) then
		w.wRifleGold.isVisible = true
		w.wPriceTag25001.isVisible = true	
		w.wRifle1.isVisible = false
		w.wPriceTag1800.isVisible = false
	elseif (g.rifle2Left.isPurchased == 1) then
		w.wRifle3.isVisible = true
		w.wPriceTag2100.isVisible = true
		w.wRifle1.isVisible = false
		w.wPriceTag1800.isVisible = false
	elseif (g.rifle1Left.isPurchased == 1) then
		w.wRifle2.isVisible = true
		w.wPriceTag1950.isVisible = true
		w.wRifle1.isVisible = false
		w.wPriceTag1800.isVisible = false
	end

	
	if (g.macheteGold.isPurchased == 1) then
		w.wMacheteGold.isVisible = true
	elseif (g.machete1.isPurchased == 1) then
		w.wMacheteGold.isVisible = true
		w.wPriceTag25002.isVisible = true	
	elseif (g.mace1.isPurchased == 1) then
		w.wMachete1.isVisible = true
		w.wPriceTag15002.isVisible = true	
	elseif (g.battleAxe1.isPurchased == 1) then
		w.wMace1.isVisible = true
		w.wPriceTag6002.isVisible = true
	end
	
	
	if (g.machete1.isPurchased == 1 or g.myGuyShieldGold.isPurchased == 1) then
		w.wHealthPackGold.isVisible = true
		w.wPriceTag250.isVisible = true
	else
		w.wHealthPack.isVisible = true
		w.wPriceTag200.isVisible = true
	end

	if (g.machete1.isPurchased == 1 or g.granadeGold.isPurchased == 1) then
		w.wGranadeGold.isVisible = true
		w.wPriceTag10002.isVisible = true
	else
		w.wGranade1.isVisible = true
		w.wPriceTag7002.isVisible = true
	end
	
end 


function changeSize(p, q)

	if (q == 8) then
		p.xScale = 1.3
		p.yScale = 1.3
	elseif (q == 7) then
		p.xScale = 1.25
		p.yScale = 1.25
	elseif (q == 6) then
		p.xScale = 1.2
		p.yScale = 1.2
	elseif (q == 5) then
		p.xScale = 1.15
		p.yScale = 1.15
	elseif (q == 4) then
		p.xScale = 1.1
		p.yScale = 1.1
	elseif (q == 3) then
		p.xScale = 1.05
		p.yScale = 1.05
	elseif (q == 2) then
		p.xScale = 1
		p.yScale = 1
	end

end


function wallFlare()
	
	if (w.wArrow2.flareNum > 0) then
		changeSize(w.wArrow2, w.wArrow2.flareNum)
		changeSize(g.crossbow2, w.wArrow2.flareNum)
		changeSize(g.arrow2, w.wArrow2.flareNum)
		changeSize(g.crossbowStringPulled, w.wArrow2.flareNum)
		w.wArrow2.flareNum = w.wArrow2.flareNum - 1
	elseif (w.wArrow3.flareNum > 0) then
		changeSize(w.wArrow3, w.wArrow3.flareNum)
		changeSize(g.crossbow3, w.wArrow3.flareNum)
		changeSize(g.arrow3, w.wArrow3.flareNum)
		changeSize(g.crossbowStringPulled, w.wArrow3.flareNum)
		w.wArrow3.flareNum = w.wArrow3.flareNum - 1
	elseif (w.wArrowGold.flareNum > 0) then
		changeSize(w.wArrowGold, w.wArrowGold.flareNum)
		changeSize(g.crossbowGold, w.wArrowGold.flareNum)
		changeSize(g.arrowGold, w.wArrowGold.flareNum)
		changeSize(g.crossbowStringPulled, w.wArrowGold.flareNum)
		w.wArrowGold.flareNum = w.wArrowGold.flareNum - 1
	elseif (w.wKnife1.flareNum > 0) then
		changeSize(w.wKnife1, w.wKnife1.flareNum)
		changeSize(g.knife1Left, w.wKnife1.flareNum)
		changeSize(g.knife1Right, w.wKnife1.flareNum)
		w.wKnife1.flareNum = w.wKnife1.flareNum - 1
	elseif (w.wKnife2.flareNum > 0) then
		changeSize(w.wKnife2, w.wKnife2.flareNum)
		changeSize(g.knife2Left, w.wKnife2.flareNum)
		changeSize(g.knife2Right, w.wKnife2.flareNum)
		w.wKnife2.flareNum = w.wKnife2.flareNum - 1
	elseif (w.wKnife3.flareNum > 0) then
		changeSize(w.wKnife3, w.wKnife3.flareNum)
		changeSize(g.knife3Left, w.wKnife3.flareNum)
		changeSize(g.knife3Right, w.wKnife3.flareNum)
		w.wKnife3.flareNum = w.wKnife3.flareNum - 1
	elseif (w.wKnifeGold.flareNum > 0) then
		changeSize(w.wKnifeGold, w.wKnifeGold.flareNum)
		changeSize(g.knifeGoldLeft, w.wKnifeGold.flareNum)
		changeSize(g.knifeGoldRight, w.wKnifeGold.flareNum)
		w.wKnifeGold.flareNum = w.wKnifeGold.flareNum - 1
	elseif (w.wTomahawk1.flareNum > 0) then
		changeSize(w.wTomahawk1, w.wTomahawk1.flareNum)
		changeSize(g.tomahawk1Left, w.wTomahawk1.flareNum)
		changeSize(g.tomahawk1Right, w.wTomahawk1.flareNum)
		w.wTomahawk1.flareNum = w.wTomahawk1.flareNum - 1
	elseif (w.wTomahawk2.flareNum > 0) then
		changeSize(w.wTomahawk2, w.wTomahawk2.flareNum)
		changeSize(g.tomahawk2Left, w.wTomahawk2.flareNum)
		changeSize(g.tomahawk2Right, w.wTomahawk2.flareNum)
		w.wTomahawk2.flareNum = w.wTomahawk2.flareNum - 1
	elseif (w.wTomahawk3.flareNum > 0) then
		changeSize(w.wTomahawk3, w.wTomahawk3.flareNum)
		changeSize(g.tomahawk3Left, w.wTomahawk3.flareNum)
		changeSize(g.tomahawk3Right, w.wTomahawk3.flareNum)
		w.wTomahawk3.flareNum = w.wTomahawk3.flareNum - 1
	elseif (w.wTomahawkGold.flareNum > 0) then
		changeSize(w.wTomahawkGold, w.wTomahawkGold.flareNum)
		changeSize(g.tomahawkGoldLeft, w.wTomahawkGold.flareNum)
		changeSize(g.tomahawkGoldRight, w.wTomahawkGold.flareNum)
		w.wTomahawkGold.flareNum = w.wTomahawkGold.flareNum - 1
	elseif (w.wPistol1.flareNum > 0) then
		changeSize(w.wPistol1, w.wPistol1.flareNum)
		changeSize(g.pistol1Left, w.wPistol1.flareNum)
		changeSize(g.pistol1Right, w.wPistol1.flareNum)
		w.wPistol1.flareNum = w.wPistol1.flareNum - 1
	elseif (w.wPistol2.flareNum > 0) then
		changeSize(w.wPistol2, w.wPistol2.flareNum)
		changeSize(g.pistol2Left, w.wPistol2.flareNum)
		changeSize(g.pistol2Right, w.wPistol2.flareNum)
		w.wPistol2.flareNum = w.wPistol2.flareNum - 1
	elseif (w.wPistol3.flareNum > 0) then
		changeSize(w.wPistol3, w.wPistol3.flareNum)
		changeSize(g.pistol3Left, w.wPistol3.flareNum)
		changeSize(g.pistol3Right, w.wPistol3.flareNum)
		w.wPistol3.flareNum = w.wPistol3.flareNum - 1
	elseif (w.wPistolGold.flareNum > 0) then
		changeSize(w.wPistolGold, w.wPistolGold.flareNum)
		changeSize(g.pistolGoldLeft, w.wPistolGold.flareNum)
		changeSize(g.pistolGoldRight, w.wPistolGold.flareNum)
		w.wPistolGold.flareNum = w.wPistolGold.flareNum - 1
	elseif (w.wRifle1.flareNum > 0) then
		changeSize(w.wRifle1, w.wRifle1.flareNum)
		changeSize(g.rifle1Left, w.wRifle1.flareNum)
		changeSize(g.rifle1Right, w.wRifle1.flareNum)
		w.wRifle1.flareNum = w.wRifle1.flareNum - 1
	elseif (w.wRifle2.flareNum > 0) then
		changeSize(w.wRifle2, w.wRifle2.flareNum)
		changeSize(g.rifle2Left, w.wRifle2.flareNum)
		changeSize(g.rifle2Right, w.wRifle2.flareNum)
		w.wRifle2.flareNum = w.wRifle2.flareNum - 1
	elseif (w.wRifle3.flareNum > 0) then
		changeSize(w.wRifle3, w.wRifle3.flareNum)
		changeSize(g.rifle3Left, w.wRifle3.flareNum)
		changeSize(g.rifle3Right, w.wRifle3.flareNum)
		w.wRifle3.flareNum = w.wRifle3.flareNum - 1
	elseif (w.wRifleGold.flareNum > 0) then
		changeSize(w.wRifleGold, w.wRifleGold.flareNum)
		changeSize(g.rifleGoldLeft, w.wRifleGold.flareNum)
		changeSize(g.rifleGoldRight, w.wRifleGold.flareNum)
		w.wRifleGold.flareNum = w.wRifleGold.flareNum - 1
	elseif (w.wMace1.flareNum > 0) then
		changeSize(w.wMace1, w.wMace1.flareNum)
		changeSize(g.mace1, w.wMace1.flareNum)
		w.wMace1.flareNum = w.wMace1.flareNum - 1
	elseif (w.wMachete1.flareNum > 0) then
		changeSize(w.wMachete1, w.wMachete1.flareNum)
		changeSize(g.machete1, w.wMachete1.flareNum)
		w.wMachete1.flareNum = w.wMachete1.flareNum - 1
	elseif (w.wMacheteGold.flareNum > 0) then
		changeSize(w.wMacheteGold, w.wMacheteGold.flareNum)
		changeSize(g.macheteGold, w.wMacheteGold.flareNum)
		w.wMacheteGold.flareNum = w.wMacheteGold.flareNum - 1
	elseif (w.wHealthPack.flareNum > 0) then
		changeSize(w.wHealthPack, w.wHealthPack.flareNum)
		changeSize(g.shield11, w.wHealthPack.flareNum)
		changeSize(g.shield12, w.wHealthPack.flareNum)
		changeSize(g.shield21, w.wHealthPack.flareNum)
		changeSize(g.shield22, w.wHealthPack.flareNum)
		w.wHealthPack.flareNum = w.wHealthPack.flareNum - 1
	elseif (w.wHealthPackGold.flareNum > 0) then
		changeSize(w.wHealthPackGold, w.wHealthPackGold.flareNum)
		changeSize(g.shield11, w.wHealthPackGold.flareNum)
		changeSize(g.shield12, w.wHealthPackGold.flareNum)
		changeSize(g.shield21, w.wHealthPackGold.flareNum)
		changeSize(g.shield22, w.wHealthPackGold.flareNum)
		changeSize(g.shieldGold, w.wHealthPackGold.flareNum)		
		w.wHealthPackGold.flareNum = w.wHealthPackGold.flareNum - 1
	elseif (w.wGranade1.flareNum > 0) then
		changeSize(w.wGranade1, w.wGranade1.flareNum)
		changeSize(g.granade1, w.wGranade1.flareNum)
		w.wGranade1.flareNum = w.wGranade1.flareNum - 1
	elseif (w.wGranadeGold.flareNum > 0) then	
		changeSize(w.wGranadeGold, w.wGranadeGold.flareNum)
		changeSize(g.granadeGold, w.wGranadeGold.flareNum)
		w.wGranadeGold.flareNum = w.wGranadeGold.flareNum - 1	
	else
		v.flareNum = 0
		updateWeaponsWall()
	end
	
end


function pButtonListener(e)

	if(v.isPaused == false) then

		if (e.phase == "began") then
			if (v.soundOn == 1) then
				audio.play(a.clickSoundMenu, 12)
			end

			if (e.target == w.wArrow2) then
				
				if (v.playerCash > 449) then
					v.playerCash = v.playerCash - 450
					writeScreenCash(v.playerCash, 0)
					g.arrow2.isPurchased = 1
					if (crossbowAmmo < 900) then
						crossbowAmmo = crossbowAmmo + 100
					else
						crossbowAmmo = 999
					end
					isWeaponsChange = 1
					v.changeWeaponTo = "crossbow"
					v.flareNum = 1
					w.wArrow2.flareNum = 8
				end
				
			elseif(e.target == w.wArrow3) then
				
				if (v.playerCash > 599) then
					v.playerCash = v.playerCash - 600
					writeScreenCash(v.playerCash, 0)
					g.arrow3.isPurchased = 1
					if (crossbowAmmo < 900) then
						crossbowAmmo = crossbowAmmo + 100
					else
						crossbowAmmo = 999
					end
					isWeaponsChange = 1
					v.changeWeaponTo = "crossbow"
					v.flareNum = 1
					w.wArrow3.flareNum = 8
				end

			elseif(e.target == w.wArrowGold) then
				
				if (v.playerCash > 999 and crossbowAmmo < 999) then
					v.playerCash = v.playerCash - 1000
					writeScreenCash(v.playerCash, 0)
					g.arrowGold.isPurchased = 1
					if (crossbowAmmo < 750) then
						crossbowAmmo = crossbowAmmo + 250
					else
						crossbowAmmo = 999
					end
					isWeaponsChange = 1
					v.changeWeaponTo = "crossbow"
					v.flareNum = 1
					w.wArrowGold.flareNum = 8
				end
			
			elseif(e.target == w.wKnife1) then

				if (v.playerCash > 549) then
					v.playerCash = v.playerCash - 550
					writeScreenCash(v.playerCash, 0)
					g.knife1Left.isPurchased = 1
					if (knifeAmmo < 850) then
						knifeAmmo = knifeAmmo + 150
					else
						knifeAmmo = 999
					end
					isWeaponsChange = 1
					v.changeWeaponTo = "knifeRight"
					v.flareNum = 1
					w.wKnife1.flareNum = 8
				end
			
			elseif(e.target == w.wKnife2) then

				if (v.playerCash > 699) then
					v.playerCash = v.playerCash - 700
					writeScreenCash(v.playerCash, 0)
					g.knife2Left.isPurchased = 1
					if (knifeAmmo < 900) then
						knifeAmmo = knifeAmmo + 100
					else
						knifeAmmo = 999
					end
					isWeaponsChange = 1
					v.changeWeaponTo = "knifeRight"
					v.flareNum = 1
					w.wKnife2.flareNum = 8
				end
			
			elseif(e.target == w.wKnife3) then

				if (v.playerCash > 849) then
					v.playerCash = v.playerCash - 850
					writeScreenCash(v.playerCash, 0)
					g.knife3Left.isPurchased = 1
					if (knifeAmmo < 900) then
						knifeAmmo = knifeAmmo + 100
					else
						knifeAmmo = 999
					end
					isWeaponsChange = 1
					v.changeWeaponTo = "knifeRight"
					v.flareNum = 1
					w.wKnife3.flareNum = 8
				end

			elseif(e.target == w.wKnifeGold) then

				if (v.playerCash > 1249 and knifeAmmo < 999) then
					v.playerCash = v.playerCash - 1250
					writeScreenCash(v.playerCash, 0)
					g.knifeGoldLeft.isPurchased = 1
					if (knifeAmmo < 750) then
						knifeAmmo = knifeAmmo + 250
					else
						knifeAmmo = 999
					end
					isWeaponsChange = 1
					v.changeWeaponTo = "knifeRight"
					v.flareNum = 1
					w.wKnifeGold.flareNum = 8
				end
			
			elseif(e.target == w.wTomahawk1) then

				if (v.playerCash > 799) then
					v.playerCash = v.playerCash - 800
					writeScreenCash(v.playerCash, 0)
					g.tomahawk1Left.isPurchased = 1
					if (tomahawkAmmo < 850) then
						tomahawkAmmo = tomahawkAmmo + 150
					else
						tomahawkAmmo = 999
					end
					isWeaponsChange = 1
					v.changeWeaponTo = "tomahawkRight"
					v.flareNum = 1
					w.wTomahawk1.flareNum = 8
				end
			
			elseif(e.target == w.wTomahawk2) then

				if (v.playerCash > 949) then
					v.playerCash = v.playerCash - 950
					writeScreenCash(v.playerCash, 0)
					g.tomahawk2Left.isPurchased = 1
					if (tomahawkAmmo < 900) then
						tomahawkAmmo = tomahawkAmmo + 100
					else
						tomahawkAmmo = 999
					end
					isWeaponsChange = 1
					v.changeWeaponTo = "tomahawkRight"
					v.flareNum = 1
					w.wTomahawk2.flareNum = 8
				end
			
			elseif(e.target == w.wTomahawk3) then

				if (v.playerCash > 1099) then
					v.playerCash = v.playerCash - 1100
					writeScreenCash(v.playerCash, 0)
					g.tomahawk3Left.isPurchased = 1
					if (tomahawkAmmo < 900) then
						tomahawkAmmo = tomahawkAmmo + 100
					else
						tomahawkAmmo = 999
					end
					isWeaponsChange = 1
					v.changeWeaponTo = "tomahawkRight"
					v.flareNum = 1
					w.wTomahawk3.flareNum = 8
				end
			
			elseif(e.target == w.wTomahawkGold) then

				if (v.playerCash > 1499 and tomahawkAmmo < 999) then
					v.playerCash = v.playerCash - 1500
					writeScreenCash(v.playerCash, 0)
					g.tomahawkGoldLeft.isPurchased = 1
					if (tomahawkAmmo < 750) then
						tomahawkAmmo = tomahawkAmmo + 250
					else
						tomahawkAmmo = 999
					end
					isWeaponsChange = 1
					v.changeWeaponTo = "tomahawkRight"
					v.flareNum = 1
					w.wTomahawkGold.flareNum = 8
				end
			
			elseif(e.target == w.wPistol1) then

				if (v.playerCash > 1449) then
					v.playerCash = v.playerCash - 1450
					writeScreenCash(v.playerCash, 0)
					g.pistol1Left.isPurchased = 1
					if (pistolAmmo < 900) then
						pistolAmmo = pistolAmmo + 100
					else
						pistolAmmo = 999
					end
					isWeaponsChange = 1
					v.changeWeaponTo = "pistolRight"
					v.flareNum = 1
					w.wPistol1.flareNum = 8
				end
			
			elseif(e.target == w.wPistol2) then

				if (v.playerCash > 1599) then
					v.playerCash = v.playerCash - 1600
					writeScreenCash(v.playerCash, 0)
					g.pistol2Left.isPurchased = 1
					if (pistolAmmo < 900) then
						pistolAmmo = pistolAmmo + 100
					else
						pistolAmmo = 999
					end
					isWeaponsChange = 1
					v.changeWeaponTo = "pistolRight"
					v.flareNum = 1
					w.wPistol2.flareNum = 8
				end
			
			elseif(e.target == w.wPistol3) then

				if (v.playerCash > 1749) then
					v.playerCash = v.playerCash - 1750
					writeScreenCash(v.playerCash, 0)
					g.pistol3Left.isPurchased = 1
					if (pistolAmmo < 900) then
						pistolAmmo = pistolAmmo + 100
					else
						pistolAmmo = 999
					end
					isWeaponsChange = 1
					v.changeWeaponTo = "pistolRight"
					v.flareNum = 1
					w.wPistol3.flareNum = 8
				end
			
			elseif(e.target == w.wPistolGold) then

				if (v.playerCash > 2149 and pistolAmmo < 999) then
					v.playerCash = v.playerCash - 2150
					writeScreenCash(v.playerCash, 0)
					g.pistolGoldLeft.isPurchased = 1
					if (pistolAmmo < 750) then
						pistolAmmo = pistolAmmo + 250
					else
						pistolAmmo = 999
					end
					isWeaponsChange = 1
					v.changeWeaponTo = "pistolRight"
					v.flareNum = 1
					w.wPistolGold.flareNum = 8
				end
			
			elseif(e.target == w.wRifle1) then

				if (v.playerCash > 1799) then
					v.playerCash = v.playerCash - 1800
					writeScreenCash(v.playerCash, 0)
					g.rifle1Left.isPurchased = 1
					if (rifleAmmo < 900) then
						rifleAmmo = rifleAmmo + 100
					else
						rifleAmmo = 999
					end
					isWeaponsChange = 1
					v.changeWeaponTo = "rifleRight"
					v.flareNum = 1
					w.wRifle1.flareNum = 8
				end
			
			elseif(e.target == w.wRifle2) then

				if (v.playerCash > 1949) then
					v.playerCash = v.playerCash - 1950
					writeScreenCash(v.playerCash, 0)
					g.rifle2Left.isPurchased = 1
					if (rifleAmmo < 900) then
						rifleAmmo = rifleAmmo + 100
					else
						rifleAmmo = 999
					end
					isWeaponsChange = 1
					v.changeWeaponTo = "rifleRight"
					v.flareNum = 1
					w.wRifle2.flareNum = 8
				end
			
			elseif(e.target == w.wRifle3) then

				if (v.playerCash > 2099) then
					v.playerCash = v.playerCash - 2100
					writeScreenCash(v.playerCash, 0)
					g.rifle3Left.isPurchased = 1
					if (rifleAmmo < 900) then
						rifleAmmo = rifleAmmo + 100
					else
						rifleAmmo = 999
					end
					isWeaponsChange = 1
					v.changeWeaponTo = "rifleRight"
					v.flareNum = 1
					w.wRifle3.flareNum = 8
				end
			
			elseif(e.target == w.wRifleGold) then

				if (v.playerCash > 2499 and rifleAmmo < 999) then
					v.playerCash = v.playerCash - 2500
					writeScreenCash(v.playerCash, 0)
					g.rifleGoldLeft.isPurchased = 1
					if (rifleAmmo < 750) then
						rifleAmmo = rifleAmmo + 250
					else
						rifleAmmo = 999
					end
					isWeaponsChange = 1
					v.changeWeaponTo = "rifleRight"
					v.flareNum = 1
					w.wRifleGold.flareNum = 8
				end
			
			elseif(e.target == w.wMace1) then

				if (v.playerCash > 599) then
					v.playerCash = v.playerCash - 600
					writeScreenCash(v.playerCash, 0)
					g.mace1.isPurchased = 1
					v.flareNum = 1
					w.wMace1.flareNum = 8
					isWeaponsChange = 1
					v.changeWeaponTo = "mace"

				end
			
			elseif(e.target == w.wMachete1) then

				if (v.playerCash > 1499) then
					v.playerCash = v.playerCash - 1500
					writeScreenCash(v.playerCash, 0)
					g.machete1.isPurchased = 1
					v.flareNum = 1
					w.wMachete1.flareNum = 8
					isWeaponsChange = 1
					v.changeWeaponTo = "machete"
				end
			
			elseif(e.target == w.wMacheteGold) then

				if (v.playerCash > 2499 and g.macheteGold.isPurchased == 0) then
					v.playerCash = v.playerCash - 2500
					writeScreenCash(v.playerCash, 0)
					g.macheteGold.isPurchased = 1
					v.flareNum = 1
					w.wMacheteGold.flareNum = 8								
					isWeaponsChange = 1
					v.changeWeaponTo = "macheteGold"
				end
			
			elseif(e.target == w.wHealthPack) then

				if (v.playerCash > 199 and v.playerHealth < 100) then
					v.playerCash = v.playerCash - 200
					writeScreenCash(v.playerCash, 0)
					v.playerHealth = 100
					v.flareNum = 1
					w.wHealthPack.flareNum = 8
					updateHealthBar(v.playerHealth)
				end
			
			elseif(e.target == w.wHealthPackGold) then

				if (v.playerCash > 249 and v.playerHealth < 127) then
					v.playerCash = v.playerCash - 250
					writeScreenCash(v.playerCash, 0)
					v.playerHealth = 127
					v.flareNum = 1
					w.wHealthPackGold.flareNum = 8
					updateHealthBar(v.playerHealth)
					if (g.myGuyShieldGold.isPurchased == 0) then
						g.myGuyShieldGold.isPurchased = 1
						weaponsChange(nil)
					end
				end
			
			elseif(e.target == w.wGranade1) then

				if (v.playerCash > 699) then
					v.playerCash = v.playerCash - 700
					writeScreenCash(v.playerCash, 0)
					v.flareNum = 1
					w.wGranade1.flareNum = 8
					if (granadeAmmo < 992) then
						granadeAmmo = granadeAmmo + 7
					else
						granadeAmmo = 999
					end						
					isWeaponsChange = 1
					v.changeWeaponTo = "granade"
				end
			
			elseif(e.target == w.wGranadeGold) then

				if (v.playerCash > 999) then
					v.playerCash = v.playerCash - 1000
					writeScreenCash(v.playerCash, 0)
					g.granadeGold.isPurchased = 1
					v.flareNum = 1
					w.wGranadeGold.flareNum = 8
					if (granadeAmmo < 990) then
						granadeAmmo = granadeAmmo + 9
					else
						granadeAmmo = 999
					end						
					isWeaponsChange = 1
					v.changeWeaponTo = "granade"
				end
			
			end

		end

	end
	
end 


function addPriceTagListeners()

--        550,  8001, 1450, 1800
--  450, 7001,   950, 1600, 1950
-- 6001,  850,  1100, 1750, 2100
-- 1001, 1250, 15001, 2150, 25001

-- 6002, 15002, 25002
--  500,  8002
-- 7002,  1002



	w.wArrow2:addEventListener("touch", pButtonListener)
	w.wArrow3:addEventListener("touch", pButtonListener)

	w.wKnife1:addEventListener("touch", pButtonListener)
	w.wKnife2:addEventListener("touch", pButtonListener)
	w.wKnife3:addEventListener("touch", pButtonListener)

	w.wTomahawk1:addEventListener("touch", pButtonListener)
	w.wTomahawk2:addEventListener("touch", pButtonListener)
	w.wTomahawk3:addEventListener("touch", pButtonListener)

	w.wPistol1:addEventListener("touch", pButtonListener)
	w.wPistol2:addEventListener("touch", pButtonListener)
	w.wPistol3:addEventListener("touch", pButtonListener)

	w.wRifle1:addEventListener("touch", pButtonListener)
	w.wRifle2:addEventListener("touch", pButtonListener)
	w.wRifle3:addEventListener("touch", pButtonListener)

	w.wArrowGold:addEventListener("touch", pButtonListener)
	w.wKnifeGold:addEventListener("touch", pButtonListener)
	w.wTomahawkGold:addEventListener("touch", pButtonListener)
	w.wPistolGold:addEventListener("touch", pButtonListener)
	w.wRifleGold:addEventListener("touch", pButtonListener)

	w.wMace1:addEventListener("touch", pButtonListener)
	w.wMachete1:addEventListener("touch", pButtonListener)

	w.wMacheteGold:addEventListener("touch", pButtonListener)

	w.wHealthPack:addEventListener("touch", pButtonListener)
	w.wHealthPackGold:addEventListener("touch", pButtonListener)
	
	w.wGranade1:addEventListener("touch", pButtonListener)
	w.wGranadeGold:addEventListener("touch", pButtonListener)
	
end


addPriceTagListeners()


function tentTouched(e)

	if (e.phase == "began" and v.moveIntoTent == 1 and v.playerHealth > 0 and v.everPlayed == 2) then
	
		
		for i = 1, table.getn(treesTentsEtc), 1 do
		
			if (treesTentsEtc[i][1] == "Tent 1" or treesTentsEtc[i][1] == "Tent 2") then
				if (treesTentsEtc[i][2] > 80 and treesTentsEtc[i][2] < 320) then
		
					v.moveIntoTent = 65
					v.tentMoveIntoX = treesTentsEtc[i][2]
					
					v.cashFound = treesTentsEtc[i][3]
					treesTentsEtc[i][3] = 0
					
					leftButtonDown = 0
					rightButtonDown = 0
					
				end
			end
		
		end
			
	end
	
end


function vegas()

	if (h.t1 > 0 and h.t1 < 211) then
		if (h.t2 == 1) then
			h.head4.isVisible = true
			h.head5.isVisible = false
			h.head6.isVisible = false
		elseif (h.t2 == 3) then
			h.head4.isVisible = false
			h.head5.isVisible = true
			h.head6.isVisible = false
		elseif (h.t2 == 5) then
			h.head4.isVisible = false
			h.head5.isVisible = false
			h.head6.isVisible = true
		end
		
		h.t2 = h.t2 + 1

		if (h.t2 == 7) then
			h.t2 = 1
		end

	elseif (h.t1 > 210 and h.t1 < 271) then

		if (h.t3 == 1) then
			h.head4.isVisible = true
			h.head5.isVisible = true
			h.head6.isVisible = true
		elseif (h.t3 == 3) then
			h.head4.isVisible = false
			h.head5.isVisible = false
			h.head6.isVisible = false
		end
		
		h.t3 = h.t3 + 1

		if (h.t3 == 5) then
			h.t3 = 1
		end
	
	end
	
	
	
	h.t1 = h.t1 + 1

	if (h.t1 == 271) then
		h.t1 = 1
	end

end


function vegas2()

	if (h.t1 > 0 and h.t1 < 211) then
		if (h.t2 == 1) then
			b.head13.isVisible = true
			b.head14.isVisible = false
			b.head15.isVisible = false
		elseif (h.t2 == 3) then
			b.head13.isVisible = false
			b.head14.isVisible = true
			b.head15.isVisible = false
		elseif (h.t2 == 5) then
			b.head13.isVisible = false
			b.head14.isVisible = false
			b.head15.isVisible = true
		end
		
		h.t2 = h.t2 + 1

		if (h.t2 == 7) then
			h.t2 = 1
		end

	elseif (h.t1 > 210 and h.t1 < 271) then

		if (h.t3 == 1) then
			b.head13.isVisible = true
			b.head14.isVisible = true
			b.head15.isVisible = true
		elseif (h.t3 == 3) then
			b.head13.isVisible = false
			b.head14.isVisible = false
			b.head15.isVisible = false
		end
		
		h.t3 = h.t3 + 1

		if (h.t3 == 5) then
			h.t3 = 1
		end
	
	end
	
	
	
	h.t1 = h.t1 + 1

	if (h.t1 == 271) then
		h.t1 = 1
	end

end


function flameBurn()

	if (flameCounter == 1) then
		flame1.isVisible = true
		flame6.isVisible = false
		sGC.a1.isVisible = true
		sGC.b1.isVisible = true
		sGC.c1.isVisible = true
		sGC.a6.isVisible = false
		sGC.b6.isVisible = false
		sGC.c6.isVisible = false
	elseif (flameCounter == 4) then
		flame2.isVisible = true
		flame1.isVisible = false	
		sGC.a2.isVisible = true
		sGC.b2.isVisible = true
		sGC.c2.isVisible = true
		sGC.a1.isVisible = false
		sGC.b1.isVisible = false
		sGC.c1.isVisible = false
	elseif (flameCounter == 7) then
		flame3.isVisible = true
		flame2.isVisible = false	
		sGC.a3.isVisible = true
		sGC.b3.isVisible = true
		sGC.c3.isVisible = true
		sGC.a2.isVisible = false
		sGC.b2.isVisible = false
		sGC.c2.isVisible = false
	elseif (flameCounter == 10) then
		flame4.isVisible = true
		flame3.isVisible = false	
		sGC.a4.isVisible = true
		sGC.b4.isVisible = true
		sGC.c4.isVisible = true
		sGC.a3.isVisible = false
		sGC.b3.isVisible = false
		sGC.c3.isVisible = false
	elseif (flameCounter == 13) then
		flame5.isVisible = true
		flame4.isVisible = false	
		sGC.a5.isVisible = true
		sGC.b5.isVisible = true
		sGC.c5.isVisible = true
		sGC.a4.isVisible = false
		sGC.b4.isVisible = false
		sGC.c4.isVisible = false
	elseif (flameCounter == 16) then
		flame6.isVisible = true
		flame5.isVisible = false
		sGC.a6.isVisible = true
		sGC.b6.isVisible = true
		sGC.c6.isVisible = true
		sGC.a5.isVisible = false
		sGC.b5.isVisible = false
		sGC.c5.isVisible = false
	end

	flameCounter = flameCounter + 1
	
	if (flameCounter == 19) then
		flameCounter = 1
	end
		
end


function menuIn()

	if (b.menuInCounter == 1) then
		b.aztecGoldLogoEn.xScale = 1.9
		b.aztecGoldLogoEn.yScale = 1.9
		b.aztecGoldLogoSp.xScale = 1.9
		b.aztecGoldLogoSp.yScale = 1.9
		b.chestLogo.xScale = 1.9
		b.chestLogo.yScale = 1.9
		b.myGuyLogo.x = b.myGuyLogo.x - 160
		b.otherGuyLogo.x = b.otherGuyLogo.x + 160
		b.playEn.y = b.playEn.y + 80
		b.playSp.y = b.playSp.y + 80
		b.optionsEn.y = b.optionsEn.y + 80
		b.optionsSp.y = b.optionsSp.y + 80
		sumDisplayGroup.y = sumDisplayGroup.y + 80
		b.facebookEn.y = b.facebookEn.y + 80
	elseif (b.menuInCounter == 2) then
		b.aztecGoldLogoEn.xScale = 1.7
		b.aztecGoldLogoEn.yScale = 1.7
		b.aztecGoldLogoSp.xScale = 1.7
		b.aztecGoldLogoSp.yScale = 1.7
		b.chestLogo.xScale = 1.7
		b.chestLogo.yScale = 1.7
		b.myGuyLogo.x = b.myGuyLogo.x + 40
		b.otherGuyLogo.x = b.otherGuyLogo.x - 40
		b.playEn.y = b.playEn.y - 20
		b.playSp.y = b.playSp.y - 20
		b.optionsEn.y = b.optionsEn.y - 20
		b.optionsSp.y = b.optionsSp.y - 20
		sumDisplayGroup.y = sumDisplayGroup.y - 20
		b.facebookEn.y = b.facebookEn.y - 20
	elseif (b.menuInCounter == 3) then
		b.aztecGoldLogoEn.xScale = 1.5
		b.aztecGoldLogoEn.yScale = 1.5
		b.aztecGoldLogoSp.xScale = 1.5
		b.aztecGoldLogoSp.yScale = 1.5
		b.chestLogo.xScale = 1.5
		b.chestLogo.yScale = 1.5
		b.myGuyLogo.x = b.myGuyLogo.x + 40
		b.otherGuyLogo.x = b.otherGuyLogo.x - 40
		b.playEn.y = b.playEn.y - 20
		b.playSp.y = b.playSp.y - 20
		b.optionsEn.y = b.optionsEn.y - 20
		b.optionsSp.y = b.optionsSp.y - 20
		sumDisplayGroup.y = sumDisplayGroup.y - 20
		b.facebookEn.y = b.facebookEn.y - 20
	elseif (b.menuInCounter == 4) then
		b.aztecGoldLogoEn.xScale = 1.3
		b.aztecGoldLogoEn.yScale = 1.3
		b.aztecGoldLogoSp.xScale = 1.3
		b.aztecGoldLogoSp.yScale = 1.3
		b.chestLogo.xScale = 1.3
		b.chestLogo.yScale = 1.3		
		b.myGuyLogo.x = b.myGuyLogo.x + 40
		b.otherGuyLogo.x = b.otherGuyLogo.x - 40
		b.playEn.y = b.playEn.y - 20
		b.playSp.y = b.playSp.y - 20
		b.optionsEn.y = b.optionsEn.y - 20
		b.optionsSp.y = b.optionsSp.y - 20
		sumDisplayGroup.y = sumDisplayGroup.y - 20
		b.facebookEn.y = b.facebookEn.y - 20
	elseif (b.menuInCounter == 5) then
		b.aztecGoldLogoEn.xScale = 1.0
		b.aztecGoldLogoEn.yScale = 1.0
		b.aztecGoldLogoSp.xScale = 1.0
		b.aztecGoldLogoSp.yScale = 1.0
		b.chestLogo.xScale = 1.0
		b.chestLogo.yScale = 1.0		
		b.myGuyLogo.x = b.myGuyLogo.x + 40
		b.otherGuyLogo.x = b.otherGuyLogo.x - 40
		b.playEn.y = b.playEn.y - 20
		b.playSp.y = b.playSp.y - 20
		b.optionsEn.y = b.optionsEn.y - 20
		b.optionsSp.y = b.optionsSp.y - 20
		sumDisplayGroup.y = sumDisplayGroup.y - 20
		b.facebookEn.y = b.facebookEn.y - 20
	end

	if (b.menuInCounter < 6) then
		b.menuInCounter = b.menuInCounter + 1
	end	
	
end


function coinTurn()

	if (b.coinCounter == 1) then
		b.sumCoin1.isVisible = true
		b.sumCoin6.isVisible = false
	elseif (b.coinCounter == 4) then
		b.sumCoin2.isVisible = true
		b.sumCoin1.isVisible = false
	elseif (b.coinCounter == 7) then
		b.sumCoin3.isVisible = true
		b.sumCoin2.isVisible = false		
	elseif (b.coinCounter == 10) then
		b.sumCoin4.isVisible = true
		b.sumCoin3.isVisible = false		
	elseif (b.coinCounter == 13) then
		b.sumCoin5.isVisible = true
		b.sumCoin4.isVisible = false		
	elseif (b.coinCounter == 16) then
		b.sumCoin6.isVisible = true
		b.sumCoin5.isVisible = false		
	end

	b.coinCounter = b.coinCounter + 1
	
	if (b.coinCounter == 19) then
		b.coinCounter = 1
	end
		
end


function shine()

	if (b.enOrSp == 1 and flameCounter == 1) then
		b.shine1.x = 111
		b.shine1.y = 21
	elseif (b.enOrSp == 1 and flameCounter == 100) then
		b.shine1.x = 250
		b.shine1.y = 58	
	elseif (b.enOrSp == 1 and flameCounter == 200) then
		b.shine1.x = 402
		b.shine1.y = 16	
	elseif(b.enOrSp == 2 and flameCounter == 1) then
		b.shine1.x = 107
		b.shine1.y = 21
	elseif (b.enOrSp == 2 and flameCounter == 100) then
		b.shine1.x = 234
		b.shine1.y = 17
	elseif (b.enOrSp == 2 and flameCounter == 200) then
		b.shine1.x = 417
		b.shine1.y = 30	
	end
	
	
	if (flameCounter == 1 or flameCounter == 101 or flameCounter == 201) then
		b.shine1.xScale = 1.4
		b.shine1.yScale = 1.4	
	elseif (flameCounter == 6 or flameCounter == 106 or flameCounter == 206) then
		b.shine1.xScale = 1.8
		b.shine1.yScale = 1.8
	elseif (flameCounter == 11 or flameCounter == 111 or flameCounter == 211) then
		b.shine1.xScale = 2.2
		b.shine1.yScale = 2.2
	elseif (flameCounter == 16 or flameCounter == 116 or flameCounter == 216) then
		b.shine1.xScale = 1.8
		b.shine1.yScale = 1.8
	elseif (flameCounter == 21 or flameCounter == 121 or flameCounter == 221) then
		b.shine1.xScale = 1.4
		b.shine1.yScale = 1.4
	elseif (flameCounter == 26 or flameCounter == 126 or flameCounter == 226) then
		b.shine1.xScale = 1
		b.shine1.yScale = 1
	elseif (flameCounter == 31 or flameCounter == 131 or flameCounter == 231) then
		b.shine1.xScale = .01
		b.shine1.yScale = .01
	end
	
	flameCounter = flameCounter + 1
	
	if (flameCounter == 300) then
		flameCounter = 1
	end

end


function moveGuyIntoTent()

	if (fFrame == 1) then
	
		if (v.moveIntoTent > 45) then
			walk()
			myGuy.y = myGuy.y - 2
			
			if (v.moveIntoTent == 65) then
				if (v.soundOn == 1) then
					audio.play(a.tentSound1, 11)
				end
				tent.tent1opening2.isVisible = true
				tent.tent2opening2.isVisible = true
			elseif (v.moveIntoTent == 63) then
				tent.tent1opening3.isVisible = true
				tent.tent2opening3.isVisible = true
			elseif (v.moveIntoTent == 61) then
				tent.tent1opening4.isVisible = true
				tent.tent2opening4.isVisible = true
			end			
			
		elseif(v.moveIntoTent > 22) then
			myGuy.isVisible = false

			if (v.moveIntoTent == 44) then
				tent.tent1opening4.isVisible = false
				tent.tent2opening4.isVisible = false
			elseif (v.moveIntoTent == 42) then
				tent.tent1opening3.isVisible = false
				tent.tent2opening3.isVisible = false
			elseif (v.moveIntoTent == 40) then
				tent.tent1opening2.isVisible = false
				tent.tent2opening2.isVisible = false
			elseif (v.moveIntoTent == 28) then
				tent.tent1opening2.isVisible = true
				tent.tent2opening2.isVisible = true
			elseif (v.moveIntoTent == 26) then
				tent.tent1opening3.isVisible = true
				tent.tent2opening3.isVisible = true
			elseif (v.moveIntoTent == 24) then
				tent.tent1opening4.isVisible = true
				tent.tent2opening4.isVisible = true
				if (v.soundOn == 1) then
					audio.play(a.tentSound2, 11)
				end
			end			
			
		elseif(v.moveIntoTent > 21) then
			myGuy.isVisible = true
		elseif(v.moveIntoTent > 1) then
			walk()
			myGuy.y = myGuy.y + 2
			
			if (v.moveIntoTent == 12) then
				tent.tent1opening4.isVisible = false
				tent.tent2opening4.isVisible = false
			elseif (v.moveIntoTent == 10) then
				tent.tent1opening3.isVisible = false
				tent.tent2opening3.isVisible = false
			elseif (v.moveIntoTent == 8) then
				tent.tent1opening2.isVisible = false
				tent.tent2opening2.isVisible = false
			end	

		end
		
		v.moveIntoTent = v.moveIntoTent - 1
		
		-- this will flip around inside the tent
		if (leftButtonDown == 1) then
			myGuy.xScale = -1
		elseif (rightButtonDown == 1) then
			myGuy.xScale = 1
		end
		
		
		if (v.moveIntoTent == 40) then
			if (v.cashFound > 0) then
				if (v.cashFound - math.floor(v.levelPlaying / 2) < 13) then
					
					granadeButtonDarkMask.isVisible = false
										
					if (v.levelPlaying < 11) then
						if (granadeAmmo < 996) then
							granadeAmmo = granadeAmmo + 3
						else
							granadeAmmo = 999
						end
					elseif (v.levelPlaying < 21) then
						if (granadeAmmo < 995) then
							granadeAmmo = granadeAmmo + 4
						else
							granadeAmmo = 999
						end
					else
						if (granadeAmmo < 994) then
							granadeAmmo = granadeAmmo + 5
						else
							granadeAmmo = 999
						end
					end
					
					c.cashTentCoin.isVisible = false
					c.cashTentGranade.isVisible = true
				else
					c.cashTentCoin.isVisible = true
					c.cashTentGranade.isVisible = false
					v.playerCash = v.playerCash + v.cashFound
					v.levelCash = v.levelCash + v.cashFound
					v.sumCash = v.sumCash + v.cashFound
					if (v.sumCash > 9999999) then
						v.sumCash = 9999999
					end
					if (v.playerCash > 99999) then
						v.playerCash = 99999
					end	
					writeScreenCash(v.playerCash)
				
				end
				
			end
		end
		
		if (v.moveIntoTent < 41) then
			if (v.cashFound > 0) then
				cashTentCoinDisplayGroup.isVisible = true
				cashTentCoinDisplayGroup.y = cashTentCoinDisplayGroup.y - 3
			end
		end
		
		if (v.moveIntoTent < 41 and v.moveIntoTent > 32) then
			c.cashTentCoin.xScale = c.cashTentCoin.xScale + 0.1
			c.cashTentCoin.yScale = c.cashTentCoin.yScale + 0.1
			c.cashTentGranade.xScale = c.cashTentGranade.xScale + 0.1
			c.cashTentGranade.yScale = c.cashTentGranade.yScale + 0.1
		end
		
		if (v.moveIntoTent < 33 and v.moveIntoTent > 24) then
			c.cashTentCoin.xScale = c.cashTentCoin.xScale - 0.1
			c.cashTentCoin.yScale = c.cashTentCoin.yScale - 0.1
			c.cashTentGranade.xScale = c.cashTentGranade.xScale - 0.1
			c.cashTentGranade.yScale = c.cashTentGranade.yScale - 0.1
		end

		
		if (v.moveIntoTent == 2) then
			v.cashFound = 0
			cashTentCoinDisplayGroup.isVisible = false
			cashTentCoinDisplayGroup.x = -115
			cashTentCoinDisplayGroup.y = 100
			c.cashTentCoin.xScale = 1
			c.cashTentCoin.yScale = 1
			c.cashTentGranade.xScale = 1
			c.cashTentGranade.yScale = 1
			c.cashTentCoin.isVisible = false
			c.cashTentGranade.isVisible = false
		end

	end

	if (f63 == 1) then
		if (v.tentMoveIntoX >= 195 and v.tentMoveIntoX <= 205) then
			-- Do Nothing
		elseif (v.tentMoveIntoX > 205) then	
			moveSide(1)
			v.tentMoveIntoX = v.tentMoveIntoX - 2.25 * f63
		elseif (v.tentMoveIntoX < 195) then	
			moveSide(-1)
			v.tentMoveIntoX = v.tentMoveIntoX + 2.25 * f63
		end
	elseif(fFrame == 1) then
		if (v.tentMoveIntoX >= 195 and v.tentMoveIntoX <= 205) then
			-- Do Nothing
		elseif (v.tentMoveIntoX > 205) then	
			moveSide(1)
			v.tentMoveIntoX = v.tentMoveIntoX - 2.25 * f63
		elseif (v.tentMoveIntoX < 195) then	
			moveSide(-1)
			v.tentMoveIntoX = v.tentMoveIntoX + 2.25 * f63
		end	
	end
			
end 


function makeUpStartUpMessage()
	
		
	hideStartUpLetters()
	
	if (b.enOrSp == 2) then
		startUpMessage[1] = startUpLetters.N
		startUpMessage[2] = startUpLetters.i
	else
		startUpMessage[1] = startUpLetters.L
		startUpMessage[2] = startUpLetters.e
	end
	
	startUpMessage[3] = startUpLetters.v
	startUpMessage[4] = startUpLetters.e2
	startUpMessage[5] = startUpLetters.l

	startUpMessage[1].x = 0
	if (b.enOrSp == 2) then
		startUpMessage[2].x = 34
	else
		startUpMessage[2].x = 30
	end
	startUpMessage[3].x = 60
	startUpMessage[4].x = 90
	startUpMessage[5].x = 116

	startUpMessage[1].y = 0
	if (b.enOrSp == 2) then
		startUpMessage[2].y = 0
	else
		startUpMessage[2].y = 6
	end
	startUpMessage[3].y = 6
	startUpMessage[4].y = 6
	startUpMessage[5].y = 0

	startUpMessage[6] = nil
	startUpMessage[7] = nil
	
	startUpMessage[1].isVisible = true
	startUpMessage[2].isVisible = true
	startUpMessage[3].isVisible = true
	startUpMessage[4].isVisible = true
	startUpMessage[5].isVisible = true
	
	local n = v.levelPlaying
	local pString = tostring(n)
	local pChar = nil
	for i = 1, string.len(pString) do
		pChar = string.sub(pString, i, i)
		if (pChar == "1") then
			startUpMessage[i + 5] = startUpNumbers[1][i]
		elseif (pChar == "2") then
			startUpMessage[i + 5] = startUpNumbers[2][i]
		elseif (pChar == "3") then
			startUpMessage[i + 5] = startUpNumbers[3][i]
		elseif (pChar == "4") then
			startUpMessage[i + 5] = startUpNumbers[4][i]
		elseif (pChar == "5") then
			startUpMessage[i + 5] = startUpNumbers[5][i]
		elseif (pChar == "6") then
			startUpMessage[i + 5] = startUpNumbers[6][i]
		elseif (pChar == "7") then
			startUpMessage[i + 5] = startUpNumbers[7][i]
		elseif (pChar == "8") then
			startUpMessage[i + 5] = startUpNumbers[8][i]
		elseif (pChar == "9") then
			startUpMessage[i + 5] = startUpNumbers[9][i]
		elseif (pChar == "0") then
			startUpMessage[i + 5] = startUpNumbers[10][i]
		end
	end
	
	startUpMessage[6].isVisible = true
	
	if (startUpMessage[7] ~= nil) then
		startUpMessage[7].isVisible = true
	end
	
	startUpMessage[6].x = 180
	startUpMessage[6].y = 0
	
	if (startUpMessage[7] ~= nil) then
		startUpMessage[7].x = 210
		startUpMessage[7].y = 0
	end
	
end
	
	
function putOutStartUpLetters()

	if (v.startOfLevel > 0 and v.startOfLevel < 6) then
		if (startUpMessage[7]  ~= nil) then
			startUpMessage[7].x = startUpMessage[7].x + 90
		end
	elseif(v.startOfLevel > 5 and v.startOfLevel < 11) then	
		startUpMessage[6].x = startUpMessage[6].x + 90
	elseif(v.startOfLevel > 10 and v.startOfLevel < 16) then	
		startUpMessage[5].x = startUpMessage[5].x + 90
	elseif(v.startOfLevel > 15 and v.startOfLevel < 21) then	
		startUpMessage[4].x = startUpMessage[4].x + 90
	elseif(v.startOfLevel > 20 and v.startOfLevel < 26) then	
		startUpMessage[3].x = startUpMessage[3].x + 90
	elseif(v.startOfLevel > 25 and v.startOfLevel < 31) then	
		startUpMessage[2].x = startUpMessage[2].x + 90
	elseif(v.startOfLevel > 30 and v.startOfLevel < 36) then	
		startUpMessage[1].x = startUpMessage[1].x + 90
	
	elseif(v.startOfLevel > 55 and v.startOfLevel < 61) then	
		startUpMessage[1].x = startUpMessage[1].x - 90
	elseif(v.startOfLevel > 60 and v.startOfLevel < 66) then	
		startUpMessage[2].x = startUpMessage[2].x - 90
	elseif(v.startOfLevel > 65 and v.startOfLevel < 71) then	
		startUpMessage[3].x = startUpMessage[3].x - 90
	elseif(v.startOfLevel > 70 and v.startOfLevel < 76) then	
		startUpMessage[4].x = startUpMessage[4].x - 90
	elseif(v.startOfLevel > 75 and v.startOfLevel < 81) then	
		startUpMessage[5].x = startUpMessage[5].x - 90
	elseif(v.startOfLevel > 80 and v.startOfLevel < 86) then	
		startUpMessage[6].x = startUpMessage[6].x - 90
	elseif(v.startOfLevel > 85 and v.startOfLevel < 91) then	
		if (startUpMessage[7]  ~= nil) then
			startUpMessage[7].x = startUpMessage[7].x - 90
		end
	end
	
		
	v.startOfLevel = v.startOfLevel + 1
	
	if (v.startOfLevel == 91) then
		v.startOfLevel = 0
		maskScreenDisplayGroup.isVisible = false
		audio.stop(3) -- menuMusic
	end

end


function putOutVictoryLetters()
	
	if (b.enOrSp == 2) then
		victoryLetters.y.isVisible = false
		victoryLetters.i2.isVisible = true
		victoryLetters.a.isVisible = true
	else
		victoryLetters.y.isVisible = true
		victoryLetters.i2.isVisible = false
		victoryLetters.a.isVisible = false
	end
	
	v.victoryLetterCounter = v.victoryLetterCounter + 1
	
	if (v.victoryLetterCounter > 0 and v.victoryLetterCounter < 6) then
		victoryLetters.V.x = victoryLetters.V.x + 90
	elseif(v.victoryLetterCounter > 5 and v.victoryLetterCounter < 11) then	
		victoryLetters.i.x = victoryLetters.i.x + 90
	elseif(v.victoryLetterCounter > 10 and v.victoryLetterCounter < 16) then	
		victoryLetters.c.x = victoryLetters.c.x + 90
	elseif(v.victoryLetterCounter > 15 and v.victoryLetterCounter < 21) then	
		victoryLetters.t.x = victoryLetters.t.x + 90
	elseif(v.victoryLetterCounter > 20 and v.victoryLetterCounter < 26) then	
		victoryLetters.o.x = victoryLetters.o.x + 90
	elseif(v.victoryLetterCounter > 25 and v.victoryLetterCounter < 31) then	
		victoryLetters.r.x = victoryLetters.r.x + 90
	elseif(v.victoryLetterCounter > 30 and v.victoryLetterCounter < 36) then	
		victoryLetters.y.x = victoryLetters.y.x + 90
		victoryLetters.i2.x = victoryLetters.i2.x + 90
	elseif(v.victoryLetterCounter > 37 and v.victoryLetterCounter < 43) then	
		victoryLetters.a.x = victoryLetters.a.x + 90
	
	elseif(v.victoryLetterCounter > 65 and v.victoryLetterCounter < 71) then	
		victoryLetters.V.x = victoryLetters.V.x + 90
	elseif(v.victoryLetterCounter > 70 and v.victoryLetterCounter < 76) then	
		victoryLetters.i.x = victoryLetters.i.x + 90
	elseif(v.victoryLetterCounter > 75 and v.victoryLetterCounter < 81) then	
		victoryLetters.c.x = victoryLetters.c.x + 90
	elseif(v.victoryLetterCounter > 80 and v.victoryLetterCounter < 86) then	
		victoryLetters.t.x = victoryLetters.t.x + 90
	elseif(v.victoryLetterCounter > 85 and v.victoryLetterCounter < 91) then	
		victoryLetters.o.x = victoryLetters.o.x + 90
	elseif(v.victoryLetterCounter > 90 and v.victoryLetterCounter < 96) then	
		victoryLetters.r.x = victoryLetters.r.x + 90
	elseif(v.victoryLetterCounter > 95 and v.victoryLetterCounter < 101) then	
		victoryLetters.y.x = victoryLetters.y.x + 90
		victoryLetters.i2.x = victoryLetters.i2.x + 90
	elseif(v.victoryLetterCounter > 100 and v.victoryLetterCounter < 106) then			
		victoryLetters.a.x = victoryLetters.a.x + 90
	end

end


function pyramidOver(e)

	if (e.phase == "ended") then
		activeScreen = "menu"
		gameScreenDisplayGroup.isVisible = false
		pyramidDisplayGroup.isVisible = false
		b.pyramidBackground:removeEventListener("touch", pyramidOver)
		audio.fadeOut({ channel = 5, time = 500 } )
	
	end
end


function doPyramid()

	if (v.pyramidCounter == 1 and pyramidDisplayGroup.isVisible == false) then
		pyramidDisplayGroup.isVisible = true
				
		b.pyramidBackground = display.newImage("Background Final Scene.png", true)
		
		b.pyramidBackground:addEventListener("touch", pyramidOver)
		
		b.pyramidBackground.x = _W / 2
		b.pyramidBackground.y = _H / 2
		
		b.leftFlame01 = display.newImage("Flame 01.png")
		b.leftFlame02 = display.newImage("Flame 02.png")
		b.leftFlame03 = display.newImage("Flame 03.png")
		b.leftFlame04 = display.newImage("Flame 04.png")
		b.leftFlame05 = display.newImage("Flame 05.png")
		b.leftFlame06 = display.newImage("Flame 06.png")
		
		b.leftFlame01.x = 49
		b.leftFlame02.x = 49
		b.leftFlame03.x = 49
		b.leftFlame04.x = 49
		b.leftFlame05.x = 49
		b.leftFlame06.x = 49

		b.leftFlame01.y = 47
		b.leftFlame02.y = 47
		b.leftFlame03.y = 47
		b.leftFlame04.y = 47
		b.leftFlame05.y = 47
		b.leftFlame06.y = 47

		b.rightFlame01 = display.newImage("Flame 01.png")
		b.rightFlame02 = display.newImage("Flame 02.png")
		b.rightFlame03 = display.newImage("Flame 03.png")
		b.rightFlame04 = display.newImage("Flame 04.png")
		b.rightFlame05 = display.newImage("Flame 05.png")
		b.rightFlame06 = display.newImage("Flame 06.png")
		
		b.rightFlame01.x = 440
		b.rightFlame02.x = 440
		b.rightFlame03.x = 440
		b.rightFlame04.x = 440
		b.rightFlame05.x = 440
		b.rightFlame06.x = 440

		b.rightFlame01.y = 47
		b.rightFlame02.y = 47
		b.rightFlame03.y = 47
		b.rightFlame04.y = 47
		b.rightFlame05.y = 47
		b.rightFlame06.y = 47

		b.beam01 = display.newImage("Beam.png")
		b.beam02 = display.newImage("Beam.png")
		b.beam03 = display.newImage("Beam.png")
		b.beam04 = display.newImage("Beam.png")
		
		b.beam01.x = 79
		b.beam02.x = 409
		b.beam03.x = 116
		b.beam04.x = 363
		
		b.beam01.y = 23
		b.beam02.y = 23
		b.beam03.y = 15
		b.beam04.y = 18
		
		b.beam01.yScale = 10
		b.beam02.yScale = 10
		b.beam03.yScale = 6
		b.beam04.yScale = 6

		b.beam03.xScale = .8
		b.beam04.xScale = .8
		
		b.beam01.alpha = 0
		b.beam02.alpha = 0
		b.beam03.alpha = 0
		b.beam04.alpha = 0
				
		pyramidDisplayGroup:insert(b.pyramidBackground)
		
		pyramidDisplayGroup:insert(b.leftFlame01)
		pyramidDisplayGroup:insert(b.leftFlame02)
		pyramidDisplayGroup:insert(b.leftFlame03)
		pyramidDisplayGroup:insert(b.leftFlame04)
		pyramidDisplayGroup:insert(b.leftFlame05)
		pyramidDisplayGroup:insert(b.leftFlame06)
		
		pyramidDisplayGroup:insert(b.rightFlame01)
		pyramidDisplayGroup:insert(b.rightFlame02)
		pyramidDisplayGroup:insert(b.rightFlame03)
		pyramidDisplayGroup:insert(b.rightFlame04)
		pyramidDisplayGroup:insert(b.rightFlame05)
		pyramidDisplayGroup:insert(b.rightFlame06)
		
		pyramidDisplayGroup:insert(b.beam01)
		pyramidDisplayGroup:insert(b.beam02)
		pyramidDisplayGroup:insert(b.beam03)
		pyramidDisplayGroup:insert(b.beam04)
		
		b.flameCounter = 1
		
	end

	
	if (b.flameCounter == 1) then
		b.leftFlame01.isVisible = true
		b.rightFlame04.isVisible = true
		b.leftFlame06.isVisible = false	
		b.rightFlame03.isVisible = false	
	elseif (b.flameCounter == 4) then
		b.leftFlame02.isVisible = true
		b.rightFlame05.isVisible = true
		b.leftFlame01.isVisible = false	
		b.rightFlame04.isVisible = false	
	elseif (b.flameCounter == 7) then
		b.leftFlame03.isVisible = true
		b.rightFlame06.isVisible = true
		b.leftFlame02.isVisible = false	
		b.rightFlame05.isVisible = false	
	elseif (b.flameCounter == 10) then
		b.leftFlame04.isVisible = true
		b.rightFlame01.isVisible = true
		b.leftFlame03.isVisible = false	
		b.rightFlame06.isVisible = false	
	elseif (b.flameCounter == 13) then
		b.leftFlame05.isVisible = true
		b.rightFlame02.isVisible = true
		b.leftFlame04.isVisible = false	
		b.rightFlame01.isVisible = false	
	elseif (b.flameCounter == 16) then
		b.leftFlame06.isVisible = true
		b.rightFlame03.isVisible = true
		b.leftFlame05.isVisible = false
		b.rightFlame02.isVisible = false
	end

	b.flameCounter = b.flameCounter + 1
	
	if (b.flameCounter == 19) then
		b.flameCounter = 1
	end
	
	
	if (victoryMaskScreen.alpha > .05) then
		victoryMaskScreen.alpha = victoryMaskScreen.alpha - .03
	else
		maskScreenDisplayGroup.isVisible = false
	end

	if (v.pyramidCounter < 300) then
		v.pyramidCounter = v.pyramidCounter + 1
	end
	
	if (v.pyramidCounter > 100 and v.pyramidCounter < 200) then
		b.beam01.alpha = b.beam01.alpha + .01
		b.beam02.alpha = b.beam02.alpha + .01
		b.beam03.alpha = b.beam03.alpha + .01
		b.beam04.alpha = b.beam04.alpha + .01
	end
		

end


function doVictorySequence()
	
	--victory do's here
	if (v.victoryLetterCounter < 106) then
		putOutVictoryLetters()
	end
		
	if (v.victorySequence < 4) then
		maskScreenDisplayGroup.isVisible = true
		victoryMaskScreen.isVisible = true
	end
	
	
	if (v.victorySequence == 1) then
		if (victoryMaskScreen.alpha < .95) then
			victoryMaskScreen.alpha = victoryMaskScreen.alpha + .03
			cashChestCoinDisplayGroup.y = cashChestCoinDisplayGroup.y - 3
		else
			cashChestCoinDisplayGroup.isVisible = false
			v.victorySequence = 2
			if (v.levelPlaying == 30) then
				weaponsWallDisplayGroup.isVisible = false
				chest1.isVisible = false
				w.wShip.isVisible = true
				treesTentsEtc[14][2] = 425
				tree2.x = 425
				treesTentsEtc[7][2] = -180
				treesTentsEtc[13][2] = -480
				treesTentsEtc[23][2] = -580
				tree1.x = -180
				if (v.levelPlaying == 30) then
					audio.fadeOut({ channel = 1, time = 500 } )
					if (v.musicOn == 1) then
						audio.play(a.finaleMusic, { channel = 5, loops = -1, fadein = 500})
					end
				end
			else
				weaponsWallDisplayGroup.isVisible = true
				chest1.isVisible = false
				treesTentsEtc[14][2] = 1025
				tree2.x = 1025
				treesTentsEtc[7][2] = -280
				treesTentsEtc[13][2] = -580
				treesTentsEtc[23][2] = -680
				tree1.x = -280
			end
			myGuy.x = 30
			treesTentsEtc[28][2] = -7
			weaponsWallDisplayGroup.x = -7
			smallCoin1.x = -1000
			smallCoin1.isVisible = false
			smallCoin2.x = -1000
			smallCoin2.isVisible = false
			smallCoin3.x = -1000
			smallCoin3.isVisible = false
			--saveFileHandling("save")
		end
	elseif (v.victorySequence == 2) then
		if (victoryMaskScreen.alpha > .05) then
			victoryMaskScreen.alpha = victoryMaskScreen.alpha - .03
		else
			v.victorySequence = 3
			if (v.levelPlaying == 30) then
				audio.stop(1) -- soundTrack
				audio.rewind(1)
				audio.setVolume( 1, { channel = 1 } )
				
				v.playerCash = v.playerCash + 10000
				v.sumCash = v.sumCash + 10000
				if (v.sumCash > 9999999) then
					v.sumCash = 9999999
				end
				if (v.playerCash > 99999) then
					v.playerCash = 99999
				end

				writeScreenCash(v.playerCash)
				
			end
		end
	elseif (v.endOfWeaponsSelection == 1) then
		if (victoryMaskScreen.alpha < .95 and v.victorySequence < 4) then
			victoryMaskScreen.alpha = victoryMaskScreen.alpha + .03
		else
			--victoryMaskScreen.alpha = 1
			--saveing.isVisible = true
			v.victorySequence = 4			
		end
		
	end
	
	-- WALKED TO THE VERY END AGAIN
	
	if(treesTentsEtc[14][2] < 280) then
		v.endOfWeaponsSelection = 1
	end
	if(treesTentsEtc[7][2] > 20) then
		v.endOfWeaponsSelection = 1
	end
	
	-- ALL FINISHED
	
	if (v.victorySequence == 4) then
				
		if (v.levelPlaying < 30) then
			v.levelPlaying = v.levelPlaying + 1
			gameScreenDisplayGroup.isVisible = false
		else
			doPyramid()
		end
		
		if (v.levelPlaying > v.levelReached) then
			v.levelReached = v.levelPlaying
		end

		--local alp = victoryMaskScreen.alpha
		--victoryMaskScreen.alpha = 1
		saveFileHandling("save")
		--saveing.isVisible = false
		--victoryMaskScreen.alpha = alp
		
	end

	
end 


function doStartOfLevel()

	maskScreenDisplayGroup.isVisible = true
	victoryMaskScreen.isVisible = true
	
	
	if (victoryMaskScreen.alpha > .05) then
			victoryMaskScreen.alpha = victoryMaskScreen.alpha - .03
	end

	putOutStartUpLetters()
	
end 


function doEndOfLevel()
	
	if (v.dyingCounter == 24) then
		if (victoryMaskScreen.alpha < .95) then
			victoryMaskScreen.alpha = victoryMaskScreen.alpha + .02
			maskScreenDisplayGroup.isVisible = true
		else
			gameScreenDisplayGroup.isVisible = false
			maskScreenDisplayGroup.isVisible = false
			victoryMaskScreen.isVisible = false
			if (v.musicOn == 1) then
				audio.play(a.soundTrack01, { channel = 1, loops = -1, fadein = 500} )
			end
		end
	end
end 


function myGuyDying()
	
	if(v.dyingCounter == 1) then

		audio.stop(1) -- soundTrack
		audio.rewind(1) 
		if (v.musicOn == 1 or v.soundOn == 1) then
			audio.play(a.deathMusic, {channel = 4, loops = 0})
		end
		
		gunSmoke01.isVisible = false
		gunSmoke02.isVisible = false
		gunSmoke03.isVisible = false

		m1.gunSmoke01.isVisible = false
		m1.gunSmoke02.isVisible = false
		m1.gunSmoke03.isVisible = false

		m2.gunSmoke01.isVisible = false
		m2.gunSmoke02.isVisible = false
		m2.gunSmoke03.isVisible = false

		m3.gunSmoke01.isVisible = false
		m3.gunSmoke02.isVisible = false
		m3.gunSmoke03.isVisible = false
		
		exp01.isVisible = false
		
		v.dyingCounter = v.dyingCounter + 1
		
		h.leftLeg1.rotation = 0
		h.leftLeg2.rotation = 0
		h.leftLeg3.rotation = 0
		
		h.rightLeg1.rotation = 0
		h.rightLeg2.rotation = 0
		h.rightLeg3.rotation = 0
		
		--leftLeg.rotation = 0
		--rightLeg.rotation = 0

		myGuy.rotation = myGuy.rotation - (2 * myGuy.xScale)
		myGuy.y = myGuy.y + 1
		myGuy.x = myGuy.x + (2 * myGuy.xScale)
		
				
	elseif(v.dyingCounter == 2) then
		v.dyingCounter = v.dyingCounter + 1

		myGuy.rotation = myGuy.rotation - (2 * myGuy.xScale)
		myGuy.y = myGuy.y + 1
		myGuy.x = myGuy.x + (2 * myGuy.xScale)
		
		
	elseif(v.dyingCounter == 3) then
		v.dyingCounter = v.dyingCounter + 1

		myGuy.rotation = myGuy.rotation + (2 * myGuy.xScale)
		myGuy.y = myGuy.y - 1
		myGuy.x = myGuy.x - (2 * myGuy.xScale)
		
		moveBody("leftLeg", 0, 0, -3)
		moveBody("rightLeg", 0, 0, 3)		
		
		--rightLeg.rotation = rightLeg.rotation - 3
		--leftLeg.rotation = leftLeg.rotation + 3

	elseif(v.dyingCounter == 4) then
		v.dyingCounter = v.dyingCounter + 1
		
		myGuy.rotation = myGuy.rotation + (2 * myGuy.xScale)
		myGuy.y = myGuy.y - 1
		myGuy.x = myGuy.x - (2 * myGuy.xScale)

		moveBody("leftLeg", 0, 0, -3)
		moveBody("rightLeg", 0, 0, 3)		
		
		--rightLeg.rotation = rightLeg.rotation - 3
		--leftLeg.rotation = leftLeg.rotation + 3
		
	elseif(v.dyingCounter == 5) then
		v.dyingCounter = v.dyingCounter + 1
		
		myGuy.rotation = myGuy.rotation + (4 * myGuy.xScale)
		myGuy.y = myGuy.y + 2
		myGuy.x = myGuy.x - (3 * myGuy.xScale)
		
		moveBody("leftLeg", 0, 0, -3)
		moveBody("rightLeg", 0, 0, 3)		

		--rightLeg.rotation = rightLeg.rotation - 3
		--leftLeg.rotation = leftLeg.rotation + 3
		
	elseif(v.dyingCounter == 6) then
		v.dyingCounter = v.dyingCounter + 1
		
		myGuy.rotation = myGuy.rotation + (6 * myGuy.xScale)
		myGuy.y = myGuy.y + 3
		myGuy.x = myGuy.x - (3 * myGuy.xScale)
		
		moveBody("leftLeg", 0, 0, -3)
		moveBody("rightLeg", 0, 0, 3)		
		
		--rightLeg.rotation = rightLeg.rotation - 3
		--leftLeg.rotation = leftLeg.rotation + 3
		
	elseif(v.dyingCounter == 7) then
		v.dyingCounter = v.dyingCounter + 1

		myGuy.rotation = myGuy.rotation + (11 * myGuy.xScale)
		myGuy.y = myGuy.y + 4
		myGuy.x = myGuy.x - (3 * myGuy.xScale)
		
		moveBody("leftLeg", 0, 0, -3)
		moveBody("rightLeg", 0, 0, 3)		

		--rightLeg.rotation = rightLeg.rotation - 3
		--leftLeg.rotation = leftLeg.rotation + 3
		
		shadow.isVisible = false
	elseif(v.dyingCounter == 8) then
		v.dyingCounter = v.dyingCounter + 1

		myGuy.rotation = myGuy.rotation + (16 * myGuy.xScale)
		myGuy.y = myGuy.y + 5
		myGuy.x = myGuy.x - (3 * myGuy.xScale)

		moveBody("leftLeg", 0, 0, -3)
		moveBody("rightLeg", 0, 0, 3)		
		
		--rightLeg.rotation = rightLeg.rotation - 3
		--leftLeg.rotation = leftLeg.rotation + 3
		
	elseif(v.dyingCounter == 9) then
		v.dyingCounter = v.dyingCounter + 1

		myGuy.rotation = myGuy.rotation + (22 * myGuy.xScale)
		myGuy.y = myGuy.y + 5
		myGuy.x = myGuy.x - (3 * myGuy.xScale)
		
		moveBody("leftLeg", 0, 0, -3)
		moveBody("rightLeg", 0, 0, 3)		

		--rightLeg.rotation = rightLeg.rotation - 3
		--leftLeg.rotation = leftLeg.rotation + 3

	elseif(v.dyingCounter == 10) then
		v.dyingCounter = v.dyingCounter + 1

		myGuy.rotation = myGuy.rotation + (26 * myGuy.xScale)
		myGuy.y = myGuy.y + 6
		myGuy.x = myGuy.x - (3 * myGuy.xScale)
		
		moveBody("leftLeg", 0, 0, -3)
		moveBody("rightLeg", 0, 0, 3)		

		--rightLeg.rotation = rightLeg.rotation - 3
		--leftLeg.rotation = leftLeg.rotation + 3

		moveBody("head", 0, 0, 10)----------------

		--head.rotation = head.rotation + 10
		--head.y = head.y - 0
		--head.x = head.x + 0

		endOfLevelDisplayGroup.isVisible = true
		
		if (b.enOrSp == 2) then
			endLetters.T.isVisible = true
			endLetters.u2.isVisible = true
			endLetters.ekezet.isVisible = true
			endLetters.M.isVisible = true
			endLetters.o2.isVisible = true
			endLetters.r.isVisible = true
			endLetters.i2.isVisible = true
			endLetters.s.isVisible = true
			endLetters.t.isVisible = true
			endLetters.e2.isVisible = true
			endLetters.ExM2.isVisible = true

			endLetters.Y.isVisible = false
			endLetters.o.isVisible = false
			endLetters.u.isVisible = false
			endLetters.D.isVisible = false
			endLetters.i.isVisible = false
			endLetters.e.isVisible = false
			endLetters.d.isVisible = false
			endLetters.ExM.isVisible = false
		else
			endLetters.Y.isVisible = true
			endLetters.o.isVisible = true
			endLetters.u.isVisible = true
			endLetters.D.isVisible = true
			endLetters.i.isVisible = true
			endLetters.e.isVisible = true
			endLetters.d.isVisible = true
			endLetters.ExM.isVisible = true

			endLetters.T.isVisible = false
			endLetters.u2.isVisible = false
			endLetters.ekezet.isVisible = false
			endLetters.M.isVisible = false
			endLetters.o2.isVisible = false
			endLetters.r.isVisible = false
			endLetters.i2.isVisible = false
			endLetters.s.isVisible = false
			endLetters.t.isVisible = false
			endLetters.e2.isVisible = false
			endLetters.ExM2.isVisible = false
		end
		

	elseif(v.dyingCounter == 11) then
		v.dyingCounter = v.dyingCounter + 1	
	elseif(v.dyingCounter == 12) then
		v.dyingCounter = v.dyingCounter + 1	
	elseif(v.dyingCounter == 13) then
		v.dyingCounter = v.dyingCounter + 1	
	elseif(v.dyingCounter == 14) then
		v.dyingCounter = v.dyingCounter + 1	
	elseif(v.dyingCounter == 15) then
		v.dyingCounter = v.dyingCounter + 1	
	elseif(v.dyingCounter == 16) then
		v.dyingCounter = v.dyingCounter + 1	
	elseif(v.dyingCounter == 17) then
		v.dyingCounter = v.dyingCounter + 1	
	elseif(v.dyingCounter == 18) then
		v.dyingCounter = v.dyingCounter + 1	
	elseif(v.dyingCounter == 19) then
		v.dyingCounter = v.dyingCounter + 1	
	elseif(v.dyingCounter == 20) then
		v.dyingCounter = v.dyingCounter + 1	
	elseif(v.dyingCounter == 21) then
		v.dyingCounter = v.dyingCounter + 1	
	elseif(v.dyingCounter == 22) then
		v.dyingCounter = v.dyingCounter + 1	
	elseif(v.dyingCounter == 23) then
		v.dyingCounter = v.dyingCounter + 1	
		maskScreenDisplayGroup.isVisible = true
		victoryMaskScreen.isVisible = true
	elseif(v.dyingCounter > 23) then
		doEndOfLevel()
	end
		
end


function otherGuyDying(p)
	
	if(p.dyingCounter == 1) then
		
		p.gunSmoke01.isVisible = false
		p.gunSmoke02.isVisible = false
		p.gunSmoke03.isVisible = false
		
		p.isWalking = 0
		p.dyingCounter = p.dyingCounter + 1
		
		p.leftLeg.rotation = 0
		p.rightLeg.rotation = 0

		p.myGuy.rotation = p.myGuy.rotation - (4 * p.myGuy.xScale)
		p.myGuy.y = p.myGuy.y + 1
		p.myGuy.x = p.myGuy.x + (2 * myGuy.xScale)
		
				
	elseif(p.dyingCounter == 2) then
		p.dyingCounter = p.dyingCounter + 1

		p.myGuy.rotation = p.myGuy.rotation - (4 * p.myGuy.xScale)
		p.myGuy.y = p.myGuy.y + 1
		p.myGuy.x = p.myGuy.x + (2 * myGuy.xScale)
		
		
	elseif(p.dyingCounter == 3) then
		p.dyingCounter = p.dyingCounter + 1

		p.myGuy.rotation = p.myGuy.rotation + (4 * p.myGuy.xScale)
		p.myGuy.y = p.myGuy.y - 1
		p.myGuy.x = p.myGuy.x - (2 * myGuy.xScale)
		
		p.leftArmGroup.rotation = p.leftArmGroup.rotation + 7
		p.rightArmGroup.rotation = p.rightArmGroup.rotation - 8
		p.rightLeg.rotation = p.rightLeg.rotation - 3
		p.leftLeg.rotation = p.leftLeg.rotation + 3

	elseif(p.dyingCounter == 4) then
		p.dyingCounter = p.dyingCounter + 1
		
		p.myGuy.rotation = p.myGuy.rotation + (4 * p.myGuy.xScale)
		p.myGuy.y = p.myGuy.y - 1
		p.myGuy.x = p.myGuy.x - (2 * myGuy.xScale)
		
		p.leftArmGroup.rotation = p.leftArmGroup.rotation + 7
		p.rightArmGroup.rotation = p.rightArmGroup.rotation - 8
		p.rightLeg.rotation = p.rightLeg.rotation - 3
		p.leftLeg.rotation = p.leftLeg.rotation + 3
		
	elseif(p.dyingCounter == 5) then
		p.dyingCounter = p.dyingCounter + 1
		
		p.myGuy.rotation = p.myGuy.rotation + (4 * p.myGuy.xScale)
		p.myGuy.y = p.myGuy.y + 2
		p.myGuy.x = p.myGuy.x - (3 * myGuy.xScale)
		
		p.leftArmGroup.rotation = p.leftArmGroup.rotation + 7
		p.rightArmGroup.rotation = p.rightArmGroup.rotation - 8
		p.rightLeg.rotation = p.rightLeg.rotation - 3
		p.leftLeg.rotation = p.leftLeg.rotation + 3
		
	elseif(p.dyingCounter == 6) then
		p.dyingCounter = p.dyingCounter + 1
		
		p.myGuy.rotation = p.myGuy.rotation + (7 * p.myGuy.xScale)
		p.myGuy.y = p.myGuy.y + 3
		p.myGuy.x = p.myGuy.x - (3 * myGuy.xScale)
		
		p.leftArmGroup.rotation = p.leftArmGroup.rotation + 7
		p.rightArmGroup.rotation = p.rightArmGroup.rotation - 8
		p.rightLeg.rotation = p.rightLeg.rotation - 3
		p.leftLeg.rotation = p.leftLeg.rotation + 3
		
	elseif(p.dyingCounter == 7) then
		p.dyingCounter = p.dyingCounter + 1

		p.myGuy.rotation = p.myGuy.rotation + (12 * p.myGuy.xScale)
		p.myGuy.y = p.myGuy.y + 4
		p.myGuy.x = p.myGuy.x - (3 * myGuy.xScale)
		
		p.leftArmGroup.rotation = p.leftArmGroup.rotation + 7
		p.rightArmGroup.rotation = p.rightArmGroup.rotation - 8
		p.rightLeg.rotation = p.rightLeg.rotation - 3
		p.leftLeg.rotation = p.leftLeg.rotation + 3
		p.shadow.isVisible = false
	elseif(p.dyingCounter == 8) then
		p.dyingCounter = p.dyingCounter + 1

		p.myGuy.rotation = p.myGuy.rotation + (19 * p.myGuy.xScale)
		p.myGuy.y = p.myGuy.y + 5
		p.myGuy.x = p.myGuy.x - (3 * myGuy.xScale)
		
		p.leftArmGroup.rotation = p.leftArmGroup.rotation + 7
		p.rightArmGroup.rotation = p.rightArmGroup.rotation - 8
		p.rightLeg.rotation = p.rightLeg.rotation - 3
		p.leftLeg.rotation = p.leftLeg.rotation + 3
		
	elseif(p.dyingCounter == 9) then
		p.dyingCounter = p.dyingCounter + 1

		p.myGuy.rotation = p.myGuy.rotation + (27 * p.myGuy.xScale)
		p.myGuy.y = p.myGuy.y + 5
		p.myGuy.x = p.myGuy.x - (3 * myGuy.xScale)
		
		p.leftArmGroup.rotation = p.leftArmGroup.rotation + 7
		p.rightArmGroup.rotation = p.rightArmGroup.rotation - 8
		p.rightLeg.rotation = p.rightLeg.rotation - 3
		p.leftLeg.rotation = p.leftLeg.rotation + 3

	elseif(p.dyingCounter == 10) then
		p.dyingCounter = p.dyingCounter + 1
											-- 32
		p.myGuy.rotation = p.myGuy.rotation + (22 * p.myGuy.xScale)
		p.myGuy.y = p.myGuy.y + 6
		p.myGuy.x = p.myGuy.x - (3 * myGuy.xScale)
		
		p.leftArmGroup.rotation = p.leftArmGroup.rotation + 7
		p.rightArmGroup.rotation = p.rightArmGroup.rotation - 8
		p.rightLeg.rotation = p.rightLeg.rotation - 3
		p.leftLeg.rotation = p.leftLeg.rotation + 3

		p.head.rotation = p.head.rotation + 10
		p.head.y = p.head.y - 0
		p.head.x = p.head.x + 0
				
	elseif(p.dyingCounter == 11) then

		if (p == m1) then
			smallCoin1.isVisible = true
			smallCoin1.x = m1.myGuy.x
		elseif(p == m2) then
			smallCoin2.isVisible = true
			smallCoin2.x = m2.myGuy.x
		elseif(p == m3) then
			smallCoin3.isVisible = true
			smallCoin3.x = m3.myGuy.x
		end
	
		p.dyingCounter = p.dyingCounter + 1
	elseif(p.dyingCounter == 12) then
		p.dyingCounter = p.dyingCounter + 1
	elseif(p.dyingCounter == 13) then
		p.dyingCounter = p.dyingCounter + 1
	elseif(p.dyingCounter == 14) then
		p.dyingCounter = p.dyingCounter + 1
	elseif(p.dyingCounter == 15) then
		p.dyingCounter = p.dyingCounter + 1
	elseif(p.dyingCounter == 16) then
		p.dyingCounter = p.dyingCounter + 1
	elseif(p.dyingCounter == 17) then
		p.dyingCounter = p.dyingCounter + 1
	elseif(p.dyingCounter == 18) then
		p.dyingCounter = p.dyingCounter + 1
	elseif(p.dyingCounter == 19) then
		p.dyingCounter = p.dyingCounter + 1
	elseif(p.dyingCounter == 20) then
		p.dyingCounter = p.dyingCounter + 1
	elseif(p.dyingCounter == 21) then
		p.dyingCounter = p.dyingCounter + 1
	elseif(p.dyingCounter == 22) then
		p.dyingCounter = p.dyingCounter + 1
	elseif(p.dyingCounter == 23) then
		p.dyingCounter = p.dyingCounter + 1
	elseif(p.dyingCounter == 24) then
		p.dyingCounter = p.dyingCounter + 1
	elseif(p.dyingCounter == 25) then
		p.dyingCounter = p.dyingCounter + 1
	elseif(p.dyingCounter == 26) then
		p.dyingCounter = p.dyingCounter + 1
	elseif(p.dyingCounter == 27) then
		p.dyingCounter = p.dyingCounter + 1
	elseif(p.dyingCounter == 28) then
		p.dyingCounter = p.dyingCounter + 1
	elseif(p.dyingCounter == 29) then
		p.dyingCounter = p.dyingCounter + 1
	elseif(p.dyingCounter == 30) then
		p.dyingCounter = p.dyingCounter + 1
	elseif(p.dyingCounter == 31) then
		p.dyingCounter = p.dyingCounter + 1
	elseif(p.dyingCounter == 32) then
		p.dyingCounter = 1

		
		-- RE-SPAWN THEM
		if (p == m1) then
			spawnOtherGuys("m1")
		elseif(p == m2) then
			spawnOtherGuys("m2")
		elseif(p == m3) then
			spawnOtherGuys("m3")
		end
	
	end
		
end


function animateOtherGuys()

	if (v.victorySequence == 1) then
	
		if (fFrame == 1) then
	
			--  IN VARIOUS RANGES AND MET MY GUY
			
			m1.inSpearRange = 0
			m1.inSwordRange = 0
			m1.inKickRange = 0
			m2.inSpearRange = 0
			m2.inSwordRange = 0
			m2.inKickRange = 0
			m3.inSpearRange = 0
			m3.inSwordRange = 0
			m3.inKickRange = 0
			
			---------- m1
			
			if (m1.isWalking == 1) then
				if (m1.myGuy.x >= myGuy.x - 94 and m1.playerHealth > 0) then
					m1.metMyGuy = 1
					if(m1.walkCounter ~= 1 or m1.walkCounter ~= 9) then
						otherGuyAntiWalk(m1)
					end
				else
					m1.metMyGuy = 0
				end

				if (m1.myGuy.x >=  -40 - _XB and myGuy.xScale == -1 and ((m1.myGuy.x >= m2.myGuy.x and m1.myGuy.x >= m3.myGuy.x) or (m1.myGuy.x >= m2.myGuy.x and m3.playerHealth <= 0) or (m1.myGuy.x >= m3.myGuy.x and m2.playerHealth <= 0) or (m2.playerHealth <= 0 and m3.playerHealth <= 0) or (m2.playerHealth <= 0 and m3.myGuy.xScale == -1) or (m3.playerHealth <= 0 and m2.myGuy.xScale == -1) or (m1.myGuy.x >= m2.myGuy.x and m3.myGuy.xScale == -1) or (m1.myGuy.x >= m3.myGuy.x and m2.myGuy.xScale == -1) or (m2.myGuy.xScale == -1 and m3.myGuy.xScale == -1))) then
					m1.inShotRange = 1
					if (m1.myGuy.x >= myGuy.x - 164) then
						m1.inSpearRange = 1
						if (m1.myGuy.x >= myGuy.x - 114) then
							m1.inSwordRange = 1
							if (m1.myGuy.x >= myGuy.x - 64) then
								m1.inKickRange = 1
							else
								m1.inKickRange = 0
							end
						else
							m1.inSwordRange = 0
						end
					else
						m1.inSpearRange = 0
					end
				else
					m1.inShotRange = 0
				end
			
			elseif (m1.isWalking == -1) then
				if (m1.myGuy.x <= myGuy.x + 94 and m1.playerHealth > 0) then
					m1.metMyGuy = -1
					if(m1.walkCounter ~= 1 or m1.walkCounter ~= 9) then
						otherGuyAntiWalk(m1)
					end
				else
					m1.metMyGuy = 0
				end		
			
				if (m1.myGuy.x <= 520 + _XB and myGuy.xScale == 1 and ((m1.myGuy.x <= m2.myGuy.x and m1.myGuy.x <= m3.myGuy.x) or (m1.myGuy.x <= m2.myGuy.x and m3.playerHealth <= 0) or (m1.myGuy.x <= m3.myGuy.x and m2.playerHealth <= 0) or (m2.playerHealth <= 0 and m3.playerHealth <= 0) or (m2.playerHealth <= 0 and m3.myGuy.xScale == 1) or (m3.playerHealth <= 0 and m2.myGuy.xScale == 1) or (m1.myGuy.x <= m2.myGuy.x and m3.myGuy.xScale == 1) or (m1.myGuy.x <= m3.myGuy.x and m2.myGuy.xScale == 1) or (m2.myGuy.xScale == 1 and m3.myGuy.xScale == 1))) then
					m1.inShotRange = 1
					if (m1.myGuy.x <= myGuy.x + 164) then
						m1.inSpearRange = 1
						if (m1.myGuy.x <= myGuy.x + 114) then
							m1.inSwordRange = 1
							if (m1.myGuy.x <= myGuy.x + 64) then
								m1.inKickRange = 1
							else
								m1.inKickRange = 0
							end
						else
							m1.inSwordRange = 0
						end
					else
						m1.inSpearRange = 0
					end
				else
					m1.inShotRange = 0
				end
			
			end

			---------- m2
			
			if (m2.isWalking == 1) then
				if (m2.myGuy.x >= myGuy.x - 94 and m2.playerHealth > 0) then
					m2.metMyGuy = 1
					if(m2.walkCounter ~= 1 or m2.walkCounter ~= 9) then
						otherGuyAntiWalk(m2)
					end
				else
					m2.metMyGuy = 0
				end

				if (m2.myGuy.x >=  -40 - _XB and myGuy.xScale == -1 and ((m2.myGuy.x >= m1.myGuy.x and m2.myGuy.x >= m3.myGuy.x) or (m2.myGuy.x >= m1.myGuy.x and m3.playerHealth <= 0) or (m2.myGuy.x >= m3.myGuy.x and m1.playerHealth <= 0) or (m1.playerHealth <= 0 and m3.playerHealth <= 0) or (m1.playerHealth <= 0 and m3.myGuy.xScale == -1) or (m3.playerHealth <= 0 and m1.myGuy.xScale == -1) or (m2.myGuy.x >= m1.myGuy.x and m3.myGuy.xScale == -1) or (m2.myGuy.x >= m3.myGuy.x and m1.myGuy.xScale == -1) or (m1.myGuy.xScale == -1 and m3.myGuy.xScale == -1))) then
					m2.inShotRange = 1
					if (m2.myGuy.x >= myGuy.x - 164) then
						m2.inSpearRange = 1
						if (m2.myGuy.x >= myGuy.x - 114) then
							m2.inSwordRange = 1
							if (m2.myGuy.x >= myGuy.x - 64) then
								m2.inKickRange = 1
							else
								m2.inKickRange = 0
							end
						else
							m2.inSwordRange = 0
						end
					else
						m2.inSpearRange = 0
					end
				else
					m2.inShotRange = 0
				end
			
			elseif (m2.isWalking == -1) then
				if (m2.myGuy.x <= myGuy.x + 94 and m2.playerHealth > 0) then
					m2.metMyGuy = -1
					if(m2.walkCounter ~= 1 or m2.walkCounter ~= 9) then
						otherGuyAntiWalk(m2)
					end
				else
					m2.metMyGuy = 0
				end		
			
				if (m2.myGuy.x <= 520 + _XB and myGuy.xScale == 1 and ((m2.myGuy.x <= m1.myGuy.x and m2.myGuy.x <= m3.myGuy.x) or (m2.myGuy.x <= m1.myGuy.x and m3.playerHealth <= 0) or (m2.myGuy.x <= m3.myGuy.x and m1.playerHealth <= 0) or (m1.playerHealth <= 0 and m3.playerHealth <= 0) or (m1.playerHealth <= 0 and m3.myGuy.xScale == 1) or (m3.playerHealth <= 0 and m1.myGuy.xScale == 1) or (m2.myGuy.x <= m1.myGuy.x and m3.myGuy.xScale == 1) or (m2.myGuy.x <= m3.myGuy.x and m1.myGuy.xScale == 1) or (m1.myGuy.xScale == 1 and m3.myGuy.xScale == 1))) then
					m2.inShotRange = 1
					if (m2.myGuy.x <= myGuy.x + 164) then
						m2.inSpearRange = 1
						if (m2.myGuy.x <= myGuy.x + 114) then
							m2.inSwordRange = 1
							if (m2.myGuy.x <= myGuy.x + 64) then
								m2.inKickRange = 1
							else
								m2.inKickRange = 0
							end
						else
							m2.inSwordRange = 0
						end
					else
						m2.inSpearRange = 0
					end
				else
					m2.inShotRange = 0
				end
			
			end	
		
			---------- m3
			
			if (m3.isWalking == 1) then
				if (m3.myGuy.x >= myGuy.x - 94 and m3.playerHealth > 0) then
					m3.metMyGuy = 1
					if(m3.walkCounter ~= 1 or m3.walkCounter ~= 9) then
						otherGuyAntiWalk(m3)
					end
				else
					m3.metMyGuy = 0
				end

				if (m3.myGuy.x >=  -40 - _XB and myGuy.xScale == -1 and ((m3.myGuy.x >= m1.myGuy.x and m3.myGuy.x >= m2.myGuy.x) or (m3.myGuy.x >= m1.myGuy.x and m2.playerHealth <= 0) or (m3.myGuy.x >= m2.myGuy.x and m1.playerHealth <= 0) or (m1.playerHealth <= 0 and m2.playerHealth <= 0) or (m1.playerHealth <= 0 and m2.myGuy.xScale == -1) or (m2.playerHealth <= 0 and m1.myGuy.xScale == -1) or (m3.myGuy.x >= m1.myGuy.x and m2.myGuy.xScale == -1) or (m3.myGuy.x >= m2.myGuy.x and m1.myGuy.xScale == -1) or (m1.myGuy.xScale == -1 and m2.myGuy.xScale == -1))) then
					m3.inShotRange = 1
					if (m3.myGuy.x >= myGuy.x - 164) then
						m3.inSpearRange = 1
						if (m3.myGuy.x >= myGuy.x - 114) then
							m3.inSwordRange = 1
							if (m3.myGuy.x >= myGuy.x - 64) then
								m3.inKickRange = 1
							else
								m3.inKickRange = 0
							end
						else
							m3.inSwordRange = 0
						end
					else
						m3.inSpearRange = 0
					end
				else
					m3.inShotRange = 0
				end
			
			elseif (m3.isWalking == -1) then
				if (m3.myGuy.x <= myGuy.x + 94 and m3.playerHealth > 0) then
					m3.metMyGuy = -1
					if(m3.walkCounter ~= 1 or m3.walkCounter ~= 9) then
						otherGuyAntiWalk(m3)
					end
				else
					m3.metMyGuy = 0
				end		
			
				if (m3.myGuy.x <= 520 + _XB and myGuy.xScale == 1 and ((m3.myGuy.x <= m1.myGuy.x and m3.myGuy.x <= m2.myGuy.x) or (m3.myGuy.x <= m1.myGuy.x and m2.playerHealth <= 0) or (m3.myGuy.x <= m2.myGuy.x and m1.playerHealth <= 0) or (m1.playerHealth <= 0 and m2.playerHealth <= 0) or (m1.playerHealth <= 0 and m2.myGuy.xScale == 1) or (m2.playerHealth <= 0 and m1.myGuy.xScale == 1) or (m3.myGuy.x <= m1.myGuy.x and m2.myGuy.xScale == 1) or (m3.myGuy.x <= m2.myGuy.x and m1.myGuy.xScale == 1) or (m1.myGuy.xScale == 1 and m2.myGuy.xScale == 1))) then
					m3.inShotRange = 1
					if (m3.myGuy.x <= myGuy.x + 164) then
						m3.inSpearRange = 1
						if (m3.myGuy.x <= myGuy.x + 114) then
							m3.inSwordRange = 1
							if (m3.myGuy.x <= myGuy.x + 64) then
								m3.inKickRange = 1
							else
								m3.inKickRange = 0
							end
						else
							m3.inSwordRange = 0
						end
					else
						m3.inSpearRange = 0
					end
				else
					m3.inShotRange = 0
				end
			
			end	
		
		
		
			-- WALKING/BREATHING
			if (m1.isWalking ~= 0 and m1.metMyGuy == 0) then
				otherGuyWalk(m1)
				if (m1.breatheCounter ~= 3) then
					otherGuyBreathe(m1)
				end
			else
				if (m1.dyingCounter == 1) then
					otherGuyBreathe(m1)
				end
			end
			if (m2.isWalking ~= 0 and m2.metMyGuy == 0) then
				otherGuyWalk(m2)
				if (m2.breatheCounter ~= 3) then
					otherGuyBreathe(m2)
				end
			else
				if (m2.dyingCounter == 1) then
					otherGuyBreathe(m2)
				end
			end
			if (m3.isWalking ~= 0 and m3.metMyGuy == 0) then
				otherGuyWalk(m3)
				if (m3.breatheCounter ~= 3) then
					otherGuyBreathe(m3)
				end
			else
				if (m3.dyingCounter == 1) then
					otherGuyBreathe(m3)
				end
			end
			
		end


		if (f63 == 1) then
		
				-- OTHERGUY MOVING SIDE ON HIS OWN
			
			if (m1.metMyGuy == 0 and m1.playerHurt == 0) then
				m1.myGuy.x = m1.myGuy.x + (m1.speed * m1.isWalking * f63)
			end
			if (m2.metMyGuy == 0 and m2.playerHurt == 0) then
				m2.myGuy.x = m2.myGuy.x + (m2.speed * m2.isWalking * f63)
			end
			if (m3.metMyGuy == 0 and m3.playerHurt == 0) then
				m3.myGuy.x = m3.myGuy.x + (m3.speed * m3.isWalking * f63)
			end
			
			-- WORLD MOVING SIDE
			
			if (v.moveIntoTent == 1) then
				if (leftButtonDown == 1 and myGuy.x == 200 and m1.metMyGuy ~= 1 and m2.metMyGuy ~= 1 and m3.metMyGuy ~= 1) then
					m1.myGuy.x = m1.myGuy.x + 2.25 * f63
					m2.myGuy.x = m2.myGuy.x + 2.25 * f63
					m3.myGuy.x = m3.myGuy.x + 2.25 * f63
				elseif (rightButtonDown == 1 and myGuy.x == 200 and m1.metMyGuy ~= -1 and m2.metMyGuy ~= -1 and m3.metMyGuy ~= -1) then
					m1.myGuy.x = m1.myGuy.x - 2.25 * f63
					m2.myGuy.x = m2.myGuy.x - 2.25 * f63
					m3.myGuy.x = m3.myGuy.x - 2.25 * f63
				end			
			end
		
		elseif(fFrame == 1) then

			-- OTHERGUY MOVING SIDE ON HIS OWN
			
			if (m1.metMyGuy == 0 and m1.playerHurt == 0) then
				m1.myGuy.x = m1.myGuy.x + (m1.speed * m1.isWalking * f63)
			end
			if (m2.metMyGuy == 0 and m2.playerHurt == 0) then
				m2.myGuy.x = m2.myGuy.x + (m2.speed * m2.isWalking * f63)
			end
			if (m3.metMyGuy == 0 and m3.playerHurt == 0) then
				m3.myGuy.x = m3.myGuy.x + (m3.speed * m3.isWalking * f63)
			end
			
			-- WORLD MOVING SIDE
			
			if (v.moveIntoTent == 1) then
				if (leftButtonDown == 1 and myGuy.x == 200 and m1.metMyGuy ~= 1 and m2.metMyGuy ~= 1 and m3.metMyGuy ~= 1) then
					m1.myGuy.x = m1.myGuy.x + 2.25 * f63
					m2.myGuy.x = m2.myGuy.x + 2.25 * f63
					m3.myGuy.x = m3.myGuy.x + 2.25 * f63
				elseif (rightButtonDown == 1 and myGuy.x == 200 and m1.metMyGuy ~= -1 and m2.metMyGuy ~= -1 and m3.metMyGuy ~= -1) then
					m1.myGuy.x = m1.myGuy.x - 2.25 * f63
					m2.myGuy.x = m2.myGuy.x - 2.25 * f63
					m3.myGuy.x = m3.myGuy.x - 2.25 * f63
				end			
			end
		
		end
				

		if (fFrame == 1) then
		
			-- ATTACKING
			--v.moveIntoTent == 1
			if (m1.myGuy.x >=  0 - _XB and m1.myGuy.x <= 480 + _XB  and v.moveIntoTent < 10) then
				if (m1.activeWeapon == "pistol" or m1.activeWeapon == "rifle") then
					if (m1.isAttackOne == 1 and v.playerHealth > 0) then
						m1.isAttackOne = 33
					end
				elseif (m1.myGuy.x >= myGuy.x - 164 and m1.myGuy.x <= myGuy.x + 164) then
					if (m1.activeWeapon == "alabard") then
						if (m1.isAttackOne == 1 and v.playerHealth > 0) then
							m1.isAttackOne = 33
						end
					elseif(m1.myGuy.x >= myGuy.x - 114 and m1.myGuy.x <= myGuy.x + 114) then
						if (m1.activeWeapon == "sword" or m1.activeWeapon == "battleAxe") then
							if (m1.isAttackOne == 1 and v.playerHealth > 0) then
								m1.isAttackOne = 33
							end
						end
					end
					
				end
			end

			if (m2.myGuy.x >=  0 - _XB and m2.myGuy.x <= 480 + _XB  and v.moveIntoTent < 10) then
				if (m2.activeWeapon == "pistol" or m2.activeWeapon == "rifle") then
					if (m2.isAttackOne == 1 and v.playerHealth > 0) then
						m2.isAttackOne = 33
					end
				elseif (m2.myGuy.x >= myGuy.x - 164 and m2.myGuy.x <= myGuy.x + 164) then
					if (m2.activeWeapon == "alabard") then
						if (m2.isAttackOne == 1 and v.playerHealth > 0) then
							m2.isAttackOne = 33
						end
					elseif(m2.myGuy.x >= myGuy.x - 114 and m2.myGuy.x <= myGuy.x + 114) then
						if (m2.activeWeapon == "sword" or m2.activeWeapon == "battleAxe") then
							if (m2.isAttackOne == 1 and v.playerHealth > 0) then
								m2.isAttackOne = 33
							end
						end
					end
					
				end
			end

			if (m3.myGuy.x >=  0 - _XB and m3.myGuy.x <= 480 + _XB  and v.moveIntoTent < 10) then
				if (m3.activeWeapon == "pistol" or m3.activeWeapon == "rifle") then
					if (m3.isAttackOne == 1 and v.playerHealth > 0) then
						m3.isAttackOne = 33
					end
				elseif (m3.myGuy.x >= myGuy.x - 164 and m3.myGuy.x <= myGuy.x + 164) then
					if (m3.activeWeapon == "alabard") then
						if (m3.isAttackOne == 1 and v.playerHealth > 0) then
							m3.isAttackOne = 33
						end
					elseif(m3.myGuy.x >= myGuy.x - 114 and m3.myGuy.x <= myGuy.x + 114) then
						if (m3.activeWeapon == "sword" or m3.activeWeapon == "battleAxe") then
							if (m3.isAttackOne == 1 and v.playerHealth > 0) then
								m3.isAttackOne = 33
							end
						end
					end
					
				end
			end


			
			if (m1.isAttackOne > 1 and m1.playerHealth > 0) then
				otherGuysDoAttack(m1)
			else
				m1.gunSmoke01.isVisible = false
				m1.gunSmoke02.isVisible = false
				m1.gunSmoke03.isVisible = false
			end
			if (m2.isAttackOne > 1 and m2.playerHealth > 0) then
				otherGuysDoAttack(m2)
			else
				m2.gunSmoke01.isVisible = false
				m2.gunSmoke02.isVisible = false
				m2.gunSmoke03.isVisible = false		end
			if (m3.isAttackOne > 1 and m3.playerHealth > 0) then
				otherGuysDoAttack(m3)
			else
				m3.gunSmoke01.isVisible = false
				m3.gunSmoke02.isVisible = false
				m3.gunSmoke03.isVisible = false		
			end

			-- DYING
			if (m1.playerHealth <= 0) then
				otherGuyDying(m1)
			end
			if (m2.playerHealth <= 0) then
				otherGuyDying(m2)
			end
			if (m3.playerHealth <= 0) then
				otherGuyDying(m3)
			end

			-- LEAVING BEHIND TOO MUCH IN LEFT SIDE
		
			if(m1.myGuy.x <= 0 - _XB - 180) then
				spawnOtherGuys("m1")
			end
			if(m2.myGuy.x <= 0 - _XB - 180) then
				spawnOtherGuys("m2")
			end
			if(m3.myGuy.x <= 0 - _XB - 180) then
				spawnOtherGuys("m3")
			end
			
			-- SIDEING
			
			if (m1.sideing > 0 or m2.sideing > 0 or m3.sideing > 0) then
				otherGuysSideing()
			end
						
		end
	
	else
		m1.myGuy.isVisible = false
		m2.myGuy.isVisible = false
		m3.myGuy.isVisible = false
		m1.gunSmoke01.isVisible = false
		m1.gunSmoke02.isVisible = false
		m1.gunSmoke03.isVisible = false
		m2.gunSmoke01.isVisible = false
		m2.gunSmoke02.isVisible = false
		m2.gunSmoke03.isVisible = false
		m3.gunSmoke01.isVisible = false
		m3.gunSmoke02.isVisible = false
		m3.gunSmoke03.isVisible = false
		m1.metMyGuy = 0
		m2.metMyGuy = 0
		m3.metMyGuy = 0
		m1.myGuy.x = 1000
		m2.myGuy.x = 1000
		m3.myGuy.x = 1000
	end
	
end


function animate()

	local cash = 0

--FPS

	if (t.tCounter == 1) then
		t.t1 = system.getTimer()
	end
	
	if (t.tCounter == 60) then
		t.t2 = system.getTimer()
		t.tCounter = 0
		--FPSText.text = math.floor(60 / ((t.t2 - t.t1) / 1000))		
		--FPSText.text = f63
		--FPSText.text = math.floor(tTemp)
		if (v.everPlayed < 2) then
			t.tTotal = t.tTotal + math.floor(60 / ((t.t2 - t.t1) / 1000))
			t.tTotalCounter = t.tTotalCounter + 1
		end
		--print(t.tTotal)
		--print(t.tTotalCounter)
	end
	
	t.tCounter = t.tCounter + 1
		
-- END FPS --]]
	
	
	animateOtherGuys()
	
	if (fFrame == 1) then
		flameBurn()
		if (h.cVegas == 1) then
			vegas()
		end
		
		if (v.flareNum > 0) then
			wallFlare()
		end		
		
	end
	
	if (v.moveIntoTent > 1) then
		moveGuyIntoTent()
		
		if (isAttackOne > 1 or isAttackTwo > 1 or isAttackThree > 1 or isAttackFour > 1) then
			if (fFrame == 1) then
				doAttack()
			end
		end
		
		if (v.moveIntoTent < 23) then
		
			if (isWeaponsChange == 1) then
				if (fFrame == 1) then
					if (isAttackOne == 1 and isAttackTwo == 1) then
						weaponsChange("change")
					end
				end
			elseif (isWeaponsChange == 2) then
				if (fFrame == 1) then
					if (isAttackOne == 1 and isAttackTwo == 1) then
						levelStartWeaponsChange()
						weaponsChange(nil)
					end
				end
			end		
		
		end
		
		
	else
	
		if ((rightButtonDown == 1 or leftButtonDown == 1) and v.playerHealth > 0) then
			if (f63 == 1) then
				moveSide()
			elseif(fFrame == 1) then
				moveSide()
			end
				
			if (fFrame == 1 and v.playerHealth > 0) then
				walk()
			end
			if(leanForwardCounter < 8) then
				if (fFrame == 1) then
					leanForward()
				end
			end
			if (breatheCounter ~= 3) then
				if (fFrame == 1 and v.playerHealth > 0) then
					breathe()
				end
			end

		else
			if(walkCounter ~= 1 or walkCounter ~= 9) then
				if (fFrame == 1) then
					antiWalk()
				end
			end

			if(leanForwardCounter > 0) then
				if (fFrame == 1) then
					antiLeanForward()
				end
			end
			
			if (fFrame == 1 and v.playerHealth > 0) then
				breathe()
			end
			
		end

		if (isAttackOne > 1 or isAttackTwo > 1 or isAttackThree > 1 or isAttackFour > 1) then
			if (fFrame == 1) then
				doAttack()
			end
		end

		if (isWeaponsChange == 1) then
			if (fFrame == 1) then
				if (isAttackOne == 1 and isAttackTwo == 1) then
					weaponsChange("change")
				end
			end
		elseif (isWeaponsChange == 2) then
			if (fFrame == 1) then
				if (isAttackOne == 1 and isAttackTwo == 1) then
					levelStartWeaponsChange()
					weaponsChange(nil)
				end
			end
		end
	
	end
	
	
	if (fFrame == 1) then
	
		if (v.healthChanged ~= 0) then
			updateHealthBar()
		end
		
		if (attackButtonMask.num > 0) then
			attackButtonMask.isVisible = true
			attackButtonMask.num = attackButtonMask.num - 1
			attackButton.xScale = 1.05
			attackButton.yScale = 1.05
			attackButtonMask.xScale = 1.05
			attackButtonMask.yScale = 1.05

		else
			attackButtonMask.isVisible = false
			attackButton.xScale = 1
			attackButton.yScale = 1
			attackButtonMask.xScale = 1
			attackButtonMask.yScale = 1
		end

		if (swingButtonMask.num > 0) then
			swingButtonMask.isVisible = true
			swingButtonMask.num = swingButtonMask.num - 1
			swingButton.xScale = 1.05
			swingButton.yScale = 1.05
			swingButtonMask.xScale = 1.05
			swingButtonMask.yScale = 1.05

		else
			swingButtonMask.isVisible = false
			swingButton.xScale = 1
			swingButton.yScale = 1
			swingButtonMask.xScale = 1
			swingButtonMask.yScale = 1
		end

		if (granadeButtonMask.num > 0) then
			granadeButtonMask.isVisible = true
			granadeButtonMask.num = granadeButtonMask.num - 1
			granadeButton.xScale = 1.05
			granadeButton.yScale = 1.05
			granadeButtonMask.xScale = 1.05
			granadeButtonMask.yScale = 1.05

		else
			granadeButtonMask.isVisible = false
			granadeButton.xScale = 1
			granadeButton.yScale = 1
			granadeButtonMask.xScale = 1
			granadeButtonMask.yScale = 1
		end
		
		
		if (i.weaponsButtonBackground.num > 0) then
			i.weaponsButtonMask.isVisible = true
			i.weaponsButtonBackground.num = i.weaponsButtonBackground.num - 1
		else
			i.weaponsButtonMask.isVisible = false
		end
		
		if (leftButtonDown == 1) then
			leftButtonMask.isVisible = true
			leftButton.xScale = 1.1
			leftButton.yScale = 1.1
			leftButtonMask.xScale = 1.1
			leftButtonMask.yScale = 1.1
		else
			leftButtonMask.isVisible = false
			leftButton.xScale = 1
			leftButton.yScale = 1
			leftButtonMask.xScale = 1
			leftButtonMask.yScale = 1
		end

		if (rightButtonDown == 1) then
			rightButtonMask.isVisible = true
			rightButton.xScale = 1.1
			rightButton.yScale = 1.1
			rightButtonMask.xScale = 1.1
			rightButtonMask.yScale = 1.1
		else
			rightButtonMask.isVisible = false
			rightButton.xScale = 1
			rightButton.yScale = 1
			rightButtonMask.xScale = 1
			rightButtonMask.yScale = 1
		end
		
		
		if (c.cashCoin.num > 0) then
			c.cashCoinMask.isVisible = true
			c.cashCoin.num = c.cashCoin.num - 1
			c.cashCoin.xScale = 1.1
			c.cashCoin.yScale = 1.1
			c.cashCoinMask.xScale = 1.1
			c.cashCoinMask.yScale = 1.1
		else
			c.cashCoinMask.isVisible = false
			c.cashCoin.xScale = 1
			c.cashCoin.yScale = 1	
			c.cashCoinMask.xScale = 1
			c.cashCoinMask.yScale = 1	
		end

		
		-- START OF LEVEL
		
		if (v.startOfLevel > 0) then
			doStartOfLevel()	
		end

		
		-- MEET COINS
		
		if (myGuy.x > smallCoin1.x - 20 and myGuy.x < smallCoin1.x + 20) then
			smallCoin1.x = -100000
			smallCoin1.isVisible = false
			cash = math.random(5, 10) + math.floor(v.levelPlaying / 3)
			v.playerCash = v.playerCash + cash
			v.levelCash = v.levelCash + cash
			v.sumCash = v.sumCash + cash
			if (v.sumCash > 9999999) then
				v.sumCash = 9999999
			end
			if (v.playerCash > 99999) then
				v.playerCash = 99999
			end
			writeScreenCash(v.playerCash)
		end
		
		if (myGuy.x > smallCoin2.x - 20 and myGuy.x < smallCoin2.x + 20) then
			smallCoin2.x = -100000
			smallCoin2.isVisible = false
			
			cash = math.random(5, 10) + math.floor(v.levelPlaying / 3)
			v.playerCash = v.playerCash + cash
			v.levelCash = v.levelCash + cash
			v.sumCash = v.sumCash + cash
			if (v.sumCash > 9999999) then
				v.sumCash = 9999999
			end
			if (v.playerCash > 99999) then
				v.playerCash = 99999
			end
			writeScreenCash(v.playerCash)
			
		end

		if (myGuy.x > smallCoin3.x - 20 and myGuy.x < smallCoin3.x + 20) then
			smallCoin3.x = -100000
			smallCoin3.isVisible = false

			cash = math.random(5, 10) + math.floor(v.levelPlaying / 3)
			v.playerCash = v.playerCash + cash
			v.levelCash = v.levelCash + cash
			v.sumCash = v.sumCash + cash
			if (v.sumCash > 9999999) then
				v.sumCash = 9999999
			end
			if (v.playerCash > 99999) then
				v.playerCash = 99999
			end
			writeScreenCash(v.playerCash)

		end
		
		-- END OF THE LEVEL
			
		if(treesTentsEtc[27][2] < 300) then
			if (v.endOfLevel == 0) then
				
				if (v.levelCash < 400 + v.levelPlaying * 50) then
					if (v.levelPlaying == 1) then
						cash = 300 + v.levelPlaying * 50 - v.levelCash + math.random(1, 50)
					else
						cash = 400 + v.levelPlaying * 50 - v.levelCash + math.random(1, 50)
					end
					
				else
					cash = math.random(1, 50)
				end
				
				--print(v.levelCash)
				--print(cash)
				v.playerCash = v.playerCash + cash
				v.sumCash = v.sumCash + cash
				if (v.sumCash > 9999999) then
					v.sumCash = 9999999
				end
				if (v.playerCash > 99999) then
					v.playerCash = 99999
				end
				writeScreenCash(v.playerCash)
				cashChestCoinDisplayGroup.isVisible = true
				smallCoin1.x = -1000
				smallCoin1.isVisible = false
				smallCoin2.x = -1000
				smallCoin2.isVisible = false
				smallCoin3.x = -1000
				smallCoin3.isVisible = false
			end
			v.endOfLevel = 1
			m1.gunSmoke01.isVisible = false
			m1.gunSmoke02.isVisible = false
			m1.gunSmoke03.isVisible = false
			m2.gunSmoke01.isVisible = false
			m2.gunSmoke02.isVisible = false
			m2.gunSmoke03.isVisible = false
			m3.gunSmoke01.isVisible = false
			m3.gunSmoke02.isVisible = false
			m3.gunSmoke03.isVisible = false
		end

		if (v.endOfLevel == 1) then
			cashChestCoinDisplayGroup.x = treesTentsEtc[27][2] - 300
			doVictorySequence()
		end

		-- BEING HURT
		
		
		if (v.myGuyHurtCounter == 3) then
			if (splash01.isVisible == false) then
				splash01.isVisible = true
				if (v.playerHurt > 0) then
					v.playerHurtDirection = 1 * myGuy.xScale
				else
					v.playerHurtDirection = -1 * myGuy.xScale
				end
				torsoGroup.rotation = torsoGroup.rotation + 4 * v.playerHurtDirection
				v.myGuyTorsoMoved = 1
			end
		end
		
		if (v.myGuyHurtCounter == 0) then
			if (splash01.isVisible == true) then
				splash01.isVisible = false
			end
			if (v.myGuyTorsoMoved == 1) then
				v.myGuyTorsoMoved = 0
				torsoGroup.rotation = torsoGroup.rotation - 4 * v.playerHurtDirection
			end
		end

		if (v.myGuyHurtCounter > 0) then
			v.myGuyHurtCounter = v.myGuyHurtCounter - 1
		end

		-- MY GUY DYING
		
		if (v.playerHealth <= 0) then
			myGuyDying()
		end

	end
end 


function gameStartZeroOut()

			if (crossbowAmmo == 0 and knifeAmmo == 0 and tomahawkAmmo == 0 and 	pistolAmmo == 0 and rifleAmmo == 0) then
				crossbowAmmo = 150	
				levelStartWeaponsChange()
			end
			
			gameScreenDisplayGroup.isVisible = true
			selectLevelDisplayGroup.isVisible = false
			
			maskScreenDisplayGroup.isVisible = true
			menuMaskScreen.isVisible = false
			b.returnToMenuEn.isVisible = false
			b.returnToMenuSp.isVisible = false
			b.yesButtonEn.isVisible = false
			b.yesButtonSp.isVisible = false
			b.noButton.isVisible = false
			menuMaskScreen.alpha = 0
			victoryMaskScreen.isVisible = true
			victoryMaskScreen.alpha = 1
			v.startOfLevel = 1
			
			myGuy.isVisible = true
					
			s.levelOneButton:removeEventListener("touch", levelOneButtonListener)
			s.levelTwoButton:removeEventListener("touch", levelTwoButtonListener)
			s.levelThreeButton:removeEventListener("touch", levelThreeButtonListener)
			s.levelFourButton:removeEventListener("touch", levelFourButtonListener)
			s.levelFiveButton:removeEventListener("touch", levelFiveButtonListener)
			s.levelSixButton:removeEventListener("touch", levelSixButtonListener)
			
			--zeroOutMyGuyBodyPosture()
			spawnOtherGuys("m1")
			spawnOtherGuys("m2")
			spawnOtherGuys("m3")
			zeroOutWeapons()
			zeroOutControls()
			zeroOutMap()
			
			makeUpMap(v.levelPlaying)
			putOutTreesTentsEtc()

			if (v.playerHealth <= 0) then
				if (g.myGuyShieldGold.isPurchased == 1) then
					v.playerHealth = 127
				else
					v.playerHealth = 100
				end
			end
			updateHealthBar(false)
			v.healthChanged = 0
			
			writeScreenCash(v.playerCash, 0)
			c.cashCoin.num = 0
			c.cashCoinMask.isVisible = false
			c.cashCoin.xScale = 1
			c.cashCoin.yScale = 1	
			c.cashCoinMask.xScale = 1
			c.cashCoinMask.yScale = 1	


			makeUpStartUpMessage()
			zeroOutVictoryLetters()
						
			myGuy.x = 200
			myGuy.y = 200
			myGuy.xScale = 1
			
			breatheCounter = 1
			walkCounter = 1
			leanForwardCounter = 0
			v.rightArmUp = 0
			isAttackOne = 1
			isAttackTwo = 1
			isAttackThree = 1
			isAttackFour = 1
			isWeaponsChange = 0
			worldCounter = 45
			flameCounter = 1
			v.moveIntoTent = 1
			v.wantOut = 0
			v.tentMoveIntoX = 0
			v.endOfLevel = 0
			v.endOfWeaponsSelection = 0
			v.victorySequence = 1
			v.victoryLetterCounter = 0
			v.cashFound = 0
			v.weaponMeetCounterOne = 0
			v.weaponMeetCounterTwo = 0
			v.myGuyHurtCounter = 0
			v.myGuyTorsoMoved = 0
			v.dyingCounter = 1
			v.playerHurt = 0
			v.playerHurtDirection = 0
			v.pyramidCounter = 1
			v.flareNum = 0
			v.levelCash = 0
			losePyramid()
						
			v.isPaused = false
			
			attackButtonMask.isVisible = false
			attackButtonDarkMask.isVisible = false
			granadeButtonDarkMask.isVisible = false
			attackButtonMask.num = 0
			attackButton.xScale = 1
			attackButton.yScale = 1
			attackButtonMask.xScale = 1
			attackButtonMask.yScale = 1

			swingButtonMask.isVisible = false
			swingButtonMask.num = 0
			swingButton.xScale = 1
			swingButton.yScale = 1
			swingButtonMask.xScale = 1
			swingButtonMask.yScale = 1

			granadeButtonMask.isVisible = false
			granadeButtonMask.num = 0
			granadeButton.xScale = 1
			granadeButton.yScale = 1
			granadeButtonMask.xScale = 1
			granadeButtonMask.yScale = 1
			
			g.arrowDouble.isVisible = false
			g.tomahawkLeftDouble.isVisible = false
			g.knifeLeftDouble.isVisible = false
			g.tomahawkRightDouble.isVisible = false
			g.knifeRightDouble.isVisible = false
			g.granadeDouble.isVisible = false
			
			
			gunSmoke01.isVisible = false
			gunSmoke02.isVisible = false
			gunSmoke03.isVisible = false
			splash01.isVisible = false
			
			smallCoin1.x = -1000
			smallCoin1.isVisible = false
			smallCoin2.x = -1000
			smallCoin2.isVisible = false
			smallCoin3.x = -1000
			smallCoin3.isVisible = false
			
			exp01.isVisible = false
			w.wShip.isVisible = false
			
			leftNext = true
			v.changeWeaponTo = nil
			v.changeWeaponFrom = nil
			
			weaponsChange(nil)
			updateWeaponsWall()

			i.weaponsButtonMask.isVisible = false
			i.weaponsButtonBackground.num = 0
			
			pauseButton:addEventListener("touch", pauseButtonListener)
			
			cashTentCoinDisplayGroup.x = -115
			cashTentCoinDisplayGroup.y = 100
			cashTentCoinDisplayGroup.isVisible = false
			c.cashTentCoin.xScale = 1
			c.cashTentCoin.yScale = 1
			c.cashTentGranade.xScale = 1
			c.cashTentGranade.yScale = 1
			
			cashChestCoinDisplayGroup.isVisible = false
			cashChestCoinDisplayGroup.x = 0
			cashChestCoinDisplayGroup.y = 100
			
			local textMem = system.getInfo( "textureMemoryUsed" ) / 1000000
			print( "TexMem:   " .. textMem )
			
			leftButtonMask.isVisible = false
			rightButtonMask.isVisible = false

			leftButton.xScale = 1
			leftButton.yScale = 1
			leftButtonMask.xScale = 1
			leftButtonMask.yScale = 1

			rightButton.xScale = 1
			rightButton.yScale = 1
			rightButtonMask.xScale = 1
			rightButtonMask.yScale = 1
			
			endOfLevelDisplayGroup.isVisible = false
			
			--saveing.isVisible = false

			if (a.pistolShot1 ~= nil) then
				
				audio.dispose(a.pistolShot1)
				audio.dispose(a.pistolShot2)
				audio.dispose(a.pistolShot3)
				audio.dispose(a.pistolShot4)
				
				audio.dispose(a.rifleShot1)
				audio.dispose(a.rifleShot2)
				audio.dispose(a.rifleShot3)
				audio.dispose(a.rifleShot4)

				a.pistolShot1 = nil
				a.pistolShot2 = nil
				a.pistolShot3 = nil
				a.pistolShot4 = nil

				a.rifleShot1 = nil
				a.rifleShot2 = nil
				a.rifleShot3 = nil
				a.rifleShot4 = nil
				
				
				--audio.dispose(a.thud1)
				--audio.dispose(a.thud2)
				--audio.dispose(a.thud3)
				
				--a.thud1 = nil
				--a.thud2 = nil
				--a.thud3 = nil
				
			end
			
			timer.performWithDelay(1, function() collectgarbage("collect") end)
			
			a.pistolShot1 = audio.loadSound("Pistol Mix 1.wav")
			a.pistolShot2 = audio.loadSound("Pistol Mix 2.wav")
			a.pistolShot3 = audio.loadSound("Pistol Mix 3.wav")
			a.pistolShot4 = audio.loadSound("Pistol Mix 4.wav")

			a.rifleShot1 = audio.loadSound("Rifle Mix 1.wav")
			a.rifleShot2 = audio.loadSound("Rifle Mix 2.wav")
			a.rifleShot3 = audio.loadSound("Rifle Mix 3.wav")
			a.rifleShot4 = audio.loadSound("Rifle Mix 4.wav")
			
			--a.thud1 = audio.loadSound("Thud 1.wav")
			--a.thud2 = audio.loadSound("Thud 1.wav")
			--a.thud3 = audio.loadSound("Thud 1.wav")

end


function gameLoop()

	if (activeScreen == "game") then
		if (gameScreenDisplayGroup.isVisible ~= true) then
			gameStartZeroOut()								
		end
		if (not v.isPaused) then
			--t.t1 = system.getTimer()
			animate()
			--t.t2 = system.getTimer()
			--FPSText.text = math.round(t.t2 - t.t1)
		end
	elseif (activeScreen == "menu") then
		if(menuDisplayGroup.isVisible ~= true) then
			audio.setVolume( 1, { channel = 3 } )
			if (v.musicOn == 1) then
				audio.play(a.menuMusic, { channel = 3, loops = -1})	
			end								
			if (v.soundOn == 1) then
				--audio.play(a.swingMix1, 9)
			end
			menuDisplayGroup.isVisible = true
			maskScreenDisplayGroup.isVisible = false
			gameScreenDisplayGroup.isVisible = false
			optionsDisplayGroup.isVisible = false
			selectLevelDisplayGroup.isVisible = false
			if (b.enOrSp == 2) then
				b.aztecGoldLogoSp.isVisible = true
				b.aztecGoldLogoEn.isVisible = false
				b.playSp.isVisible = true
				b.optionsSp.isVisible = true
				b.playEn.isVisible = false
				b.optionsEn.isVisible = false
				b.playSp:addEventListener("touch", playGameListener)
				b.optionsSp:addEventListener("touch", optionsListener)
				b.facebookEn.isVisible = true
				b.facebookEn:addEventListener("touch", socialNetworkBtnTouch)
			else
				b.aztecGoldLogoEn.isVisible = true
				b.aztecGoldLogoSp.isVisible = false
				b.playEn.isVisible = true
				b.optionsEn.isVisible = true
				b.playSp.isVisible = false
				b.optionsSp.isVisible = false
				b.playEn:addEventListener("touch", playGameListener)
				b.optionsEn:addEventListener("touch", optionsListener)
				b.facebookEn.isVisible = true
				b.facebookEn:addEventListener("touch", socialNetworkBtnTouch)
			end
			b.yesButtonEn:removeEventListener("touch", yesButtonListener)
			b.yesButtonSp:removeEventListener("touch", yesButtonListener)
			b.noButton:removeEventListener("touch", noButtonListener)
			pauseButton:removeEventListener("touch", pauseButtonListener)
			b.optionsReturnButtonEn:removeEventListener("touch", optionsReturnButtonListener)
			b.optionsReturnButtonSp:removeEventListener("touch", optionsReturnButtonListener)
			b.englishEn:removeEventListener("touch", englishEnEventListener)
			b.spanishSp:removeEventListener("touch", spanishSpEventListener)
			b.exitEn:removeEventListener("touch", exitEnEventListener)
			b.exitSp:removeEventListener("touch", exitSpEventListener)
			b.speaker:removeEventListener("touch", toggleSpeaker)
			b.music:removeEventListener("touch", toggleMusic)
			b.shine1.xScale = 1
			b.shine1.yScale = 1
			b.shine1.x = 1000
			
			if (v.sumCash < 1000) then
				sumDisplayGroup.x = 220
			elseif (v.sumCash < 10000) then
				sumDisplayGroup.x = 215
			elseif (v.sumCash < 100000) then
				sumDisplayGroup.x = 210
			elseif (v.sumCash < 1000000) then
				sumDisplayGroup.x = 205
			else
				sumDisplayGroup.x = 200
			end
			
			writeSumCash(v.sumCash)
		end
		shine()
		if (fFrame == 1) then
			coinTurn()
			if (b.menuInCounter < 6) then
				menuIn()
			end
		end		
	elseif (activeScreen == "select colors") then
	
		if (v.everPlayed < 2) then
			if (v.everPlayed == 0) then
				if (openingScene == nil) then
					openingScene = display.newImage("Opening Scene.png", true)
					openingScene.x = -45
					openingScene.y = _H / 2
				end
				gameStartZeroOut()
				v.everPlayed = 1
				b.playEn:removeEventListener("touch", playGameListener)
				b.playSp:removeEventListener("touch", playGameListener)
				b.optionsEn:removeEventListener("touch", optionsListener)
				b.optionsSp:removeEventListener("touch", optionsListener)
				b.facebookEn:removeEventListener("touch", socialNetworkBtnTouch)
				if (v.musicOn == 1) then
					audio.fadeOut({ channel = 3, time = 150 } )
					audio.play(a.introMusic, { channel = 2, loops = -1, fadein = 300})
				end
				
			end
			
			if (t.tTotalCounter > 1 and t.tTotalCounter < 11) then
				openingScene.x = openingScene.x + 1
			end
			
			animate()
			moveSide(1)
			walk()
			m1.myGuy.x = 1000
			m2.myGuy.x = 1000
			m3.myGuy.x = 1000
			
			
			if(t.tTotalCounter == 12) then
				audio.fadeOut({ channel = 2, time = 330 } )
				audio.setVolume( 1, { channel = 3 } )
			end
			
			if (t.tTotalCounter == 14) then
				if ((t.tTotal / t.tTotalCounter) < 25) then
					Runtime:removeEventListener("enterFrame", fFunction)
					local function onExitComplete()
						os.exit()
					end
					native.showAlert("Message", "Insufficient Frame Rate", {"OK"}, onExitComplete)
				end
				if ((t.tTotal / t.tTotalCounter) > 50) then
					f63 = 1
				else
					f63 = 2
				end
				--tTemp = t.tTotal / t.tTotalCounter
				v.everPlayed = 2
				openingScene.isVisible = false
				openingScene:removeSelf()
				openingScene = nil
				gameScreenDisplayGroup.isVisible = false
				selectLevelDisplayGroup.isVisible = false
				menuDisplayGroup.isVisible = false				
				if ((t.tTotal / t.tTotalCounter) < 25) then
					--don't save
				else
					saveFileHandling("save")
				end
				audio.stop(2) --introMusic
				if ((t.tTotal / t.tTotalCounter) < 25) then
					--don't play music
				else
					if (v.musicOn == 1) then
						audio.play(a.menuMusic, { channel = 3, loops = -1, fadein = 500})	
					end								
				end
			end

	
		elseif (selectColorsDisplayGroup.isVisible == false) then
			selectColorsDisplayGroup.isVisible = true
			menuDisplayGroup.isVisible = false
			if (b.enOrSp == 2) then
				b.selectColorsSp.isVisible = true
				b.selectColorsEn.isVisible = false
			else
				b.selectColorsEn.isVisible = true
				b.selectColorsSp.isVisible = false
			end			
		
			b.playEn:removeEventListener("touch", playGameListener)
			b.playSp:removeEventListener("touch", playGameListener)
			b.optionsEn:removeEventListener("touch", optionsListener)
			b.optionsSp:removeEventListener("touch", optionsListener)
			b.facebookEn:removeEventListener("touch", socialNetworkBtnTouch)
			b.selectColorsExit:addEventListener("touch", exitColorsListener)
			b.breatheCounter = 1

			b.colorToBeSelected = 1
			updateColorsScreen()
			addColorSquareListeners(1)
			b.bigSquare = 1
			largeSquare(1)
			zeroOutColorGuy()
		end
		if (fFrame == 1) then
			colorGuybreathe()
			if (h.cVegas == 1) then
				vegas2()
			end
		end
		largeSquare(1)
	elseif (activeScreen == "select level") then

			
		if(selectLevelDisplayGroup.isVisible ~= true) then
			
			selectLevelDisplayGroup.isVisible = true
			selectColorsDisplayGroup.isVisible = false
			if (b.enOrSp == 2) then
				b.selectLevelSp.isVisible = true
				b.selectLevelEn.isVisible = false
			else
				b.selectLevelEn.isVisible = true
				b.selectLevelSp.isVisible = false
			end			
			
			addColorSquareListeners(-1)

			b.selectColorsExit:removeEventListener("touch", exitColorsListener)
			
			s.levelOneButton:addEventListener("touch", levelOneButtonListener)
			s.levelTwoButton:addEventListener("touch", levelTwoButtonListener)
			s.levelThreeButton:addEventListener("touch", levelThreeButtonListener)
			s.levelFourButton:addEventListener("touch", levelFourButtonListener)
			s.levelFiveButton:addEventListener("touch", levelFiveButtonListener)
			s.levelSixButton:addEventListener("touch", levelSixButtonListener)
						
			s.levelTwoButtonMask.isVisible = true
			s.levelThreeButtonMask.isVisible = true
			s.levelFourButtonMask.isVisible = true
			s.levelFiveButtonMask.isVisible = true
			s.levelSixButtonMask.isVisible = true
			
			if (v.levelReached > 5) then 
				s.levelTwoButtonMask.isVisible = false 
			end
			
			if(v.levelReached > 10) then
				s.levelThreeButtonMask.isVisible = false
			end
			
			if(v.levelReached > 15) then
				s.levelFourButtonMask.isVisible = false
			end
			
			if(v.levelReached > 20) then
				s.levelFiveButtonMask.isVisible = false
			end
			
			if(v.levelReached > 25) then
				s.levelSixButtonMask.isVisible = false
			end
		end

	elseif (activeScreen == "options") then
		if(optionsDisplayGroup.isVisible ~= true) then
			optionsDisplayGroup.isVisible = true
			if (b.enOrSp == 2) then
				b.optionsReturnButtonSp.isVisible = true
				b.optionsReturnButtonEn.isVisible = false
				b.englishEn.alpha = .5
				b.exitSp.isVisible = true
				b.exitEn.isVisible = false
			else
				b.optionsReturnButtonEn.isVisible = true
				b.optionsReturnButtonSp.isVisible = false
				b.spanishSp.alpha = .5
				b.exitSp.isVisible = false
				b.exitEn.isVisible = true
			end
			menuDisplayGroup.isVisible = false
			b.optionsReturnButtonEn:addEventListener("touch", optionsReturnButtonListener)			
			b.optionsReturnButtonSp:addEventListener("touch", optionsReturnButtonListener)
			b.englishEn:addEventListener("touch", englishEnEventListener)
			b.spanishSp:addEventListener("touch", spanishSpEventListener)
			b.exitEn:addEventListener("touch", exitEnEventListener)
			b.exitSp:addEventListener("touch", exitSpEventListener)
			b.optionsEn:removeEventListener("touch", optionsListener)
			b.optionsSp:removeEventListener("touch", optionsListener)
			b.playEn:removeEventListener("touch", playGameListener)
			b.playSp:removeEventListener("touch", playGameListener)
			b.facebookEn:removeEventListener("touch", socialNetworkBtnTouch)
			
			if (v.soundOn == 1) then
				b.speakerOff.isVisible = false
			else
				b.speakerOff.isVisible = true
			end
			b.speaker:addEventListener("touch", toggleSpeaker)
			if (v.musicOn == 1) then
				b.musicOff.isVisible = false
			else
				b.musicOff.isVisible = true
			end
			b.music:addEventListener("touch", toggleMusic)
		end
	end
end


function fFunction()
	
	gameLoop()
	
	if (fFrame == 2) then
		fFrame = 1
	else
		fFrame = fFrame + 1
	end
	

end


local function onSystemEvent(e)

	if (e.type == "applicationSuspend") then
		audio.pause()
		if (activeScreen == "game") then
			pauseButton.xScale = 1.2
			pauseButton.yScale = 1.2
--		end


--		if (e.phase == "ended") then
		
			v.isPaused = true
			maskScreenDisplayGroup.isVisible = true
			menuMaskScreen.isVisible = true
			menuMaskScreen.alpha = .5
			if (b.enOrSp == 2) then
				b.returnToMenuSp.isVisible = true
				b.returnToMenuEn.isVisible = false
				b.yesButtonSp.isVisible = true			
				b.yesButtonEn.isVisible = false
				b.noButton.isVisible = true
			else
				b.returnToMenuEn.isVisible = true
				b.returnToMenuSp.isVisible = false
				b.yesButtonEn.isVisible = true			
				b.yesButtonSp.isVisible = false
				b.noButton.isVisible = true
			end
			b.yesButtonEn:addEventListener("touch", yesButtonListener)
			b.yesButtonSp:addEventListener("touch", yesButtonListener)
			b.noButton:addEventListener("touch", noButtonListener)
	
		end
	elseif(e.type == "applicationResume") then
		if(v.isPaused == false) then
			audio.resume()
		end
	end

end 


-- THE PROGRAM CODE FROM HERE

weaponsIconsDisplayGroup:addEventListener("touch", weaponsChangeNeeded)

attackButton:addEventListener("touch", attackButtonListener)
swingButton:addEventListener("touch", swingButtonListener)
granadeButton:addEventListener("touch", granadeButtonListener)

Runtime:addEventListener("touch", button)
tent1:addEventListener("touch", tentTouched)
tent2:addEventListener("touch", tentTouched)

levelStartWeaponsChange()
weaponsChange(nil)

Runtime:addEventListener("enterFrame", fFunction)

-- ANDROID ONLY
Runtime:addEventListener("key", onKeyHardwareListener)

Runtime:addEventListener("system", onSystemEvent)


end

--run()				 
timer.performWithDelay(100, run, 1)
