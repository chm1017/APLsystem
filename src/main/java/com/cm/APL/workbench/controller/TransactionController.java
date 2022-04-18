package com.cm.APL.workbench.controller;


import com.cm.APL.utils.DateTimeUtil;
import com.cm.APL.utils.PrintJson;
import com.cm.APL.utils.ServiceFactory;
import com.cm.APL.utils.UUIDUtil;
import com.cm.APL.vo.PaginationVO;
import com.cm.APL.workbench.domain.Order;
import com.cm.APL.workbench.domain.OrderId;
import com.cm.APL.workbench.domain.Orderform;
import com.cm.APL.workbench.domain.Product;
import com.cm.APL.workbench.service.Impl.ProductServiceImpl;
import com.cm.APL.workbench.service.Impl.TransactionServiceImpl;
import com.cm.APL.workbench.service.ProductService;
import com.cm.APL.workbench.service.TransactionService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;

public class TransactionController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/workbench/transaction/getProductById.do".equals(path)) {
            getProductById(request, response);
        } else if ("/workbench/transaction/add.do".equals(path)) {
            add(request, response);
        } else if ("/workbench/transaction/addProductToOrder.do".equals(path)) {
            addProductToOrder(request, response);
        } else if ("/workbench/transaction/orderProductList.do".equals(path)) {
            orderProductList(request, response);
        } else if ("/workbench/transaction/getSumByOrderId.do".equals(path)) {
            getSumByOrderId(request, response);
        } else if ("/workbench/transaction/saveOrder.do".equals(path)) {
            saveOrder(request, response);
        } else if ("/workbench/transaction/orderListPage.do".equals(path)) {
            orderListPage(request, response);
        } else if ("/workbench/transaction/detail.do".equals(path)) {
            detail(request, response);
        }
    }

    private void detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        TransactionService service = (TransactionService) ServiceFactory.getService(new TransactionServiceImpl());
        Orderform o = service.detail(id);
        request.setAttribute("o",o);
        request.getRequestDispatcher("/workbench/transaction/detail.jsp").forward(request, response);
    }

    private void orderListPage(HttpServletRequest request, HttpServletResponse response) {
        String pageSizeStr = request.getParameter("pageSize");
        String pageNOStr = request.getParameter("pageNo");
        int pageNo = Integer.parseInt(pageNOStr);
        int pageSize = Integer.parseInt(pageSizeStr);
        int skipCount = (pageNo - 1) * pageSize;
        HashMap<String, Object> map = new HashMap<>();
        map.put("pageSize", pageSize);
        map.put("skipCount", skipCount);
        TransactionService service = (TransactionService) ServiceFactory.getService(new TransactionServiceImpl());
        PaginationVO<Orderform> vo = service.orderListPage(map);
        PrintJson.printJsonObj(response, vo);

    }

    private void saveOrder(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("jinlail ");
        String createDate = DateTimeUtil.getSysTime();
        String name = request.getParameter("name");
        String countStr = request.getParameter("count");
        double count = Double.parseDouble(countStr);
        String createBy = request.getParameter("createBy");
        System.out.println(createBy);
        String carid = request.getParameter("carid");
        String description = request.getParameter("description");
        String id = request.getParameter("oid");
        String stage = request.getParameter("stage");
        Orderform o = new Orderform();
        o.setId(id);
        o.setName(name);
        o.setCount(count);
        o.setCreateBy(createBy);
        o.setCreateDate(createDate);
        o.setCarid(carid);
        o.setStage(stage);
        o.setDescription(description);
        TransactionService service = (TransactionService) ServiceFactory.getService(new TransactionServiceImpl());
        boolean flag = service.saveOrder(o);
        PrintJson.printJsonFlag(response, flag);

    }

    private void getSumByOrderId(HttpServletRequest request, HttpServletResponse response) {
        String oid = request.getParameter("oid");
        TransactionService service = (TransactionService) ServiceFactory.getService(new TransactionServiceImpl());
        Orderform orderform = service.getSumByOrderId(oid);
        PrintJson.printJsonObj(response,orderform);

    }

    private void orderProductList(HttpServletRequest request, HttpServletResponse response) {
        String oid = request.getParameter("oid");
        String pageNoStr = request.getParameter("pageNo");

        String pageSizeStr = request.getParameter("pageSize");
        int pageNo = Integer.parseInt(pageNoStr);
        int pageSize = Integer.parseInt(pageSizeStr);
        int skipCount = (pageNo - 1) * pageSize;
        HashMap<String, Object> map = new HashMap<>();
        map.put("pageSize", pageSize);
        map.put("skipCount", skipCount);
        map.put("oid", oid);
        TransactionService service = (TransactionService) ServiceFactory.getService(new TransactionServiceImpl());
        PaginationVO<Order> vo = service.orderProductList(map);
        PrintJson.printJsonObj(response, vo);
    }

    private void addProductToOrder(HttpServletRequest request, HttpServletResponse response) {
        String id = UUIDUtil.getUUID();
        String pname = request.getParameter("pname");
        System.out.println(pname);
        String mname = request.getParameter("mname");
        String priceStr = request.getParameter("price");
        String createDate = request.getParameter("createDate");
        String countStr = request.getParameter("count");
        String oid = request.getParameter("oid");
        String paddress = request.getParameter("paddress");
        double price = Double.parseDouble(priceStr);
        int count = Integer.parseInt(countStr);
        Double totalprice = count*price;
        Order o = new Order();
        o.setId(id);
        o.setPname(pname);
        o.setMname(mname);
        o.setCreateDate(createDate);
        o.setOid(oid);
        o.setPaddress(paddress);
        o.setPrice(price);
        o.setCount(count);
        o.setTotalprice(totalprice);
        TransactionService service = (TransactionService) ServiceFactory.getService(new TransactionServiceImpl());
        Boolean flag = service.addProductToOrder(o);
        PrintJson.printJsonFlag(response, flag);
    }

    private void add(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderid = UUIDUtil.getUUID();
        OrderId oId = new OrderId();
        oId.setId(orderid);
        request.setAttribute("oid",oId);
        request.getRequestDispatcher("/workbench/transaction/save2.jsp").forward(request, response);
    }

    private void getProductById(HttpServletRequest request, HttpServletResponse response) {
        String pid = request.getParameter("pid");
        ProductService service = (ProductService) ServiceFactory.getService(new ProductServiceImpl());
        Product p = service.getProductById(pid);
        PrintJson.printJsonObj(response, p);
    }
}
