package com.cm.APL.workbench.service.Impl;

import com.cm.APL.utils.SqlSessionUtil;
import com.cm.APL.workbench.dao.Product;
import com.cm.APL.workbench.domain.Fproduct;
import com.cm.APL.workbench.service.ProductService;

public class ProductServiceImpl implements ProductService {
    private Product projectDao = SqlSessionUtil.getSqlSession().getMapper(Product.class);
    @Override
    public boolean save(Fproduct fp) {
        int i = projectDao.save(fp);
        if (i != 1) {
            return false;
        }
        return true;
    }
}
