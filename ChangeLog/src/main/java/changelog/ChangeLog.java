package changelog;


import changelog.mapping.*;
import spark.Request;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Основной класс, обработчик действий
 * @author bisirkin_pv
 */
public class ChangeLog {
    private static final Logger LOG = Logger.getLogger(ChangeLog.class.getName());

    /**
     * Сохраняет данные по логам
     * @param request
     * @return id добавленной строки
     */
    public String saveHeader(Request request){
        Worker worker = new Worker();
        try {
            return String.valueOf(worker.insertHeader(request));
        } catch (IOException ex) {
            LOG.log(Level.SEVERE, ex.getMessage());
            return "-1";
        }
    }

    /**
     * Получение списка всех данных по логам (без деталей)
     * @return Список класса данных по логам TableHeader
     */
    public List<TableHeader> getAllHeader(){
        Worker worker = new Worker();
        try {
            return worker.getAllHeader();
        } catch (IOException ex) {
            LOG.log(Level.SEVERE, ex.getMessage());
        }
        return null;
    }

    /**
     * Обновляем данные по логам (не детали)
     * @param request
     * @return Результат выполнения
     */
    public String updateHeader(Request request){
        Worker worker = new Worker();
        try {
            worker.updHeader(request);
            return "OK";
        } catch (IOException ex) {
            LOG.log(Level.SEVERE, ex.getMessage());
            return "Error";
        }
    }

    /**
     * Получает список фильтрованных логов
     * @param request
     * @return Список класса фильтрованных логов TableFilteredHeader
     */
    public List<TableFilteredHeader> getFilteredHeader(Request request){
        Worker worker = new Worker();
        try {
            return worker.getFilteredHeader(request);
        } catch (IOException ex) {
            LOG.log(Level.SEVERE, ex.getMessage());
            return null;
        }
    }

    /**
     * Получает определенный лог
     * @param id лога
     * @return Список класса лога TableHeader
     */
    public List<TableHeader> getHeader(int id){
        Worker worker = new Worker();
        try {
            return worker.getHeader(id);
        } catch (IOException ex) {
            LOG.log(Level.SEVERE, ex.getMessage());
        }
        return null;
    }

    /**
     * Сохраняет информацию по деталям (по строчно)
     * @param request
     * @return id добавленного объекта
     */
    public String saveDetail(Request request){
        Worker worker = new Worker();
        try {
            return String.valueOf(worker.insertDetail(request));
        } catch (IOException ex) {
            LOG.log(Level.SEVERE, ex.getMessage());
            return "-1";
        }
    }

    /**
     * Возвращает детали по определенному логу
     * @param id лога
     * @return Список класса деталей лога TableDetail
     */
    public List<TableDetail> getDetail(int id) {
        Worker worker = new Worker();
        try {
            return worker.getDetail(id);
        } catch (IOException ex) {
            LOG.log(Level.SEVERE, ex.getMessage());
        }
        return null;
    }

    /**
     * Получает список пользователей задействованных в ведении логов
     * @return Список класса разработчиков TableUserList
     */
    public List<TableUserList> getUserList(){
        Worker worker = new Worker();
        try {
            return worker.getUserList();
        } catch (IOException ex) {
            LOG.log(Level.SEVERE, ex.getMessage());
        }
        return null;
    }

    /**
     * Получение текущей версии на бою
     * @return Список класса текущая версия TableCurrentVersion
     */
    public String getCurrentVersion(){
        Worker worker = new Worker();
        List<TableCurrentVersion> currentVersionList;
        try {
            currentVersionList = worker.getCurrentVersion();
            if(currentVersionList !=null ){
                return currentVersionList.get(0).getVersion();
            }
        } catch (IOException ex) {
            LOG.log(Level.SEVERE, ex.getMessage());
        }
        return "";
    }

    /**
     * Обновляет информацию по измененным объектам
     * @param request
     * @return Статус обновления
     */
    public String updateDetail(Request request){
        Worker worker = new Worker();
        try {
            String query="";

            if("0".equals(request.queryParams("id"))){
                int clid = Integer.parseInt(request.queryParams("clId"));
                if("name".equals(request.queryParams("type"))){
                    query = QuerysLoader.getQuery("insertDetailName");
                }
                if("desc".equals(request.queryParams("type"))){
                    query = QuerysLoader.getQuery("insertDetailDesc");
                }
                return String.valueOf(worker.insertDetail(clid, query, request.queryParams("content")));
            }else{
                if(!"".equals(request.queryParams("type"))){
                    if("name".equals(request.queryParams("type"))){
                        query = QuerysLoader.getQuery("updateDetailName");
                    }
                    if("desc".equals(request.queryParams("type"))){
                        query = QuerysLoader.getQuery("updateDetailDesc");
                    }
                }
                int id = Integer.parseInt(request.queryParams("id"));
                worker.updateDetail(id, query, request.queryParams("content"));
            }
            return "OK";
        } catch (IOException ex) {
            LOG.log(Level.SEVERE, ex.getMessage());
            return "-1";
        }
    }

    /**
     * Удаляет объект в зависимости от переданного типа
     * @param request
     * @return Статсус опирации
     */
    public String removeLog(Request request){
        Worker worker = new Worker();
        try {
            int id = Integer.parseInt(request.queryParams("id"));
            String query="";
            if(!"".equals(request.queryParams("type"))){
                if("detail".equals(request.queryParams("type"))){
                    query = QuerysLoader.getQuery("removeDetail");
                }
                if("log".equals(request.queryParams("type"))){
                    query = QuerysLoader.getQuery("removeLog");
                }
            }
            worker.removeObject(id, query);
            return "OK";
        } catch (NumberFormatException | IOException ex) {
            LOG.log(Level.SEVERE, ex.getMessage());
        }
        return "-1";
    }
}
