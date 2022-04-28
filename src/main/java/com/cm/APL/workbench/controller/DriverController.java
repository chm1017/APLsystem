package com.cm.APL.workbench.controller;

import com.cm.APL.utils.DateTimeUtil;
import com.cm.APL.vo.PaginationVO;
import com.cm.APL.settings.domain.User;
import com.cm.APL.settings.service.Impl.UserServiceImpl;
import com.cm.APL.settings.service.UserService;
import com.cm.APL.utils.PrintJson;
import com.cm.APL.utils.ServiceFactory;
import com.cm.APL.utils.UUIDUtil;
import com.cm.APL.workbench.domain.Driver;
import com.cm.APL.workbench.service.DriverService;
import com.cm.APL.workbench.service.Impl.DriverServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

public class DriverController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/workbench/driver/getUserList.do".equals(path)) {
            getUserList(request, response);
        } else if ("/workbench/driver/save.do".equals(path)) {
            save(request, response);
        } else if ("/workbench/driver/pageList.do".equals(path)) {
            pageList(request, response);
        } else if ("/workbench/driver/detail.do".equals(path)) {
            detail(request, response);
        } else if ("/workbench/driver/getDriverById.do".equals(path)) {
            getDriverById(request, response);
        } else if ("/workbench/driver/update.do".equals(path)) {
            update(request, response);
        } else if ("/workbench/driver/delete.do".equals(path)) {
            delete(request, response);
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) {
        String[] ids = request.getParameterValues("id");
        DriverService service = (DriverService) ServiceFactory.getService(new DriverServiceImpl());
        boolean flag = service.delete(ids);
        PrintJson.printJsonFlag(response,flag);

    }

    private void update(HttpServletRequest request, HttpServletResponse response) {
        String did = request.getParameter("did");
        String dname = request.getParameter("dname");
        String dage = request.getParameter("dage");
        String dphone = request.getParameter("dphone");
        String daddress = request.getParameter("daddress");
        String dplace = request.getParameter("dplace");
        String idNumber = request.getParameter("idNumber");
        String driveId = request.getParameter("driveId");
        String stage = request.getParameter("stage");
        String createBy = request.getParameter("createBy");
        Driver driver = new Driver();
        driver.setDid(did);
        driver.setDname(dname);
        driver.setDage(dage);
        driver.setDaddress(daddress);
        driver.setDphone(dphone);
        driver.setDplace(dplace);
        driver.setIdNumber(idNumber);
        driver.setDriveId(driveId);
        driver.setStage(stage);
        driver.setCreateBy(createBy);


        DriverService service = (DriverService) ServiceFactory.getService(new DriverServiceImpl());
        boolean flag = service.update(driver);
        PrintJson.printJsonFlag(response,flag);


    }

    private void getDriverById(HttpServletRequest request, HttpServletResponse response) {
        String did = request.getParameter("did");
        DriverService service = (DriverService) ServiceFactory.getService(new DriverServiceImpl());
        HashMap<String , Object> map = service.getDriverById(did);
        PrintJson.printJsonObj(response, map);
    }

    private void detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String did = request.getParameter("id");
        DriverService service = (DriverService) ServiceFactory.getService(new DriverServiceImpl());
        Driver d= service.detail(did);
        request.setAttribute("d", d);
        request.getRequestDispatcher("/workbench/driver/detail.jsp").forward(request, response);
    }

    private void pageList(HttpServletRequest request, HttpServletResponse response) {
        String pageNoStr = request.getParameter("pageNo");
        int pageNo = Integer.parseInt(pageNoStr);
        String pageSizeStr = request.getParameter("pageSize");
        int pageSize = Integer.parseInt(pageSizeStr);
        int skipCount = (pageNo-1)*pageSize;
        HashMap<String, Object> map = new HashMap<>();
        map.put("skipCount", skipCount);
        map.put("pageSize", pageSize);
        DriverService service = (DriverService) ServiceFactory.getService(new DriverServiceImpl());
        PaginationVO<Driver> vo =service.pageList(map);
        PrintJson.printJsonObj(response, vo);
    }

    private void save(HttpServletRequest request, HttpServletResponse response) {
        String did = UUIDUtil.getUUID();
        String dname = request.getParameter("dname");
        String dage = request.getParameter("dage");
        String dphone = request.getParameter("dphone");
        String daddress = request.getParameter("daddress");
        String dplace = request.getParameter("dplace");
        String idNumber = request.getParameter("idNumber");
        String driveId = request.getParameter("driveId");
        String stage = request.getParameter("stage");
        String createBy = request.getParameter("createBy");
        Driver driver = new Driver();
        driver.setDid(did);
        driver.setDname(dname);
        driver.setDage(dage);
        driver.setDaddress(daddress);
        driver.setDphone(dphone);
        driver.setDplace(dplace);
        driver.setIdNumber(idNumber);
        driver.setDriveId(driveId);
        driver.setStage(stage);
        driver.setCreateBy(createBy);

        DriverService service = (DriverService) ServiceFactory.getService(new DriverServiceImpl());
        boolean flag = service.save(driver);
        PrintJson.printJsonFlag(response,flag);
    }

    private void getUserList(HttpServletRequest request, HttpServletResponse response) {
        UserService service = (UserService) ServiceFactory.getService(new UserServiceImpl());
        List<User> userList = service.getUserList();
        PrintJson.printJsonObj(response, userList);
    }
}
