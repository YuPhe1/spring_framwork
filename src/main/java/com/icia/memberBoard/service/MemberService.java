package com.icia.memberBoard.service;

import com.icia.memberBoard.dto.MemberDTO;
import com.icia.memberBoard.dto.MemberProfileDTO;
import com.icia.memberBoard.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;

@Service
public class MemberService {

    @Autowired
    private MemberRepository memberRepository;

    public void save(MemberDTO memberDTO) throws IOException {
        if (memberDTO.getMemberProfile().isEmpty()) {
            // 파일 없다.
            memberDTO.setProfileAttached(0);
            ;
            memberRepository.save(memberDTO);
        } else {
            // 파일 있다.
            memberDTO.setProfileAttached(1);
            // 게시글 저장 후 id값 활용을 위해 리턴 받음
            MemberDTO saveMember = memberRepository.save(memberDTO);
            // 파일이 여러개 있기 때문에 반복문으로 파일 하나씩 꺼내서 저장 처리
            // 파일만 따로 가져오기
            MultipartFile profile = memberDTO.getMemberProfile();

            // 파일 이름 가져오기
            String originalFileName = profile.getOriginalFilename();
            // 저장용 이름 만들기
            String storedFileName = System.currentTimeMillis() + "-" + originalFileName;
            // BoardFileDTO 세팅
            MemberProfileDTO memberProfileDTO = new MemberProfileDTO();
            memberProfileDTO.setOriginalFileName(originalFileName);
            memberProfileDTO.setStoredFileName(storedFileName);
            memberProfileDTO.setMemberId(saveMember.getId());
            // 파일 저장용 폴더에 파일 저장 처리
            String savePath = "D:\\spring_img\\" + storedFileName;
            profile.transferTo(new File(savePath));
            memberRepository.saveFile(memberProfileDTO);

        }
    }

    public MemberDTO findByEmail(String email) {
        return memberRepository.findByEmail(email);
    }

    public boolean login(MemberDTO memberDTO) {
        MemberDTO dto = memberRepository.login(memberDTO);
        if(dto != null){
            return true;
        } else {
            return false;
        }
    }
}
