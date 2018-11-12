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
    public List<MvUserModel> getUesr(MvUserModel user) {
        return userMapper.getUser(user);
    }

    @Override
    public List<MvUserQueryModel> getUserByExample(MvUserQueryModel user) {
        return userMapper.getUserByExample(user);
    }
}
