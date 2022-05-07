package com.cm.APL.workbench.service;


import com.cm.APL.vo.PaginationVO;
import com.cm.APL.workbench.domain.Car;
import com.cm.APL.workbench.domain.Orderform;

import java.util.HashMap;
import java.util.List;

public interface CarService {
    boolean save(Car c);

    PaginationVO<Car> pageList(HashMap<String, Object> map);

    List<Car> getCarList();

    Car detail(String cid);

    boolean delete(String[] ids);

    int updateCarStage(Car car);

    List<Orderform> transHistory(String cid);

    List<Orderform> isTrans(String cid);
}
