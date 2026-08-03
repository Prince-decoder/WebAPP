package com.ashu.WebApplication.Security.Model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Data;


@Data
@Entity
public class User {
    @Id
    private Integer id;
    @Column(name = "name")
    private String userName;
    private String password;
}
