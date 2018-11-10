package xin.liaozhixing.service.role;

import xin.liaozhixing.model.role.MvRoleModel;

import java.util.List;

public interface MvRoleService {

    /**
     * 查询角色
     * @param id
     * @return
     */
    List<MvRoleModel> getRoles(Long id);

    /**
     * 修改角色
     * @param role
     */
    void modifyRole(MvRoleModel role);

    void addRole(MvRoleModel role);

    void deleteRoles(Long[] roleIds);
}
