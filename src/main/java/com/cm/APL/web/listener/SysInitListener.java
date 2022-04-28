package com.cm.APL.web.listener;

import com.cm.APL.settings.domain.DicType;
import com.cm.APL.settings.service.DicService;
import com.cm.APL.settings.service.Impl.DicServiceImpl;
import com.cm.APL.utils.ServiceFactory;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.HashMap;
import java.util.List;

public class SysInitListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent event) {
        ServletContext application = event.getServletContext();
        DicService service = (DicService) ServiceFactory.getService(new DicServiceImpl());
        List<DicType> dicTypeList = service.getType();
        HashMap<String, List<DicType>> map = new HashMap<>();
        application.setAttribute("dic", dicTypeList);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

    }
}
