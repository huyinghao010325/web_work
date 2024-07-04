
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人信息修改</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background-color: rgb(245, 105, 105); /* 红色背景 */
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.9); /* 阴影效果 */
        }

        h1 {
            color: #333;
            text-align: center;
        }
        form {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }
        input[type="text"],
        input[type="password"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }
        input[type="file"] {
            margin-top: 10px;
        }
        input[type="submit"] {
            margin-top: 10px;
            width: 100%;
            background-color: #ff3333; /* 红色按钮 */
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #cc0000; /* 按钮悬停颜色 */
        }
        .error-message {
            color: white;
            font-size: 14px;
            margin-top: 5px;
        }
    </style>
</head>
<body>


<div class="container">
    <header>
        <h1>个人信息修改</h1>
    </header>
    <form id="edit-form" action="#" method="post" enctype="multipart/form-data">
        <label for="name">姓名:</label>
        <input type="text" id="name" name="name" value="张三" required>
        <span id="name-error" class="error-message"></span><br>

        <label for="password">密码:</label>
        <input type="password" id="password" name="password" required>
        <span id="password-error" class="error-message"></span><br>

        <label for="new-password">新密码:</label>
        <input type="password" id="new-password" name="new-password">
        <div><span id="new-password-error" class="error-message"></span></div>

        <label for="confirm-password">确认密码:</label>
        <input type="password" id="confirm-password" name="confirm-password">
        <div>
            <span id="confirm-password-error" class="error-message"></span>
        </div>

        <label for="avatar">更改头像:</label>
        <input type="file" id="avatar" name="avatar" accept="image/*">
        <div>
            <span id="avatar-error" class="error-message"></span>
        </div>

        <input type="submit" value="保存">
    </form>
</div>

<script>
    document.getElementById('edit-form').addEventListener('submit', function(event) {
        event.preventDefault();
        // 清空之前可能存在的错误消息
        document.querySelectorAll('.error-message').forEach(function(element) {
            element.textContent = '';
        });

        // 获取表单数据
        var name = document.getElementById('name').value.trim();
        var password = document.getElementById('password').value.trim();
        var newPassword = document.getElementById('new-password').value.trim();
        var confirmPassword = document.getElementById('confirm-password').value.trim();
        var avatar = document.getElementById('avatar').value.trim();

        // 表单验证
        var isValid = true;

        // 姓名验证
        if (name === '') {
            document.getElementById('name-error').textContent = '请输入姓名';
            isValid = false;
        }

        // 密码验证
        if (password === '') {
            document.getElementById('password-error').textContent = '请输入密码';
            isValid = false;
        }

        // 新密码验证
        if (newPassword !== '' && newPassword.length < 6) {
            document.getElementById('new-password-error').textContent = '新密码至少需要6个字符';
            isValid = false;
        }

        // 确认密码验证
        if (newPassword !== confirmPassword) {
            document.getElementById('confirm-password-error').textContent = '两次输入的密码不一致';
            isValid = false;
        }

        // 头像验证（示例，可以根据实际需求扩展）
        if (avatar !== '') {
            var allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/i;
            if (!allowedExtensions.exec(avatar)) {
                document.getElementById('avatar-error').textContent = '请选择有效的图片文件（jpg, jpeg, png, gif）';
                isValid = false;
            }
        }

        // 如果表单验证通过，则可以提交表单
        if (isValid) {
            this.submit(); // 提交表单
        }
    });
</script>

</body>
</html>

