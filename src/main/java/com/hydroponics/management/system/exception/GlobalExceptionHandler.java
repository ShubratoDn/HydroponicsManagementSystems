package com.hydroponics.management.system.exception;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(ArithmeticException.class)
    public String handleArithmeticException(ArithmeticException ex, Model model) {
        // Handle the ArithmeticException
        model.addAttribute("errorType", "Arithmetic Error");
        model.addAttribute("errorMessage", ex.getMessage());

        System.out.println("ERROR");
        // Return the view name for the error page
//        return "redirect:/not-found";
        return "error";
    }
}