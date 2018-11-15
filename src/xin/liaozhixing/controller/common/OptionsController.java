package xin.liaozhixing.controller.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import sun.invoke.empty.Empty;
import xin.liaozhixing.model.base.BaseOptionsResponse;
import xin.liaozhixing.model.base.OptionsModel;
import xin.liaozhixing.model.organization.MvOrganizationModel;
import xin.liaozhixing.model.role.MvRoleModel;
import xin.liaozhixing.service.organization.MvOrganizationService;
import xin.liaozhixing.service.role.MvRoleService;
import xin.liaozhixing.service.role.impl.MvRoleServiceImpl;
import xin.liaozhixing.utils.EmptyUtils;

import java.util.ArrayList;
import java.util.List;


@Controller
@RequestMapping("/common/options")
public class OptionsController {

    @Autowired
    private MvOrganizationService organizationService;
    @Autowired
    private MvRoleService roleService;

    @RequestMapping("/getOrganizationOption")
    public @ResponseBody BaseOptionsResponse getOrganizationOption() {
        BaseOptionsResponse response = new BaseOptionsResponse();
        List<MvOrganizationModel> existOrganizations = organizationService.getOrganizationByExample(new MvOrganizationModel());
        List<OptionsModel> options = new ArrayList<>();
        if (EmptyUtils.isNotEmpty(existOrganizations)) {
            for (MvOrganizationModel organization : existOrganizations) {
                OptionsModel option = new OptionsModel();
                option.setKey(organization.getMogzId());
                option.setValue(organization.getMogzName());
                options.add(option);
            }
        }
        response.setOptions(options);
        return response;
    }

    @RequestMapping("/getRoleOption")
    public @ResponseBody BaseOptionsResponse getRoleOption() {
        BaseOptionsResponse response = new BaseOptionsResponse();
        List<MvRoleModel> existRoles = roleService.getRoles(new MvRoleModel());
        List<OptionsModel> options = new ArrayList<>();
        if(EmptyUtils.isNotEmpty(existRoles)) {
            for (MvRoleModel role : existRoles) {
                OptionsModel option = new OptionsModel();
                option.setKey(role.getMvrlId());
                option.setValue(role.getMvrlName());
                options.add(option);
            }
        }
        response.setOptions(options);
        return response;
    }

}
