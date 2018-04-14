package setting;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

/**
 * Класс получения и обработки настроек приложения
 */
public class Setting {
    Properties properties = null;

    public Setting() throws IOException {
        properties = new Properties();
        String file = System.getProperty("user.dir") + "/ChangeLog/config/settings.properties";
        properties.load(new BufferedReader(new FileReader(file)));
    }

    public String getProperties(String name){
        return properties.getProperty(name);
    }
}
