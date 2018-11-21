package xin.liaozhixing.controller.title;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import xin.liaozhixing.model.base.BaseResponse;
import xin.liaozhixing.model.title.MvTitleModel;
import xin.liaozhixing.model.user.MvUserModel;
import xin.liaozhixing.service.title.MvTitleService;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/title")
public class MvTitleController {

    @Autowired
    private MvTitleService titleService;


    /**
     * 根据角色查询功能
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/getTitle")
    public String getTitle(Model model, HttpServletRequest request) {
        String path = "/home";
        Long roleId = null;
        MvUserModel loginUser = (MvUserModel) request.getSession().getAttribute("loginUser");
        if (loginUser != null) {
            roleId = loginUser.getMvusRoleId();
            // 获取父标题
            List<MvTitleModel> parantTitle =  titleService.getTitleOfRole(roleId, "1");
            // 获取子标题
            List<MvTitleModel> childTitle = titleService.getTitleOfRole(roleId, "0");
            model.addAttribute("parentTitle", parantTitle);
            model.addAttribute("childTitle", childTitle);
        } else {
            model.addAttribute("errorMsg", "登陆失败");
            path = "/login";
        }
        return path;
    }

    /**
     * 查询所有功能，供分配权限调用
     * @return
     */
    @RequestMapping("/getAllTitle")
    public @ResponseBody  BaseResponse getAllTitle() {
        BaseResponse response = new BaseResponse();
        // 利用超级管理员拿到所有功能，供分配权限调用
        Long adminRoleId = 1L;
        // 获取父标题
        List<MvTitleModel> parantTitle =  titleService.getTitleOfRole(adminRoleId, "1");
        // 获取子标题
        List<MvTitleModel> childTitle = titleService.getTitleOfRole(adminRoleId, "0");
        parantTitle.addAll(childTitle);
        response.setSuccess(true);
        response.setData(parantTitle);
        return response;
    }
}
