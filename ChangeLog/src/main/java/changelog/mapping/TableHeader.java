package changelog.mapping;


/**
 * Класс соответствует таблице с шапой лога.
 * author bisirkin_pv
 */
public class TableHeader {
    private int id;
    private String version;
    private String dt;
    private int issue;
    private String issueUrl;
    private String description;
    private String comment;
    private String developer;
    private int svnCopyTo;
    private int svnCommit;
    private Boolean isDev;
    private String fio;
    private String crossIssue;

    public String getComment() {
        return comment;
    }

    public Boolean getIsDev() {
        return isDev;
    }

    public String getCrossIssue() {
        return crossIssue;
    }

    public void setCrossIssue(String crossIssue) {
        this.crossIssue = crossIssue;
    }


    public String getFio() {
        return fio;
    }

    public void setFio(String fio) {
        this.fio = fio;
    }

    public void setIsDev(Boolean isDev) {
        this.isDev = isDev;
    }



    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getDt() {
        return dt;
    }

    public void setDt(String dt) {
        this.dt = dt;
    }

    public int getIssue() {
        return issue;
    }

    public void setIssue(int issue) {
        this.issue = issue;
    }

    public String getIssueUrl() {
        return issueUrl;
    }

    public void setIssueUrl(String issueUrl) {
        this.issueUrl = issueUrl;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDeveloper() {
        return developer;
    }

    public void setDeveloper(String developer) {
        this.developer = developer;
    }

    public int getSvnCopyTo() {
        return svnCopyTo;
    }

    public void setSvnCopyTo(int svnCopyTo) {
        this.svnCopyTo = svnCopyTo;
    }

    public int getSvnCommit() {
        return svnCommit;
    }

    public void setSvnCommit(int svnCommit) {
        this.svnCommit = svnCommit;
    }

}
