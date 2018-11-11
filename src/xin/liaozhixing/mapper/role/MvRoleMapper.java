package xin.liaozhixing.mapper.role;

import org.apache.ibatis.annotations.Param;
import xin.liaozhixing.model.role.MvRoleModel;

import java.util.List;

public interface MvRoleMapper {

    List<MvRoleModel> getRoles(@Param("example") MvRoleModel example);

    void modifyRole(@Param("role") MvRoleModel role);

    void addRole(@Param("role") MvRoleModel role);

    void deleteRoles(@Param("roleIds") Long[] roleIds);
}
