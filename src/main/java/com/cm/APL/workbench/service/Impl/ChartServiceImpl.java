package com.cm.APL.workbench.service.Impl;

import com.cm.APL.utils.SqlSessionUtil;
import com.cm.APL.vo.PaginationVO;
import com.cm.APL.workbench.dao.OrderDao;
import com.cm.APL.workbench.domain.Product;
import com.cm.APL.workbench.domain.charts.MPBoss;
import com.cm.APL.workbench.domain.charts.MPvo;
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
    public MPvo getMPBoss() {
        List<MPBoss> MPlist = orderDao.getMPBoss();

        HashSet<String> pset = new HashSet<>();
        HashSet<String> mset = new HashSet<>();
        MPlist.forEach(mpBoss -> pset.add(mpBoss.getPname())
        );
        MPlist.forEach(mpBoss -> mset.add(mpBoss.getMname())
        );
        int pl = pset.size();
        int ml = mset.size();
        List<String> mlist = new ArrayList<>();
        mlist.addAll(mset);
        ArrayList<String> plist = new ArrayList<>();
        plist.addAll(pset);
        ArrayList<ArrayList<Integer>> data = new ArrayList<>();
        for (int i = 0; i < plist.size(); i++) {
            for (int j = 0 ; j <mlist.size();j++) {
                String pname = plist.get(i);
                String mname = mlist.get(j);
                for (int k = 0; k < MPlist.size(); k++) {
                    String mname1 = MPlist.get(k).getMname();
                    String pname1 = MPlist.get(k).getPname();
                    ArrayList<Integer> list = new ArrayList<>();
                    list.add(i);
                    list.add(j);
                    if (pname.equals(pname1) && mname.equals(mname1)) {
                        list.add(MPlist.get(k).getTol());
                    } else {
                        list.add(0);
                    }
                    data.add(list);
                }
            }
        }
        MPvo vo = new MPvo();
        vo.setData(data);
        vo.setM(mlist);
        vo.setP(plist);
        return vo;
    }
}
