package com.icia.board.service;

import com.icia.board.dto.BoardDTO;
import com.icia.board.dto.BoardFileDTO;
import com.icia.board.repository.BoardRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
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

    public void save(BoardDTO boardDTO) throws IOException {
        if (boardDTO.getBoardFile().get(0).isEmpty()) {
            // 파일 없다.
            boardDTO.setFileAttached(0);
            boardRepository.save(boardDTO);
        } else {
            // 파일 있다.
            boardDTO.setFileAttached(1);
            // 게시글 저장 후 id값 활용을 위해 리턴 받음
            BoardDTO saveBoard = boardRepository.save(boardDTO);
            // 파일이 여러개 있기 때문에 반복문으로 파일 하나씩 꺼내서 저장 처리
            // 파일만 따로 가져오기
            List<MultipartFile> boardFileList = boardDTO.getBoardFile();
            for (MultipartFile boardFile : boardFileList) {
                // 파일 이름 가져오기
                String originalFileName = boardFile.getOriginalFilename();
                // 저장용 이름 만들기
                String storedFileName = System.currentTimeMillis() + "-" + originalFileName;
                // BoardFileDTO 세팅
                BoardFileDTO boardFileDTO = new BoardFileDTO();
                boardFileDTO.setOriginalFileName(originalFileName);
                boardFileDTO.setStoredFileName(storedFileName);
                boardFileDTO.setBoardId(saveBoard.getId());
                // 파일 저장용 폴더에 파일 저장 처리
                String savePath = "D:\\spring_img\\" + storedFileName;
                boardFile.transferTo(new File(savePath));
                boardRepository.saveFile(boardFileDTO);
            }
        }
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

    public List<BoardDTO> findBySearch(String searchType, String q, int page) {
        Map<String, String> map = new HashMap<>();
        map.put("searchType", searchType);
        map.put("q", q);
        map.put("page", Integer.toString((page - 1) * 5));
        return boardRepository.findBySearch(map);
    }

    public int getPage(String searchType, String q) {
        Map<String, String> map = new HashMap<>();
        map.put("searchType", searchType);
        map.put("q", q);
        return boardRepository.getPage(map);
    }

    public List<BoardFileDTO> findFile(Long boardId) {
        return boardRepository.findFile(boardId);
    }
}
