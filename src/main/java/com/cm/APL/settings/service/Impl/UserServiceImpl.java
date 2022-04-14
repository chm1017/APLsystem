package com.cm.APL.settings.service.Impl;

import com.cm.APL.settings.dao.UserDao;
import com.cm.APL.settings.domain.User;
import com.cm.APL.settings.service.UserService;
import com.cm.APL.utils.SqlSessionUtil;

import javax.security.auth.login.LoginException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserServiceImpl implements UserService {
    private UserDao userDao = SqlSessionUtil.getSqlSession().getMapper(UserDao.class);

    @Override
    public User login(String loginAct, String loginPwd, String ip) throws LoginException {
        Map<String , String> map = new HashMap<String, String>();
        map.put("loginAct", loginAct);
        map.put("loginPwd", loginPwd);
        User user = userDao.login(map);
        System.out.println(user);
        if (user == null) {
            throw new LoginException("账号密码错误");
        }
        return user;
    }

    @Override
    public List<User> getUserList() {
        List<User> userList = userDao.getUserList();
        return userList;
    }
}
