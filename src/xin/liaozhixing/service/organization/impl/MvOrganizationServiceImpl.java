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
    public List<MvOrganizationModel> getOrganizationByExample(MvOrganizationModel example, Long page, Long limit) {
        List<MvOrganizationModel> list;
        if (page==null) {
            list = mapper.getOrganizationByExample(example,null, null);
        } else {
            list = mapper.getOrganizationByExample(example,(page-1)* limit, limit);
        }
        return list;
    }

    @Override
    public Long getOrganizationCountByExample(MvOrganizationModel example) {
        return mapper.getOrganizationCountByExample(example);
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
