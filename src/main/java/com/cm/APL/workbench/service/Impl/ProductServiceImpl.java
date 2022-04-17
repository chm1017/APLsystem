package com.cm.APL.workbench.service.Impl;


import com.cm.APL.utils.SqlSessionUtil;
import com.cm.APL.vo.PaginationVO;
import com.cm.APL.workbench.dao.ProductDao;
import com.cm.APL.workbench.domain.Product;
import com.cm.APL.workbench.service.ProductService;

import java.util.HashMap;
import java.util.List;

public class ProductServiceImpl implements ProductService {
    private ProductDao productDao = SqlSessionUtil.getSqlSession().getMapper(ProductDao.class);
    @Override
    public boolean save(Product fp) {
        int i = productDao.save(fp);
        if (i != 1) {
            return false;
        }
        return true;
    }

    @Override
    public PaginationVO<Product> pageList(HashMap<String, Object> map) {
        int total = productDao.getTotalByCondition(map);

        List<Product> productList= productDao.getProductListByCondition(map);

        System.out.println(productList);

        PaginationVO<Product> vo = new PaginationVO<Product>();
        vo.setDataList(productList);
        vo.setTotal(total);

        return vo;
    }

    @Override
    public Product getProductById(String pid) {
        Product p =productDao.getProductById(pid);
        return p;
    }
}
