package com.hydroponics.management.system.exception;

import java.io.IOException;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class CustomErrorController implements ErrorController   {

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the error status
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        
        if (status != null) {
            int statusCode = Integer.parseInt(status.toString());

            // Redirect to "/not-found" only if the error status is 404
            if (statusCode == 404) {
//                return "redirect:/not-found";                
                request.getRequestDispatcher("/views/404.jsp").forward(request, response );
            }
        }

        // For other error types, you can handle them differently or provide a generic error page
        return "error";
    }

    
    public String getErrorPath() {
        return "/error";
    }
}