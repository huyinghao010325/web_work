
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="css/login.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" charset="utf-8"></script>
    <script src="./js/ajax.js"></script>

    <script type="text/javascript">
        function refresh() {
            // alert("asdasdas")
            loginForm.imgValidate.src = "validate.jsp?id=" + Math.random();
        }
        function dataDeal(){
            if(xmlhttp.readyState == 4){
                if (xmlhttp.status == 200){
                    document.getElementById("errMsg").innerHTML = xmlhttp.responseText;
                }else {
                    alert(xmlhttp.status);
                }
            }
        }


    </script>
</head>
<style>
    #result{
        display: inline;
        height: 70px;
        width: 70px;
        /*background-color: greenyellow;*/
    }
    #result img{
        height: 70px;
        width: 70px;
        border-radius: 50%;
        overflow: hidden;
        border: 2px solid skyblue;
    }
</style>
<body>
<div class="container" id="login-box">
    <div class="form-container sign-up-container">
        <form action="servlets/RegisterServlet" class="form" name="form1" id="form1" method="post" enctype="multipart/form-data">
            <h1>注册</h1>
            <div id="result" style="width: 100%;text-align: center"><img/></div>
            <div class="txtb">
                <input type="file" id="upload" name="myFile" required>
                <%--                <span data-placeholder="Password" ></span>--%>
            </div>
            <div class="txtb">
                <input type="text" placeholder="请输入用户名称" name="userName" required>
                <%--                <span data-placeholder="Email" ></span>--%>
            </div>
            <div class="txtb">
                <input type="text" placeholder="请输入账号" name="account" required>
<%--                <span data-placeholder="Useranme" ></span>--%>
            </div>
            <div class="txtb">
                <input type="password" placeholder="请输入密码" name="password" required>
<%--                <span data-placeholder="Email" ></span>--%>
            </div>


            <button onclick="checkRegisterForm()">注册</button>
        </form>
    </div>
    <div class="form-container sign-in-container">
        <form action="servlets/LoginServlet" name="loginForm" method="post">
            <h1>登录</h1>
            <div class="txtb">
                <input type="text" name="account" placeholder="请输入账号">
<%--                <span data-placeholder="请输入账号" ></span>--%>
            </div>
            <div class="txtb">
                <input type="password" name="password" placeholder="请输入密码">
<%--                <span data-placeholder="请输入密码"></span>--%>
            </div>
            <div class="txtb">
                <input type="text" name="code" size="10" placeholder="请输入验证码">
                <%--    验证码以图片形式处理--%>
            </div>
            <div style="display: flex;justify-content: space-between;">
                <div>
                    <img src="validate.jsp" border="0" onclick="refresh()" style="height:45px;width: 80px" name="imgValidate">
                </div>
                <a href="#" style="float: left">忘记密码？</a>
                <div></div>
                <div></div>
            </div>
            <button onclick="checkLoginForm">登录</button>
            <div style="width: 100%;text-align: center;color: red">${loginState}</div>
        </form>
    </div>
    <div class="overlay-container">
        <div class="overlay">
            <div class="overlay-panel overlay-left">
                <h1>已有账号？</h1>
                <p>请使用您的账号进行登录</p>
                <button class="ghost" id="signIn" >登录</button>
            </div>
            <div class="overlay-panel overlay-right">
                <h1>没有账号?</h1>
                <p>立即注册加入我们，和我们一起开始旅程吧</p>
                <button class="ghost" id="signUp">注册</button>
            </div>
        </div>

    </div>
</div>
</body>
<script type="text/javascript"> 
    function checkRegisterForm() {
        if(document.account==null){
            alert("账户是空的")
        }else if(document.password == null){
            alert("密码是空的")
        }else{
            document.form1.submit();
        }
    }
    function checkLoginForm(){
        if (document.account===null){
            alert("账号是空的！")
        }else if(document.password===null){
            alert("密码是空的！")
        }else {
            document.loginForm.submit();
        }
    }
</script>
<script>
    var result = document.getElementById("result");
    var input = document.getElementById("upload");

    if(typeof FileReader==='undefined'){
        result.innerHTML = "抱歉，你的浏览器不支持 FileReader";
        input.setAttribute('disabled','disabled');
    }else{
        input.addEventListener('change',readFile,false);
    }
    function readFile(){
        var file = this.files[0];
        if(!/image\/\w+/.test(file.type)){
            alert("文件必须为图片！");
            return false;
        }
        var reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = function(e){
            result.innerHTML = '<img name="imge" src="'+this.result+'" alt=""/>'
        }
    }
</script>
<script>
    $("#signUp").click(function(){
        $("#login-box").addClass('right-panel-active')
    })

    $("#signIn").click(function(){
        $("#login-box").removeClass('right-panel-active')
    })

    $(".txtb input").on("focus",function(){
        $(this).addClass("focus")
    })

    $(".txtb input").on("blur",function(){
        if($(this).val() == '')
            $(this).removeClass("focus")
    })
    
</script>
</html>

