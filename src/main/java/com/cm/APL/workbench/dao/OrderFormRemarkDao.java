package com.cm.APL.workbench.dao;

import com.cm.APL.workbench.domain.OrderFormRemark;

import java.util.List;

public interface OrderFormRemarkDao {
    List<OrderFormRemark> getRemarkListById(String orderFormId);

    int saveRemark(OrderFormRemark or);

    int deleteRemark(String id);
}
