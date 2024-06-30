package filter;

import javax.servlet.*;
import java.io.IOException;

public class EncodingFilter implements Filter{
    public EncodingFilter(){}
    public void init(FilterConfig config)throws ServletException{
        System.out.println("过滤器初始化函数");
    }
    public void destroy(){}
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws
            ServletException, IOException{
        request.setCharacterEncoding("utf-8");
        chain.doFilter(request, response);
    }
}
