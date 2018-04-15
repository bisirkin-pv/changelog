package connect;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 * Класс читающий проперти с настройками
 * @author bisirkin_pv
 */
public class Config {
    private static final Logger LOG = Logger.getLogger(Config.class.getName());
    private static final Map<Type, Properties> listProperties = new HashMap<>();

    public static synchronized void putConfig(Type type, Properties properties) {
        listProperties.put(type, properties);
    }

    public static synchronized DbProperties getDbProperties(Type type) {
        return new DbProperties(
                listProperties.get(type).getProperty("connection.url"),
                listProperties.get(type).getProperty("class.for.name"),
                listProperties.get(type).getProperty("username"),
                listProperties.get(type).getProperty("password")
        );
    }

    public static String getValue(Type type, String name){
        return listProperties.get(type).getProperty(name);
    }

    public static void load(Type type, String path){
        try {
            Properties properties = new Properties();
            //String file = System.getProperty("user.dir") + "/ChangeLog/" + path;
            properties.load(new BufferedReader(new FileReader(path)));
            Config.putConfig(type, properties);
            StringBuilder sb = new StringBuilder();
            sb.append("Add properties:");
            sb.append(type.toString());
            LOG.log(Level.INFO, sb.toString());
        } catch (IOException ex) {
            Logger.getLogger(Config.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public enum Type {
        PROD,
        TEST
    }

}
