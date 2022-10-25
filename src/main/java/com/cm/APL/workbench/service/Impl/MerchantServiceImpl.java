package com.cm.APL.workbench.service.Impl;


import com.cm.APL.settings.dao.UserDao;
import com.cm.APL.settings.domain.User;
import com.cm.APL.utils.SqlSessionUtil;
import com.cm.APL.vo.PaginationVO;
import com.cm.APL.workbench.dao.MerchantDao;
import com.cm.APL.workbench.domain.Merchant;
import com.cm.APL.workbench.service.MerchantService;

import java.util.HashMap;
import java.util.List;

public class MerchantServiceImpl implements MerchantService {
    private MerchantDao merchantDao = SqlSessionUtil.getSqlSession().getMapper(MerchantDao.class);
    private UserDao userDao = SqlSessionUtil.getSqlSession().getMapper(UserDao.class);
    @Override
    public boolean save(Merchant merchant) {
        int i =merchantDao.save(merchant);
        if (i != 1) {return false;}
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

    @Override
    public Merchant detail(String mid) {
        Merchant m = merchantDao.detail(mid);
        return m;
    }

    @Override
    public HashMap<String, Object> getMerchantById(String mid) {
        List<User> userList = userDao.getUserList();
        Merchant merchant = merchantDao.getMerchantById(mid);
        HashMap<String, Object> map = new HashMap<>();
        map.put("a", merchant);
        map.put("uList", userList);
        return map;
    }

    @Override
    public boolean update(Merchant m) {
        int i = merchantDao.update(m);
        if (i != 1) {return false;}
        return true;
    }

    @Override
    public boolean delete(String[] ids) {
        int i =merchantDao.delete(ids);
        if (i != ids.length) {return false;}
        return true;
    }
}
