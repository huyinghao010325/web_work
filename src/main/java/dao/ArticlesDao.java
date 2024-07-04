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

    //获得所有评论信息
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

    //获得作者的全部文章信息
    public ArrayList<ArticlesBean> getUserAll(String userId)throws Exception{
        ArrayList<ArticlesBean> articlesBeans = new ArrayList<>();
        this.Connection();
        if (this.conn!=null){

            Statement st = this.conn.createStatement();
            String sql = String.format("select * from %s where %s='%s' ", this.dbName, this.dbItem[4], userId);
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()){
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


        }
        this.Close();
        return articlesBeans;
    }

    //删除评论信息
    public boolean delA(String aId)throws Exception{
        boolean isDel = false;
        this.Connection();
        if (this.conn!=null){
            Statement st = this.conn.createStatement();
            String sql = String.format("delete from %s where %s='%s'", this.dbName, this.dbItem[0], aId);
            int i = st.executeUpdate(sql);
            System.out.println("成功删除"+i+"行");
            if (i == 1){
                isDel = true;
            }
            st.close();
        }
        this.Close();
        return isDel;
    }

    public boolean isInsert(ArticlesBean articlesBean)throws Exception{
        boolean isInsert = false;
        this.Connection();
        Date date = new Date();
        SimpleDateFormat dateFm = new SimpleDateFormat("yyyy-MM-dd");
        articlesBean.setAtime(dateFm.format(date));
        if(this.conn != null){
            String sql = String.format("insert into %s (%s,%s,%s,%s,%s) " +
                            "values('%s','%s','%s','%s','%s')"
                    ,this.dbName,
                    this.dbItem[1],
                    this.dbItem[2],
                    this.dbItem[3],
                    this.dbItem[4],
                    this.dbItem[5],
                    articlesBean.getTitle(),
                    articlesBean.getA_content(),
                    articlesBean.getAphoto(),
                    articlesBean.getForm_id(),
                    articlesBean.getAtime());
            Statement st = this.conn.createStatement();
            int ic = st.executeUpdate(sql);
            if (ic>0){
                isInsert = true;
            }
        }

        this.Close();
        return isInsert;
    }




}
