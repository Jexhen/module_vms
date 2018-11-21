package xin.liaozhixing.model.certification;

public class MvCertificationTypeModel {

    private Long mvctId;

    private String mvctName;

    private String mvctDesc;

    private String mvctAuditor;

    private Long organizationId;// 证明对接人所在组织

    private Long mvctIsNeedAttachment;

    private String creator;

    private String createTime;

    private String modifier;

    private String modifyTime;

    public Long getMvctId() {
        return mvctId;
    }

    public void setMvctId(Long mvctId) {
        this.mvctId = mvctId;
    }

    public String getMvctName() {
        return mvctName;
    }

    public void setMvctName(String mvctName) {
        this.mvctName = mvctName;
    }

    public String getMvctDesc() {
        return mvctDesc;
    }

    public void setMvctDesc(String mvctDesc) {
        this.mvctDesc = mvctDesc;
    }

    public String getMvctAuditor() {
        return mvctAuditor;
    }

    public void setMvctAuditor(String mvctAuditor) {
        this.mvctAuditor = mvctAuditor;
    }

    public Long getMvctIsNeedAttachment() {
        return mvctIsNeedAttachment;
    }

    public void setMvctIsNeedAttachment(Long mvctIsNeedAttachment) {
        this.mvctIsNeedAttachment = mvctIsNeedAttachment;
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

    public Long getOrganizationId() {
        return organizationId;
    }

    public void setOrganizationId(Long organizationId) {
        this.organizationId = organizationId;
    }
}
