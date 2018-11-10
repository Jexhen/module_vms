package xin.liaozhixing.controller.title;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
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


    @RequestMapping("/getTitle.shtml")
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
            model.addAttribute("loginUser", loginUser);
        } else {
            model.addAttribute("errorMsg", "登陆失败");
            path = "/login";
        }
        return path;
    }

}
