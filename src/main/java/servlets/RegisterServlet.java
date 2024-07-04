package servlets;

import dao.UserDao;
import javaBean.UserBean;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;

//@MultipartConfig(
//        fileSizeThreshold = 1024 * 1024 * 1,  // 1 MB
//        maxFileSize = 1024 * 1024 * 10,       // 10 MB
//        maxRequestSize = 1024 * 1024 * 50     // 50 MB
//)
@WebServlet("/register")
@MultipartConfig
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取表单字段
        String username = request.getParameter("username");
        String account = request.getParameter("account");
        String password = request.getParameter("password");
        Part avatarPart = request.getPart("avatar");

        // 检查是否成功获取到文件部分
        if (avatarPart == null || avatarPart.getSize() == 0) {
            request.setAttribute("message", "Avatar upload failed or no file selected.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }



        // 头像文件保存路径（webapp目录中的相对路径）Articles
//        String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
        String uploadPath = getServletContext().getRealPath("") + File.separator + "avatars";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();
        String uc = request.getRealPath("");

        // 生成头像文件名并保存
        String fileName = account + "_" + avatarPart.getSubmittedFileName();
        File avatarFile = new File(uploadPath + File.separator + fileName);
        try (InputStream inputStream = avatarPart.getInputStream()) {
            Files.copy(inputStream, avatarFile.toPath());
        }

        // 这里可以添加代码将用户信息保存到数据库中（例如：username, password, name, avatarFile.getName()）
        // 示例代码：saveUserToDatabase(username, password, name, avatarFile.getName());

        // 将用户信息存储在request中
//        request.setAttribute("username", username);
//        request.setAttribute("name", name);
//        request.setAttribute("avatarPath", "avatars/" + fileName);

        UserBean userBean = new UserBean();
        userBean.setUserName(username);
        userBean.setUserID(account);
        userBean.setUserCode(password);
        userBean.setUserPhoto(avatarFile.getName());

        UserDao userDao = new UserDao();
        String registerTage;
        HttpSession session = request.getSession();
        String registerState;
        try {
            registerTage = userDao.insertUser(userBean);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        if (registerTage.equals("1")){
            // 转发到成功页面
            registerState = "注册成功，请重新登入！";
            session.setAttribute("registerState", registerState);
        }else if (registerTage.equals("-1")){
            registerState = "用户已经存在，注册失败！";
            session.setAttribute("registerState", registerState);
        }else {
            registerState = "注册失败！";
            session.setAttribute("registerState", registerState);
        }
        request.getRequestDispatcher("login.jsp").forward(request, response);

    }


}
