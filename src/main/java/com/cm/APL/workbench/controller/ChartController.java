package com.cm.APL.workbench.controller;

import com.cm.APL.utils.PrintJson;
import com.cm.APL.utils.ServiceFactory;
import com.cm.APL.vo.PaginationVO;
import com.cm.APL.workbench.domain.Product;
import com.cm.APL.workbench.domain.charts.ProductSailNumber;
import com.cm.APL.workbench.service.ChartService;
import com.cm.APL.workbench.service.Impl.ChartServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ChartController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/workbench/chart/getProductNumber.do".equals(path)) {
            getProductNumber(request, response);
        } else if ("/workbench/chart/getMPBoss.do".equals(path)) {
            getMPBoss(request, response);
        }
    }

    private void getMPBoss(HttpServletRequest request, HttpServletResponse response) {
        ChartService service = (ChartService) ServiceFactory.getService(new ChartServiceImpl());
        boolean flag = service.getMPBoss();
        PrintJson.printJsonFlag(response, true);
    }

    private void getProductNumber(HttpServletRequest request, HttpServletResponse response) {
        ChartService service = (ChartService) ServiceFactory.getService(new ChartServiceImpl());
        PaginationVO<ProductSailNumber> vo= service.getProductNumber();
        PrintJson.printJsonObj(response, vo);
    }


}
