package xin.liaozhixing.controller.user;

import com.fasterxml.jackson.databind.ser.Serializers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import sun.invoke.empty.Empty;
import xin.liaozhixing.model.base.BaseResponse;
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
                List<MvUserModel> users = userService.getUser(user);
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

    @RequestMapping("/logout")
    public String userLogout(HttpServletRequest request) {
        request.getSession().removeAttribute("loginUser");
        return "redirect:/index.jsp";
    }

    @RequestMapping("/modifyPassword")
    public @ResponseBody BaseResponse modifyPassword(String loginName, String originalPassword, String newPassword, String reNewPassword) {
        BaseResponse response = new BaseResponse();
        if (EmptyUtils.isNotEmpty(originalPassword)) {
            if (EmptyUtils.isNotEmpty(newPassword)) {
                if (EmptyUtils.isNotEmpty(reNewPassword)) {
                    if (newPassword.equals(reNewPassword)) {
                        MvUserModel user = new MvUserModel();
                        user.setMvusLoginName(loginName);
                        user.setMvusPassword(originalPassword);
                        List<MvUserModel> existUser = userService.getUser(user);
                        if (EmptyUtils.isNotEmpty(existUser)) {
                            userService.updatePassword(existUser.get(0).getMvusId(),newPassword);
                            response.setSuccess(true);
                            response.setMessage("修改成功");
                        } else {
                            response.setSuccess(false);
                            response.setMessage("原密码错误");
                        }
                    } else {
                        response.setSuccess(false);
                        response.setMessage("两次密码不一致");
                    }
                } else {
                    response.setSuccess(false);
                    response.setMessage("重复密码不能为空");
                }
            } else {
                response.setSuccess(false);
                response.setMessage("新密码不能为空");
            }
        } else {
            response.setSuccess(false);
            response.setMessage("原密码不能为空");
        }
        return response;
    }

    @RequestMapping("/getUsers")
    public @ResponseBody BaseTableResponse getUsers(MvUserQueryModel user, Long page, Long limit) {
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
        List<MvUserQueryModel> existUsers = userService.getUserByExample(user,page,limit);
        response.setCode(0);
        response.setMsg("");
        response.setData(existUsers);
        response.setCount(userService.getUserCountByExample(user).intValue());
        return response;
    }

    @RequestMapping("/addUser")
    public @ResponseBody BaseResponse addUser(MvUserModel user, HttpServletRequest request) {
        BaseResponse response = new BaseResponse();
        if (user!=null) {
            if (EmptyUtils.isNotEmpty(user.getMvusName())) {
                if (EmptyUtils.isNotEmpty(user.getMvusLoginName())) {
                    if (EmptyUtils.isNotEmpty(user.getMvusMail())) {
                        if (user.getMvusOrganizationId()!=null) {
                            if (user.getMvusRoleId()!=null) {
                                MvUserQueryModel example = new MvUserQueryModel();
                                example.setMvusLoginName(user.getMvusName());
                                List<MvUserQueryModel> existUsers = userService.getUserByExample(example,null,null);
                                if (EmptyUtils.isNotEmpty(existUsers)) {
                                    response.setSuccess(false);
                                    response.setMessage("登陆名不能重复");
                                } else {
                                    MvUserModel loginUser = (MvUserModel) request.getSession().getAttribute("loginUser");
                                    user.setCreator(loginUser.getMvusId().toString());
                                    user.setModifier(loginUser.getMvusId().toString());
                                    userService.addUser(user);
                                    response.setSuccess(true);
                                    response.setMessage("增加成功！");
                                }
                            } else {
                                response.setSuccess(false);
                                response.setMessage("角色不能为空");
                            }
                        } else {
                            response.setSuccess(false);
                            response.setMessage("组织不能为空");
                        }
                    } else {
                        response.setSuccess(false);
                        response.setMessage("身份证号不能为空");
                    }
                } else {
                    response.setSuccess(false);
                    response.setMessage("登陆名不能为空");
                }
            } else {
                response.setSuccess(false);
                response.setMessage("姓名不能为空");
            }
        } else {
            response.setSuccess(false);
            response.setMessage("参数不能为空");
        }
        return response;
    }

    @RequestMapping("/modifyUser")
    public @ResponseBody BaseResponse modifyUser(MvUserModel user, HttpServletRequest request) {
        BaseResponse response = new BaseResponse();
        if (user!=null) {
            if (EmptyUtils.isNotEmpty(user.getMvusName())) {
                if (EmptyUtils.isNotEmpty(user.getMvusLoginName())) {
                    if (EmptyUtils.isNotEmpty(user.getMvusMail())) {
                        if (user.getMvusOrganizationId()!=null) {
                            if (user.getMvusRoleId()!=null) {
                                MvUserQueryModel example = new MvUserQueryModel();
                                example.setMvusLoginName(user.getMvusName());
                                List<MvUserQueryModel> existUsers = userService.getUserByExample(example,null,null);
                                if (EmptyUtils.isNotEmpty(existUsers)) {
                                    response.setSuccess(false);
                                    response.setMessage("登陆名不能重复");
                                } else {
                                    MvUserModel loginUser = (MvUserModel) request.getSession().getAttribute("loginUser");
                                    user.setCreator(loginUser.getMvusId().toString());
                                    user.setModifier(loginUser.getMvusId().toString());
                                    userService.modifyUser(user);
                                    response.setSuccess(true);
                                    response.setMessage("修改成功！");
                                }
                            } else {
                                response.setSuccess(false);
                                response.setMessage("角色不能为空");
                            }
                        } else {
                            response.setSuccess(false);
                            response.setMessage("组织不能为空");
                        }
                    } else {
                        response.setSuccess(false);
                        response.setMessage("身份证号不能为空");
                    }
                } else {
                    response.setSuccess(false);
                    response.setMessage("登陆名不能为空");
                }
            } else {
                response.setSuccess(false);
                response.setMessage("姓名不能为空");
            }
        } else {
            response.setSuccess(false);
            response.setMessage("参数不能为空");
        }
        return response;
    }

    @RequestMapping("/removeUser")
    public @ResponseBody BaseResponse removeUser(@RequestParam("ids[]") Long[]ids) {
        BaseResponse response = new BaseResponse();
        userService.removeUser(ids);
        response.setSuccess(true);
        response.setMessage("删除成功");
        return response;
    }
}
