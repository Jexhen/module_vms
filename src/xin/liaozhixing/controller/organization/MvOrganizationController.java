package xin.liaozhixing.controller.organization;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import xin.liaozhixing.model.base.BaseResponse;
import xin.liaozhixing.model.base.BaseTableResponse;
import xin.liaozhixing.model.organization.MvOrganizationModel;
import xin.liaozhixing.model.user.MvUserModel;
import xin.liaozhixing.service.organization.MvOrganizationService;
import xin.liaozhixing.utils.EmptyUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.List;

@Controller
@RequestMapping("organization")
public class MvOrganizationController {

    @Autowired
    private MvOrganizationService service;

    @RequestMapping("/getOrganization")
    public @ResponseBody BaseTableResponse getOrganization(MvOrganizationModel model, Long page, Long limit) {
        BaseTableResponse response = new BaseTableResponse();
        if (null!=model && EmptyUtils.isNotEmpty(model.getMogzName())) {
            // layui默认以get方式提交请求，中文会出现乱码问题，此处如果有组织名称，则对名称重新编码
            try {
                String decodeMogzName = new String(model.getMogzName().getBytes("ISO-8859-1"),"UTF-8");
                model.setMogzName(decodeMogzName);
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        List<MvOrganizationModel> existOrganization = service.getOrganizationByExample(model,page,limit);
        response.setCode(0);// 成功
        response.setMsg("");
        response.setData(existOrganization);
        response.setCount(service.getOrganizationCountByExample(model).intValue());
        return response;
    }

    @RequestMapping("/modifyOrganization")
    public @ResponseBody BaseResponse modifyOrganization(MvOrganizationModel model, HttpServletRequest request) {
        BaseResponse response = new BaseResponse();
        if (model.getMogzId() == null) {
            response.setSuccess(false);
            response.setMessage("ID不能为空");
        } else {
            MvOrganizationModel example = new MvOrganizationModel();
            example.setMogzName(model.getMogzName());
            List<MvOrganizationModel> existModels = service.getOrganizationByExample(example, null, null);
            if (EmptyUtils.isNotEmpty(existModels)) {
                response.setSuccess(false);
                response.setMessage("该组织名称已存在，组织名称不能重复!");
            } else {
                MvUserModel loginUser = (MvUserModel) request.getSession().getAttribute("loginUser");
                model.setModifier(loginUser.getMvusId().toString());
                service.modifyOrganization(model);
                response.setSuccess(true);
                response.setMessage("修改成功！");
            }
        }
        return response;
    }

    @RequestMapping("/addOrganization")
    public @ResponseBody BaseResponse addOrganization(MvOrganizationModel model, HttpServletRequest request) {
        BaseResponse response = new BaseResponse();
        if (model==null || EmptyUtils.isEmpty(model.getMogzName())) {
            response.setSuccess(false);
            response.setMessage("组织名称不能为空");
        } else {
            MvOrganizationModel example = new MvOrganizationModel();
            example.setMogzName(model.getMogzName());
            List<MvOrganizationModel> existModels = service.getOrganizationByExample(example, null, null);
            if (EmptyUtils.isNotEmpty(existModels)) {
                response.setSuccess(false);
                response.setMessage("该组织名称已存在，组织名称不能重复!");
            } else {
                MvUserModel loginUser = (MvUserModel) request.getSession().getAttribute("loginUser");
                model.setCreator(loginUser.getMvusId().toString());
                model.setModifier(loginUser.getMvusId().toString());
                service.addOrganization(model);
                response.setSuccess(true);
                response.setMessage("新增成功！");
            }
        }
        return response;
    }

    @RequestMapping("/removeOrganization")
    public @ResponseBody BaseResponse removeOrganization(@RequestParam(value = "ids[]") Long[] ids) {
        BaseResponse response = new BaseResponse();
        if (ids==null || ids.length<=0) {
            response.setSuccess(false);
            response.setMessage("组织ID不能为空");
        } else {
            service.removeOrganization(ids);
            response.setSuccess(true);
            response.setMessage("删除成功！");
        }
        return response;
    }
}
