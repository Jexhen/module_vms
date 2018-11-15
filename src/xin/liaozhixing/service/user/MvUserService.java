package xin.liaozhixing.service.user;

import xin.liaozhixing.model.user.MvUserModel;
import xin.liaozhixing.model.user.MvUserQueryModel;

import java.util.List;

public interface MvUserService {
    List<MvUserModel> getUesr(MvUserModel user);

    List<MvUserQueryModel> getUserByExample(MvUserQueryModel user);

    void addUser(MvUserModel user);

    void removeUser(Long[] ids);
}
