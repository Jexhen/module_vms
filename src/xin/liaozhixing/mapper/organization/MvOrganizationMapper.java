package xin.liaozhixing.mapper.organization;

import xin.liaozhixing.model.organization.MvOrganizationModel;

import java.util.List;

public interface MvOrganizationMapper {

    List<MvOrganizationModel> getOrganizations(Long id);

}
