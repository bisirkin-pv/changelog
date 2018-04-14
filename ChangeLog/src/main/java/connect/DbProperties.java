package connect;


/**
 * Класс для настроек подключения к базе данных
 * @author bisirkin_pv
 */
public class DbProperties {
    private final String url;
    private final String clazz;
    private final String username;
    private final String password;

    public DbProperties(String url, String clazz, String username, String password) {
        this.url = url;
        this.clazz = clazz;
        this.username = username;
        this.password = password;
    }

    public String getUrl() {
        return url;
    }

    public String getClazz() {
        return clazz;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

}