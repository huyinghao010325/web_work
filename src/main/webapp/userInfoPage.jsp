<%@ page import="javaBean.ArticlesBean" %>
<%@ page import="dao.ArticlesDao" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2024/7/2
  Time: 上午1:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人网页</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #FFFFFF;
            color: #0d1117;
            display: flex;
        }

        .sidebar {
            width: 250px;
            background-color: #CC3333;
            padding: 20px;
            height: 100vh;
            position: fixed;
        }

        .sidebar h2 {
            color: #fff;
            text-align: center;
        }

        .sidebar ul {
            list-style-type: none;
            padding: 0;
        }

        .sidebar ul li {
            padding: 10px;
            text-align: center;
        }

        .sidebar ul li a {
            color: #161b22;
            text-decoration: none;
        }

        .sidebar ul li a:hover {
            text-decoration: underline;
        }

        .content {
            margin-left: 270px;
            padding: 20px;
            flex-grow: 1;
        }

        .profile-pic {
            text-align: center;
        }

        .profile-pic img {
            border-radius: 50%;
            width: 150px;
            height: 150px;
        }

        .section {
            margin-bottom: 20px;
        }

        .section h2 {
            color: #58a6ff;
        }

        .section p {
            color: #8b949e;
        }

        .projects,
        .activity {
            background-color: #FFFFFF;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .projects h2,
        .activity h2 {
            color: #58a6ff;
        }

        .project-item,
        .activity-item {
            border-bottom: 1px solid #21262d;
            padding: 10px 0;
        }

        .project-item:last-child,
        .activity-item:last-child {
            border-bottom: none;
        }

        .project-item a,
        .activity-item a {
            color: #58a6ff;
            text-decoration: none;
        }

        .project-item a:hover,
        .activity-item a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>
<div class="sidebar">
    <div class="profile-pic">
        <img src="https://avatars.githubusercontent.com/u/9919?s=280&v=4" alt="Profile Picture">
        <!-- Replace with your own image URL -->
    </div>
    <h2>索引</h2>
    <ul>
        <li><a href="#personal-info" class="smooth-scroll">个人信息</a></li>
        <li><a href="#comments" class="smooth-scroll">评论</a></li>
        <li><a href="#hobbies" class="smooth-scroll">兴趣爱好</a></li>
        <li><a href="#projects" class="smooth-scroll">项目</a></li>
    </ul>
</div>
<div class="content">
    <div id="personal-info" class="section projects">
        <h2>个人信息</h2>
        <p>用户名：${sessionScope.username}</p>
        <p>个人账户：${sessionScope.userAccount}</p>
    </div>
    <div id="comments" class="section projects">
        <h2>评论</h2>
        <p>这里是用户评论的部分。你可以展示来自他人的评价和反馈。</p>
    </div>
    <div id="hobbies" class="section projects">
        <h2>兴趣爱好</h2>
        <p>这里是你的兴趣爱好部分。你可以描述你喜欢的活动、爱好以及你在空闲时间喜欢做的事情。</p>
    </div>
    <div id="projects" class="projects">
        <h2>文章</h2>
        <%
            String userID = (String) session.getAttribute("userAccount");
            String userName =(String) session.getAttribute("username");
            ArticlesDao articlesDao = new ArticlesDao();

            ArrayList<ArticlesBean> articlesBeans = null;
            try {
                articlesBeans = articlesDao.getUserAll(userID);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        %>
        <%if (articlesBeans != null){%>
            <%for (ArticlesBean articlesBean:articlesBeans){%>
                <div class="project-item">
                    <h3><a href="#"><%=articlesBean.getTitle()%></a></h3>
                    <p><%=articlesBean.getA_content()%></p>
                    <img src="<%=("./avatars/"+articlesBean.getAphoto())%>">
                </div>

            <%}%>
        <%}%>

        <!-- Add more projects as needed -->
    </div>

</div>

<script>
    document.querySelectorAll('.smooth-scroll').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            document.querySelector(this.getAttribute('href')).scrollIntoView({
                behavior: 'smooth'
            });
        });
    });
</script>
</body>

</html>
