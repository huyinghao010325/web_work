<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>发布新文章</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            background-color: #ffe6e6; /* 淡红色背景 */
            padding: 20px;
            margin: 0;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff; /* 白色背景 */
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #cc3333; /* 深红色标题 */
            text-align: center;
        }
        label {
            font-weight: bold;
            color: #cc3333; /* 深红色标签 */
        }
        input[type="text"], input[type="file"], textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }
        textarea {
            height: 200px;
            resize: vertical;
        }
        input[type="submit"] {
            width: 100%;

            background-color: #cc3333; /* 深红色按钮 */
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #b32424; /* 深红色按钮悬停颜色 */
        }
        .error-message {
            color: #cc3333; /* 深红色错误消息 */
            font-size: 14px;
            margin-top: 5px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>发布新文章</h1>
    <form name="articleForm" action="sendArticle" method="post" enctype="multipart/form-data">
        <label for="title">文章标题:</label>
        <input type="text" id="title" name="title" required>
        <span id="title-error" class="error-message"></span><br>

        <label for="author">文章作者:</label>
        <input type="text" id="author" name="author" value="${sessionScope.username}" required>
        <span id="author-error" class="error-message"></span><br>

        <label for="content">文章内容:</label><br>
        <textarea id="content" name="content" required></textarea>
        <span id="content-error" class="error-message"></span><br>

        <label for="image">文章封面图片:</label>
        <input type="file" id="image" name="image" accept="image/*">
        <span id="image-error" class="error-message"></span><br>

        <input type="button" value="发布文章" onclick="checkedForm()">
    </form>
</div>

<script>

    function checkedForm(){
        var title = document.articleForm.title.value;
        var author = document.articleForm.author.value;
        var content = document.articleForm.content.value;
        var isValid = true;
        if (title === '') {
            document.getElementById('title-error').textContent = '请输入文章标题';
            isValid = false;
        }

        // 作者验证
        if (author === '') {
            document.getElementById('author-error').textContent = '请输入文章作者';
            isValid = false;
        }

        // 内容验证
        if (content === '') {
            document.getElementById('content-error').textContent = '请输入文章内容';
            isValid = false;
        }
        if (isValid){
            document.articleForm.submit();
        }
    }
</script>

</body>
</html>
