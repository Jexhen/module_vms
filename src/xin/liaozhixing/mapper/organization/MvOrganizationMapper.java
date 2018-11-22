package xin.liaozhixing.mapper.organization;

import org.apache.ibatis.annotations.Param;
import xin.liaozhixing.model.organization.MvOrganizationModel;

import java.util.List;

public interface MvOrganizationMapper {

    /**
     * 查询组织
     * @param example
     * @param firstIndex
     * @param pageSize
     * @return
     */
    List<MvOrganizationModel> getOrganizationByExample(@Param(value = "example") MvOrganizationModel example, @Param("firstIndex") Long firstIndex, @Param("pageSize") Long pageSize);

    /**
     * 查询个数
     * @param example
     * @return
     */
    Long getOrganizationCountByExample(@Param(value = "example") MvOrganizationModel example);

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
     * @param ids
     */
    void removeOrganization(@Param(value = "ids")Long[] ids);
}
