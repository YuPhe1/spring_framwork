package com.icia.memberBoard.controller;

import com.icia.memberBoard.dto.BoardDTO;
import com.icia.memberBoard.dto.MemberDTO;
import com.icia.memberBoard.dto.MemberProfileDTO;
import com.icia.memberBoard.service.BoardService;
import com.icia.memberBoard.service.CommentService;
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
    @Autowired
    private BoardService boardService;
    @Autowired
    private CommentService commentService;

    @GetMapping("/save")
    public String save(){
        return "member/memberSave";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute MemberDTO memberDTO) throws IOException {
        memberService.save(memberDTO);
        return "redirect:/member/login";
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
    public String login(@RequestParam(value = "target", required = false, defaultValue = "") String target, Model model){
        model.addAttribute("target", target);
        return "member/memberLogin";
    }

    @PostMapping("/login")
    public ResponseEntity login(@ModelAttribute MemberDTO memberDTO, HttpSession session){
        MemberDTO dto = memberService.login(memberDTO);
        if(dto != null){
            session.setAttribute("loginId", dto.getId());
            session.setAttribute("loginEmail", dto.getMemberEmail());
            session.setAttribute("loginName", dto.getMemberName());
            if(dto.getProfileAttached() == 1){
                MemberProfileDTO memberProfileDTO = memberService.findProfile(dto.getId());
                session.setAttribute("memberProfile", memberProfileDTO.getStoredFileName());
            }
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
    public String findByEmail(@RequestParam("id") Long id, Model model){
        MemberDTO memberDTO = memberService.findById(id);
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

    @PostMapping("/update")
    public String update(@ModelAttribute MemberDTO memberDTO, HttpSession session) throws Exception{
        memberService.update(memberDTO);
        boardService.updateWriter(memberDTO.getId(), memberDTO.getMemberName());
        commentService.updateWriter(memberDTO.getId(), memberDTO.getMemberName());
        session.setAttribute("loginName", memberDTO.getMemberName());
        MemberDTO dto = memberService.login(memberDTO);
        if(dto.getProfileAttached() == 1){
            MemberProfileDTO memberProfileDTO = memberService.findProfile(memberDTO.getId());
            session.setAttribute("memberProfile", memberProfileDTO.getStoredFileName());
        }
        return "redirect:/member/detail";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id") Long id){
        MemberDTO memberDTO = memberService.findById(id);
        boardService.deleteFileByWriterId(id);
        if(memberDTO.getProfileAttached() == 1){
            // 폴더에 저장되 있는 파일 삭제
            memberService.deleteProfile(id);
        }
        memberService.delete(id);
        return "redirect:/member/list";
    }

    @GetMapping("/delete-check")
    public String deleteCheck(Model model, HttpSession session){
        String email = (String) session.getAttribute("loginEmail");
        MemberDTO memberDTO = memberService.findByEmail(email);
        model.addAttribute("member", memberDTO);
        return "member/memberDeleteCheck";
    }

    @PostMapping("/delete-check")
    public String deleteCheck(@RequestParam("id") Long id, HttpSession session){
        MemberDTO memberDTO = memberService.findById(id);
        boardService.deleteFileByWriterId(id);
        if(memberDTO.getProfileAttached() == 1){
            // 폴더에 저장되 있는 파일 삭제
            memberService.deleteProfile(id);
        }
        memberService.delete(id);
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/board-list")
    public String boardList(@RequestParam("id") Long id, Model model){
        MemberDTO memberDTO = memberService.findById(id);
        model.addAttribute("member", memberDTO);
        List<BoardDTO> boardDTOList = boardService.findByWriterId(id);
        model.addAttribute("boardList", boardDTOList);
        return "member/memberBoard";
    }
}
