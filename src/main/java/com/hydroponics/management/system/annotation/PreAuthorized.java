package com.hydroponics.management.system.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface PreAuthorized {
	String role() default ""; // Specify the required role
    String[] roles() default {}; // Specify the required roles as an array
}
