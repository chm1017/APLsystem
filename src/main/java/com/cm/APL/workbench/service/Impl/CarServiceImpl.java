package com.cm.APL.workbench.service.Impl;


import com.cm.APL.utils.SqlSessionUtil;
import com.cm.APL.vo.PaginationVO;
import com.cm.APL.workbench.dao.CarDao;
import com.cm.APL.workbench.dao.OrderformDao;
import com.cm.APL.workbench.domain.Car;
import com.cm.APL.workbench.domain.Orderform;
import com.cm.APL.workbench.service.CarService;

import java.util.HashMap;
import java.util.List;

public class CarServiceImpl implements CarService {
    private CarDao carDao = SqlSessionUtil.getSqlSession().getMapper(CarDao.class);
    private OrderformDao orderformDao = SqlSessionUtil.getSqlSession().getMapper(OrderformDao.class);
    @Override
    public boolean save(Car c) {
        int i = carDao.save(c);
        if (i != 1) {return false;}
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
    @Override
    public List<Car> getCarList() {
        List<Car> cars = carDao.getCarnameList();
        return cars;
    }
    @Override
    public Car detail(String cid) {
        Car c= carDao.detail(cid);
        return c;
    }
    @Override
    public boolean delete(String[] ids) {
        int i = carDao.delete(ids);
        if (i != ids.length) {return false;}
        return true;
    }
    @Override
    public int updateCarStage(Car car) {
        int i =carDao.updateCarStage(car);
        return i;
    }
    @Override
    public List<Orderform> transHistory(String cid) {
        List<Orderform> list = orderformDao.transHistory(cid);
        return list;
    }
    @Override
    public List<Orderform> isTrans(String cid) {
        List<Orderform> list = orderformDao.isTrans(cid);
        return list;
    }

}
