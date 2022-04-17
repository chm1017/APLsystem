package com.cm.APL.workbench.service;


import com.cm.APL.vo.PaginationVO;
import com.cm.APL.workbench.domain.Driver;

import java.util.HashMap;
import java.util.List;

public interface DriverService {
    boolean save(Driver driver);

    PaginationVO<Driver> pageList(HashMap<String, Object> map);

    List<Driver> getDriverList();
}
