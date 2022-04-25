package com.cm.APL.workbench.service;

import com.cm.APL.vo.PaginationVO;
import com.cm.APL.workbench.domain.Product;
import com.cm.APL.workbench.domain.charts.MPBoss;
import com.cm.APL.workbench.domain.charts.MPvo;
import com.cm.APL.workbench.domain.charts.ProductSailNumber;

import java.util.HashMap;

public interface ChartService {
    PaginationVO<ProductSailNumber> getProductNumber();


    MPvo getMPBoss();
}
