package xin.liaozhixing.mapper.organization;

import org.apache.ibatis.annotations.Param;
import xin.liaozhixing.model.organization.MvOrganizationModel;

import java.util.List;

public interface MvOrganizationMapper {

    /**
     * 查询组织
     * @param example 查询条件
     * @return
     */
    List<MvOrganizationModel> getOrganizationByExample(@Param(value = "example") MvOrganizationModel example);

    /**
     * 修改组织
     * @param model
     */
    void modifyOrganization(@Param(value = "model") MvOrganizationModel model);

    /**
     * 新增组织
     * @param model
     */
    void addOrganization(@Param(value = "model") MvOrganizationModel model);

    /**
     * 删除组织
     * @param model
     */
    void removeOrganization(@Param(value = "ids")Long[] ids);
}
