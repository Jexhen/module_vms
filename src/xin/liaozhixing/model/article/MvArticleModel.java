package xin.liaozhixing.model.article;

public class MvArticleModel {

    private Long matcId;

    private String matcTitle;

    private String matcContent;

    private String matcType;

    private String matcOrganizationId;

    private String creator;

    private String createTime;

    private String modifier;

    private String modifyTime;

    public Long getMatcId() {
        return matcId;
    }

    public void setMatcId(Long matcId) {
        this.matcId = matcId;
    }

    public String getMatcTitle() {
        return matcTitle;
    }

    public void setMatcTitle(String matcTitle) {
        this.matcTitle = matcTitle;
    }

    public String getMatcContent() {
        return matcContent;
    }

    public void setMatcContent(String matcContent) {
        this.matcContent = matcContent;
    }

    public String getMatcType() {
        return matcType;
    }

    public void setMatcType(String matcType) {
        this.matcType = matcType;
    }

    public String getMatcOrganizationId() {
        return matcOrganizationId;
    }

    public void setMatcOrganizationId(String matcOrganizationId) {
        this.matcOrganizationId = matcOrganizationId;
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
