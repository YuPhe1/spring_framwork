package com.icia.memberBoard.service;

import com.icia.memberBoard.dto.BoardDTO;
import com.icia.memberBoard.dto.BoardFileDTO;
import com.icia.memberBoard.dto.PageDTO;
import com.icia.memberBoard.repository.BoardRepository;
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

    public List<BoardDTO> pagingList(int page) {
        int pageLimit = 5; // 한페이지당 보여줄 글 갯수
        int pagingStart = (page - 1) * pageLimit;
        Map<String, Integer> pageParams = new HashMap<>();
        pageParams.put("start", pagingStart);
        pageParams.put("limit", pageLimit);
        return boardRepository.pagingList(pageParams);
    }

    public PageDTO pageNumber(int page) {
        int pageLimit = 5; // 한페이지에 보여줄 글 갯수
        int blockLimit = 3; // 하단에 보여줄 페이지 번호 갯수
        // 전체 글 갯수 조회
        int boardCount = boardRepository.boardCount();
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

    public List<BoardDTO> searchList(String type, String q, int page) {
        Map<String, Object> searchParam = new HashMap<>();
        searchParam.put("type", type);
        searchParam.put("q", q);
        int pageLimit = 5; // 한페이지당 보여줄 글 갯수
        int pagingStart = (page - 1) * pageLimit;
        searchParam.put("start", pagingStart);
        searchParam.put("limit", pageLimit);

        return boardRepository.searchList(searchParam);
    }

    public PageDTO searchPageNumber(String q, String type, int page) {
        int pageLimit = 5; // 한페이지에 보여줄 글 갯수
        int blockLimit = 3; // 하단에 보여줄 페이지 번호 갯수
        Map<String, String> pagingParams = new HashMap<>();
        pagingParams.put("type", type);
        pagingParams.put("q", q);
        // 검색어 기준 전체 글 갯수 조회
        int boardCount = boardRepository.boardSearchCount(pagingParams);
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

    public void upHits(Long id) {
        boardRepository.upHits(id);
    }

    public BoardDTO findById(Long id) {
        return boardRepository.findById(id);
    }

    public List<BoardFileDTO> findFile(Long boardId) {
        return boardRepository.findFile(boardId);
    }

    public void deleteFile(Long id) {
        List<BoardFileDTO> boardFileDTOList = boardRepository.findFile(id);
        for (BoardFileDTO boardFileDTO : boardFileDTOList) {
            File file = new File("D:\\boardFile\\" + boardFileDTO.getStoredFileName());
            if (file.exists()) {
                file.delete();
            }
        }
    }

    public void delete(Long id) {
        boardRepository.delete(id);
    }

    public void update(BoardDTO boardDTO, List<String> deleteFileName) throws IOException {
        List<BoardFileDTO> boardFileDTOList = boardRepository.findFile(boardDTO.getId());
        if (deleteFileName != null) {
            if (boardFileDTOList.size() == deleteFileName.size() && boardDTO.getBoardFile().get(0).isEmpty()) {
                boardDTO.setFileAttached(0);
            } else {
                boardDTO.setFileAttached(1);
            }
            // 삭제할 파일 삭제
            for (String fileName : deleteFileName) {
                File file = new File("D:\\boardFile\\" + fileName);
                if (file.exists()) {
                    file.delete();
                }
                BoardFileDTO boardFileDTO = new BoardFileDTO();
                boardFileDTO.setBoardId(boardDTO.getId());
                boardFileDTO.setStoredFileName(fileName);
                boardRepository.deleteFile(boardFileDTO);
            }
            boardRepository.update(boardDTO);
            if(!boardDTO.getBoardFile().get(0).isEmpty()) {
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
                    boardFileDTO.setBoardId(boardDTO.getId());
                    // 파일 저장용 폴더에 파일 저장 처리
                    String savePath = "D:\\boardFile\\" + storedFileName;
                    boardFile.transferTo(new File(savePath));
                    boardRepository.saveFile(boardFileDTO);
                }
            }
        } else {
            if(!boardDTO.getBoardFile().get(0).isEmpty()){
                boardDTO.setFileAttached(1);boardDTO.setFileAttached(1);
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
                    boardFileDTO.setBoardId(boardDTO.getId());
                    // 파일 저장용 폴더에 파일 저장 처리
                    String savePath = "D:\\boardFile\\" + storedFileName;
                    boardFile.transferTo(new File(savePath));
                    boardRepository.saveFile(boardFileDTO);
                }
            }
        }
    }

    public void deleteFileByWriterId(Long id) {
        List<BoardDTO> boardDTOList = boardRepository.findByWriterId(id);
        for(BoardDTO boardDTO : boardDTOList){
            if(boardDTO.getFileAttached() == 1){
                List<BoardFileDTO> boardFileDTOList = boardRepository.findFile(boardDTO.getId());
                for (BoardFileDTO boardFileDTO : boardFileDTOList) {
                    File file = new File("D:\\boardFile\\" + boardFileDTO.getStoredFileName());
                    if (file.exists()) {
                        file.delete();
                    }
                }
            }
        }
    }
}
