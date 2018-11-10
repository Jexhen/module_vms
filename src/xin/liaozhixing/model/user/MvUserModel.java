package xin.liaozhixing.model.user;

import java.util.Date;

public class MvUserModel {

    private Long mvusId;

    private String mvusName;

    private String mvusLoginName;

    private String mvusPassword;

    private String mvusGender;

    private String mvusMail;

    private String mvusMobile;

    private Long mvusOrganizationId;

    private String mogzName;

    private Long mvusRoleId;

    private String mvrlName;

    private Long mvusFamilyId;

    private String hostName;

    private Long creator;

    private Date createTime;

    private Long modifier;

    private Date modifyTime;

    public Long getMvusId() {
        return mvusId;
    }

    public void setMvusId(Long mvusId) {
        this.mvusId = mvusId;
    }

    public String getMvusName() {
        return mvusName;
    }

    public void setMvusName(String mvusName) {
        this.mvusName = mvusName;
    }

    public String getMvusLoginName() {
        return mvusLoginName;
    }

    public void setMvusLoginName(String mvusLoginName) {
        this.mvusLoginName = mvusLoginName;
    }

    public String getMvusPassword() {
        return mvusPassword;
    }

    public void setMvusPassword(String mvusPassword) {
        this.mvusPassword = mvusPassword;
    }

    public String getMvusGender() {
        return mvusGender;
    }

    public void setMvusGender(String mvusGender) {
        this.mvusGender = mvusGender;
    }

    public String getMvusMail() {
        return mvusMail;
    }

    public void setMvusMail(String mvusMail) {
        this.mvusMail = mvusMail;
    }

    public String getMvusMobile() {
        return mvusMobile;
    }

    public void setMvusMobile(String mvusMobile) {
        this.mvusMobile = mvusMobile;
    }

    public Long getMvusOrganizationId() {
        return mvusOrganizationId;
    }

    public void setMvusOrganizationId(Long mvusOrganizationId) {
        this.mvusOrganizationId = mvusOrganizationId;
    }

    public Long getMvusRoleId() {
        return mvusRoleId;
    }

    public void setMvusRoleId(Long mvusRoleId) {
        this.mvusRoleId = mvusRoleId;
    }

    public Long getMvusFamilyId() {
        return mvusFamilyId;
    }

    public void setMvusFamilyId(Long mvusFamilyId) {
        this.mvusFamilyId = mvusFamilyId;
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

    public String getMogzName() {
        return mogzName;
    }

    public void setMogzName(String mogzName) {
        this.mogzName = mogzName;
    }

    public String getMvrlName() {
        return mvrlName;
    }

    public void setMvrlName(String mvrlName) {
        this.mvrlName = mvrlName;
    }

    public String getHostName() {
        return hostName;
    }

    public void setHostName(String hostName) {
        this.hostName = hostName;
    }
}
