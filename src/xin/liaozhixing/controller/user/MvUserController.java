package xin.liaozhixing.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import sun.invoke.empty.Empty;
import xin.liaozhixing.model.user.MvUserModel;
import xin.liaozhixing.service.user.MvUserService;
import xin.liaozhixing.utils.EmptyUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/user")
public class MvUserController {

    @Autowired
    private MvUserService userService;

    @RequestMapping("/login.shtml")
    public String userLogin(MvUserModel user, Model model, HttpServletRequest request) {
        String path = "redirect:/title/getTitle.shtml";
        if (null != user) {
            if (EmptyUtils.isNotEmpty(user.getMvusLoginName()) && EmptyUtils.isNotEmpty(user.getMvusPassword())) {
                List<MvUserModel> users = userService.getUesr(user);
                if (EmptyUtils.isEmpty(users)) {
                    model.addAttribute("errorInfo","用户名或者密码错误");
                    path = "forward:/index.jsp";
                } else {
                    request.getSession().setAttribute("loginUser", users.get(0));
                }
            } else {
                model.addAttribute("errorInfo", "用户名或者密码不能为空");
            }
        } else {
            model.addAttribute("errorInfo", "用户名或者密码不能为空");
        }
        return path;
    }
}
