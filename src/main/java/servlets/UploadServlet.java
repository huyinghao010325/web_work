package servlets;

import com.jspsmart.upload.File;
import com.jspsmart.upload.SmartUpload;
import com.jspsmart.upload.SmartUploadException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

public class UploadServlet extends HttpServlet{
    public void doGet(HttpServletRequest request, HttpServletResponse response)throws
            ServletException, IOException{
        doPost(request, response);
    }
    public  void  doPost(HttpServletRequest request, HttpServletResponse response)throws
            ServletException, IOException{

        SmartUpload smartUpload = new SmartUpload();
        //初始化
        ServletConfig config = this.getServletConfig();
        smartUpload.initialize(config, request, response);
        String src;
        try {
            //上传文件
            smartUpload.upload();
            //得到上传的文件对象
            File smartFile = smartUpload.getFiles().getFile(0);
            //保存文件对象
            String src1 = "D:/javaweb/work_one/demo2/src/main/webapp/File/"+smartFile.getFileName();
            src = smartFile.getFileName();
            smartFile.saveAs(src1, SmartUpload.SAVE_PHYSICAL);
        } catch (SmartUploadException e) {
            throw new RuntimeException(e);
        }
        HttpSession session = request.getSession();
        ArrayList<String> imgs = (ArrayList<String>) session.getAttribute("imgs");
        if (imgs==null){
            imgs = new ArrayList<>();
            imgs.add(src);
            session.setAttribute("imgs", imgs);
        }else {
            imgs.add(src);
        }
        session.setAttribute("tx", src);
        String msg = "Upload Success!";
        request.setAttribute("msg", msg);
        response.sendRedirect("/demo2_war_exploded/mainPage.jsp");
//        RequestDispatcher rd = request.getRequestDispatcher("/mainPage.jsp");
//        rd.forward(request, response);
    }
}
