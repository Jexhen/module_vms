package xin.liaozhixing.controller.role;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import xin.liaozhixing.model.base.BaseResponse;
import xin.liaozhixing.model.base.BaseTableResponse;
import xin.liaozhixing.model.role.MvRoleModel;
import xin.liaozhixing.model.user.MvUserModel;
import xin.liaozhixing.service.role.MvRoleService;
import xin.liaozhixing.utils.EmptyUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/role")
public class MvRoleController {

    @Autowired
    private MvRoleService roleService;

    /**
     * 查询所有角色
     * @param model
     * @return
     */
    @RequestMapping("/getRoles.shtml")
    public @ResponseBody BaseTableResponse getRoles(Model model) {
        BaseTableResponse response = new BaseTableResponse();
        List<MvRoleModel> roles = roleService.getRoles(null);
        response.setCode(0);// 成功
        response.setCount(roles.size());
        response.setMsg("");
        response.setData(roles);
        return response;
    }

    /**
     * 查询角色
     * @param roleId
     * @return
     */
    @RequestMapping("/getRoleById.shtml")
    public @ResponseBody BaseResponse getRoleById(Long roleId) {
        BaseResponse response = new BaseResponse();
        List<MvRoleModel> roles = roleService.getRoles(roleId);
        if (EmptyUtils.isNotEmpty(roles)) {
            response.setSuccess(true);
            response.setData(roles.get(0));
        } else {
            response.setSuccess(false);
            response.setMessage("没有数据！");
        }
        return response;
    }

    /**
     * 修改角色
     * @param role
     * @return
     */
    @RequestMapping("/modifyRole.shtml")
    public @ResponseBody BaseResponse modifyRole(MvRoleModel role, HttpServletRequest request) {
        BaseResponse response = new BaseResponse();
        if (role != null) {
            if (null == role.getMvrlId()) {
                response.setSuccess(false);
                response.setMessage("角色ID不能为空！");
            } else if (EmptyUtils.isEmpty(role.getMvrlName())) {
                response.setSuccess(false);
                response.setMessage("角色名称不能为空！");
            } else {
                MvUserModel loginUser = (MvUserModel) request.getSession().getAttribute("loginUser");
                role.setModifier(loginUser.getMvusId().toString());
                roleService.modifyRole(role);
                response.setSuccess(true);
                response.setMessage("修改成功！");
            }
        } else {
            response.setSuccess(false);
            response.setMessage("请求参数不能为空！");
        }

        return response;
    }

    @RequestMapping("/addRole.shtml")
    public @ResponseBody BaseResponse addRole(MvRoleModel role, HttpServletRequest request) {
        BaseResponse response = new BaseResponse();
        if (EmptyUtils.isNotEmpty(role.getMvrlName())) {
            MvUserModel loginUser = (MvUserModel) request.getSession().getAttribute("loginUser");
            role.setCreator(loginUser.getMvusId().toString());
            role.setModifier(loginUser.getMvusId().toString());
            roleService.addRole(role);
            response.setSuccess(true);
            response.setMessage("保存成功！");
        } else {
            response.setSuccess(false);
            response.setMessage("角色名称不能为空！");
        }
        return response;
    }

    @RequestMapping("/deleteRoles.shtml")
    public @ResponseBody  BaseResponse deleteRole(@RequestParam(value = "roleIds[]") Long[] roleIds) {
        BaseResponse response = new BaseResponse();
        if (roleIds != null && roleIds.length > 0) {
            roleService.deleteRoles(roleIds);
            response.setSuccess(true);
            response.setMessage("删除成功！");
        } else {
            response.setSuccess(false);
            response.setMessage("角色ID不能为空！");
        }
        return response;
    }
}
