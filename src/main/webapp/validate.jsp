<%--
  Created by IntelliJ IDEA.
  User: 20762
  Date: 2024/5/30
  Time: 16:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=gb2312" language="java" %>
<%@page import="java.awt.*" %>
<%@page import="java.util.*" %>
<%@page import="javax.imageio.ImageIO" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@page pageEncoding="gb2312" %>
<html>
<head>
    <title>��֤��</title>
</head>
<body>
<%
    response.setHeader("Cache-Control", "no-cache");
    //���ڴ��д���ͼ��
    int width = 60, height = 20;
    BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
    //��ȡ����
    Graphics g = image.getGraphics();
    //�趨����ɫ
    g.setColor(new Color(200, 200, 200));
    g.fillRect(0, 0, width, height);
    //�����������֤�루4λ���֣�
    Random rnd = new Random();
    int randNum = rnd.nextInt(8999) + 1000;
    String randStr = String.valueOf(randNum);
    //����֤�����session
    session.setAttribute("randStr", randStr);
    //����֤����ʾ��ͼ����
    g.setColor(Color.black);
    g.setFont(new Font("", Font.PLAIN, 20));
    g.drawString(randStr, 10, 17);
    //�������100�����ŵ㣬ʹ��ͼ������֤�벻�ױ���������̽�⵽
    for (int i =0 ;i<100;i++){
        int x = rnd.nextInt(width);
        int y = rnd.nextInt(height);
        g.drawOval(x, y , 1, 1);
    }
    //���ͼ��ҳ��
    ImageIO.write(image, "JPEG", response.getOutputStream());
    out.clear();
    out = pageContext.pushBody();
%>
</body>
</html>
