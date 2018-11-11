package xin.liaozhixing.service.role;

import xin.liaozhixing.model.role.MvRoleModel;

import java.util.List;

public interface MvRoleService {

    /**
     * 查询角色
     * @param model 查询条件
     * @return
     */
    List<MvRoleModel> getRoles(MvRoleModel model);

    /**
     * 修改角色
     * @param role
     */
    void modifyRole(MvRoleModel role);

    void addRole(MvRoleModel role);

    void deleteRoles(Long[] roleIds);
}
