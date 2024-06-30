var xmlhttp=null;
//创建XMLHttpRequest对象
function createHttpRequest(){
    if(window.XMLHttpRequest){ //Mozilla 浏览器
        xmlhttp = new XMLHttpRequest();
    }else if(window.ActiveXObject){
        try{
            xmlhttp = new ActiveXObject("Msxml2.XMLHTTP"); //新版IE
        }catch(e){
            try {
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }catch(e){
                xmlhttp = null;
            }
        }
    }
    if(!xmlhttp){ //创建XMLHttpRequest失败
        alert("不能创建XMLHttpRequest对象实例");
    }
}
//发送函数
function sendRequest(method,url,param,callbackHandler){
    //创建对象
    createHttpRequest();
    //绑定事件,后台返回的数据，通过callback方法处理
    xmlhttp.onreadystatechange = callbackHandler;

    if(method=="get" || method=="GET"){
        //初始化发送信息
        xmlhttp.open(method,url + "?" + param,true);
        xmlhttp.send(null);
    }

    if(method=="post" || method=="POST"){
        //初始化发送信息
        xmlhttp.open(method,url,true);
        xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
        xmlhttp.send(param);
    }
}