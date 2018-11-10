package xin.liaozhixing.model.title;

import java.util.Date;

public class MvTitleModel {

    private Long mvttId;

    private String mvttName;

    private String mvttUrl;

    private String mvttParentId;

    private Long creator;

    private Date createTime;

    private Long modifier;

    private Date modifyTime;

    public Long getMvttId() {
        return mvttId;
    }

    public void setMvttId(Long mvttId) {
        this.mvttId = mvttId;
    }

    public String getMvttName() {
        return mvttName;
    }

    public void setMvttName(String mvttName) {
        this.mvttName = mvttName;
    }

    public String getMvttUrl() {
        return mvttUrl;
    }

    public void setMvttUrl(String mvttUrl) {
        this.mvttUrl = mvttUrl;
    }

    public String getMvttParentId() {
        return mvttParentId;
    }

    public void setMvttParentId(String mvttParentId) {
        this.mvttParentId = mvttParentId;
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
