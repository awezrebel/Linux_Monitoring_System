package com.example.demo.repo;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.model.login;

@Repository
public interface LoginRepo extends JpaRepository<login, Integer>{


	Optional<login> findByUsername(String username);

}
