package com.icia.board.service;

import com.icia.board.dto.BoardDTO;
import com.icia.board.repository.BoardRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BoardService {

    @Autowired
    private BoardRepository boardRepository;

    public List<BoardDTO> findAll() {
        return boardRepository.findAll();
    }

    public void save(BoardDTO boardDTO) {
        boardRepository.save(boardDTO);
    }

    public void upHits(Long id) {
        boardRepository.upHits(id);
    }

    public BoardDTO findById(Long id) {
        return boardRepository.findById(id);
    }

    public void update(BoardDTO boardDTO) {
        boardRepository.update(boardDTO);
    }

    public void delete(Long id) {
        boardRepository.delete(id);
    }

    public List<BoardDTO> findBySearch(String searchType, String q) {
        Map<String, String> map = new HashMap<>();
        map.put("searchType", searchType);
        map.put("q", q);
        return boardRepository.findBySearch(map);
    }
}
