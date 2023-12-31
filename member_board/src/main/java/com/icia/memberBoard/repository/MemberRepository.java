package com.icia.memberBoard.repository;

import com.icia.memberBoard.dto.MemberDTO;
import com.icia.memberBoard.dto.MemberProfileDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MemberRepository {

    @Autowired
    private SqlSessionTemplate sql;

    public MemberDTO save(MemberDTO memberDTO) {
        sql.insert("Member.save", memberDTO);
        return memberDTO;
    }

    public void saveFile(MemberProfileDTO memberProfileDTO) {
        sql.insert("Member.saveFile", memberProfileDTO);
    }

    public MemberDTO findByEmail(String email) {
        return sql.selectOne("Member.findByEmail", email);
    }

    public MemberDTO login(MemberDTO memberDTO) {
        return sql.selectOne("Member.login", memberDTO);
    }

    public List<MemberDTO> findByAll() {
        return sql.selectList("Member.findByAll");
    }

    public MemberProfileDTO findProfile(Long id) {
        return sql.selectOne("Member.findProfile", id);
    }

    public void update(MemberDTO memberDTO) {
        sql.update("Member.update", memberDTO);
    }

    public void updateFile(MemberProfileDTO memberProfileDTO) {
        sql.update("Member.profileUpdate", memberProfileDTO);
    }

    public MemberDTO findById(Long id) {
        return sql.selectOne("Member.findById", id);
    }

    public void delete(Long id) {
        sql.delete("Member.delete", id);
    }
}
