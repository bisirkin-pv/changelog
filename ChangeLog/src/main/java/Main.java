import account.Authorize;
import spark.ModelAndView;
import view.Template;

import static spark.Spark.*;
import com.google.gson.Gson;

import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Main {
    private static final Logger LOG = Logger.getLogger(Main.class.getName());
    public static void main(String[] args) {
        exception(Exception.class, (e, req, res) -> e.printStackTrace());
        staticFiles.location("public");
        //4567
        port(8080);
        Template.setTemplate();

        Gson gson = new Gson();

        get("/", (req, res) -> Template.getTemplate().render(
                new ModelAndView(null, "base.ftl"))
        );

        enableCORS("*","GET,POST","Access-Control-Allow-Origin");
        
        post("/api/login",(request, response)-> {
            System.out.println(request.queryParams());
            Authorize authorize = new Authorize();
            boolean isAuth = authorize.autorize(request.queryParams("username") == null ? "" : request.queryParams("username")
                    ,request.queryParams("password") == null ? "" : request.queryParams("password"));
            //TODO: Доделать авторизацию
            String authCode = isAuth ? "200" : "403";
            LOG.log(Level.INFO, authCode);
            request.session().attribute("authCode", authCode);
            return authCode;
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
            boolean authenticated;
            authenticated = "200".equals(request.session().attribute("authCode"));
            if (!isApi && !authenticated && request.splat().length>0) {
                halt(401, "You are not welcome here");
            }
        });
    }
}
