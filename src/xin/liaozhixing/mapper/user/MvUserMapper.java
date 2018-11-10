package xin.liaozhixing.mapper.user;

import org.apache.ibatis.annotations.Param;
import xin.liaozhixing.model.user.MvUserModel;

import java.util.List;

public interface MvUserMapper {

    List<MvUserModel> getUser(@Param("user") MvUserModel user);

}
