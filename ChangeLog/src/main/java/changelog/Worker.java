package changelog;


import changelog.mapping.*;
import connect.Config;
import connect.ConnectionProducer;
import connect.ConnectionProducerFactory;
import org.sql2o.Connection;
import spark.Request;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Класс выполняющий запросы к БД
 * @author bisirkin_pv
 */
public class Worker {
    private static final Logger LOG = Logger.getLogger(Worker.class.getName());

    public List<TableHeader> getAllHeader() throws IOException{
        String sql = QuerysLoader.getQuery("getAllHeader");
        ConnectionProducer myDao = ConnectionProducerFactory.create(Config.Type.PROD);
        try(Connection con = myDao.produceSql2o().open()) {
            return con.createQuery(sql).executeAndFetch(TableHeader.class);
        }
    }

    public int insertHeader(Request req) throws IOException {
        int queryId;
        final String insertQuery = QuerysLoader.getQuery("insertHeader");
        ConnectionProducer myDao = ConnectionProducerFactory.create(Config.Type.PROD);
        try (Connection con = myDao.produceSql2o().beginTransaction()) {
            String isDev = req.queryParams("in_chk_dev");
            isDev = isDev == null ? "0" : isDev;
            queryId = con.createQuery(insertQuery)
                    .addParameter("version",    req.queryParams("in_version"))
                    .addParameter("dt",         req.queryParams("in_date"))
                    .addParameter("issue",      req.queryParams("in_issue"))
                    .addParameter("issueUrl",   req.queryParams("in_url"))
                    .addParameter("description",req.queryParams("in_descr"))
                    .addParameter("comment",    req.queryParams("in_comment"))
                    .addParameter("developer",  req.queryParams("in_developer"))
                    .addParameter("svnCopyTo",  req.queryParams("in_copy_to"))
                    .addParameter("svnCommit",  req.queryParams("in_commit"))
                    .addParameter("isDev",      isDev)
                    .executeUpdate().getKey(Integer.class);
            con.commit();
        }
        return queryId;
    }

    public void updHeader(Request req) throws IOException {
        final String query = QuerysLoader.getQuery("updHeader");
        ConnectionProducer myDao = ConnectionProducerFactory.create(Config.Type.PROD);
        try (Connection con = myDao.produceSql2o().beginTransaction()) {
            String isDev = req.queryParams("in_chk_dev");
            isDev = isDev == null ? "0" : isDev;
            con.createQuery(query)
                    .addParameter("version", req.queryParams("in_version"))
                    .addParameter("dt", req.queryParams("in_date"))
                    .addParameter("issue", req.queryParams("in_issue"))
                    .addParameter("issueUrl", req.queryParams("in_url"))
                    .addParameter("description", req.queryParams("in_descr"))
                    .addParameter("comment", req.queryParams("in_comment"))
                    .addParameter("developer", req.queryParams("in_developer"))
                    .addParameter("svnCopyTo", req.queryParams("in_copy_to"))
                    .addParameter("svnCommit", req.queryParams("in_commit"))
                    .addParameter("isDev", isDev)
                    .addParameter("id", req.queryParams("in_id"))
                    .executeUpdate();
            con.commit();
        }
    }

    public List<TableHeader> getHeader(int id) throws IOException{
        String sql = QuerysLoader.getQuery("getHeader");
        ConnectionProducer myDao = ConnectionProducerFactory.create(Config.Type.PROD);
        try(Connection con = myDao.produceSql2o().open()) {
            return con.createQuery(sql)
                    .addParameter("id", id)
                    .executeAndFetch(TableHeader.class);
        }
    }

    public int insertDetail(Request req) throws IOException {
        int queryId;
        final String insertQuery = QuerysLoader.getQuery("insertDetail");
        ConnectionProducer myDao = ConnectionProducerFactory.create(Config.Type.PROD);
        try (Connection con = myDao.produceSql2o().beginTransaction()) {
            queryId = con.createQuery(insertQuery)
                    .addParameter("clid", req.queryParams("in_log_id"))
                    .addParameter("objName", req.queryParams("in_object"))
                    .addParameter("description", req.queryParams("in_obj_desc"))
                    .executeUpdate().getKey(Integer.class);
            con.commit();
        }
        return queryId;
    }

