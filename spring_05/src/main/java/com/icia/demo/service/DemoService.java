package com.icia.demo.service;

import com.icia.demo.dto.DemoDTO;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class DemoService {

    public DemoDTO req1(String name, int age){
        DemoDTO demoDTO = new DemoDTO();
        demoDTO.setName(name);
        demoDTO.setAge(age);
        return demoDTO;
    }

    public List<DemoDTO> req2(DemoDTO demoDTO){
        List<DemoDTO> demoDTOList = new ArrayList<>();
        demoDTOList.add(demoDTO);
        return demoDTOList;
    }
}
