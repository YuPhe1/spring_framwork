package com.icia.demo.repository;

import com.icia.demo.dto.DemoDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DemoDBRepository {
    @Autowired
    private SqlSessionTemplate sql;
    public void reqdb1(DemoDTO demoDTO) {
        sql.insert("Demo.save", demoDTO);
    }
}
