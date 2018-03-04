package account;

import java.util.HashMap;
import java.util.Map;

public class UserOnline {
    private static Map<Object, User> onlineUsers = new HashMap<>();

    public synchronized static User getUser(Object sessionId){
        return onlineUsers.get(sessionId);
    }

    public synchronized static void putUser(Object sessionId, User user){
        onlineUsers.put(sessionId, user);
    }

    public synchronized static int size(){
        return onlineUsers.size();
    }
}
