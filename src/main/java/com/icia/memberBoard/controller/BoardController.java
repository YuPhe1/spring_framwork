package com.icia.memberBoard.controller;

import com.icia.memberBoard.dto.BoardDTO;
import com.icia.memberBoard.dto.PageDTO;
import com.icia.memberBoard.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    private BoardService boardService;

    @GetMapping("/list")
    public String findAll(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
                          @RequestParam(value = "searchType", required = false, defaultValue = "boardTitle") String type,
                          @RequestParam(value = "q", required = false, defaultValue = "") String q,
                          Model model){
        // 검색이든 아니든 핑요한 정보: boardList, paging
        List<BoardDTO> boardDTOList = null;
        PageDTO pageDTO = null;
        // 검색 요쳥인지 아닌지 구분
        if(q.equals("")){
            // 일반 페이지 요청
            boardDTOList = boardService.pagingList(page);
            pageDTO =boardService.pageNumber(page);
        } else {
            // 검색결과 페이지 요청
            boardDTOList = boardService.searchList(type, q, page);
            pageDTO = boardService.searchPageNumber(q, type, page);
        }
        model.addAttribute("boardList", boardDTOList);
        model.addAttribute("paging", pageDTO);
        model.addAttribute("q", q);
        model.addAttribute("type", type);
        return "board/boardList";
    }

    @GetMapping("/save")
    public String save(){
        return "board/boardSave";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute BoardDTO boardDTO) throws IOException {
        boardService.save(boardDTO);
        return "redirect:/board/list";
    }
    @GetMapping("/insert")
    public String insert() throws IOException {
        for(int i = 1; i <= 15 ; i++) {
            BoardDTO boardDTO = new BoardDTO();
            boardDTO.setBoardTitle("test"+i);
            boardDTO.setBoardWriter("test1");
            boardDTO.setBoardContents("test"+i);
            boardDTO.setBoardWriterId(2L);
            boardDTO.setFileAttached(0);
            boardService.save(boardDTO);
        }
        return "redirect:/board/list";
    }
}
