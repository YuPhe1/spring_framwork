package com.icia.memberBoard.service;

import com.icia.memberBoard.dto.CommentDTO;
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
}
