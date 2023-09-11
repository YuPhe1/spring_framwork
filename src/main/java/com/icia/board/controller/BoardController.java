package com.icia.board.controller;

import com.icia.board.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class BoardController {
    @Autowired
    private BoardService boardService;

}
