package com.cm.APL.workbench.controller;


import com.cm.APL.settings.domain.User;
import com.cm.APL.settings.service.Impl.UserServiceImpl;
import com.cm.APL.settings.service.UserService;
import com.cm.APL.utils.DateTimeUtil;
import com.cm.APL.utils.PrintJson;
import com.cm.APL.utils.ServiceFactory;
import com.cm.APL.utils.UUIDUtil;
import com.cm.APL.vo.PaginationVO;
import com.cm.APL.workbench.domain.Merchant;
import com.cm.APL.workbench.service.Impl.MerchantServiceImpl;
import com.cm.APL.workbench.service.MerchantService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

public class MerchantController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/workbench/merchant/getUserList.do".equals(path)) {
            getUserList(request, response);
        } else if ("/workbench/merchant/save.do".equals(path)) {
            save(request, response);
        } else if ("/workbench/merchant/pageList.do".equals(path)) {
            pageList(request, response);
        } else if ("/workbench/merchant/detail.do".equals(path)) {
            detail(request, response);
        } else if ("/workbench/merhchant/getMerchantById.do".equals(path)) {
            getMerchantById(request, response);
        } else if ("/workbench/merchant/update.do".equals(path)) {
            update(request, response);
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response) {
        String createBy = request.getParameter("createBy");
        String mid = request.getParameter("mid");
        String mname = request.getParameter("mname");
        String mage = request.getParameter("mage");
        String madress = request.getParameter("madress");
        String memail = request.getParameter("memail");
        String mphone = request.getParameter("mphone");
        String company = request.getParameter("company");
        String description = request.getParameter("description");
        String editDate = DateTimeUtil.getSysTime();
        Merchant m = new Merchant();
        m.setMid(mid);
        m.setCreateBy(createBy);
        m.setMname(mname);
        m.setMage(mage);
        m.setMaddress(madress);
        m.setMemail(memail);
        m.setMphone(mphone);
        m.setCompany(company);
        m.setEditDate(editDate);
        m.setDescription(description);
        MerchantService service = (MerchantService) ServiceFactory.getService(new MerchantServiceImpl());
        boolean flag = service.update(m);
        PrintJson.printJsonFlag(response,flag);

    }

    private void getMerchantById(HttpServletRequest request, HttpServletResponse response) {
        String mid = request.getParameter("mid");
        MerchantService service = (MerchantService) ServiceFactory.getService(new MerchantServiceImpl());
        HashMap < String, Object> map= service.getMerchantById(mid);
        PrintJson.printJsonObj(response, map);
    }

    private void detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String mid = request.getParameter("id");
        MerchantService service = (MerchantService) ServiceFactory.getService(new MerchantServiceImpl());
        Merchant m = service.detail(mid);
        request.setAttribute("m",m);
        request.getRequestDispatcher("/workbench/merchant/detail.jsp").forward(request, response);

    }

    private void pageList(HttpServletRequest request, HttpServletResponse response) {
        String pageNoStr = request.getParameter("pageNo");
        int pageNo = Integer.parseInt(pageNoStr);
        String pageSizeStr = request.getParameter("pageSize");
        int pageSize = Integer.parseInt(pageSizeStr);

        int skipCount = (pageNo - 1) * pageSize;
        System.out.println("跳过的数据"+skipCount);

        String mname = request.getParameter("mname");
        String mphone = request.getParameter("mphone");
        String maddress = request.getParameter("maddress");
        String description = request.getParameter("description");
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("mname",mname);
        map.put("mphone", mphone);
        map.put("maddress", maddress);
        map.put("description", description);
        map.put("skipCount", skipCount);
        map.put("pageSize", pageSize);

        MerchantService service = (MerchantService) ServiceFactory.getService(new MerchantServiceImpl());
        PaginationVO<Merchant> vo = service.pageList(map);
        PrintJson.printJsonObj(response, vo);

    }

    private void save(HttpServletRequest request, HttpServletResponse response) {
        String mid = UUIDUtil.getUUID();
        String createBy = request.getParameter("createBy");
        String mname = request.getParameter("mname");
        String mage = request.getParameter("mage");
        String madress = request.getParameter("madress");
        String memail = request.getParameter("memail");
        String mphone = request.getParameter("mphone");
        String company = request.getParameter("company");
        String createDate = request.getParameter("createDate");
        String description = request.getParameter("description");
        Merchant m = new Merchant();
        m.setMid(mid);
        m.setCreateBy(createBy);
        m.setMname(mname);
        m.setMage(mage);
        m.setMaddress(madress);
        m.setMemail(memail);
        m.setMphone(mphone);
        m.setCompany(company);
        m.setCreateDate(createDate);
        m.setDescription(description);

        MerchantService service = (MerchantService) ServiceFactory.getService(new MerchantServiceImpl());
        boolean flag = service.save(m);
        PrintJson.printJsonFlag(response,flag);
    }

    private void getUserList(HttpServletRequest request, HttpServletResponse response) {

        UserService us = (UserService) ServiceFactory.getService(new UserServiceImpl());
        List<User> userList = us.getUserList();
        PrintJson.printJsonObj(response,userList);
    }
}
