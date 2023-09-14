package com.icia.memberBoard.controller;

import com.icia.memberBoard.dto.MemberDTO;
import com.icia.memberBoard.dto.MemberProfileDTO;
import com.icia.memberBoard.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

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
        MemberDTO dto = memberService.login(memberDTO);
        if(dto != null){
            session.setAttribute("loginEmail", dto.getMemberEmail());
            session.setAttribute("loginName", dto.getMemberName());
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.CONFLICT);
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/list")
    public String findByAll(Model model){
        List<MemberDTO> memberDTOList = memberService.findByAll();
        model.addAttribute("memberList", memberDTOList);
        return "member/memberList";
    }

    @GetMapping("/detail")
    public String findByEmail(HttpSession session, Model model){
        String email = (String) session.getAttribute("loginEmail");
        MemberDTO memberDTO = memberService.findByEmail(email);
        model.addAttribute("member", memberDTO);
        if(memberDTO.getProfileAttached() == 1){
            MemberProfileDTO memberProfileDTO = memberService.findProfile(memberDTO.getId());
            model.addAttribute("memberProfile", memberProfileDTO);
        }
        return "member/memberDetail";
    }

    @GetMapping("/update")
    public String update(HttpSession session, Model model){
        String email = (String) session.getAttribute("loginEmail");
        MemberDTO memberDTO = memberService.findByEmail(email);
        model.addAttribute("member", memberDTO);
        if(memberDTO.getProfileAttached() == 1){
            MemberProfileDTO memberProfileDTO = memberService.findProfile(memberDTO.getId());
            model.addAttribute("memberProfile", memberProfileDTO);
        }
        return "member/memberUpdate";
    }
}
