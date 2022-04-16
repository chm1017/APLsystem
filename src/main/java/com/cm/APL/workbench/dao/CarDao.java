package com.cm.APL.workbench.dao;

import com.cm.APL.workbench.domain.Car;

import java.util.HashMap;
import java.util.List;

public interface CarDao {
    int save(Car c);

    int getTotal(HashMap<String, Object> map);

    List<Car> getCarList(HashMap<String, Object> map);
}
