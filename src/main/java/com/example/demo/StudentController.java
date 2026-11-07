package com.example.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.LinkedHashMap;
import java.util.Map;

@RestController
public class StudentController {

    // Endpoint 1: Home
    @GetMapping("/")
    public String home() {
        return "Welcome to Cloud Deployment Demo!";
    }

    // Endpoint 2: Health Check
    @GetMapping("/health")
    public String health() {
        return "Application is running successfully!";
    }

    // Endpoint 3: Student Information
    @GetMapping("/student")
    public Map<String, Object> getStudent() {
        Map<String, Object> student = new LinkedHashMap<>();
        student.put("id", 101);
        student.put("name", "John");
        student.put("course", "Computer Science");
        student.put("status", "Active");
        return student;
    }
}

