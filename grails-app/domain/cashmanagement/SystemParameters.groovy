package cashmanagement

class SystemParameters {
    LoanGroup tabserei
    LoanGroup gheyreTabserei
    LoanGroup gharzolhasane

    //** Gheire Tabsare
    Double maxGrowth
    Double minGrowth
    Double permitToward
    Integer numofDays



    //**  Tabsare
    Double permitReceivePercent
    Double permitReceiveDaysNum


    //gharzolhasane
    Double ghMonthlyPercent
    Double ghCentralBankPercent
    Integer today

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
        tabserei(nullable: true)
        gheyreTabserei(nullable: true)
        gharzolhasane(nullable: true)
        today(nullable: true)
    }
}
