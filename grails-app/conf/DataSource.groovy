dataSource {
    pooled = true
    driverClassName = "org.h2.Driver"
    username = "sa"
    password = ""
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update" // one of 'create', '   create-drop', 'update', 'validate', ''
//            url = "jdbc:h2:devDb;MVCC=TRUE;LOCK_TIMEOUT=10000"
//            url = "jdbc:mysql://localhost/refah?useUnicode=true&characterEncoding=UTF-8"
//            username = "root"
//            password = ""
//            pooled = true
//                driverClassName = "com.mysql.jdbc.Driver"
//            dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"
//            properties {
//                maxActive = -1
//                minEvictableIdleTimeMillis = 1800000
//                timeBetweenEvictionRunsMillis = 1800000
//                numTestsPerEvictionRun = 3
//                testOnBorrow = true
//                testWhileIdle = true
//                testOnReturn = true
//                validationQuery = "SELECT 1"
//            }
            username = "sa"
            password = "Salam123"
            url = "jdbc:sqlserver://192.168.47.164:1433;databaseName=CashDB"

            driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
            dialect = "org.hibernate.dialect.SQLServerDialect"
            properties {
                maxActive = -1
                minEvictableIdleTimeMillis = 1800000
                timeBetweenEvictionRunsMillis = 1800000
                numTestsPerEvictionRun = 3
                testOnBorrow = true
                testWhileIdle = true
                testOnReturn = true
                validationQuery = "SELECT 1"
            }

        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:h2:mem:testDb;MVCC=TRUE;LOCK_TIMEOUT=10000"
        }
    }
    production {
        dataSource {
            dbCreate = "update"
//            username = "cashdb"
//            password = "cashdb"
//            url = "jdbc:sqlserver://localhost:1433"
//
//            driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
//            dialect = "org.hibernate.dialect.SQLServerDialect"
//            properties {
//                maxActive = -1
//                minEvictableIdleTimeMillis = 1800000
//                timeBetweenEvictionRunsMillis = 1800000
//                numTestsPerEvictionRun = 3
//                testOnBorrow = true
//                testWhileIdle = true
//                testOnReturn = true
//                validationQuery = "SELECT 1"
//            }
            dialect = "org.hibernate.dialect.SQLServerDialect"
            jndiName = "java:comp/env/jdbc/RefahPool"

            properties {
                maxActive = -1
                minEvictableIdleTimeMillis = 1800000
                timeBetweenEvictionRunsMillis = 1800000
                numTestsPerEvictionRun = 3
                testOnBorrow = true
                testWhileIdle = true
                testOnReturn = true
                validationQuery = "SELECT 1"
            }
        }
    }
}
