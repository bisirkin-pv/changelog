package changelog;


import changelog.mapping.TableQuery;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Класс загрузки запросов из базы
 * @author bisirkin_pv
 */
public class QuerysLoader {
    private static final Logger LOG = Logger.getLogger(QuerysLoader.class.getName());
    private static List<TableQuery> querys;

    /**
     * Загружает класс запросов
     * @return Код ошибки - 0 ошибка
     */
    public static int load(){
        QuerysWorker querysWorker = new QuerysWorker();
        try {
            querys = querysWorker.loadQuerys();
            if(querys==null){
                LOG.log(Level.SEVERE, "Error load querysClass");
                return 0;
            }
            LOG.log(Level.INFO, "querysClass load success");
            return 1;
        } catch (IOException | ClassNotFoundException ex) {
            LOG.log(Level.SEVERE, ex.getMessage());
        }
        return 0;
    }

    public static List<TableQuery> getListQuery(){
        return querys;
    }

    public static TableQuery getTableQuery(int id){
        return querys.get(id);
    }

    public static int getSize(){
        return querys.size();
    }

    public static String getQuery(String name){
        String result = "";
        for(int i=0; i< getSize(); i++){
            if(getTableQuery(i).getName().equals(name)){
                result = getTableQuery(i).getText();
                break;
            }
        }
        return result;
    }

    public static int reload(){
        querys.clear();
        return load();
    }
}

