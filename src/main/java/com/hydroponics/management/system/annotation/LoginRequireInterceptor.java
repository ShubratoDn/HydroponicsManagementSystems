package com.hydroponics.management.system.annotation;

import java.lang.reflect.Method;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginRequireInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (!(handler instanceof HandlerMethod)) {
            return true;
        }

        HandlerMethod handlerMethod = (HandlerMethod) handler;
        Method method = handlerMethod.getMethod();

        // Check for @LoginRequired annotation
        if (method.isAnnotationPresent(LoginRequired.class)) {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("loggedUser") == null) {
            	
                response.sendRedirect("/login"); // Redirect to login if not logged in
                return false;
            }
        }
        return true;
    }
}
