package com.cm.APL.workbench.service;


import com.cm.APL.workbench.domain.OrderHistoryVo;
import com.cm.APL.vo.PaginationVO;
import com.cm.APL.workbench.domain.Product;

import java.util.HashMap;
import java.util.List;

public interface ProductService {
    boolean save(Product fp);

    PaginationVO<Product> pageList(HashMap<String, Object> map);

    Product getProductById(String pid);

    Product detail(String pid);

    int updateProductNumberById(Integer repertory,String pid );


    List<OrderHistoryVo> getProductHistory(String pid);
}
