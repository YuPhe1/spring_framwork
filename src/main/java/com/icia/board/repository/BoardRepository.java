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
        return sql.selectList("Board.list");
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

    public List<BoardDTO> findBySearch(Map<String, String> map) {
        return sql.selectList("Board.search", map);
    }

    public int getPage(Map<String, String> map) {
        return sql.selectOne("Board.paging", map);
    }

    public void saveFile(BoardFileDTO boardFileDTO) {
        sql.insert("Board.saveFile", boardFileDTO);
    }
}
