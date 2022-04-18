package com.cm.APL.workbench.service.Impl;


import com.cm.APL.utils.SqlSessionUtil;
import com.cm.APL.vo.PaginationVO;
import com.cm.APL.workbench.dao.DriverDao;
import com.cm.APL.workbench.domain.Driver;
import com.cm.APL.workbench.service.DriverService;

import java.util.HashMap;
import java.util.List;

public class DriverServiceImpl implements DriverService {
    private DriverDao driverDao = SqlSessionUtil.getSqlSession().getMapper(DriverDao.class);
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
}
