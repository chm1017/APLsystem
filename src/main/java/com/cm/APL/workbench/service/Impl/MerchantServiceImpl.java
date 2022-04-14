package com.cm.APL.workbench.service.Impl;

import com.bjpowernode.crm.vo.PaginationVO;
import com.cm.APL.utils.SqlSessionUtil;
import com.cm.APL.workbench.dao.MerchantDao;
import com.cm.APL.workbench.domain.Merchant;
import com.cm.APL.workbench.service.MerchantService;

import java.awt.*;
import java.util.HashMap;
import java.util.List;

public class MerchantServiceImpl implements MerchantService {
    private MerchantDao merchantDao = SqlSessionUtil.getSqlSession().getMapper(MerchantDao.class);
    @Override
    public boolean save(Merchant merchant) {

        int i =merchantDao.save(merchant);
        if (i != 1) {
            return false;
        }
        return true;
    }

    @Override
    public PaginationVO<Merchant> pageList(HashMap<String, Object> map) {
        int total = merchantDao.getTotalByCondition(map);
        System.out.println(total+"查到的总数");
        List<Merchant> dataList = merchantDao.getMerchantListByCondition(map);
        PaginationVO<Merchant> vo = new PaginationVO<Merchant>();
        vo.setDataList(dataList);
        vo.setTotal(total);
        return vo;
    }

    @Override
    public List<Merchant> getMerchantList() {
        List<Merchant> merchantList = merchantDao.getMerchantList();
        return merchantList;
    }
}
