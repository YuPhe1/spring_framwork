package com.icia.board.controller;

import com.icia.board.dto.BoardDTO;
import com.icia.board.dto.BoardFileDTO;
import com.icia.board.dto.CommentDTO;
import com.icia.board.dto.PageDTO;
import com.icia.board.service.BoardService;
import com.icia.board.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.net.HttpCookie;
import java.util.List;

@Controller
@RequestMapping("/board")
public class BoardController {
    @Autowired
    private BoardService boardService;
    @Autowired
    private CommentService commentService;
    @GetMapping("/list")
    public String findAll(@RequestParam(value = "page", required = false, defaultValue = "1") int page, Model model){
        List<BoardDTO> boardDTOList = boardService.pagingList(page);
        model.addAttribute("boardList", boardDTOList);
        PageDTO pageDTO =boardService.pageNumber(page);
        model.addAttribute("paging", pageDTO);
        return "boardPage/boardList";
    }

    @GetMapping("/save")
    public String save(){
        return "boardPage/boardSave";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute BoardDTO boardDTO) throws IOException {
        boardService.save(boardDTO);
        return "redirect:/board/list";
    }

    @GetMapping
    public String detail(Model model, @RequestParam("id") Long id, @RequestParam(value = "page", required = false, defaultValue = "1") int page, HttpServletResponse response, HttpServletRequest request){
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
        if(boardDTO.getFileAttached() == 1){
            List<BoardFileDTO> boardFileDTOList = boardService.findFile(id);
            model.addAttribute("boardFileList", boardFileDTOList);
        }
        model.addAttribute("board", boardDTO);
        List<CommentDTO> commentDTOList = commentService.findAll(id);
        if (commentDTOList.size() == 0){
            model.addAttribute("commentList", null);
        } else {
            model.addAttribute("commentList", commentDTOList);
        }
        model.addAttribute("page", page);
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
        return "redirect:/board/list";
    }

    @GetMapping("/search")
    public String search(@RequestParam("searchType") String type, @RequestParam("q") String q,
                         @RequestParam(value = "page", required = false, defaultValue = "1") int page, Model model){
        List<BoardDTO> boardDTOList = boardService.searchList(type, q, page);
        model.addAttribute("boardList", boardDTOList);

        PageDTO pageDTO = boardService.searchPageNumber(q, type, page);
        model.addAttribute("paging", pageDTO);

        return "boardPage/boardList";
    }

    @GetMapping("/getPaging")
    public @ResponseBody int getPage(@RequestParam("searchType") String searchType, @RequestParam("q") String q){
        int maxPage = boardService.getPage(searchType, q);
        return maxPage;
    }
}
