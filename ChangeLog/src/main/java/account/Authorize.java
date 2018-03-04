package account;

public class Authorize implements AutorizeService {
    @Override
    public int autorize(String username, String password) {
        UserValidateService userValidateService = new UserValidate();
        int userId = userValidateService.check(username, password);
        return userId;
    }
}
