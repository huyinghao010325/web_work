package dao;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

import javaBean.ArticlesBean;
import javaBean.UserBean;

public class ArticlesDao {
    protected String dbURL =  "jdbc:sqlserver://localhost:1433;DatabaseName=javaweb";
    protected String userName = "sa";
    protected String userPwd = "010325";

    protected String dbName = "Articles";
    protected String[] dbItem = {"article_id", "title", "a_content", "aphoto", "form_id", "Atime"};

    protected Connection conn = null;

    private void Connection() throws Exception{
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(dbURL, userName, userPwd);
            System.out.println("连接成功！");
        }catch (Exception e){
            throw new RuntimeException(e);
        }
    }
    //关闭数据库连接
    private void Close() throws Exception{
        try {
            if (this.conn!=null){
                conn.close();
                conn = null;
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
    }

    public ArrayList<ArticlesBean> getAll() throws Exception {
        ArrayList<ArticlesBean> articlesBeans = new ArrayList<>();
        this.Connection();
        if (this.conn != null) {
            Statement st = this.conn.createStatement();
            String sql = String.format("select * from %s", this.dbName);
            ResultSet rs = st.executeQuery(sql);
            if (rs.next()) {
                ArticlesBean articlesBean = new ArticlesBean();
                articlesBean.setArticle_id(rs.getString(this.dbItem[0]));
                articlesBean.setTitle(rs.getString(this.dbItem[1]));
                articlesBean.setA_content(rs.getString(this.dbItem[2]));
                articlesBean.setAphoto(rs.getString(this.dbItem[3]));
                articlesBean.setForm_id(rs.getString(this.dbItem[4]));
                articlesBean.setAtime(rs.getString(this.dbItem[5]));
                articlesBeans.add(articlesBean);
            }
            rs.close();
            st.close();

            this.Close();
        }

        return articlesBeans;

    }

}
