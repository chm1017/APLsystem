package com.cm.APL.workbench.dao;

import com.cm.APL.workbench.domain.OrderHistoryVo;
import com.cm.APL.workbench.domain.Order;
import com.cm.APL.workbench.domain.Orderform;
import com.cm.APL.workbench.domain.Product;
import com.cm.APL.workbench.domain.charts.MPBoss;
import com.cm.APL.workbench.domain.charts.ProductSailNumber;

import java.util.HashMap;
import java.util.List;

public interface OrderDao {

    int addProductToOrder(Order o);

    int getTotalById(HashMap<String, Object> map);

    List<Order> getProductListByOrderId(HashMap<String, Object> map);

    Orderform getSumByOrderId(String oid);


    List<OrderHistoryVo> getProductHistory(String pid);


    List<Order> getOrderListById(String oid);

    int getProductType();

    List<ProductSailNumber> getProductSailNumber();

    List<MPBoss> getMPBoss();
}
