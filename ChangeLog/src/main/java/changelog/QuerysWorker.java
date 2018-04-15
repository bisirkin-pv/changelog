package changelog;


import changelog.mapping.TableQuery;
import connect.Config;
import connect.ConnectionProducer;
import connect.ConnectionProducerFactory;
import org.sql2o.Connection;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author bisirkin_pv
 */
public class QuerysWorker {
    /**
     * Загружаем список запросов для дальнейшей работы
     * @return Список класса запросов TableQuery
     * @throws IOException
     * @throws ClassNotFoundException
     */
    public List<TableQuery> loadQuerys() throws IOException, ClassNotFoundException{
        String query = getQueryForLoad();
        if("".equals(query)){
            return null;
        }
        ConnectionProducer myDao = ConnectionProducerFactory.create(Config.Type.PROD);
        try(Connection con = myDao.produceSql2o().open()) {
            return con.createQuery(query).executeAndFetch(TableQuery.class);
        }
    }
    /**
     * Возвращает начальный запрос для загрузки остальных
     * @return Запрос для загрузки таблицы с запросами
     */
    private String getQueryForLoad(){
        Properties properties = new Properties();
        try {
            //String file = System.getProperty("user.dir") + "/ChangeLog/config/settings.properties";
            properties.load(new BufferedReader(new FileReader("config/settings.properties")));
            return properties.getProperty("change.log.querys");
        } catch (IOException ex) {
            Logger.getLogger(QuerysWorker.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "";
    }
}
