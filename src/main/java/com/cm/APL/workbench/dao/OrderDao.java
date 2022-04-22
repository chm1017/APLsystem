package com.cm.APL.workbench.dao;

import com.cm.APL.workbench.domain.OrderHistoryVo;
import com.cm.APL.workbench.domain.Order;
import com.cm.APL.workbench.domain.Orderform;

import java.util.HashMap;
import java.util.List;

public interface OrderDao {

    int addProductToOrder(Order o);

    int getTotalById(HashMap<String, Object> map);

    List<Order> getProductListByOrderId(HashMap<String, Object> map);

    Orderform getSumByOrderId(String oid);


    List<OrderHistoryVo> getProductHistory(String pid);
}
