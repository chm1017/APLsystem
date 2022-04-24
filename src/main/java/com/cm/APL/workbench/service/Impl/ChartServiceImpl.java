package com.cm.APL.workbench.service.Impl;

import com.cm.APL.utils.SqlSessionUtil;
import com.cm.APL.vo.PaginationVO;
import com.cm.APL.workbench.dao.OrderDao;
import com.cm.APL.workbench.domain.Product;
import com.cm.APL.workbench.domain.charts.ProductSailNumber;
import com.cm.APL.workbench.service.ChartService;

import java.util.List;

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
}
