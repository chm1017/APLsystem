package com.cm.APL.workbench.dao;

import com.cm.APL.workbench.domain.Order;

import java.util.HashMap;
import java.util.List;

public interface OrderDao {

    int addProductToOrder(Order o);

    int getTotalById(HashMap<String, Object> map);

    List<Order> getProductListByOrderId(HashMap<String, Object> map);
}
