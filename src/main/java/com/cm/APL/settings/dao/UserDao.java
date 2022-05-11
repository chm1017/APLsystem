package com.cm.APL.settings.dao;

import com.cm.APL.settings.domain.User;

import java.util.List;
import java.util.Map;

public interface UserDao {

    User login(Map<String, String> map);

    List<User> getUserList();

    int updatePwd(User user);
}
