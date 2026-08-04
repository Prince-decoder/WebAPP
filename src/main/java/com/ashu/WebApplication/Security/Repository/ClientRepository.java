package com.ashu.WebApplication.Security.Repository;

import com.ashu.WebApplication.Security.Model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.stereotype.Repository;

@Repository
@EnableJpaRepositories
public interface ClientRepository extends JpaRepository<User,Integer> {
}
