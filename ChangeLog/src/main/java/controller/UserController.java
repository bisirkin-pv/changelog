package controller;

import account.AuthMessage;
import account.Authorize;
import account.UserBase;
import account.UserOnline;
import com.google.gson.Gson;
import spark.Request;

import java.util.logging.Level;
import java.util.logging.Logger;

public class UserController {
    private static final Logger LOG = Logger.getLogger(UserController.class.getName());

    public static String login(Request request){
        Authorize authorize = new Authorize();
        String username = request.queryParams("username") == null ? "" : request.queryParams("username");
        int userId = authorize.autorize(username
                ,request.queryParams("password") == null ? "" : request.queryParams("password"));
        AuthMessage authMessage = null;
        if(userId!=0){
            UserOnline.putUser(request.session().id(), UserBase.getInstance().getUser(username));
            request.session().attribute("authUser", userId);
            authMessage = new AuthMessage("200", "Access");
            String msg = "auth user:" + String.valueOf(userId);
            LOG.log(Level.INFO, msg);
        }
        else{
            authMessage = new AuthMessage("401", "Неверное имя пользователя или пароль");
        }
        Gson gson = new Gson();
        return gson.toJson (authMessage);
    }
}
