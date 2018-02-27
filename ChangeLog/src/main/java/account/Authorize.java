package account;

public class Authorize implements AutorizeService {
    @Override
    public boolean autorize(String username, String password) {
        return "admin".equals(username) && "admin".equals(password);
    }
}
