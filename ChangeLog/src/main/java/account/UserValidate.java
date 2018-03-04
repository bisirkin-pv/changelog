package account;

public class UserValidate implements UserValidateService {
    @Override
    public int check(String username, String password) {
        User user = UserBase.getInstance().getUser(username);
        if(user != null && password.equals(user.getPassword())){
            return user.getId();
        }
        return 0;
    }
}
