package changelog.mapping;

/**
 * Класс информации по задаче
 * @author bisirkin_pv
 */
public class TableRedmainInfo {
    private int issueId;
    private String issueName;
    private String login;
    private String endDevelopmentDt;
    private String status;

    public int getIssueId() {
        return issueId;
    }

    public void setIssueId(int issueId) {
        this.issueId = issueId;
    }

    public String getIssueName() {
        return issueName;
    }

    public void setIssueName(String issueName) {
        this.issueName = issueName;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getEndDevelopmentDt() {
        return endDevelopmentDt;
    }

    public void setEndDevelopmentDt(String endDevelopmentDt) {
        this.endDevelopmentDt = endDevelopmentDt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
