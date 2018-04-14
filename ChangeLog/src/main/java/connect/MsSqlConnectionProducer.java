package connect;


import org.sql2o.QuirksMode;
import org.sql2o.Sql2o;

/**
 * Реализация подклюяения к MS SQL Server
 * @author bisirkin_pv
 */
public class MsSqlConnectionProducer implements ConnectionProducer{
    private final Sql2o sql2o;

    public MsSqlConnectionProducer(DbProperties dbProperties) {
        this.sql2o = new Sql2o(dbProperties.getUrl()
                , dbProperties.getUsername()
                , dbProperties.getPassword()
                , QuirksMode.MSSqlServer);
    }

    public MsSqlConnectionProducer(String url, String username, String password) {
        this.sql2o = new Sql2o(url
                , username
                , password
                , QuirksMode.MSSqlServer);
    }

    @Override
    public Sql2o produceSql2o() {
        return sql2o;
    }
}
