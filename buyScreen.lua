
--todo: ensure that when we have reached the limits of buying, the app will not crash

local myGameProperties = require("gameProperties")
local myLookupTables = require("lookupTables")

local widget = require( "widget" )

local utilities = require("utilities")

local myBuyScreen = {}

local _cw = display.contentWidth
local _ch = display.contentHeight

local myBuyScreenDisplayGroup

function myBuyScreen.removeScreen()
    
    -- will this clear it
    myBuyScreenDisplayGroup:removeSelf()
    
end

function myBuyScreen.createScreen()
    
    -- forward reference
    local btnPurchaseNewDigLevel
    local btnPurchaseNewSpeedIncrease
    
    -- create a new display group
    myBuyScreenDisplayGroup = display.newGroup()
    
    local myBackground = display.newRect(0, 0, _cw * 1.25, _ch * 1.25)
    myBackground:setFillColor(0, 0, 0, 1)
    myBackground.x = display.contentCenterX
    myBackground.y = display.contentCenterY
    
    -- add a listener so we can stop the click throughs
    myBackground:addEventListener('touch', function() return true; end)
    
    
    local myExitCircle = display.newCircle(500, 500, 50)
    myExitCircle.x = _cw - myExitCircle.width / 2
    myExitCircle.y = _ch - myExitCircle.height / 2

    local function exitBuyScreen(event)

        if event.phase == 'began' then

            myBuyScreen.removeScreen()

        end

    end

    myExitCircle:addEventListener('touch', exitBuyScreen)

    
    local txtLabelBuy = display.newText('Buy', 0, 0, 0, 0, native.systemFont, 100)
    txtLabelBuy.x, txtLabelBuy.y = 75, 50


    ----------------------------------------------------------------
    -- Buy Level 
    ----------------------------------------------------------------
        
        

        local costForNewLevel = myLookupTables.newLevel[myGameProperties.curentLevel].cost
        local nextLevelText = myLookupTables.newLevel[myGameProperties.curentLevel].level

        local newStringForDigLevelButton = 'Purchase level ' .. nextLevelText .. 
                                            ' for $' .. costForNewLevel

        -- Function to handle button events
        local function handlePurchaseDigLevelEvent( event )

            if ( "ended" == event.phase ) then

               if myGameProperties.money >= costForNewLevel then

                   myGameProperties.money = myGameProperties.money - costForNewLevel
                   myGameProperties.curentLevel = myGameProperties.curentLevel + 1

                    native.showAlert('Level ' .. nextLevelText .. ' puchased!' , 'Level ' .. nextLevelText .. ' puchased!', { "OK"})


                    costForNewLevel = myLookupTables.newLevel[myGameProperties.curentLevel].cost
                    nextLevelText = myLookupTables.newLevel[myGameProperties.curentLevel].level

                    newStringForDigLevelButton = 'Purchase level ' .. nextLevelText .. 
                                            ' for $' .. costForNewLevel               

                   btnPurchaseNewDigLevel:setLabel(newStringForDigLevelButton)
                   btnPurchaseNewDigLevel.x = 75 + btnPurchaseNewDigLevel.width / 2

                    -- fire the event to let the main screen money needs to be updated
                    local event = { name="moneyHasBeenUpdatedEvent"}
                    Runtime:dispatchEvent(event )

               else

                   native.showAlert('Not enough money', 'Not enough money, honey', { "OK"})


               end

            end

        end

        -- Create the widget
         btnPurchaseNewDigLevel = widget.newButton
        {
            left = 75,
            top = 125,
            width = 200,
            height = 100,
            fontSize = 50,
            labelColor = { default={ 0.8, 0.2, 0.2 }, over={ 0, 1, 1, 1 } },
            id = "button1",
            label = newStringForDigLevelButton,
            onEvent = handlePurchaseDigLevelEvent
        }
    
    
    ----------------------------------------------------------------
    -- Speed Increase
    ----------------------------------------------------------------

        local costForNewSpeedIncrease = myLookupTables.speedModifier[myGameProperties.speedModifier].cost
        local nextSpeedIncreaseText = myLookupTables.speedModifier[myGameProperties.speedModifier].speed

        local newStringForSpeedIncreaseButton = 'Purchase Speed increase ' .. nextSpeedIncreaseText .. 
                                            ' for $' .. costForNewSpeedIncrease

        -- Function to handle button events
        local function handlePurchaseSpeedIncreaseEvent( event )

            if ( "ended" == event.phase ) then

               if myGameProperties.money >= costForNewSpeedIncrease then

                   myGameProperties.money = myGameProperties.money - costForNewSpeedIncrease
                   myGameProperties.speedModifier = myGameProperties.speedModifier + 1

                    native.showAlert('Speed Increased ' .. nextSpeedIncreaseText .. ' puchased!' , 'Speed Increased ' .. nextSpeedIncreaseText .. ' puchased!', { "OK"})


                    costForNewSpeedIncrease = myLookupTables.speedModifier[myGameProperties.speedModifier].cost
                    nextSpeedIncreaseText = myLookupTables.speedModifier[myGameProperties.speedModifier].speed

                    newStringForSpeedIncreaseButton = 'Purchase Speed increase ' .. nextSpeedIncreaseText .. 
                                            ' for $' .. costForNewSpeedIncrease             

                   btnPurchaseNewSpeedIncrease:setLabel(newStringForSpeedIncreaseButton)
                   btnPurchaseNewSpeedIncrease.x = 75 + btnPurchaseNewSpeedIncrease.width / 2

                    -- fire the event to let the main screen money needs to be updated
                    local event = { name="moneyHasBeenUpdatedEvent"}
                    Runtime:dispatchEvent(event )

               else

                   native.showAlert('Not enough money', 'Not enough money, honey', { "OK"})


               end

            end

        end

        -- Create the widget
         btnPurchaseNewSpeedIncrease = widget.newButton
        {
            left = 75,
            top = 200,
            width = 200,
            height = 100,
            fontSize = 50,
            labelColor = { default={ 0.8, 0.2, 0.2 }, over={ 0, 1, 1, 1 } },
            id = "button1",
            label = newStringForSpeedIncreaseButton,
            onEvent = handlePurchaseSpeedIncreaseEvent
        }
    
    

    myBuyScreenDisplayGroup:insert(myBackground)
    myBuyScreenDisplayGroup:insert(btnPurchaseNewDigLevel)
    myBuyScreenDisplayGroup:insert(btnPurchaseNewSpeedIncrease)
    myBuyScreenDisplayGroup:insert(txtLabelBuy)
    myBuyScreenDisplayGroup:insert(txtLabelBuy)
    
    

