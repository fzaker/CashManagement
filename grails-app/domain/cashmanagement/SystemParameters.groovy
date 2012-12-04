package cashmanagement

class SystemParameters {
    //** Gheire Tabsare
    Double maxGrowth
    Double minGrowth
    Double permitToward

    //**  Tabsare
    Double permitReceivePercent
    Double permitReceiveDaysNum

    //** Gharzol hasane


    static constraints = {
        maxGrowth(nullable: false)
        minGrowth(nullable: false)
        permitToward(nullable: false)
        permitReceivePercent(nullable: false)
        permitReceiveDaysNum(nullable: false)
    }
}
