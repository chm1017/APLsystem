package com.cm.APL.workbench.service;

import com.cm.APL.vo.PaginationVO;
import com.cm.APL.workbench.domain.Product;
import com.cm.APL.workbench.domain.charts.ProductSailNumber;

public interface ChartService {
    PaginationVO<ProductSailNumber> getProductNumber();

    boolean getMPBoss();
}
