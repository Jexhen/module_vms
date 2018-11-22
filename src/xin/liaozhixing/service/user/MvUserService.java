package xin.liaozhixing.service.user;

import xin.liaozhixing.model.user.MvUserModel;
import xin.liaozhixing.model.user.MvUserQueryModel;

import java.util.List;

public interface MvUserService {
    List<MvUserModel> getUser(MvUserModel user);

    List<MvUserQueryModel> getUserByExample(MvUserQueryModel user, Long page, Long limit);

    Long getUserCountByExample(MvUserQueryModel user);

    void addUser(MvUserModel user);

    void removeUser(Long[] ids);

    List<MvUserModel> getAnswerer(MvUserModel user);

    void modifyUser(MvUserModel user);
}
