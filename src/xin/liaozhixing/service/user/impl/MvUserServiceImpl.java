package xin.liaozhixing.service.user.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import xin.liaozhixing.mapper.user.MvUserMapper;
import xin.liaozhixing.model.user.MvUserModel;
import xin.liaozhixing.model.user.MvUserQueryModel;
import xin.liaozhixing.service.user.MvUserService;

import java.util.List;

@Service
public class MvUserServiceImpl implements MvUserService {

    @Autowired
    private MvUserMapper userMapper;

    @Override
    public List<MvUserModel> getUser(MvUserModel user) {
        return userMapper.getUser(user);
    }

    @Override
    public List<MvUserQueryModel> getUserByExample(MvUserQueryModel user, Long page, Long limit) {
        List<MvUserQueryModel> list;
        if (page==null) {
            list = userMapper.getUserByExample(user, null, null);
        } else {
            list = userMapper.getUserByExample(user, (page-1)* limit, limit);
        }
        return list;
    }

    @Override
    public Long getUserCountByExample(MvUserQueryModel user) {
        return userMapper.getUserCountByExample(user);
    }

    @Override
    public void addUser(MvUserModel user) {
        userMapper.addUser(user);
    }

    @Override
    public void removeUser(Long[] ids) {
        userMapper.removeUser(ids);
    }

    @Override
    public List<MvUserModel> getAnswerer(MvUserModel user) {
        return userMapper.getAnswerer(user);
    }

    @Override
    public void modifyUser(MvUserModel user) {
        userMapper.modifyUser(user);
    }
}
