package servlets;

import dao.ArticlesDao;
import dao.UserDao;
import javaBean.ArticlesBean;
import security.Md5;
import javaBean.UserBean;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/login")
public class LoginServlet extends HttpServlet{
    public void doGet(HttpServletRequest request, HttpServletResponse response)throws
            ServletException, IOException{
        doPost(request, response);
    }
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)throws
            ServletException, IOException{
        //获得从某网页发来的请求的session
        HttpSession session = request.getSession();
        //获得表单提交的account和password和输入验证码
        String account = request.getParameter("account");
        String password = request.getParameter("password");
        String code = request.getParameter("code");
        //创建一个用户Bean类
        UserBean userBean = new UserBean();
        //创建一个UserDao
        UserDao userDao = new UserDao();
        String ranStr = (String) session.getAttribute("randStr");
        //设置登入信息：验证码错误，登入密码错误，登入账号不存在
        String loginState;
        String loginTage;
        boolean isLogin = false;
        if (code.equals(ranStr)){
            try {
                loginTage = userDao.loginUser(account, password);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
            if (loginTage.equals("-1")){
                loginState="用户不存在";
                session.setAttribute("loginState", loginState);
            }else if (loginTage.equals("0")){
                loginState="密码不正确";
                session.setAttribute("loginState", loginState);
            }else {
                loginState="登入成功！";
                isLogin = true;

                try {
                    UserBean user = userDao.getInfo(account);
                    session.setAttribute("username", user.getUserName());
                    session.setAttribute("userAccount", user.getUserID());
                    session.setAttribute("userPhoto", "./avatars/"+user.getUserPhoto());

                    //获取个人文章

//                    ArticlesDao articlesDao = new ArticlesDao();
//                    ArrayList<ArticlesBean> articlesBeans = articlesDao.getUserAll(user.getUserID());
//                    if (!articlesBeans.isEmpty()){
//                        session.setAttribute("oneUserArticles", articlesBeans);
//                    }


                } catch (Exception e) {
                    throw new RuntimeException(e);
                }

            }

        }else {
            loginState = "验证码错误";
            session.setAttribute("loginState", loginState);
        }
        if (isLogin){
            request.getRequestDispatcher("admin.jsp").forward(request, response);
        }else {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }

    }



//    public void doPost(HttpServletRequest request, HttpServletResponse response)throws
//            ServletException, IOException{
//        //获得从某网页发来的请求的session
//        HttpSession session = request.getSession();
//        //获得表单提交的account和password和输入验证码
//        String account = request.getParameter("account");
//        String password = request.getParameter("password");
//        String code = request.getParameter("code");
//        //创建一个用户Bean类
//        UserBean userBean = new UserBean();
//        //创建一个UserDao
//        UserDao userDao = new UserDao();
//
//
//        String ranStr = (String) session.getAttribute("randStr");
//        //设置登入信息：验证码错误，登入密码错误，登入账号不存在
//        String loginState;
//        String loginTage;
//        if (code.equals(ranStr)){
//            try {
//                loginTage = userDao.loginUser(account, password);
//            } catch (Exception e) {
//                throw new RuntimeException(e);
//            }
//            if (loginTage.equals("-1")){
//                loginState="用户不存在";
//                session.setAttribute("loginState", loginState);
//                response.sendRedirect("http://localhost/demo3_war");
//            }else if (loginTage.equals("0")){
//                loginState="密码不正确";
//                session.setAttribute("loginState", loginState);
//                response.sendRedirect("http://localhost/demo3_war");
//            }else {
//                loginState="登入成功！";
//
//                try {
//                    UserBean user = userDao.getInfo(account);
//                    session.setAttribute("username", user.getUserName());
//                    session.setAttribute("userAccount", user.getUserID());
//                    session.setAttribute("userPhoto", user.getUserPhoto());
//                } catch (Exception e) {
//                    throw new RuntimeException(e);
//                }
//                response.sendRedirect("http://localhost/demo3_war/admin.jsp");
//
//            }
//
//        }else {
//            loginState = "验证码错误";
//            session.setAttribute("loginState", loginState);
//            response.sendRedirect("http://localhost/demo3_war");
//
//        }
//
//    }


}
