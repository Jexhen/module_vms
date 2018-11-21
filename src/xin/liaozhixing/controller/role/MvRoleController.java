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
import java.io.UnsupportedEncodingException;
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
    @RequestMapping("/getRoles")
    public @ResponseBody BaseTableResponse getRoles(MvRoleModel model) {
        BaseTableResponse response = new BaseTableResponse();
        // 解决lay ui get方式请求中文乱码问题
        if (model!=null && EmptyUtils.isNotEmpty(model.getMvrlName())) {
            try {
                String decodeMvrlName = new String(model.getMvrlName().getBytes("ISO-8859-1"),"UTF-8");
                model.setMvrlName(decodeMvrlName);
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        List<MvRoleModel> roles = roleService.getRoles(model);
        response.setCode(0);// 成功
        response.setCount(roles.size());
        response.setMsg("");
        response.setData(roles);
        return response;
    }

    /**
     * 修改角色
     * @param role
     * @return
     */
    @RequestMapping("/modifyRole")
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

    /**
     * 增加角色
     * @param role
     * @param request
     * @return
     */
    @RequestMapping("/addRole")
    public @ResponseBody BaseResponse addRole(MvRoleModel role, HttpServletRequest request) {
        BaseResponse response = new BaseResponse();
        if (role!=null && EmptyUtils.isNotEmpty(role.getMvrlName())) {
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

    /**
     * 删除角色
     * @param roleIds
     * @return
     */
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

    /**
     * 分配权限
     * @param mvrlId
     * @param ids
     * @param request
     * @return
     */
    @RequestMapping("/distribute")
    public @ResponseBody BaseResponse distribute(Long mvrlId, @RequestParam("ids[]") Long[] ids, HttpServletRequest request) {
        BaseResponse response = new BaseResponse();
        // 删除该角色下的所有权限
        roleService.removeAuthority(mvrlId);
        // 新建权限
        MvUserModel loginUser = (MvUserModel) request.getSession().getAttribute("loginUser");
        roleService.distributeAuthority(mvrlId,ids,loginUser.getMvusId());
        response.setSuccess(true);
        response.setMessage("分配权限成功");
        return response;
    }

    /**
     *
     * @param id
     * @return
     */
    @RequestMapping("/getAuthority")
    public @ResponseBody BaseResponse getAuthority(Long id) {
        BaseResponse response = new BaseResponse();
        if (id!=null) {
            List<Long> existAuthority = roleService.getAuthority(id);
            response.setSuccess(true);
            response.setData(existAuthority);
        } else {
            response.setSuccess(false);
            response.setMessage("id不能为空");
        }
        return response;
    }
}
