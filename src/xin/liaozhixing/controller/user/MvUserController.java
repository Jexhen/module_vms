package xin.liaozhixing.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import sun.invoke.empty.Empty;
import xin.liaozhixing.model.base.BaseTableResponse;
import xin.liaozhixing.model.user.MvUserModel;
import xin.liaozhixing.model.user.MvUserQueryModel;
import xin.liaozhixing.service.user.MvUserService;
import xin.liaozhixing.utils.EmptyUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.List;

@Controller
@RequestMapping("/user")
public class MvUserController {

    @Autowired
    private MvUserService userService;

    @RequestMapping("/login")
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

    @RequestMapping("/getUsers")
    public @ResponseBody BaseTableResponse getUsers(MvUserQueryModel user) {
        BaseTableResponse response = new BaseTableResponse();
        if (null != user){
            // 解决layui get提交编码问题
            if (EmptyUtils.isNotEmpty(user.getMvusName())) {
                try {
                    String decodeUserName = new String(user.getMvusName().getBytes("ISO-8859-1"),"UTF-8");
                    user.setMvusName(decodeUserName);
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
            }
            if (EmptyUtils.isNotEmpty(user.getMvusOrganizationName())) {
                try {
                    String decodeOrganizationName = new String(user.getMvusOrganizationName().getBytes("ISO-8859-1"),"UTF-8");
                    user.setMvusOrganizationName(decodeOrganizationName);
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
            }
            if (EmptyUtils.isNotEmpty(user.getMvusRoleName())) {
                try {
                    String decodeRoleName = new String(user.getMvusRoleName().getBytes("ISO-8859-1"),"UTF-8");
                    user.setMvusRoleName(decodeRoleName);
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
            }
        }
        List<MvUserQueryModel> existUsers = userService.getUserByExample(user);
        response.setCode(0);
        response.setMsg("");
        response.setData(existUsers);
        response.setCount(existUsers.size());
        return response;
    }
}
