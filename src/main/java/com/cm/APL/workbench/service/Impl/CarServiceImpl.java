package com.cm.APL.workbench.service.Impl;

import com.bjpowernode.crm.vo.PaginationVO;
import com.cm.APL.utils.SqlSessionUtil;
import com.cm.APL.workbench.dao.CarDao;
import com.cm.APL.workbench.domain.Car;
import com.cm.APL.workbench.service.CarService;

import java.util.HashMap;
import java.util.List;

public class CarServiceImpl implements CarService {
    private CarDao carDao = SqlSessionUtil.getSqlSession().getMapper(CarDao.class);
    @Override
    public boolean save(Car c) {
        int i = carDao.save(c);
        if (i != 1) {
            return false;
        }
        return true;
    }

    @Override
    public PaginationVO<Car> pageList(HashMap<String, Object> map) {
        int Count = carDao.getTotal(map);
        List<Car> cars = carDao.getCarList(map);
        PaginationVO<Car> vo = new PaginationVO<>();
        vo.setDataList(cars);
        vo.setTotal(Count);
        return vo;
    }
}
