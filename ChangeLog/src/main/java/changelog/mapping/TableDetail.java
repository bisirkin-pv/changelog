package changelog.mapping;


/**
 * Класс соответствует таблицы по измененным объектам
 * @author bisirkin_pv
 */
public class TableDetail {

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public boolean isChangeType() {
        return changeType;
    }

    public void setChangeType(boolean changeType) {
        this.changeType = changeType;
    }

    public String getObjName() {
        return objName;
    }

    public void setObjName(String objName) {
        this.objName = objName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    private int id;
    private boolean changeType;
    private String objName;
    private String description;
}
