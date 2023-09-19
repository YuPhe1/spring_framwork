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

    public List<CommentDTO> findAll(Long boardId) {
        return commentRepository.findAll(boardId);

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
}
