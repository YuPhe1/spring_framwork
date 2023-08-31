package com.icia.study.controller;

import com.icia.study.dto.StudyDTO;
import com.icia.study.service.StudyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

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

    @GetMapping("/req2")
    public String req2(@RequestParam("q1") String q1, @RequestParam("q2") String q2){
        studyService.req2(q1, q2);
        return "index";
    }

    @PostMapping("/req3")
    public String req3(@ModelAttribute StudyDTO studyDTO){
        studyService.req3(studyDTO);
        return "index";
    }
}
