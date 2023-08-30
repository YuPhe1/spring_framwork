package com.study.basic.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String welcome(){
     return "welcome";
    }
    @GetMapping("/test")
    public String test(){
        return "test/test";
    }
}
