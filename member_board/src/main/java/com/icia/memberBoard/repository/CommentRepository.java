package com.icia.memberBoard.repository;

import com.icia.memberBoard.dto.CommentDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class CommentRepository {

    @Autowired
    private SqlSessionTemplate sql;

    public void save(CommentDTO commentDTO) {
        sql.insert("Comment.save", commentDTO);
    }

    public List<CommentDTO> findAll(Long boardId) {
        return sql.selectList("Comment.findAll", boardId);
    }

    public void updateWriter(Map<String, Object> parameter) {
        sql.update("Comment.updateWriter", parameter);
    }

    public void delete(Long id) {
        sql.delete("Comment.delete", id);
    }

    public int likeCount(Long id) {
        return sql.selectOne("Comment.likeCount", id);
    }

    public int disLikeCount(Long id) {
        return sql.selectOne("Comment.dislikeCount", id);
    }

    public int likeByMember(Map<String, Long> parameter) {
        return sql.selectOne("Comment.likeByMember", parameter) == null ? 0 : (int) sql.selectOne("Comment.likeByMember", parameter);
    }

    public int disLikeByMember(Map<String, Long> parameter) {
        return sql.selectOne("Comment.dislikeByMember", parameter) == null ? 0 : (int) sql.selectOne("Comment.dislikeByMember", parameter);
    }

    public void likeUp(Map<String, Object> parameters) {
        sql.insert("Comment.likeUp", parameters);
    }

    public void deleteLikeCount(Map<String, Object> parameters) {
        sql.delete("Comment.disLikeDown", parameters);
    }

    public void disLikeUp(Map<String, Object> parameters) {
        sql.insert("Comment.disLikeUp", parameters);
    }

    public List<CommentDTO> pagingList(Map<String, Object> pageParams) {
        return sql.selectList("Comment.pagingList", pageParams);
    }

    public int boardCount(Long boardId) {
        return sql.selectOne("Comment.count", boardId);
    }
}
