package xin.liaozhixing.controller.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import xin.liaozhixing.model.base.BaseOptionsResponse;
import xin.liaozhixing.model.base.OptionsModel;
import xin.liaozhixing.model.certification.MvCertificationTypeModel;
import xin.liaozhixing.model.organization.MvOrganizationModel;
import xin.liaozhixing.model.role.MvRoleModel;
import xin.liaozhixing.model.user.MvUserModel;
import xin.liaozhixing.service.certification.MvCertificationService;
import xin.liaozhixing.service.organization.MvOrganizationService;
import xin.liaozhixing.service.role.MvRoleService;
import xin.liaozhixing.service.user.MvUserService;
import xin.liaozhixing.utils.EmptyUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;


@Controller
@RequestMapping("/common/options")
public class OptionsController {

    @Autowired
    private MvOrganizationService organizationService;
    @Autowired
    private MvRoleService roleService;
    @Autowired
    private MvUserService userService;
    @Autowired
    private MvCertificationService certificationService;

    /**
     * 获取组织下拉框
     * @return
     */
    @RequestMapping("/getOrganizationOption")
    public @ResponseBody BaseOptionsResponse getOrganizationOption() {
        BaseOptionsResponse response = new BaseOptionsResponse();
        List<MvOrganizationModel> existOrganizations = organizationService.getOrganizationByExample(new MvOrganizationModel(), null, null);
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

    /**
     * 获取角色下拉框
     * @return
     */
    @RequestMapping("/getRoleOption")
    public @ResponseBody BaseOptionsResponse getRoleOption() {
        BaseOptionsResponse response = new BaseOptionsResponse();
        List<MvRoleModel> existRoles = roleService.getRoles(new MvRoleModel(),null,null);
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

    /**
     * 获取意见回复人下拉框
     * @param request
     * @return
     */
    @RequestMapping("/getAnswererOption")
    public @ResponseBody BaseOptionsResponse getAnswererOption(HttpServletRequest request) {
        BaseOptionsResponse response = new BaseOptionsResponse();
        MvUserModel loginUser = (MvUserModel) request.getSession().getAttribute("loginUser");
        List<MvUserModel> answerer = userService.getAnswerer(loginUser);
        List<OptionsModel> options = new ArrayList<>();
        if(EmptyUtils.isNotEmpty(answerer)) {
            for (MvUserModel user : answerer) {
                OptionsModel option = new OptionsModel();
                option.setKey(user.getMvusId());
                option.setValue(user.getMvusName());
                options.add(option);
            }
        }
        response.setOptions(options);
        return response;
    }

    /**
     * 获取证明类型
     * @param request
     * @return
     */
    @RequestMapping("/getCertificationTypeOption")
    public @ResponseBody BaseOptionsResponse getCertificationTypeOption(HttpServletRequest request) {
        BaseOptionsResponse response = new BaseOptionsResponse();
        MvUserModel loginUser = (MvUserModel) request.getSession().getAttribute("loginUser");
        MvCertificationTypeModel example = new MvCertificationTypeModel();
        example.setOrganizationId(loginUser.getMvusOrganizationId());
        List<MvCertificationTypeModel> certificationTypes = certificationService.getCertificationTypeByExample(example);
        List<OptionsModel> options = new ArrayList<>();
        if(EmptyUtils.isNotEmpty(certificationTypes)) {
            for (MvCertificationTypeModel certificationType : certificationTypes) {
                OptionsModel option = new OptionsModel();
                option.setKey(certificationType.getMvctId());
                option.setValue(certificationType.getMvctName());
                options.add(option);
            }
        }
        response.setOptions(options);
        return response;
    }
}
