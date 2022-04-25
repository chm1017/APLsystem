package com.cm.APL.workbench.service.Impl;

import com.cm.APL.utils.SqlSessionUtil;
import com.cm.APL.vo.PaginationVO;
import com.cm.APL.workbench.dao.OrderDao;
import com.cm.APL.workbench.domain.Product;
import com.cm.APL.workbench.domain.charts.MPBoss;
import com.cm.APL.workbench.domain.charts.ProductSailNumber;
import com.cm.APL.workbench.service.ChartService;

import java.util.*;

public class ChartServiceImpl implements ChartService {
    private OrderDao orderDao = SqlSessionUtil.getSqlSession().getMapper(OrderDao.class);
    @Override
    public PaginationVO<ProductSailNumber> getProductNumber() {
        int total = orderDao.getProductType();
        List<ProductSailNumber> productList = orderDao.getProductSailNumber();
        PaginationVO<ProductSailNumber> vo = new PaginationVO<ProductSailNumber>();
        vo.setDataList(productList);
        vo.setTotal(total);
        return vo;
    }

    @Override
    public boolean getMPBoss() {
        List<MPBoss> lists = orderDao.getMPBoss();

        Set<String> ptype = new HashSet<>();
        Set<String> mtype = new HashSet<>();
        for(int i =0 ; i<lists.size();i++){
            MPBoss m = lists.get(i);
            mtype.add(m.getMname());
            ptype.add(m.getPname());
        }
        int i = 0;
        HashMap<String, String> map = new HashMap<String, String>();
        for (String s : ptype) {
            System.out.println(s);
            i++;
            System.out.println(map.get(s));
        }

        return true;
    }

}
