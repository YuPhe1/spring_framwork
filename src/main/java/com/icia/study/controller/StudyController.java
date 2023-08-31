package com.icia.study.controller;

import com.icia.study.service.StudyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class StudyController {

    // StudyService 객체 주입
    @Autowired
    private StudyService studyService;

    @GetMapping("/req1")
    public String req1(){
        studyService.req1();
        return "index";
    }
}
