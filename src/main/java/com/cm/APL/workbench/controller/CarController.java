package com.cm.APL.workbench.controller;

import com.bjpowernode.crm.vo.PaginationVO;
import com.cm.APL.utils.PrintJson;
import com.cm.APL.utils.ServiceFactory;
import com.cm.APL.utils.UUIDUtil;
import com.cm.APL.workbench.domain.Car;
import com.cm.APL.workbench.domain.Driver;
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
        }

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