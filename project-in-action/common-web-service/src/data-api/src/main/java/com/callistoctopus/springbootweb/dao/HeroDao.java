package com.callistoctopus.springbootweb.dao;

import java.util.List;

import com.callistoctopus.springbootweb.model.po.Hero;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.CrudRepository;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

@Repository
public interface HeroDao extends CrudRepository<Hero, Long>{
    // private final JdbcTemplate jdbcTemplate;

    // @Autowired
    // public HeroDao(JdbcTemplate jdbcTemplate) {
    //     this.jdbcTemplate = jdbcTemplate;
    // }

    // public List<Hero> getHeroes(){
    //     return jdbcTemplate.queryForList("select * from hero", Hero.class);
    // }
}
