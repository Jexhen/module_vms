package xin.liaozhixing.model.certification;

import java.util.Date;

public class MvCertificationModel {

    private Long mctfId;

    private String mctfName;

    private String mctfStatus;

    private String mctfCertificationTypeId;

    private String mctfAttachmentName;

    private String mctfAttachmentUrl;

    private String mctfRejectReason;

    private Date mctfPickUpTime;

    private Long auditor;

    private String creator;

    private String createTime;

    private String modifier;

    private String modifyTime;

    private String organizationName;

    public Long getMctfId() {
        return mctfId;
    }

    public void setMctfId(Long mctfId) {
        this.mctfId = mctfId;
    }

    public String getMctfName() {
        return mctfName;
    }

    public void setMctfName(String mctfName) {
        this.mctfName = mctfName;
    }

    public String getMctfStatus() {
        return mctfStatus;
    }

    public void setMctfStatus(String mctfStatus) {
        this.mctfStatus = mctfStatus;
    }

    public String getMctfCertificationTypeId() {
        return mctfCertificationTypeId;
    }

    public void setMctfCertificationTypeId(String mctfCertificationTypeId) {
        this.mctfCertificationTypeId = mctfCertificationTypeId;
    }

    public String getMctfAttachmentName() {
        return mctfAttachmentName;
    }

    public void setMctfAttachmentName(String mctfAttachmentName) {
        this.mctfAttachmentName = mctfAttachmentName;
    }

    public String getMctfAttachmentUrl() {
        return mctfAttachmentUrl;
    }

    public void setMctfAttachmentUrl(String mctfAttachmentUrl) {
        this.mctfAttachmentUrl = mctfAttachmentUrl;
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

    public String getMctfRejectReason() {
        return mctfRejectReason;
    }

    public void setMctfRejectReason(String mctfRejectReason) {
        this.mctfRejectReason = mctfRejectReason;
    }

    public Date getMctfPickUpTime() {
        return mctfPickUpTime;
    }

    public void setMctfPickUpTime(Date mctfPickUpTime) {
        this.mctfPickUpTime = mctfPickUpTime;
    }

    public Long getAuditor() {
        return auditor;
    }

    public void setAuditor(Long auditor) {
        this.auditor = auditor;
    }

    public String getOrganizationName() {
        return organizationName;
    }

    public void setOrganizationName(String organizationName) {
        this.organizationName = organizationName;
    }
}
