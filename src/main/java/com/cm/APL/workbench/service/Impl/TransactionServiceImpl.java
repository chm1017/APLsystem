package com.cm.APL.workbench.service.Impl;

import com.bjpowernode.crm.vo.PaginationVO;
import com.cm.APL.utils.SqlSessionUtil;
import com.cm.APL.workbench.dao.OrderDao;
import com.cm.APL.workbench.domain.Order;
import com.cm.APL.workbench.service.TransactionService;

import java.util.HashMap;
import java.util.List;

public class TransactionServiceImpl implements TransactionService {
    private OrderDao orderDao = SqlSessionUtil.getSqlSession().getMapper(OrderDao.class);
    @Override
    public Boolean addProductToOrder(Order o) {
        int i = orderDao.addProductToOrder(o);
        if (i != 1) {
            return false;
        }
        return true;
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
}
