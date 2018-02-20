package account;

/**
 * Класс содержащий информацию о пользователе
 */
public class User {
    private final int id;
    private final String login;
    private final String name;
    private final String password;
    private final String email;

    public User(int id, String login, String name, String password, String email) {
        this.id = id;
        this.login = login;
        this.name = name;
        this.password = password;
        this.email = email;
    }

    public int getId() {
        return id;
    }

    public String getLogin() {
        return login;
    }

    public String getName() {
        return name;
    }

    public String getPassword() {
        return password;
    }

    public String getEmail() {
        return email;
    }
}
