package account;

public class AuthMessage {
    private final String code;
    private final String msg;

    public AuthMessage(String code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public String getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }
}
