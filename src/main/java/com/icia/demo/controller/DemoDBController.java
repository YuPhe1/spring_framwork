package com.icia.demo.controller;

import com.icia.demo.dto.DemoDTO;
import com.icia.demo.service.DemoDBService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class DemoDBController {

    @Autowired
    private DemoDBService demoDBService;

    @GetMapping("/demodb1")
    public String demodb1(){
        return "demodb1";
    }

    @PostMapping("/reqdb1")
    public String reqdb1(@ModelAttribute DemoDTO demoDTO){
        demoDBService.reqdb1(demoDTO);
        return "index";
    }
}
