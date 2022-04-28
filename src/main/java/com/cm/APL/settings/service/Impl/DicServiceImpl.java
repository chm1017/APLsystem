package com.cm.APL.settings.service.Impl;

import com.cm.APL.settings.dao.DicDao;
import com.cm.APL.settings.domain.DicType;
import com.cm.APL.settings.service.DicService;
import com.cm.APL.utils.SqlSessionUtil;

import java.util.List;

public class DicServiceImpl implements DicService {
    private DicDao dicDao = SqlSessionUtil.getSqlSession().getMapper(DicDao.class);
    @Override
    public List<DicType> getType() {
        List<DicType> dicTypeList = dicDao.getType();
        return dicTypeList;
    }
}
