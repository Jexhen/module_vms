package xin.liaozhixing.model.advise;

public class MvAdviseResponseModel {

    private Long mvarId;

    private String madvContent;

    private String mvarContent;

    private Long mvarAdivseId;

    private String creator;

    private String createTime;

    private String modifier;

    private String modifyTime;

    public Long getMvarId() {
        return mvarId;
    }

    public void setMvarId(Long mvarId) {
        this.mvarId = mvarId;
    }

    public String getMvarContent() {
        return mvarContent;
    }

    public void setMvarContent(String mvarContent) {
        this.mvarContent = mvarContent;
    }

    public Long getMvarAdivseId() {
        return mvarAdivseId;
    }

    public void setMvarAdivseId(Long mvarAdivseId) {
        this.mvarAdivseId = mvarAdivseId;
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

    public String getMadvContent() {
        return madvContent;
    }

    public void setMadvContent(String madvContent) {
        this.madvContent = madvContent;
    }
}
