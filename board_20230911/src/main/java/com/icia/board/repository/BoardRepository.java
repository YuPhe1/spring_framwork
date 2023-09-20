package com.icia.board.repository;

import com.icia.board.dto.BoardDTO;
import com.icia.board.dto.BoardFileDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class BoardRepository {

    @Autowired
    private SqlSessionTemplate sql;

    public List<BoardDTO> findAll() {
        return sql.selectList("Board.findAll");
    }

    public BoardDTO save(BoardDTO boardDTO) {
        sql.insert("Board.save", boardDTO);
        return boardDTO;
    }

    public void upHits(Long id) {
        sql.update("Board.upHits", id);
    }

    public BoardDTO findById(Long id) {
        return sql.selectOne("Board.findById", id);
    }

    public void update(BoardDTO boardDTO) {
        sql.update("Board.update", boardDTO);
    }

    public void delete(Long id) {
        sql.delete("Board.delete", id);
    }

    public int getPage(Map<String, String> map) {
        return sql.selectOne("Board.paging", map);
    }

    public void saveFile(BoardFileDTO boardFileDTO) {
        sql.insert("Board.saveFile", boardFileDTO);
    }

    public List<BoardFileDTO> findFile(Long boardId) {
        return sql.selectList("Board.findFile", boardId);
    }

    public List<BoardDTO> pagingList(Map<String, Integer> pageParams) {
        return sql.selectList("Board.pagingList", pageParams);
    }

    public int boardCount() {
        return sql.selectOne("Board.count");
    }

    public List<BoardDTO> searchList(Map<String, Object> searchParam) {
        return sql.selectList("Board.search", searchParam);
    }

    public int boardSearchCount(Map<String, String> pagingParams) {
        return sql.selectOne("Board.searchCount", pagingParams);
    }
}
