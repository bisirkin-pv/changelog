import account.Authorize;
import account.User;
import account.UserBase;
import account.UserOnline;
import changelog.ChangeLog;
import changelog.QuerysLoader;
import connect.Config;
import controller.UserController;
import setting.Setting;
import spark.ModelAndView;
import spark.Request;
import view.Template;

import static spark.Spark.*;
import com.google.gson.Gson;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Main {
    private static int goodLoad;
    private static final Logger LOG = Logger.getLogger(Main.class.getName());
    public static void main(String[] args) {
        exception(Exception.class, (e, req, res) -> e.printStackTrace());
        //staticFiles.location("public");
        //String workingDir = System.getProperty("user.dir") + "/ChangeLog/public";
        String workingDir = "public";
        externalStaticFileLocation(workingDir);

        //4567
        port(8080);
        Template.setTemplate();

        try {
            setting(); //ssl settings
        } catch (IOException ex) {
            LOG.log(Level.INFO, ex.getMessage());
        }

        Gson gson = new Gson();

        get("/", (req, res) -> Template.getTemplate().render(
            new ModelAndView(null, "login.ftl"))
        );

        get("/changelog/add", (req, res) -> {
            Map<String, Object> model = templatePrepare(req);
            model.put("current_page", "addlog");
            return Template.getTemplate().render(
                    new ModelAndView(model, "addlog.ftl")
            );
        });

        get("/changelog/show", (req, res) -> {
            Map<String, Object> model = templatePrepare(req);
            model.put("current_page", "showlog");
            return Template.getTemplate().render(
                    new ModelAndView(model, "showlog.ftl")
            );
        });

        enableCORS("*", "GET,POST", "Access-Control-Allow-Origin");

        post("/api/login", (request, response) -> UserController.login(request));

        /* add log page */
        post("/api/header", (request, response)->{
            ChangeLog changeLog = new ChangeLog();
            return changeLog.saveHeader(request);
        });

        post("/api/detail",(req, res)->{
            ChangeLog changeLog = new ChangeLog();
            return changeLog.saveDetail(req);
        });

        post("/api/version",(req, res)->{
            ChangeLog changeLog = new ChangeLog();
            return changeLog.getCurrentVersion();
        });

        post("/api/issue",(req, res)->{
            ChangeLog changeLog = new ChangeLog();
            if("".equals(req.queryParams("in_issue"))){
                return new Gson().toJson("");
            }
            int issue;
            try{
                issue = Integer.parseInt(req.queryParams("in_issue"));
            }catch(NumberFormatException ex){
                LOG.log(Level.SEVERE, ex.getMessage());
                return new Gson().toJson("");
            }
            return new Gson().toJson(changeLog.getIssueInfo(issue));
        });
        /* show log page */
        get("/api/header","application/json", (request, response) -> {
            ChangeLog cl = new ChangeLog();
            return new Gson().toJson(cl.getAllHeader());
        });
        post("/api/header/upd","application/json",(req, res)->{
            ChangeLog changeLog = new ChangeLog();
            return new Gson().toJson(changeLog.updateHeader(req));
        });
        get("/api/header/:id","application/json", (request, response) -> {
            ChangeLog cl = new ChangeLog();
            return new Gson().toJson(cl.getHeader(Integer.parseInt(request.params("id"))));
        });
        get("/api/detail/:id","application/json", (request, response) -> {
            ChangeLog cl = new ChangeLog();
            return new Gson().toJson(cl.getDetail(Integer.parseInt(request.params("id"))));
        });
        post("/api/detail/upd","application/json", (req, res)->{
            ChangeLog changeLog = new ChangeLog();
            return new Gson().toJson(changeLog.updateDetail(req));
        });
        post("/api/changelog/del","application/json", (req, res)->{
            ChangeLog changeLog = new ChangeLog();
            return new Gson().toJson(changeLog.removeLog(req));
        });
        post("/api/filter","application/json", (request, response) -> {
            ChangeLog cl = new ChangeLog();
            return new Gson().toJson(cl.getFilteredHeader(request));
        });
    }

    private static void enableCORS(final String origin, final String methods, final String headers) {

        options("/api/*", (request, response) -> {

            String accessControlRequestHeaders = request.headers("Access-Control-Request-Headers");
            if (accessControlRequestHeaders != null) {
                response.header("Access-Control-Allow-Headers", accessControlRequestHeaders);
            }

            String accessControlRequestMethod = request.headers("Access-Control-Request-Method");
            if (accessControlRequestMethod != null) {
                response.header("Access-Control-Allow-Methods", accessControlRequestMethod);
            }

            return "OK";
        });

        before("api/*", (request, response) -> {
            response.header("Access-Control-Allow-Origin", origin);
            response.header("Access-Control-Request-Method", methods);
            response.header("Access-Control-Allow-Headers", headers);
            // Note: this may or may not be necessary in your particular application
            response.type("application/json");
        });

        before("/*", (request, response) -> {
            String log = "connect ip:" + request.ip() + " >> " + request.requestMethod() + " - " + request.url();
            LOG.log(Level.INFO, log);
            boolean isApi = false;
            if(request.splat().length>0){
                String path = request.splat()[0];
                isApi = path.contains("api/");
            }
            boolean authenticated = false;
            if(UserOnline.getUser(request.session().id())!= null) {
                authenticated = true;
            }
            if (!isApi && !authenticated) {
                if(request.splat().length>0 && !"images".equals(request.splat()[0].split("/")[0])) {
                    //halt(401, "You are not welcome here");
                    response.redirect("/");
                }
            }
        });
    }

    private static Map<String, Object> templatePrepare(Request request){
        Map<String, Object> model = new HashMap<>();
        User user = UserOnline.getUser(request.session().id());
        System.out.println(request.session().attribute("authUser").toString());
        model.put("user_name", user != null ? user.getName() : "");
        model.put("user_login", user != null ?  user.getLogin() : "");
        model.put("users_online", "");
        return model;
    }

    private static void setting() throws IOException {
        Setting setting = new Setting();
        Config.load(Config.Type.PROD, setting.getProperties("config.db.prod.path"));
        Config.load(Config.Type.TEST, setting.getProperties("config.db.test.path"));
        goodLoad = QuerysLoader.load();
    }
}
