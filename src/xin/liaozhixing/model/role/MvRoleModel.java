package xin.liaozhixing.model.role;


public class MvRoleModel {

    // 主键
    private Long mvrlId;
    // 角色名称
    private String mvrlName;

    private String creator;

    private String createTime;

    private String modifier;

    private String modifyTime;

    public Long getMvrlId() {
        return mvrlId;
    }

    public void setMvrlId(Long mvrlId) {
        this.mvrlId = mvrlId;
    }

    public String getMvrlName() {
        return mvrlName;
    }

    public void setMvrlName(String mvrlName) {
        this.mvrlName = mvrlName;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getModifier() {
        return modifier;
    }

    public void setModifier(String modifier) {
        this.modifier = modifier;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(String modifyTime) {
        this.modifyTime = modifyTime;
    }
}
