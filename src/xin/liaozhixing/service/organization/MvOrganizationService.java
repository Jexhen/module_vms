package xin.liaozhixing.service.organization;

import xin.liaozhixing.model.organization.MvOrganizationModel;

import java.util.List;

public interface MvOrganizationService {

    List<MvOrganizationModel> getOrganizations(Long id);

}
