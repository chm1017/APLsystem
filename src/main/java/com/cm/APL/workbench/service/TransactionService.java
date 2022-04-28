package com.cm.APL.workbench.service;


import com.cm.APL.vo.PaginationVO;
import com.cm.APL.workbench.domain.Order;
import com.cm.APL.workbench.domain.Orderform;

import java.util.HashMap;
import java.util.List;

public interface TransactionService {
    Integer addProductToOrder(Order o);

    PaginationVO<Order> orderProductList(HashMap<String, Object> map);


    Orderform getSumByOrderId(String oid);

    boolean saveOrder(Orderform o);

    PaginationVO<Orderform> orderListPage(HashMap<String, Object> map);

    Orderform detail(String id);

    List<Order> getOrderListById(String oid);

    boolean changeStage(HashMap<String, String> map);
}
