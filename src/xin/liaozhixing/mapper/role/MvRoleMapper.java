package xin.liaozhixing.mapper.role;

import org.apache.ibatis.annotations.Param;
import xin.liaozhixing.model.role.MvRoleModel;

import java.util.List;

public interface MvRoleMapper {

    List<MvRoleModel> getRoles(@Param("id") Long id);

    void modifyRole(@Param("role") MvRoleModel role);

    void addRole(@Param("role") MvRoleModel role);

    void deleteRoles(@Param("roleIds") Long[] roleIds);
}
