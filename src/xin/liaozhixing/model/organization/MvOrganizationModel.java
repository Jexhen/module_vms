package xin.liaozhixing.model.organization;

public class MvOrganizationModel {

    private Long mogzId;

    private String mogzName;

    private String creator;

    private String createTime;

    private String modifier;

    private String modifyTime;

    public Long getMogzId() {
        return mogzId;
    }

    public void setMogzId(Long mogzId) {
        this.mogzId = mogzId;
    }

    public String getMogzName() {
        return mogzName;
    }

    public void setMogzName(String mogzName) {
        this.mogzName = mogzName;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getModifier() {
        return modifier;
    }

    public void setModifier(String modifier) {
        this.modifier = modifier;
    }

    public String getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(String modifyTime) {
        this.modifyTime = modifyTime;
    }
}
