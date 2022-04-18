package com.cm.APL.workbench.service;


import com.cm.APL.vo.PaginationVO;
import com.cm.APL.workbench.domain.Car;

import java.util.HashMap;
import java.util.List;

public interface CarService {
    boolean save(Car c);

    PaginationVO<Car> pageList(HashMap<String, Object> map);

    List<Car> getCarList();

    Car detail(String cid);
}
