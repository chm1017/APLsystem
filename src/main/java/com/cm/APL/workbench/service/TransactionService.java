package com.cm.APL.workbench.service;

import com.bjpowernode.crm.vo.PaginationVO;
import com.cm.APL.workbench.domain.Order;

import java.util.HashMap;

public interface TransactionService {
    Boolean addProductToOrder(Order o);

    PaginationVO<Order> orderProductList(HashMap<String, Object> map);
}
