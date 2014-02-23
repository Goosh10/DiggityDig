

local myLookupTables = {}


myLookupTables.digLevelFinds= {
    {dollarValue = 3, name='Coal'},
    {dollarValue = 6, name='Iron'},
    {dollarValue = 12, name='Nickle'},
    {dollarValue = 24, name='Tin'},
    {dollarValue = 48, name='Tungsten'},
    {dollarValue = 96, name='Silver'},
    {dollarValue = 192, name='Gold'},
    {dollarValue = 384, name='Ruby'},
    {dollarValue = 768, name='Emerald'},
    {dollarValue = 1536, name='Diamond'},
    {dollarValue = 2000, name='Platinum'},
    {dollarValue = 2500, name='Titanium'},
    {dollarValue = 3000, name='Uridium'},
    {dollarValue = 3500, name='Inanium'},
    {dollarValue = 4000, name='Crazium'},
    {dollarValue = 5000, name='Cocoite'},
}





myLookupTables.speedModifier= {
    {speed = 0.9, cost=48},
    {speed = 0.8, cost=96},
    {speed = 0.7, cost=192},
    {speed = 0.6, cost=384},
    {speed = 0.5, cost=768},
    {speed = 0.4, cost=1536},
    {speed = 0.3, cost=3072},
    {speed = 0.2, cost=6144},
    {speed = 0.18, cost=12288},
    {speed = 0.14, cost=24576},
    {speed = 0.1, cost=32000},
}




myLookupTables.valueModifier= {
    {value = 1, cost=48},
    {value = 1.2, cost=96},
    {value = 1.4, cost=192},
    {value = 1.6, cost=384},
    {value = 1.8, cost=768},
    {value = 2, cost=1536},
    {value = 2.2, cost=3072},
    {value = 2.4, cost=6144},
    {value = 2.6, cost=12288},
    {value = 2.8, cost=24576},
    {value = 3, cost=32000},
}



myLookupTables.newLevel= {
    {level = 2, cost=48},
    {level = 3, cost=96},
    {level = 4, cost=192},
    {level = 5, cost=384},
    {level = 6, cost=768},
    {level = 7, cost=1536},
    {level = 8, cost=3072},
    {level = 9, cost=6144},
    {level = 10, cost=12288},
    {level = 11, cost=24576},
    {level = 12, cost=32000},
}



myLookupTables.gasTank={
    {tank = 20, cost=48},
    {tank = 30, cost=96},
    {tank = 40, cost=192},
    {tank = 50, cost=384},
    {tank = 60, cost=768},
    {tank = 70, cost=1536},
    {tank = 80, cost=3072},
    {tank = 90, cost=6144},
    {tank = 100, cost=12288},
    {tank = 110, cost=24576},
    {tank = 120, cost=32000},
}


myLookupTables.myCardOdds={
    {relativeLevel = 1, chances=3},
    {relativeLevel = 2, chances=6},
    {relativeLevel = 3, chances=18},
    {relativeLevel = 4, chances=90},
    {relativeLevel = 5, chances=180},
    {relativeLevel = 6, chances=540},
}



return myLookupTables

