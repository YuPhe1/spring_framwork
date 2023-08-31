package com.ex.demo.controller;

import com.ex.demo.dto.DemoDTO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ResultController {

    @GetMapping("/result1")
    public String result1(Model model){
        String value1 = "안녕하세요";
        // model 객체에 화면에 출력할 데이터를 담아감
        model.addAttribute("m1",value1);
        return "result1";
    }
    @GetMapping("/result2")
    public String result2(Model model){
        DemoDTO demoDTO = new DemoDTO();
        demoDTO.setParam1("param1에 담긴값");
        demoDTO.setParam2("param2에 담긴값");
        model.addAttribute("demo",demoDTO);
        return "result2";
    }
    @GetMapping("/result3")
    public String result3(){
        return "result3";
    }
}