--    local txtLabelDigDepth = display.newText('DigDepth', 0, 0, 0, 0, native.systemFont, 50)
--    local txtValueDigDepth= display.newText('0', 0, 0, 0, 0, native.systemFont, 50)
--    local txtBuyDigDepth = display.newText('Click Me To Buy', 0, 0, 0, 0, native.systemFont, 50)



--    local txtLabelSpeed = display.newText('SpeedModifier', 0, 0, 0, 0, native.systemFont, 50)
--    local txtValueSpeedIncrease = display.newText('0', 0, 0, 0, 0, native.systemFont, 50)
--    local txtValueSpeedCost = display.newText('0', 0, 0, 0, 0, native.systemFont, 50)
--    local txtBuySpeed = display.newText('Click Me To Buy', 0, 0, 0, 0, native.systemFont, 50)
--    
--    txtValueSpeedCost.text = lookupTables.speedModifier[gameProperties.speedModifier + 1].cost
--   txtValueSpeedIncrease.text = lookupTables.speedModifier[gameProperties.speedModifier + 1].speed
--   
--    
--    txtLabelSpeed.x, txtLabelSpeed.y =  txtLabelSpeed.x + txtLabelSpeed.width / 2, 150
--    
--    txtValueSpeedIncrease.y = txtLabelSpeed.y
--    utilities.getXToPlaceObjectToTheRightOfAnother(txtLabelSpeed, txtValueSpeedIncrease, 20)
--    utilities.getXToPlaceObjectToTheRightOfAnother(txtValueSpeedIncrease, txtValueSpeedCost, 20)
--    utilities.getXToPlaceObjectToTheRightOfAnother(txtValueSpeedCost, txtBuySpeed, 20)
       


--    local txtLabelDigDepth = display.newText('DigDepth', 0, 0, 0, 0, native.systemFont, 50)
--    local txtValueDigDepth= display.newText('0', 0, 0, 0, 0, native.systemFont, 50)
--    local txtBuyDigDepth = display.newText('Click Me To Buy', 0, 0, 0, 0, native.systemFont, 50)
--
--
--    local txtLabelGasTank = display.newText('DigDepth', 0, 0, 0, 0, native.systemFont, 50)
--    local txtValueGasTank= display.newText('0', 0, 0, 0, 0, native.systemFont, 50)
--    local txtBuyGasTank = display.newText('Click Me To Buy', 0, 0, 0, 0, native.systemFont, 50)
--
--
--    local txtLabelGas = display.newText('DigDepth', 0, 0, 0, 0, native.systemFont, 50)
--    local txtValueGas= display.newText('0', 0, 0, 0, 0, native.systemFont, 50)
--    local txtBuyGas = display.newText('Click Me To Buy', 0, 0, 0, 0, native.systemFont, 50)

end




return myBuyScreen











