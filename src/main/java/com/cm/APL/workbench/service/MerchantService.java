package com.cm.APL.workbench.service;


import com.cm.APL.vo.PaginationVO;
import com.cm.APL.workbench.domain.Merchant;

import java.util.HashMap;
import java.util.List;

public interface MerchantService {
    boolean save(Merchant merchant);

    PaginationVO<Merchant> pageList(HashMap<String, Object> map);

    List<Merchant> getMerchantList();
}
