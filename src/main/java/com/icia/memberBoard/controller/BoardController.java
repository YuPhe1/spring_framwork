package com.icia.memberBoard.controller;

import com.icia.memberBoard.dto.BoardDTO;
import com.icia.memberBoard.dto.BoardFileDTO;
import com.icia.memberBoard.dto.PageDTO;
import com.icia.memberBoard.service.BoardService;
import com.icia.memberBoard.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    private BoardService boardService;
    @Autowired
    private CommentService commentService;

    @GetMapping("/list")
    public String findAll(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
                          @RequestParam(value = "searchType", required = false, defaultValue = "boardTitle") String type,
                          @RequestParam(value = "q", required = false, defaultValue = "") String q,
                          Model model) {
        // 검색이든 아니든 핑요한 정보: boardList, paging
        List<BoardDTO> boardDTOList = null;
        PageDTO pageDTO = null;
        // 검색 요쳥인지 아닌지 구분
        if (q.equals("")) {
            // 일반 페이지 요청
            boardDTOList = boardService.pagingList(page);
            pageDTO = boardService.pageNumber(page);
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
    public String save() {
        return "board/boardSave";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute BoardDTO boardDTO) throws IOException {
        boardService.save(boardDTO);
        return "redirect:/board/list";
    }

    @GetMapping
    public String detail(Model model,
                         @RequestParam("id") Long id,
                         @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                         @RequestParam(value = "searchType", required = false, defaultValue = "boardTitle") String type,
                         @RequestParam(value = "q", required = false, defaultValue = "") String q,
                         HttpServletResponse response, HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        boolean isHit = false;
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("hit" + id)) {
                isHit = true;
            }
        }
        if (!isHit) {
            boardService.upHits(id);
            Cookie cookie = new Cookie("hit" + id, "1");
            cookie.setPath("/");
            cookie.setMaxAge(5 * 60);
            response.addCookie(cookie);
        }
        BoardDTO boardDTO = boardService.findById(id);
        if (boardDTO.getFileAttached() == 1) {
            List<BoardFileDTO> boardFileDTOList = boardService.findFile(id);
            model.addAttribute("boardFileList", boardFileDTOList);
        }
        model.addAttribute("board", boardDTO);
        model.addAttribute("page", page);
        model.addAttribute("q", q);
        model.addAttribute("type", type);

        model.addAttribute("commentList", commentService.findAll(id));
        return "board/boardDetail";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id") Long id) {
        BoardDTO boardDTO = boardService.findById(id);
        if (boardDTO.getFileAttached() == 1) {
            boardService.deleteFile(id);
        }
        boardService.delete(id);
        return "redirect:/board/list";
    }

    @GetMapping("/update")
    public String update(Model model,
                         @RequestParam("id") Long id) {

        BoardDTO boardDTO = boardService.findById(id);
        if (boardDTO.getFileAttached() == 1) {
            List<BoardFileDTO> boardFileDTOList = boardService.findFile(id);
            model.addAttribute("boardFileList", boardFileDTOList);
        }
        model.addAttribute("board", boardDTO);

        return "board/boardUpdate";
    }

    @PostMapping("/update")
    public String update(@ModelAttribute BoardDTO boardDTO, @RequestParam(value = "deleteFile", required = false) List<String> deleteFileName) throws IOException {
        boardService.update(boardDTO, deleteFileName);
        return "redirect:/board?id=" + boardDTO.getId();
    }
}
