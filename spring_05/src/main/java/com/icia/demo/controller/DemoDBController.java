package com.icia.demo.controller;

import com.icia.demo.dto.DemoDTO;
import com.icia.demo.service.DemoDBService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

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

    @GetMapping("/demodb2")
    public String demodb2(Model model){
        List<DemoDTO> demoDTOList = demoDBService.findAll();
        model.addAttribute("demoList", demoDTOList);
        return "demodb2";
    }

    @GetMapping("/find")
    public String findById(Model model,@RequestParam("id") Long id){
        DemoDTO demoDTO = demoDBService.findById(id);
        model.addAttribute("demo",demoDTO);
        return "demodb3";
    }
}
