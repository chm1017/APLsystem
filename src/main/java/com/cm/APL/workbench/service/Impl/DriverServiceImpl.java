package com.cm.APL.workbench.service.Impl;


import com.cm.APL.settings.dao.UserDao;
import com.cm.APL.settings.domain.User;
import com.cm.APL.utils.SqlSessionUtil;
import com.cm.APL.vo.PaginationVO;
import com.cm.APL.workbench.dao.DriverDao;
import com.cm.APL.workbench.domain.Driver;
import com.cm.APL.workbench.service.DriverService;

import java.util.HashMap;
import java.util.List;

public class DriverServiceImpl implements DriverService {
    private DriverDao driverDao = SqlSessionUtil.getSqlSession().getMapper(DriverDao.class);
    private UserDao userDao = SqlSessionUtil.getSqlSession().getMapper(UserDao.class);
    @Override
    public boolean save(Driver driver) {
        int i = driverDao.save(driver);
        if (i!=1){
            return false;
        }
        return true;
    }

    @Override
    public PaginationVO<Driver> pageList(HashMap<String, Object> map) {
        int count = driverDao.getTotalDriver(map);
        List<Driver> drivers = driverDao.getDriverList(map);
        PaginationVO<Driver> vo = new PaginationVO<Driver>();
        vo.setTotal(count);
        vo.setDataList(drivers);
        return vo;

    }

    @Override
    public List<Driver> getDriverList() {
        List<Driver> drivers = driverDao.getDriver();
        return drivers;
    }

    @Override
    public Driver detail(String did) {
        Driver d= driverDao.detail(did);
        return d;
    }

    @Override
    public HashMap<String, Object> getDriverById(String did) {
        List<User> userList = userDao.getUserList();
        Driver driver = driverDao.getDriverById(did);
        HashMap<String, Object> map = new HashMap<>();
        map.put("a", driver);
        map.put("uList", userList);
        return map;
    }

    @Override
    public boolean update(Driver driver) {
        int i =driverDao.update(driver);
        if (i!=1){
            return false;
        }
        return true;
    }

    @Override
    public boolean delete(String[] ids) {
        int i = driverDao.delete(ids);
        if (i != ids.length) {
            return false;
        }
        return true;
    }
}
