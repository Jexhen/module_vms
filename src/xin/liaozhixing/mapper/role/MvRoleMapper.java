package xin.liaozhixing.mapper.role;

import org.apache.ibatis.annotations.Param;
import xin.liaozhixing.model.role.MvRoleModel;

import java.util.List;

public interface MvRoleMapper {

    List<MvRoleModel> getRoles(@Param("example") MvRoleModel example);

    void modifyRole(@Param("role") MvRoleModel role);

    void addRole(@Param("role") MvRoleModel role);

    void deleteRoles(@Param("roleIds") Long[] roleIds);

    void removeAuthority(@Param("mvrlId") Long mvrlId);

    void distributeAuthority(@Param("mvrlId")Long mvrlId, @Param("ids") Long[] ids, @Param("creator") Long creator);
}
