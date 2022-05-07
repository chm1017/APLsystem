package com.cm.APL.workbench.controller;

import com.cm.APL.vo.PaginationVO;
import com.cm.APL.utils.PrintJson;
import com.cm.APL.utils.ServiceFactory;
import com.cm.APL.utils.UUIDUtil;
import com.cm.APL.workbench.domain.Car;
import com.cm.APL.workbench.domain.Driver;
import com.cm.APL.workbench.domain.Orderform;
import com.cm.APL.workbench.service.CarService;
import com.cm.APL.workbench.service.DriverService;
import com.cm.APL.workbench.service.Impl.CarServiceImpl;
import com.cm.APL.workbench.service.Impl.DriverServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

public class CarController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/workbench/car/save.do".equals(path)) {
            save(request, response);
        } else if ("/workbench/car/getDriverList.do".equals(path)) {
            getDriverList(request, response);
        } else if ("/workbench/car/pageList.do".equals(path)) {
            pageList(request, response);
        } else if ("/workbench/car/getCarList.do".equals(path)) {
            getCarList(request, response);
        } else if ("/workbench/car/detail.do".equals(path)) {
            detail(request, response);
        } else if ("/workbench/car/delete.do".equals(path)) {
            delete(request, response);
        } else if ("/workbench/car/transHistory.do".equals(path)) {
            transHistory(request, response);
        } else if ("/workbench/car/isTrans.do".equals(path)) {
            isTrans(request, response);
        }

    }

    private void isTrans(HttpServletRequest request, HttpServletResponse response) {
        String cid = request.getParameter("cid");
        CarService service = (CarService) ServiceFactory.getService(new CarServiceImpl());
        List<Orderform> orderformList = service.isTrans(cid);
        System.out.println(orderformList);

        PrintJson.printJsonObj(response, orderformList);
    }

    private void transHistory(HttpServletRequest request, HttpServletResponse response) {
        String cid = request.getParameter("cid");
        CarService service = (CarService) ServiceFactory.getService(new CarServiceImpl());
        List<Orderform> orderformList = service.transHistory(cid);
        PrintJson.printJsonObj(response, orderformList);
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) {
        String[] ids = request.getParameterValues("id");
        CarService service = (CarService) ServiceFactory.getService(new CarServiceImpl());
        boolean flag = service.delete(ids);
        PrintJson.printJsonFlag(response, flag);
    }

    private void detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cid = request.getParameter("id");
        CarService service = (CarService) ServiceFactory.getService(new CarServiceImpl());
        Car c = service.detail(cid);
        request.setAttribute("c", c);
        request.getRequestDispatcher("/workbench/car/detail.jsp").forward(request, response);

    }

    private void getCarList(HttpServletRequest request, HttpServletResponse response) {
        CarService service = (CarService) ServiceFactory.getService(new CarServiceImpl());
        List<Car> cars = service.getCarList();
        PrintJson.printJsonObj(response, cars);
    }

    private void pageList(HttpServletRequest request, HttpServletResponse response) {
        String pageNoStr = request.getParameter("pageNo");
        int pageNo = Integer.parseInt(pageNoStr);
        String pageSizeStr = request.getParameter("pageSize");
        int pageSize = Integer.parseInt(pageSizeStr);
        int skipCount = (pageNo - 1) * pageSize;
        HashMap<String, Object> map = new HashMap<>();
        map.put("pageSize", pageSize);
        map.put("skipCount", skipCount);
        CarService service = (CarService) ServiceFactory.getService(new CarServiceImpl());
        PaginationVO<Car> vo = service.pageList(map);
        PrintJson.printJsonObj(response, vo);
    }

    private void getDriverList(HttpServletRequest request, HttpServletResponse response) {
        DriverService service = (DriverService) ServiceFactory.getService(new DriverServiceImpl());
        List<Driver> drivers = service.getDriverList();
        PrintJson.printJsonObj(response, drivers);
    }

    private void save(HttpServletRequest request, HttpServletResponse response) {
        String cid = UUIDUtil.getUUID();
        String plateNo = request.getParameter("plateNo");
        String cplace = request.getParameter("cplace");
        String stage = request.getParameter("stage");
        String company = request.getParameter("company");
        String did = request.getParameter("did");
        String cload = request.getParameter("cload");
        String fdjId = request.getParameter("fdjId");
        String baoxianId = request.getParameter("baoxianId");
        String description = request.getParameter("description");
        String cname = request.getParameter("cname");
        String createBy = request.getParameter("createBy");
        Car c = new Car();
        c.setCid(cid);
        c.setPlateNo(plateNo);
        c.setCplace(cplace);
        c.setStage(stage);
        c.setCompany(company);
        c.setDid(did);
        c.setCload(cload);
        c.setFdjId(fdjId);
        c.setBaoxianId(baoxianId);
        c.setDescription(description);
        c.setCname(cname);
        c.setCreateBy(createBy);
        CarService service = (CarService) ServiceFactory.getService(new CarServiceImpl());
        boolean flag = service.save(c);
        PrintJson.printJsonFlag(response, flag);
    }
}
