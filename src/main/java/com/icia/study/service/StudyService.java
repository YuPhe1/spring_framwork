package com.icia.study.service;

import com.icia.study.dto.StudyDTO;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class StudyService {

    public void req1(){
        System.out.println("StudyController.req1");
    }

    // req2 메서드에서 q1, q2 값 출력
    public void req2(String q1, String q2){
        System.out.println("q1 = " + q1 + ", q2 = " + q2);
    }

    public void req3(StudyDTO studyDTO) {
        System.out.println("studyDTO = " + studyDTO);
    }



    /**
     * req4 메서드
     * StudyDTO 객체를 리턴한다.
     * index.jsp에서 req4 주소를 요청하면
     * 서비스 클래스의 req4 메서드가 리턴한 객체 데이터 값을 req4.jsp에 출력함.
     *
     */
    public StudyDTO req4() {
        StudyDTO studyDTO = new StudyDTO();
        studyDTO.setP1("DTOp1");
        studyDTO.setP2("DTOp2");
        studyDTO.setP3(3);
        return studyDTO;
    }

    /**
     * req5 메서드
     * StudyDTO가 담긴 리스트 객체를 리턴한다.
     * index.jsp에서 req5 주소를 요청하면
     * 서비스 클래스의 req5 메서드가 리턴한 객체 데이터 값을 req5.jsp에 출력함.
     */
    public List<StudyDTO> req5() {
        List<StudyDTO> studyDTOList = new ArrayList<>();
        for(int i = 1; i <= 10; i++){
            StudyDTO studyDTO = new StudyDTO();
            studyDTO.setP1("p1=" + i);
            studyDTO.setP2("p2=" + i);
            studyDTO.setP3(i);
            studyDTOList.add(studyDTO);
        }
        return studyDTOList;
    }
}
