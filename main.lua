--Note: for testing on my own device I made the resolution 1024x600 and landscape

-- set the seed
math.randomseed(os.time())

local myLookupTables = require("lookupTables")
local myGameProperites = require("gameProperties")
local myUtilities = require("utilities")

local myBuyScreen = require("buyScreen")

local _cw = display.contentWidth
local _ch = display.contentHeight


local mySounds = {}
mySounds.zap = audio.loadSound("sounds/zap1.mp3")
mySounds.lowDown = audio.loadSound("sounds/lowdown.mp3")
mySounds.dig = audio.loadSound("sounds/dig.mp3")





local myBuyCircle = display.newCircle(500, 500, 50)
myBuyCircle.x = _cw - myBuyCircle.width / 2
myBuyCircle.y = _ch - myBuyCircle.height / 2

local function showBuyScreen(event)
    
    if event.phase == 'began' then
        
        myBuyScreen.createScreen()
        
    end
    
end

myBuyCircle:addEventListener('touch', showBuyScreen)


-----------------------------------
-- Utilitiy functions
------------------------------------- 
    
    
    local function getMaterialLevelFromRandomNumber()
        
        local myRandomNumber = math.random(1,myLookupTables.myCardOdds[#myLookupTables.myCardOdds].chances)
        local myFoundMateralLevel
        
        local maxLevelThatWeCanFind = myGameProperites.curentLevel + 4
                
        -- the odds are relative to level... you always have the same chance of getting higher 
        -- material no matter what level.
        -- For example: finding a level 3 item when you are level 1 is (1 in 18)
        --              finding a level 7 item when you are level 5 is still ( 1 in 18)
        local myRangeOdds
        
        -- get 5 levels above teh current level and work down to the current level
        for i = maxLevelThatWeCanFind, myGameProperites.curentLevel, -1 do
            
            -- since chances(odds) are relative to the make sure we validate a range
            -- odds are static relative to level, so from level 5 to 6 is just the same add as level 8 finding 9
            myRangeOdds = i - myGameProperites.curentLevel + 1
            
            -- if we have a remainder, it means it is not a multiple of the odds (so no hit)
            local myRemainder = myRandomNumber % myLookupTables.myCardOdds[myRangeOdds].chances
            
            -- we have a match
            if myRemainder == 0 then
                
                -- we get the level from which we have found the item
                myFoundMateralLevel = i

                return myFoundMateralLevel

            end
            
        end
        
        -- if we've reached here we did not find a hit, so return dirt
       myFoundMateralLevel = 0
       
       return myFoundMateralLevel       

        
    end
    
    local function getCardNameAndValueFromRandomNumber()
        --returns  myFoundDollarValue, myFoundNameOfMaterial
        
        local myFoundDollarValue
        local myFoundNameOfMaterial

        local myFoundMaterialLevel = getMaterialLevelFromRandomNumber()
                
        -- we have found dirt
        if myFoundMaterialLevel == 0 then
            
          -- get the value of the found material
           myFoundDollarValue =  0
           myFoundNameOfMaterial = 'Dirt'

            
        else
            
            -- get the value of the found material
           myFoundDollarValue =  myLookupTables.digLevelFinds[myFoundMaterialLevel].dollarValue
           myFoundNameOfMaterial = myLookupTables.digLevelFinds[myFoundMaterialLevel].name
        
        end
        
               
        return myFoundDollarValue, myFoundNameOfMaterial
       
    end
    
        
-------------------------------------------------        
-- Defining interface
-------------------------------------------------

    local txtLabelAverage = display.newText('Average', 0, 0, 0, 0, native.systemFont, 50)
    local txtValueAverage = display.newText('0', 0, 0, 0, 0, native.systemFont, 50)

    txtLabelAverage.x = 0 + myUtilities.getDistanceToXEdge(txtLabelAverage)
    txtLabelAverage.y = 30
    
    txtValueAverage.x = myUtilities.getXToPlaceObjectToTheRightOfAnother(txtLabelAverage, txtValueAverage, 100 )
    txtValueAverage.y = 30
    
    
    local txtLabelMoney = display.newText('Money', 0, 0, 0, 0, native.systemFont, 50)
    local txtValueMoney = display.newText('0', 0, 0, 0, 0, native.systemFont, 50)

    txtLabelMoney.x = myUtilities.getXToPlaceObjectToTheRightOfAnother(txtValueAverage, txtLabelMoney, 100 )
    txtLabelMoney.y = 30
    
    txtValueMoney.x = myUtilities.getXToPlaceObjectToTheRightOfAnother(txtLabelMoney, txtValueMoney, 100 )
    txtValueMoney.y = 30
        
    local txtLabelGas = display.newText('Gas', 0, 0, 0, 0, native.systemFont, 50)
    local txtValueGas = display.newText('0', 0, 0, 0, 0, native.systemFont, 50)

    txtLabelGas.x = myUtilities.getXToPlaceObjectToTheRightOfAnother(txtValueMoney, txtLabelGas, 75 )
    txtLabelGas.y = 30
    
    txtValueGas.x = myUtilities.getXToPlaceObjectToTheRightOfAnother(txtLabelGas, txtValueGas, 75 )
    txtValueGas.y = 30    
        
        
    local myQueueOfCards = {}
    
    
    
        
    ----------------------------------------
    -- Initialize the UI values
    ----------------------------------------

    txtValueGas.text = myLookupTables.gasTank[myGameProperites.gasTankLevel].tank
    
    
----------------------------------------------------
-- Create the 7 cards
----------------------------------------------------

local myCardWidth = _cw / 8

local myCards = {}
    
-- play the sounds while we are digging
local myDigSoundTimer
local myDigDurationTestTimer
    
local function createCard(startXValue)
    

    
    -- this is an optional parameter
    if startXValue == nil then
        startXValue = 0
    end
    
    local myCard = display.newRect(0, 0, myCardWidth, 200)
    local redRandom = math.random(1, 1000) / 1000
    local blueRandom = math.random(1, 1000) / 1000
    local greenRandom= math.random(1, 1000) / 1000
    
    myCard:setFillColor(redRandom, blueRandom, greenRandom, 1)
    myCard.y = 200
    myCard.x = startXValue
    
    myCard.name = 'hello'
    
    local totalTimeDug = 0
    
    local startTime = 0
    local oldTime = 0
    local newTime = 0
    
    -- restart the values on the card
    local function restartDiggingForThisCard()
                
        -- stop the timer if we have one for the sound
        -- if we still have a sound timer running
        if myDigSoundTimer ~= nil then
            timer.cancel(myDigSoundTimer)
            myDigSoundTimer = nil
        end
        
        -- cancel the timer that's checking for holding delay
        if myDigDurationTestTimer ~= nil then
            timer.cancel(myDigDurationTestTimer)
            myDigDurationTestTimer = nil
        end
        

        
        startTime = 0

        
        totalTimeDug = 0
                
    end    
    
    local function myDigTimerSoundFunction()
        
        audio.play(mySounds.dig)
        
    end

    --forward reference
    local digTimeWithModifier
    local function myDigTimerDurationTest()
        
        -- if we have a zero start timer, we do presume the user has already ended his/her touch
        if startTime == 0 then
            return
        end
        
        digTimeWithModifier = myGameProperites.timeToRub * myLookupTables.speedModifier[myGameProperites.speedModifier].speed

        -- get the total time we've been digging
        totalTimeDug = system.getTimer() - startTime

        if totalTimeDug >= digTimeWithModifier then
            
            timer.cancel(myDigDurationTestTimer)
            
            -- tell the other cards to restart their digging time because one was revealed
            local event = { name="cardRevealedEvent", target=myCard }
            Runtime:dispatchEvent(event )
            
            local dollarValueOfCard, nameOfCard = getCardNameAndValueFromRandomNumber()
            
            if dollarValueOfCard > 0 then
                -- play a sound to reward the user
                audio.play(mySounds.zap)
            else
                
                audio.play(mySounds.lowDown)
                --todo: play sad sound for the dirt
            end
            
            
            local function transitionValuesUp(xStartLocation, yStartLocation, moveUpDistance, stringToTransition)
                
                
                local newText = display.newText(stringToTransition, 0, 0, 0, 0, native.systemFont, 50)
                
                newText.x = xStartLocation
                newText.y = yStartLocation
                
                local function onComplete()
                    
                    newText:removeSelf()
                    
                end
                
                transition.to(newText, {time=1000, y=moveUpDistance, onComplete = onComplete})
                
            end
            
            -- add modifier here
            local newValueWithModifier = dollarValueOfCard
            
            -- we only show the original / different if they are actually different
            local newMessage
            if newValueWithModifier ~= dollarValueOfCard then
                newMessage = nameOfCard .. '! ' .. newValueWithModifier .. '(' .. dollarValueOfCard .. ')'
            else
                newMessage = nameOfCard .. '! ' .. dollarValueOfCard
            end
            
            
            transitionValuesUp(event.target.x, event.target.y, 100, newMessage) 
            
            
            -- don't debug dirt {}
            if nameOfCard ~= 'Dirt' then
                print(nameOfCard .. ': ' .. dollarValueOfCard)
            end
            
            
            -- update the gloals
            myGameProperites.totalNumberOfDigs = myGameProperites.totalNumberOfDigs + 1
            myGameProperites.totalMoneyEarned = myGameProperites.totalMoneyEarned + dollarValueOfCard
            myGameProperites.money = myGameProperites.money + dollarValueOfCard
            
            myGameProperites.curentGas = myGameProperites.curentGas - 1
            
            --lua doesnt' have a simple rounding function for one decimal place
            local myAverage = math.floor((myGameProperites.totalMoneyEarned / myGameProperites.totalNumberOfDigs) * 10) / 10
            txtValueAverage.text = myAverage
            
            txtValueMoney.text = myGameProperites.money
            
            txtValueGas.text = myGameProperites.curentGas
            
            restartDiggingForThisCard()
            
            -- create a new card to replace the soon to be moved card (and place it in the same x spot)
            table.insert(myCards, createCard(event.target.x))
            
            
            -- quick hack for the blitz, move the new card to the back so my earlie text gets displayed
            myCards[#myCards]:toBack()
            
            -- if we've reached the max, remove one
            if #myQueueOfCards == 7 then
                                
                --remove the first card in the set
                myQueueOfCards[1]:removeSelf()
                
                table.remove(myQueueOfCards, 1)
                                                
                --move the cards one card width to the left
                for i = 1, 6 do
                    
                    
                    -- move the card to the left 
                    myQueueOfCards[i].x = myQueueOfCards[i].x - myQueueOfCards[i].width
                    
                    --todo: make transitions for movement
                    --local myNewX = myQueueOfCards[i].x - myQueueOfCards[i].width
                    --transition.to(myQueueOfCards[i], {time = 200, x=myNewX})
                    
                end
                                
            end
            
            table.insert(myQueueOfCards, event.target)
            
            if #myQueueOfCards > 1 then
                myQueueOfCards[#myQueueOfCards].x = myUtilities.getXToPlaceObjectToTheRightOfAnother(myQueueOfCards[#myQueueOfCards - 1], event.target)
            else
                myQueueOfCards[#myQueueOfCards].x = myQueueOfCards[#myQueueOfCards].width / 2
            end
            
            myQueueOfCards[#myQueueOfCards].y = _ch --- myQueueOfCards[#myQueueOfCards].height
            
        end
        
    end

    local function digCardTouchHandler(event)
        
        -- if phase has began it means they restarted (and maybe they didn't fire the end event')
        if event.phase == 'began' then
            
            restartDiggingForThisCard()
            
            print('began')
            
            -- get the time we started 
            startTime = system.getTimer()
            
            myDigSoundTimer = timer.performWithDelay(300, myDigTimerSoundFunction, 0)
            myDigDurationTestTimer = timer.performWithDelay(1, myDigTimerDurationTest, 0)
            
        end
        
        -- we wish to allow the user to start digging again when they move
        if event.phase == 'moved' then
            
            -- if we don't have a start timer, start a new timer
            if startTime == 0 then             -- get the time we started 
                startTime = system.getTimer()
            end
            
            -- if we haven't started the timer, start one now
            if myDigSoundTimer == nil then
                myDigSoundTimer = timer.performWithDelay(300, myDigTimerSoundFunction, 0)
            end
            
            -- if we haven't started the timer, start one now
            if myDigDurationTestTimer == nil then
                
                myDigDurationTestTimer = timer.performWithDelay(1, myDigTimerDurationTest, 0)
            end
            
        end
        
        
        -- if they have stopped rubbing, reset the timers
        if event.phase == 'ended' then
            
            print('ended')
            
            restartDiggingForThisCard()
            
        end

        --todo: fix speed modifier, currently it is one row off (you're already at .9 when you buy .9. System says you are buy .9, but you are buying .8for example')
        
    end
    
    local function updateMoneyText()
        
        txtValueMoney.text = myGameProperites.money
        
    end
    
    
    myCard:addEventListener('touch', digCardTouchHandler)
    
    
    Runtime:addEventListener('cardRevealedEvent', restartDiggingForThisCard)
    
    Runtime:addEventListener('moneyHasBeenUpdatedEvent', updateMoneyText)
    
    return myCard

end

table.insert(myCards, createCard())
table.insert(myCards, createCard())
table.insert(myCards, createCard())
table.insert(myCards, createCard())
table.insert(myCards, createCard())
table.insert(myCards, createCard())
table.insert(myCards, createCard())

-- position the first card
myCards[1].x = 75

for i = 2, 7 do
    
    myCards[i].x = myUtilities.getXToPlaceObjectToTheRightOfAnother(myCards[i-1], myCards[i], 20)
    
end
