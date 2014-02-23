

local utilities = {}


    -- presuming center anchors
    function utilities.getDistanceToXEdge(myDisplayObject)

        local distanceToEdge

        distanceToEdge = myDisplayObject.width / 2

        return distanceToEdge
    end

    -- presuming center anchors
    function utilities.getDistanceToYEdge(myDisplayObject)

        local distanceToEdge

        distanceToEdge = myDisplayObject.height / 2

        return distanceToEdge
    end
    

    -- presuming we are using center anchors
    function utilities.getBottom(displayObject)
    
        --print('-')
        --print(displayObject.y)
        --print(displayObject.height / 2)
        
        local myBottom = displayObject.y + (displayObject.height / 2)
        --print ('myBttom:' .. myBottom)

        return myBottom

    end
    
    -- presuming we are using center anchors
    function utilities.getTop(displayObject)

        local myTop = displayObject.y - (displayObject.height / 2)

        return myTop

    end    
    
    -- presuming we are using center anchors
    function utilities.getLeft(displayObject)

        local myLeft = displayObject.x - (displayObject.width / 2)

        return myLeft

    end      
    
    -- presuming we are using center anchors
    function utilities.getRight(displayObject)

        local myRight = displayObject.x + (displayObject.width / 2)

        return myRight

    end      
    
    
    -- move an object to the right of another display object (buffer is optional)
    function utilities.getXToPlaceObjectToTheRightOfAnother(myDisplayObjectLeft, myDisplayObjectRight, myBuffer)
        
        if myBuffer == nil then
            myBuffer = 0
        end
        
        local myNewCenteredXForTargetObject
        
        myNewCenteredXForTargetObject = utilities.getRight(myDisplayObjectLeft) + myBuffer + utilities.getDistanceToXEdge(myDisplayObjectRight)
        
        return myNewCenteredXForTargetObject
    end
    
    return utilities
    
    
