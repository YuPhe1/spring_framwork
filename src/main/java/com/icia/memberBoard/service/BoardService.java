package com.icia.memberBoard.service;

import com.icia.memberBoard.dto.BoardDTO;
import com.icia.memberBoard.dto.BoardFileDTO;
import com.icia.memberBoard.repository.BoardRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;

@Service
public class BoardService {

    @Autowired
    private BoardRepository boardRepository;

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
                String savePath = "D:\\boardFile\\" + storedFileName;
                boardFile.transferTo(new File(savePath));
                boardRepository.saveFile(boardFileDTO);
            }
        }
    }
}
