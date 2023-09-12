package com.icia.board.controller;

import com.icia.board.dto.BoardDTO;
import com.icia.board.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.HttpCookie;
import java.util.List;

@Controller
@RequestMapping("/board")
public class BoardController {
    @Autowired
    private BoardService boardService;

    @GetMapping("/")
    public String boardList(Model model){
        List<BoardDTO> boardDTOList = boardService.findAll();
        model.addAttribute("boardList", boardDTOList);
        return "boardPage/boardList";
    }

    @GetMapping("/save")
    public String save(){
        return "boardPage/boardSave";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute BoardDTO boardDTO){
        boardService.save(boardDTO);
        return "redirect:/board/";
    }

    @GetMapping
    public String detail(Model model, @RequestParam("id") Long id, HttpServletResponse response, HttpServletRequest request){
        Cookie[] cookies = request.getCookies();
        boolean isHit = false;
        for(Cookie cookie : cookies){
            if(cookie.getName().equals("hit"+id)){
                isHit = true;
            }
        }
        if(!isHit) {
            boardService.upHits(id);
            Cookie cookie = new Cookie("hit"+id, "1");
            cookie.setPath("/");
            cookie.setMaxAge(5*60);
            response.addCookie(cookie);
        }
        BoardDTO boardDTO = boardService.findById(id);
        model.addAttribute("board", boardDTO);
        return "boardPage/boardDetail";
    }

    @GetMapping("/update")
    public String update(Model model, @RequestParam("id") Long id){
        BoardDTO boardDTO = boardService.findById(id);
        model.addAttribute("board", boardDTO);
        return "boardPage/boardUpdate";
    }

    @PostMapping("/update")
    public String update(@ModelAttribute BoardDTO boardDTO){
        boardService.update(boardDTO);
        return "redirect:/board/detail?id=" + boardDTO.getId();
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id") Long id, Model model){
        BoardDTO boardDTO = boardService.findById(id);
        model.addAttribute("board", boardDTO);
        return "boardPage/deleteCheck";
    }

    @PostMapping("/delete")
    public String delete(@ModelAttribute("id") Long id){
        boardService.delete(id);
        return "redirect:/board/";
    }
}
