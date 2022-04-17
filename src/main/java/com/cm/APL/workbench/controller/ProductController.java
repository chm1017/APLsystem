package com.cm.APL.workbench.controller;


import com.cm.APL.settings.domain.User;
import com.cm.APL.settings.service.Impl.UserServiceImpl;
import com.cm.APL.settings.service.UserService;
import com.cm.APL.utils.PrintJson;
import com.cm.APL.utils.ServiceFactory;
import com.cm.APL.utils.UUIDUtil;

import com.cm.APL.vo.PaginationVO;
import com.cm.APL.workbench.domain.Product;
import com.cm.APL.workbench.domain.Merchant;
import com.cm.APL.workbench.service.Impl.MerchantServiceImpl;
import com.cm.APL.workbench.service.Impl.ProductServiceImpl;
import com.cm.APL.workbench.service.MerchantService;
import com.cm.APL.workbench.service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

public class ProductController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/workbench/product/getUserList.do".equals(path)) {
            getUserList(request, response);
        } else if ("/workbench/product/getMerchantList.do".equals(path)) {
            getMerchantList(request, response);
        } else if ("/workbench/project/save.do".equals(path)) {
            save(request, response);
        } else if ("/workbench/product/pageList.do".equals(path)) {
            pageList(request, response);
        }
    }

    private void pageList(HttpServletRequest request, HttpServletResponse response) {
        String pname = request.getParameter("pname");
        String paddress = request.getParameter("paddress");
        String mid = request.getParameter("mid");
        String createDate = request.getParameter("createDate");
        String endDate = request.getParameter("endDate");
        String pageNoStr = request.getParameter("pageNo");
        int pageNo = Integer.parseInt(pageNoStr);
        String pageSizeStr = request.getParameter("pageSize");
        int pageSize = Integer.parseInt(pageSizeStr);
        int skipCount = (pageNo-1)*pageSize;
        HashMap<String, Object> map = new HashMap<>();
        map.put("pageSize", pageSize);
        map.put("skipCount", skipCount);
        map.put("pname", pname);
        map.put("paddress", paddress);
        map.put("mid", mid);
        map.put("createDate", createDate);
        map.put("endDate", endDate);
        ProductService service = (ProductService) ServiceFactory.getService(new ProductServiceImpl());
        PaginationVO<Product> vo = service.pageList(map);
        PrintJson.printJsonObj(response, vo);
    }

    private void save(HttpServletRequest request, HttpServletResponse response) {
        String pid = UUIDUtil.getUUID();
        String pname = request.getParameter("pname");
        String createDate = request.getParameter("createDate");
        String endDate = request.getParameter("endDate");
        String paddress = request.getParameter("paddress");
        String priceStr = request.getParameter("price");
        double price = Double.parseDouble(priceStr);
        String numberStr = request.getParameter("number");
        int number = Integer.parseInt(numberStr);
        String mid = request.getParameter("mid");
        String description = request.getParameter("description");
        String createBy = request.getParameter("createBy");
        Product fp = new Product();
        fp.setPid(pid);
        fp.setPname(pname);
        fp.setCreateDate(createDate);
        fp.setEndDate(endDate);
        fp.setPaddress(paddress);
        fp.setPrice(price);
        fp.setNumber(number);
        fp.setMid(mid);
        fp.setDescription(description);
        fp.setCreateBy(createBy);

        ProductService service = (ProductService) ServiceFactory.getService(new ProductServiceImpl());


        boolean flag =service.save(fp);
        PrintJson.printJsonFlag(response, flag);


    }

    private void getMerchantList(HttpServletRequest request, HttpServletResponse response) {
        MerchantService service = (MerchantService) ServiceFactory.getService(new MerchantServiceImpl());
        List<Merchant> merchantList = service.getMerchantList();
        PrintJson.printJsonObj(response, merchantList);
    }

    private void getUserList(HttpServletRequest request, HttpServletResponse response) {
        UserService service = (UserService) ServiceFactory.getService(new UserServiceImpl());
        List<User> userList = service.getUserList();
        PrintJson.printJsonObj(response,userList);

    }
}
