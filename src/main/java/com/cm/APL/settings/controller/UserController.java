package com.cm.APL.settings.controller;

import com.cm.APL.settings.domain.User;
import com.cm.APL.settings.service.Impl.UserServiceImpl;
import com.cm.APL.settings.service.UserService;
import com.cm.APL.utils.MD5Util;
import com.cm.APL.utils.PrintJson;
import com.cm.APL.utils.ServiceFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;

public class UserController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/settings/user/login.do".equals(path)) {
            login(request, response);
        } else if ("/settings/user/eqPwd.do".equals(path)) {
            eqPwd(request, response);
        } else if ("/settings/user/updatePwd.do".equals(path)) {
            updatePwd(request, response);
        }

    }

    private void updatePwd(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        String loginPwd = request.getParameter("confirmPwd");
        String md5 = MD5Util.getMD5(loginPwd);
        UserService service = (UserService) ServiceFactory.getService(new UserServiceImpl());
        User user = new User();
        user.setId(id);
        user.setLoginPwd(md5);

        boolean flag = service.updatePwd(user);
        PrintJson.printJsonFlag(response, flag);

    }

    private void eqPwd(HttpServletRequest request, HttpServletResponse response) {
        String loginPwd = request.getParameter("loginPwd");
        String oldPwd = request.getParameter("oldPwd");
        String md5 = MD5Util.getMD5(oldPwd);
        boolean flag = false;
        if (md5.equals(loginPwd)) {
            flag = true;
        }
        PrintJson.printJsonFlag(response, flag);
    }

    private void login(HttpServletRequest request, HttpServletResponse response) {
        String loginAct = request.getParameter("loginAct");
        String loginPwd = request.getParameter("loginPwd");
        String md5 = MD5Util.getMD5(loginPwd);
        String ip = request.getRemoteAddr();
        UserService service = (UserService) ServiceFactory.getService(new UserServiceImpl());
        try {
            User user = service.login(loginAct, md5, ip);
            request.getSession().setAttribute("user",user);
            PrintJson.printJsonFlag(response,true);
        } catch (Exception e) {
            e.printStackTrace();
            String msg = e.getMessage();
            HashMap<String, Object> map = new HashMap<>();
            map.put("success", false);
            map.put("msg", msg);
            PrintJson.printJsonObj(response, map);
        }

    }
}
