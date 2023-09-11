package com.icia.board.controller;

import com.icia.board.dto.BoardDTO;
import com.icia.board.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

@Controller
public class BoardController {
    @Autowired
    private BoardService boardService;

    @GetMapping("/board/list")
    public String boardList(Model model){
        List<BoardDTO> boardDTOList = boardService.findAll();
        model.addAttribute("boardList", boardDTOList);
        return "boardList";
    }

    @GetMapping("/board/save")
    public String save(){
        return "boardSave";
    }

    @PostMapping("/board/save")
    public String save(@ModelAttribute BoardDTO boardDTO){
        boardService.save(boardDTO);
        return "redirect:/board/list";
    }
}
