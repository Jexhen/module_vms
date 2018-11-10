package xin.liaozhixing.model.organization;

import java.util.Date;

public class MvOrganizationModel {

    private Long mogzId;

    private String mogzName;

    private Long creator;

    private Date createTime;

    private Long modifier;

    private Date modifyTime;

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

    public Long getCreator() {
        return creator;
    }

    public void setCreator(Long creator) {
        this.creator = creator;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Long getModifier() {
        return modifier;
    }

    public void setModifier(Long modifier) {
        this.modifier = modifier;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }
}
