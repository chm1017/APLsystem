package com.cm.APL.workbench.service.Impl;


import com.cm.APL.utils.SqlSessionUtil;
import com.cm.APL.vo.PaginationVO;
import com.cm.APL.workbench.dao.OrderDao;
import com.cm.APL.workbench.dao.OrderformDao;
import com.cm.APL.workbench.domain.Order;
import com.cm.APL.workbench.domain.Orderform;
import com.cm.APL.workbench.service.TransactionService;

import java.util.HashMap;
import java.util.List;

public class TransactionServiceImpl implements TransactionService {
    private OrderDao orderDao = SqlSessionUtil.getSqlSession().getMapper(OrderDao.class);
    private OrderformDao orderformDao =  SqlSessionUtil.getSqlSession().getMapper(OrderformDao.class);
    @Override
    public Integer addProductToOrder(Order o) {
        int i = orderDao.addProductToOrder(o);
        return i;
    }

    @Override
    public PaginationVO<Order> orderProductList(HashMap<String, Object> map) {
        int total = orderDao.getTotalById(map);
        List<Order> orders = orderDao.getProductListByOrderId(map);
        System.out.println(orders);

        PaginationVO<Order> vo = new PaginationVO<>();
        vo.setTotal(total);
        vo.setDataList(orders);

        return vo;
    }

    @Override
    public Orderform getSumByOrderId(String oid) {
        Orderform orderform = orderDao.getSumByOrderId(oid);
        return orderform;
    }

    @Override
    public boolean saveOrder(Orderform o) {
        int i =orderformDao.saveOrder(o);
        if (i != 1) {
            return false;
        }
        return true;
    }

    @Override
    public PaginationVO<Orderform> orderListPage(HashMap<String, Object> map) {
        int total = orderformDao.getTotalOrderCount();
        List<Orderform> orderforms = orderformDao.getOrderList(map);
        PaginationVO<Orderform> vo = new PaginationVO<>();
        vo.setDataList(orderforms);
        vo.setTotal(total);

        return vo;
    }

    @Override
    public Orderform detail(String id) {
        Orderform o = orderformDao.detail(id);
        return o;
    }


}
