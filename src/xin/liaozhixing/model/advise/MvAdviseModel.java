package xin.liaozhixing.model.advise;

public class MvAdviseModel {

    private Long madvId;

    private String madvTitle;

    private String madvContent;

    private String madvStatus;

    private String madvToUserId;

    private String creator;

    private String createTime;

    private String modifier;

    private String modifyTime;

    public Long getMadvId() {
        return madvId;
    }

    public void setMadvId(Long madvId) {
        this.madvId = madvId;
    }

    public String getMadvTitle() {
        return madvTitle;
    }

    public void setMadvTitle(String madvTitle) {
        this.madvTitle = madvTitle;
    }

    public String getMadvContent() {
        return madvContent;
    }

    public void setMadvContent(String madvContent) {
        this.madvContent = madvContent;
    }

    public String getMadvStatus() {
        return madvStatus;
    }

    public void setMadvStatus(String madvStatus) {
        this.madvStatus = madvStatus;
    }

    public String getMadvToUserId() {
        return madvToUserId;
    }

    public void setMadvToUserId(String madvToUserId) {
        this.madvToUserId = madvToUserId;
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
