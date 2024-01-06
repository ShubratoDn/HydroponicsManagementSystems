package com.hydroponics.management.system.annotation;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import com.hydroponics.management.system.DTO.UserDTO;
import com.hydroponics.management.system.payloads.ServerMessage;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.lang.reflect.Method;
import java.util.Arrays;

public class PreAuthorizedInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (!(handler instanceof HandlerMethod)) {
            return true;
        }

        HandlerMethod handlerMethod = (HandlerMethod) handler;
        Method method = handlerMethod.getMethod();

        if (method.isAnnotationPresent(PreAuthorized.class)) {
            PreAuthorized preAuthorized = method.getAnnotation(PreAuthorized.class);
            String requiredRole = preAuthorized.role();
            String[] requiredRoles = preAuthorized.roles();

            // Check user's role
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("loggedUser") == null) {
                // Redirect to login if not logged in
//                response.sendRedirect("/login");
            	request.setAttribute("serverMessage", new ServerMessage(
            		    "You are not authorized to access this page. Please contact the administrator for assistance.",
            		    "Authorization Error",
            		    "alert-info"
            		));
                request.getRequestDispatcher("/views/login.jsp").forward(request, response);
                return false;
            }

//            UserDTO loggedUser = (UserDTO) session.getAttribute("loggedUser");
//            if (!loggedUser.getRole().equalsIgnoreCase(requiredRole)) {
//                // Directly render the unauthorized view
//                request.getRequestDispatcher("/views/401.jsp").forward(request, response);
//                return false;
//            }
            
            UserDTO loggedUser = (UserDTO) session.getAttribute("loggedUser");
            if (!requiredRole.isBlank() && !loggedUser.getRole().equalsIgnoreCase(requiredRole)) {
                // Directly render the unauthorized view
                request.getRequestDispatcher("/views/401.jsp").forward(request, response);
                return false;
            }

            if (requiredRoles.length > 0 &&
                    !Arrays.asList(requiredRoles).stream().anyMatch(role -> role.equalsIgnoreCase(loggedUser.getRole()))) {
                // Directly render the unauthorized view
                request.getRequestDispatcher("/views/401.jsp").forward(request, response);
                return false;
            }
        }

        return true;
    }
}
