package xin.liaozhixing.service.role.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import xin.liaozhixing.mapper.role.MvRoleMapper;
import xin.liaozhixing.model.role.MvRoleModel;
import xin.liaozhixing.service.role.MvRoleService;

import java.util.List;

@Service("roleService")
public class MvRoleServiceImpl implements MvRoleService {

    @Autowired
    private MvRoleMapper roleMapper;

    @Override
    public List<MvRoleModel> getRoles(MvRoleModel model) {
        return roleMapper.getRoles(model);
    }

    @Override
    public void modifyRole(MvRoleModel role) {
        roleMapper.modifyRole(role);
    }

    @Override
    public void addRole(MvRoleModel role) {
        roleMapper.addRole(role);
    }

    @Override
    public void deleteRoles(Long[] roleIds) {
        roleMapper.deleteRoles(roleIds);
    }

    /**
     * 删除角色的所有权限
     *
     * @param mvrlId
     */
    @Override
    public void removeAuthority(Long mvrlId) {
        roleMapper.removeAuthority(mvrlId);
    }

    /**
     * 分配权限
     *
     * @param mvrlId 角色ID
     * @param ids    功能id集
     * @param mvusId 修改者
     */
    @Override
    public void distributeAuthority(Long mvrlId, Long[] ids, Long mvusId) {
        roleMapper.distributeAuthority(mvrlId,ids,mvrlId);
    }
}
