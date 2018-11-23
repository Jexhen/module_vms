package xin.liaozhixing.mapper.user;

import org.apache.ibatis.annotations.Param;
import xin.liaozhixing.model.user.MvUserModel;
import xin.liaozhixing.model.user.MvUserQueryModel;

import java.util.List;

public interface MvUserMapper {

    List<MvUserModel> getUser(@Param("user") MvUserModel user);

    List<MvUserQueryModel> getUserByExample(@Param("example") MvUserQueryModel user, @Param("firstIndex") Long firstIndex, @Param("pageSize") Long pageSize);

    void addUser(@Param("user") MvUserModel user);

    void removeUser(@Param("ids") Long[] ids);

    List<MvUserModel> getAnswerer(@Param("example")MvUserModel user);

    void modifyUser(@Param("user")MvUserModel user);

    Long getUserCountByExample(@Param("example") MvUserQueryModel user);

    void updatePasssword(@Param("mvusId")Long mvusId, @Param("newPassword")String newPassword);
}
