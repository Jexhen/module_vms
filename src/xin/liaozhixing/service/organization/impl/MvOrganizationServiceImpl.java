package xin.liaozhixing.service.organization.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import xin.liaozhixing.mapper.organization.MvOrganizationMapper;
import xin.liaozhixing.model.organization.MvOrganizationModel;
import xin.liaozhixing.service.organization.MvOrganizationService;

import java.util.List;

@Service
public class MvOrganizationServiceImpl implements MvOrganizationService {

    @Autowired
    private MvOrganizationMapper mapper;

    @Override
    public List<MvOrganizationModel> getOrganizationByExample(MvOrganizationModel example) {
        return mapper.getOrganizationByExample(example);
    }

    @Override
    public void modifyOrganization(MvOrganizationModel model) {
        mapper.modifyOrganization(model);
    }

    @Override
    public void addOrganization(MvOrganizationModel model) {
        mapper.addOrganization(model);
    }

    @Override
    public void removeOrganization(Long[] ids) {
        mapper.removeOrganization(ids);
    }

}
