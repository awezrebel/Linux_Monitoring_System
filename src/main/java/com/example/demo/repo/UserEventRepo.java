package com.example.demo.repo;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo.model.UserEvent;

public interface UserEventRepo extends JpaRepository<UserEvent, Integer>{

}
