package com.cm.APL.workbench.dao;

import com.cm.APL.workbench.domain.Product;

import java.util.HashMap;
import java.util.List;

public interface ProductDao {
    int save(Product fp);

    int getTotalByCondition(HashMap<String, Object> map);

    List<Product> getProductListByCondition(HashMap<String, Object> map);

    Product getProductById(String pid);
}
