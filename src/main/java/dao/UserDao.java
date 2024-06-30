package dao;

import java.sql.*;
import java.util.*;
import javaBean.UserBean;
public class UserDao {
    protected String dbURL =  "jdbc:sqlserver://localhost:1433;DatabaseName=javaweb";
    protected String userName = "sa";
    protected String userPwd = "010325";
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



}
