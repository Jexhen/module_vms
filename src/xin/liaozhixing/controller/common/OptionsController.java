package xin.liaozhixing.controller.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import xin.liaozhixing.model.base.BaseOptionsResponse;
import xin.liaozhixing.model.base.OptionsModel;
import xin.liaozhixing.model.organization.MvOrganizationModel;
import xin.liaozhixing.service.organization.MvOrganizationService;
import xin.liaozhixing.utils.EmptyUtils;

import java.util.ArrayList;
import java.util.List;


@Controller
@RequestMapping("/common/options")
public class OptionsController {

    @Autowired
    private MvOrganizationService organizationService;

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

}
