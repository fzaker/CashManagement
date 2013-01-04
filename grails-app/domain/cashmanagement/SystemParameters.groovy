package cashmanagement

class SystemParameters {
    //** Gheire Tabsare
    Double maxGrowth
    Double minGrowth
    Double permitToward
    Integer numofDays
    //**  Tabsare
    Double permitReceivePercent
    Double permitReceiveDaysNum

    //** Gharzol hasane

    static mapping = {
        table 'cash_parameters'
           }

    static constraints = {
        maxGrowth(nullable: false)
        minGrowth(nullable: false)
        permitToward(nullable: false)
        numofDays(nullable: false)
        permitReceivePercent(nullable: false)
        permitReceiveDaysNum(nullable: false)
    }
}
