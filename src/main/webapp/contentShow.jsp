<%@ page import="java.util.ArrayList" %>
<%@ page import="javaBean.ArticlesBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javaBean.ArticlesBean" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.ArticlesDao" %>
<%@ page import="dao.UserDao" %>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户管理表单</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .container { width: 80%; margin: 20px auto; height: 80%;}
        .search-bar { display: flex; justify-content: space-between; margin-bottom: 20px; }
        .search-bar input, .search-bar button { padding: 10px; margin-right: 10px; }
        .search-bar button { cursor: pointer; }
        .main{width: 100%; height: 450px;overflow: hidden;}
        .table { width: 100%; border-collapse: collapse; }
        .table th, .table td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        .table th { background-color: #f9f9f9; }
        .table td{height: 20px}
        .pagination { text-align: center; margin-top: 20px; }
        .pagination button { padding: 5px 10px; margin: 0 5px; cursor: pointer; }
    </style>
</head>
<body>

<div class="container">
    <div class="search-bar">
        <div>
            <button>新建用户</button>
            <button>导出数据</button>
        </div>
        <div>
            <input type="text" placeholder="请输入用户名">
            <button>查询</button>
            <button>重置</button>
        </div>
    </div>

    <div class="main">
        <table class="table">
            <thead>
            <tr>
                <th>文章序号</th>
                <th>文章题目</th>
                <th>发布时间</th>
                <th>文章内容</th>
                <th>作者姓名</th>
                <th>文章图片</th>
            </tr>

            </thead>
            <!-- 表格数据行 -->

            <tbody>
                <%
                    String userID = (String) session.getAttribute("userAccount");
                    String userName =(String) session.getAttribute("username");
                    ArticlesDao articlesDao = new ArticlesDao();

                    ArrayList<ArticlesBean> articlesBeans = null;
                    try {
                        articlesBeans = articlesDao.getUserAll("207621");
                    } catch (Exception e) {
                        throw new RuntimeException(e);
                    }
                    int le = 0;
                    if (articlesBeans==null){
                        le = 10;
                    }else {
                        le = articlesBeans.size();
                    }
                    int max = 10;
                %>
                <%for (int i=0;i<=max;i++){%>


                    <%if(articlesBeans!=null&&i<articlesBeans.size()){ ArticlesBean articlesBean = articlesBeans.get(i); %>
                        <tr>
                            <td><%=articlesBean.getArticle_id()%></td>
                            <td><%=articlesBean.getTitle()%></td>
                            <td><%=articlesBean.getAtime()%></td>
                            <td><%=articlesBean.getA_content()%></td>
                            <td><%=userName%></td>
                            <td><%=articlesBean.getAphoto()%></td>
                        </tr>

                    <%}else {%>

                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    <%}%>
                <%}%>

            </tbody>




        </table>

    </div>


    <div class="pagination">
        <button>1</button>
        <button>2</button>
        <button>3</button>
    </div>
</div>

</body>
</html>

