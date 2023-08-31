package com.icia.study.service;

import org.springframework.stereotype.Service;

@Service
public class StudyService {

    public void req1(){
        System.out.println("StudyController.req1");
    }

    // req2 메서드에서 q1, q2 값 출력
    public void req2(String q1, String q2){
        System.out.println("q1 = " + q1 + ", q2 = " + q2);
    }
}
