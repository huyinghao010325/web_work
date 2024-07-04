package dao;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

import javaBean.UserBean;
public class UserDao {
    protected String dbURL =  "jdbc:sqlserver://localhost:1433;DatabaseName=javaweb";
    protected String userName = "sa";
    protected String userPwd = "010325";

    protected String dbName = "Clients";

    protected String[] dbItem = {"client_id", "cname", "code", "cphoto", "client_date"};
    protected Connection conn = null;
    //数据连接
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

    public String insertUser(UserBean userBean) throws Exception {

            if (this.isExist(userBean.getUserID())){
                return "-1";//用户已经存在注册失败
            }else {
                if (this.insert(userBean)){
                    return "1";
                    //注册成功
                }else{
                    return "0";
//                    注册失败
                }
            }
    }

    public String loginUser(String account,String password) throws Exception{
            if (!this.isExist(account)){
            return "-1";//用户不存在登入失败
        }else {
            UserBean user = this.getInfo(account);
            if (password.equals(user.getUserCode())){
                //密码正确
                return "1";
            }else {
                return "0";

            }

        }

    }


    public UserBean getInfo(String account) throws Exception{
        this.Connection();
        UserBean userBean = new UserBean();
        if (this.conn!=null){
            Statement st = this.conn.createStatement();
            String sql = String.format("select * from %s where %s='%s'",this.dbName,this.dbItem[0],account);
            ResultSet rs = st.executeQuery(sql);
            if (rs.next()){
                userBean.setUserID(rs.getString(this.dbItem[0]));
                userBean.setUserName(rs.getString(this.dbItem[1]));
                userBean.setUserCode(rs.getString(this.dbItem[2]));
                userBean.setUserPhoto(rs.getString(this.dbItem[3]));
                userBean.setUserDate(rs.getString(this.dbItem[4]));
            }
            rs.close();
            st.close();
        }
        this.Close();
        return userBean;
    }


    public boolean isExist(String account) throws Exception {
        this.Connection();
        boolean isExit = false;
        if (this.conn!=null){
            Statement st = this.conn.createStatement();
            String sql = String.format("select * from %s ",this.dbName);
            ResultSet rs = st.executeQuery(sql);
            if (rs.next()){
                isExit = true;
            }
            rs.close();
            st.close();
        }
        this.Close();
        return isExit;
    }

    public boolean insert(UserBean userBean) throws Exception {
        boolean isInsert = false;
        Date date = new Date();
        SimpleDateFormat dateFm = new SimpleDateFormat("yyyy-MM-dd");

        userBean.setUserDate(dateFm.format(date));
        this.Connection();
        if (this.conn!=null){
            String sql = String.format("insert into %s (%s, %s, %s, %s, %s) " +
                            "values('%s','%s','%s', '%s', '%s')",
                    this.dbName,
                    this.dbItem[0], this.dbItem[1],this.dbItem[2],this.dbItem[3],this.dbItem[4],
                    userBean.getUserID(),userBean.getUserName(),userBean.getUserCode(),userBean.getUserPhoto(),dateFm.format(date));

            Statement st = this.conn.createStatement();
            int i = st.executeUpdate(sql);
            if (i==1){
                isInsert = true;
            }
            st.close();
        }
        this.Close();
        return isInsert;
    }

}
