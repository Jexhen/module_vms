package xin.liaozhixing.service.organization;

import xin.liaozhixing.model.organization.MvOrganizationModel;

import java.util.List;

public interface MvOrganizationService {

    /**
     * 查询组织
     * @param example 查询条件
     * @return
     */
    List<MvOrganizationModel> getOrganizationByExample(MvOrganizationModel example);

    void modifyOrganization(MvOrganizationModel model);

    void addOrganization(MvOrganizationModel model);

    void removeOrganization(Long[] ids);
}