    public List<TableDetail> getDetail(int id) throws IOException{
        String sql = QuerysLoader.getQuery("getDetail");
        ConnectionProducer myDao = ConnectionProducerFactory.create(Config.Type.PROD);
        try(Connection con = myDao.produceSql2o().open()) {
            return con.createQuery(sql)
                    .addParameter("id", id)
                    .executeAndFetch(TableDetail.class);
        }
    }

    public List<TableUserList> getUserList() throws IOException{
        String sql = QuerysLoader.getQuery("getUserList");
        ConnectionProducer myDao = ConnectionProducerFactory.create(Config.Type.PROD);
        try(Connection con = myDao.produceSql2o().open()) {
            return con.createQuery(sql).executeAndFetch(TableUserList.class);
        }
    }

    public List<TableFilteredHeader> getFilteredHeader(Request req) throws IOException{
        String sql = QuerysLoader.getQuery("getFilteredHeader");
        String version = "".equals(req.queryParams("in_find_version")) ? "" : req.queryParams("in_find_version");
        String issue = "".equals(req.queryParams("in_find_issue")) ? "-1" : req.queryParams("in_find_issue");
        String objectName = "".equals(req.queryParams("in_find_object")) ? "" : req.queryParams("in_find_object");
        String versionType = "".equals(req.queryParams("rb-version")) ? "" : req.queryParams("rb-version");
        String issueType = "".equals(req.queryParams("rb-issue")) ? "" : req.queryParams("rb-issue");
        String objectNameType = "".equals(req.queryParams("rb-object-name")) ? "" : req.queryParams("rb-object-name");
        ConnectionProducer myDao = ConnectionProducerFactory.create(Config.Type.TEST);
        try(Connection con = myDao.produceSql2o().open()) {
            return con.createQuery(sql)
                    .addParameter("version", version)
                    .addParameter("issue", issue)
                    .addParameter("objectName", objectName)
                    .addParameter("versionType", versionType)
                    .addParameter("issueType", issueType)
                    .addParameter("objectNameType", objectNameType)
                    .executeAndFetch(TableFilteredHeader.class);
        }
    }

    public List<TableCurrentVersion> getCurrentVersion() throws IOException{
        String sql = QuerysLoader.getQuery("getCurrentVersion");
        ConnectionProducer myDao = ConnectionProducerFactory.create(Config.Type.PROD);
        try(Connection con = myDao.produceSql2o().open()) {
            return con.createQuery(sql).executeAndFetch(TableCurrentVersion.class);
        }
    }

    public void updateDetail(int id, String query, String content) throws IOException {
        ConnectionProducer myDao = ConnectionProducerFactory.create(Config.Type.PROD);
        try (Connection con = myDao.produceSql2o().beginTransaction()) {
            con.createQuery(query)
                    .addParameter("content", content)
                    .addParameter("id", id)
                    .executeUpdate();
            con.commit();
        }
        LOG.log(Level.INFO, "Update detailed object");
    }

    public int insertDetail(int clid, String query, String content) throws IOException {
        int queryId = 0;
        ConnectionProducer myDao = ConnectionProducerFactory.create(Config.Type.PROD);
        try (Connection con = myDao.produceSql2o().beginTransaction()) {
            queryId = con.createQuery(query)
                    .addParameter("content", content)
                    .addParameter("clid", clid)
                    .executeUpdate().getKey(Integer.class);
            con.commit();
        }
        LOG.log(Level.INFO, "insert detailed object");
        return queryId;
    }

    public void removeObject(int id, String query) throws IOException{
        ConnectionProducer myDao = ConnectionProducerFactory.create(Config.Type.PROD);
        try (Connection con = myDao.produceSql2o().beginTransaction()) {
            con.createQuery(query)
                    .addParameter("id", id)
                    .executeUpdate();
            con.commit();
        }
        LOG.log(Level.INFO, "Delete detailed object");
    }

}

