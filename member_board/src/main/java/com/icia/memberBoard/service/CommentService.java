package com.icia.memberBoard.service;

import com.icia.memberBoard.dto.CommentDTO;
import com.icia.memberBoard.dto.PageDTO;
import com.icia.memberBoard.repository.CommentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CommentService {

    @Autowired
    private CommentRepository commentRepository;

    public void save(CommentDTO commentDTO) {
        commentRepository.save(commentDTO);
    }

    public List<CommentDTO> findAll(Long boardId, Long loginId) {
        List<CommentDTO> commentDTOList = commentRepository.findAll(boardId);
        boolean checkLogin = loginId == null ? false : true;
        for (CommentDTO commentDTO : commentDTOList) {
            commentDTO.setLikeCount(commentRepository.likeCount(commentDTO.getId()));
            commentDTO.setDisLikeCount(commentRepository.disLikeCount(commentDTO.getId()));
            if (checkLogin) {
                Map<String, Long> parameter = new HashMap<>();
                parameter.put("commentId", commentDTO.getId());
                parameter.put("memberId", loginId);
                commentDTO.setLike(commentRepository.likeByMember(parameter));
                commentDTO.setDisLike(commentRepository.disLikeByMember(parameter));
            }
        }
        return commentDTOList;
    }

    public void updateWriter(Long id, String memberName) {
        Map<String, Object> parameter = new HashMap<>();
        parameter.put("writerId", id);
        parameter.put("writer", memberName);
        commentRepository.updateWriter(parameter);
    }

    public void delete(Long id) {
        commentRepository.delete(id);
    }

    public void deleteLikeCount(Long commentId, Long memberId) {
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("commentId" , commentId);
        parameters.put("memberId", memberId);
        commentRepository.deleteLikeCount(parameters);
    }

    public void likeUp(Long commentId, Long memberId) {
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("commentId" , commentId);
        parameters.put("memberId", memberId);
        commentRepository.likeUp(parameters);
    }

    public void disLikeUp(Long commentId, Long memberId) {
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("commentId" , commentId);
        parameters.put("memberId", memberId);
        commentRepository.disLikeUp(parameters);
    }

    public List<CommentDTO> pagingList(int page, int limit, Long boardId, Long loginId){
        int pageLimit = limit; // 한페이지당 보여줄 글 갯수
        int pagingStart = (page - 1) * pageLimit;
        Map<String, Object> pageParams = new HashMap<>();
        pageParams.put("start", pagingStart);
        pageParams.put("limit", pageLimit);
        pageParams.put("boardId", boardId);
        List<CommentDTO> commentDTOList = commentRepository.pagingList(pageParams);
        boolean checkLogin = loginId == null ? false : true;
        for (CommentDTO commentDTO : commentDTOList) {
            commentDTO.setLikeCount(commentRepository.likeCount(commentDTO.getId()));
            commentDTO.setDisLikeCount(commentRepository.disLikeCount(commentDTO.getId()));
            if (checkLogin) {
                Map<String, Long> parameter = new HashMap<>();
                parameter.put("commentId", commentDTO.getId());
                parameter.put("memberId", loginId);
                commentDTO.setLike(commentRepository.likeByMember(parameter));
                commentDTO.setDisLike(commentRepository.disLikeByMember(parameter));
            }
        }
        return commentDTOList;
    }

    public PageDTO pageNumber(int page, int limit, Long boardId) {
        int pageLimit = limit; // 한페이지에 보여줄 글 갯수
        int blockLimit = 3; // 하단에 보여줄 페이지 번호 갯수
        // 전체 글 갯수 조회
        int boardCount = commentRepository.boardCount(boardId);
        // 전체 페이지 갯수 계산
        int maxPage = (int) (Math.ceil((double) boardCount / pageLimit));
        // 시작 페이지 값 계산(1, 11, 21, 31 ~~)
        int startPage = (((int) (Math.ceil((double) page / blockLimit))) - 1) * blockLimit + 1;
        // 마지막 페이지 값 계산(10, 20, 30, 40 ~~)
        int endPage = startPage + blockLimit - 1;
        // 전체 페이지 갯수가 계산한 endPage 보다 작을 때는 endPage 값을 maxPage 값과 같게 세팅
        if (endPage > maxPage) {
            endPage = maxPage;
        }
        PageDTO pageDTO = new PageDTO();
        pageDTO.setPage(page);
        pageDTO.setMaxPage(maxPage);
        pageDTO.setEndPage(endPage);
        pageDTO.setStartPage(startPage);
        return pageDTO;
    }
}
