package com.icia.memberBoard.controller;

import com.icia.memberBoard.dto.MemberDTO;
import com.icia.memberBoard.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberService memberService;

    @GetMapping("/save")
    public String save(){
        return "member/memberSave";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute MemberDTO memberDTO) throws IOException {
        System.out.println("memberDTO = " + memberDTO);
        memberService.save(memberDTO);
        return "index";
    }

    @PostMapping("/duplicate-check")
    public ResponseEntity ajaxCheck(@RequestParam("memberEmail") String email) {
        MemberDTO memberDTO = memberService.findByEmail(email);
        if (memberDTO == null)
            return new ResponseEntity<>(HttpStatus.OK);
        else
            return new ResponseEntity<>(HttpStatus.CONFLICT);
    }

    @GetMapping("/login")
    public String login(){
        return "member/memberLogin";
    }

    @PostMapping("/login")
    public ResponseEntity login(@ModelAttribute MemberDTO memberDTO, HttpSession session){
        boolean result = memberService.login(memberDTO);
        if(result){
            session.setAttribute("loginEmail", memberDTO.getMemberEmail());
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.CONFLICT);
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("loginEmail");
        return "redirect:/";
    }
}
