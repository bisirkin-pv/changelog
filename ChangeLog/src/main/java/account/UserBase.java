package account;

import java.util.HashMap;
import java.util.Map;

public class UserBase {
    private static Map<String, User> users = new HashMap<>();
    private static volatile UserBase instance;

     public static UserBase getInstance() {
        UserBase localInstance = instance;
        if (localInstance == null) {
            synchronized (UserBase.class) {
                localInstance = instance;
                if (localInstance == null) {
                    instance = localInstance = new UserBase();
                }
            }
        }
        return localInstance;
    }

    private UserBase(){
         defaultInit();
    }

    private void defaultInit(){
        users.put ("admin", new User(-1
                    ,"admin"
                    ,"Administrator"
                    ,"admin"
                    ,"admin@admin.com")
        );
    }

    /**
     * Возвращает объект пользователя по его имени
     * @param username - имя пользователя
     * @return Объект класса User
     */
    public User getUser(String username){
        return users.get(username);
    }
}
