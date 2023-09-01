package com.icia.demo.service;

import com.icia.demo.dto.DemoDTO;
import com.icia.demo.repository.DemoDBRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DemoDBService {

    @Autowired
    private DemoDBRepository demoDBRepository;
    public void reqdb1(DemoDTO demoDTO) {
        demoDBRepository.reqdb1(demoDTO);
    }
}
