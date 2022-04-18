package com.cm.APL.workbench.dao;

import com.cm.APL.workbench.domain.Driver;
import com.cm.APL.workbench.domain.Product;

import java.util.HashMap;
import java.util.List;

public interface DriverDao {

    int save(Driver driver);

    int getTotalDriver(HashMap<String, Object> map);

    List<Driver> getDriverList(HashMap<String, Object> map);

    List<Driver> getDriver();

    Driver detail(String did);
}
