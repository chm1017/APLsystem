package com.cm.APL.workbench.service;

import com.bjpowernode.crm.vo.PaginationVO;
import com.cm.APL.workbench.domain.Car;

import java.util.HashMap;

public interface CarService {
    boolean save(Car c);

    PaginationVO<Car> pageList(HashMap<String, Object> map);
}
