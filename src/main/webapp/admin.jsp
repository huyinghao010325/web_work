<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>示例网站</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .navbar { background-color: red; color: white; display: flex; justify-content: space-between; align-items: center; padding: 0 20px; height: 60px; }
        .navbar a { color: white; text-decoration: none; }
        .navbar img { border-radius: 50%; }
        .dropdown-content { display: none; position: absolute; right: 20px; background-color: #f9f9f9; min-width: 160px; box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); z-index: 1; }
        .dropdown-content a { color: black; padding: 12px 16px; text-decoration: none; display: block; }
        .dropdown:hover .dropdown-content { display: block; }
        .sidebar { width: 250px; background-color: #f9f9f9; height: 100vh; border-right: 1px solid #ddd; padding: 10px; }
        .sidebar button { display: block; width: 100%; padding: 10px; border: none; background: none; text-align: left; }
        .sidebar button:hover { background-color: #ddd; }
        #main-content { margin-left: 50px;margin-right: 50px; padding: 10px; width: 100%;}
        .toggle-sidebar { cursor: pointer; }
    </style>
</head>
<body>

<div class="navbar">
    <a href="index.jsp">七十五周年</a>
    <div class="dropdown">
    <span style="display: flex;">
      <img src="${sessionScope.userPhoto}" alt="用户头像" width="40" height="40" style="margin-right: 10px;">
      <span style="align-self: center;text-align: center;font-size: 20px; width: 120px;background-color: skyblue; border-radius: 10px;">${sessionScope.username}</span>
    </span>
        <div class="dropdown-content">
            <a href="#">个人资料</a>
            <a href="#">设置</a>
            <a href="back">退出</a>
        </div>
    </div>
</div>

<div class="main" style="display: flex;flex-direction: row;">
    <div class="sidebar">
        <button class="toggle-sidebar">☰</button>
        <button onclick="loadPage('userInfoPage.jsp')">个人信息</button>
        <button onclick="loadPage('changInfo.jsp')">修改信息</button>
        <button onclick="loadPage('sendArticle.jsp')">发布文章</button>
        <button onclick="loadPage('contentShow.jsp')">文章显示</button>
    </div>

    <div id="main-content" style="display: flex;justify-content: center;align-items: center;overflow: hidden">
        <!-- 主内容加载区域 -->
    </div>
</div>


<script>
    document.getElementById('main-content').innerHTML = '<object type="text/html" data="' + 'index.jsp' + '" style="width:100%; height:100vh;"></object>';
    document.querySelector('.toggle-sidebar').addEventListener('click', function() {
        var sidebar = document.querySelector('.sidebar');
        var mainContent = document.querySelector('.main-content');
        if (sidebar.style.width === '250px') {
            sidebar.style.width = '50px';
            mainContent.style.marginLeft = '50px';
        } else {
            sidebar.style.width = '250px';
            mainContent.style.marginLeft = '250px';
        }
    });
    function loadPage(page) {
        document.getElementById('main-content').innerHTML = '<object type="text/html" data="' + page + '" style="width:100%; height:100vh;"></object>';
    }
</script>

</body>
</html>
