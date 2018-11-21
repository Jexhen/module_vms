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

    /**
     * 删除角色的所有权限
     * @param mvrlId
     */
    void removeAuthority(Long mvrlId);

    /**
     * 分配权限
     * @param mvrlId 角色ID
     * @param ids 功能id集
     * @param mvusId 修改者
     */
    void distributeAuthority(Long mvrlId, Long[] ids, Long mvusId);
}
