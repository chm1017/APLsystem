package com.cm.APL.workbench.dao;

import com.cm.APL.workbench.domain.Merchant;

import java.util.HashMap;
import java.util.List;

public interface MerchantDao {
    int save(Merchant merchant);

    int getTotalByCondition(HashMap<String, Object> map);

    List<Merchant> getMerchantListByCondition(HashMap<String, Object> map);

    List<Merchant> getMerchantList();

    Merchant detail(String mid);
}
