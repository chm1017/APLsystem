package com.cm.APL.workbench.dao;

import com.cm.APL.workbench.domain.Order;
import com.cm.APL.workbench.domain.Orderform;

import java.util.HashMap;
import java.util.List;

public interface OrderformDao {


    int saveOrder(Orderform o);

    int getTotalOrderCount();


    List<Orderform> getOrderList(HashMap<String, Object> map);

    Orderform detail(String id);

    int changeStage(HashMap<String, String> map);

    List<Orderform> transHistory(String cid);

    List<Orderform> isTrans(String cid);
}
