package com.icia.memberBoard.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommentDTO {
    private Long id;
    private Long commentWriterId;
    private String commentWriter;
    private String commentContents;
    private String createdAt;
    private Long boardId;
    private int likeCount;
    private int disLikeCount;
    private int like;
    private int disLike;
}
