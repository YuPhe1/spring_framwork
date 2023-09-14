package com.icia.memberBoard.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberProfileDTO {
    private Long id;
    private Long memberId;
    private String originalFileName;
    private String storedFileName;
}
