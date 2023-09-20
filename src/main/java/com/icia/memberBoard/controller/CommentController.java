package com.icia.memberBoard.controller;

import com.icia.memberBoard.dto.CommentDTO;
import com.icia.memberBoard.dto.PageDTO;
import com.icia.memberBoard.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;


@Controller
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    private CommentService commentService;

    @PostMapping("/save")
    public ResponseEntity save(@ModelAttribute CommentDTO commentDTO, HttpSession session) {
        commentService.save(commentDTO);
        Long loginId = (Long) session.getAttribute("loginId");
        List<CommentDTO> commentDTOList = commentService.pagingList(1, 10, commentDTO.getBoardId(), loginId);
        return new ResponseEntity<>(commentDTOList, HttpStatus.OK);
    }

    @PostMapping("/delete")
    public ResponseEntity delete(@RequestParam("id") Long id, @RequestParam Long boardId,
                                 @RequestParam("page") int page, HttpSession session) {
        commentService.delete(id);
        Long loginId = (Long) session.getAttribute("loginId");
        List<CommentDTO> commentDTOList = commentService.pagingList(page, 10, boardId, loginId);
        return new ResponseEntity<>(commentDTOList, HttpStatus.OK);
    }

    @PostMapping("/like-count-up")
    public ResponseEntity likeCountUp(@RequestParam("commentId") Long commentId,
                                      @RequestParam("boardId") Long boardId,
                                      @RequestParam("disLike") int disLike,
                                      @RequestParam("page") int page,
                                      HttpSession session) {
        Long memberId = (Long) session.getAttribute("loginId");
        if (disLike == 1) {
            commentService.deleteLikeCount(commentId, memberId);
        }
        commentService.likeUp(commentId, memberId);
        List<CommentDTO> commentDTOList = commentService.pagingList(page, 10, boardId, memberId);
        return new ResponseEntity<>(commentDTOList, HttpStatus.OK);
    }

    @PostMapping("/delete_like_count")
    public ResponseEntity deleteLikeCount(@RequestParam("commentId") Long commentId,
                                          @RequestParam("boardId") Long boardId,
                                          @RequestParam("page") int page,
                                          HttpSession session) {
        Long memberId = (Long) session.getAttribute("loginId");
        commentService.deleteLikeCount(commentId, memberId);
        List<CommentDTO> commentDTOList = commentService.pagingList(page, 10, boardId, memberId);
        return new ResponseEntity<>(commentDTOList, HttpStatus.OK);
    }

    @PostMapping("/disLike-count-up")
    public ResponseEntity disLikeCountUp(@RequestParam("commentId") Long commentId, @RequestParam("boardId") Long boardId,
                                         @RequestParam("like") int like, @RequestParam("page") int page, HttpSession session) {
        Long memberId = (Long) session.getAttribute("loginId");
        if (like == 1) {
            commentService.deleteLikeCount(commentId, memberId);
        }
        commentService.disLikeUp(commentId, memberId);
        List<CommentDTO> commentDTOList = commentService.pagingList(page, 10, boardId, memberId);
        return new ResponseEntity<>(commentDTOList, HttpStatus.OK);
    }

    @GetMapping("/paging-list")
    public ResponseEntity pagingList(@RequestParam("page") int page,
                                     @RequestParam("boardId") Long boardId,
                                     @RequestParam("loginId") Long loginId) {
        List<CommentDTO> commentDTOList = commentService.pagingList(page, 10, boardId, loginId);
        return new ResponseEntity(commentDTOList, HttpStatus.OK);
    }

    @GetMapping("/paging-number")
    public ResponseEntity pagingNumber(@RequestParam("page") int page, @RequestParam("boardId") Long boardId) {
        PageDTO pageDTO = commentService.pageNumber(page, 10, boardId);
        return new ResponseEntity<>(pageDTO, HttpStatus.OK);
    }
}
