package servlets;


import dao.ArticlesDao;
import javaBean.ArticlesBean;

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


@WebServlet("/sendArticle")
@MultipartConfig
public class SubmitArticleServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
        ArticlesBean articlesBean = new ArticlesBean();
        String title = req.getParameter("title");


        String authorName = req.getParameter("author");
        HttpSession session = req.getSession();
        String authorID = (String) session.getAttribute("userAccount");
        authorID = "207621";
        String content = req.getParameter("content");
        Part avatarPart = req.getPart("image");
        articlesBean.setTitle(title);
        articlesBean.setA_content(content);
        articlesBean.setForm_id(authorID);


        if (avatarPart == null || avatarPart.getSize() == 0) {

        }else {
            String uploadPath = getServletContext().getRealPath("") + File.separator + "articles";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();
            String fileName = authorID + "_" + avatarPart.getSubmittedFileName();


            articlesBean.setAphoto(fileName);


            File avatarFile = new File(uploadPath + File.separator + fileName);
            try (InputStream inputStream = avatarPart.getInputStream()) {
                Files.copy(inputStream, avatarFile.toPath());
            }
        }

        ArticlesDao articlesDao = new ArticlesDao();
        boolean isAdd=false;
        try {
            isAdd = articlesDao.isInsert(articlesBean);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        String subArtState;

        if (isAdd){
            subArtState = "上传文章成功";
            session.setAttribute("subArtState", subArtState);
            req.getRequestDispatcher("admin.jsp").forward(req, resp);
        }

    }
}
