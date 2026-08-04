package com.ashu.WebApplication.Security.Model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
public class User {
    @Id
    private Integer id;
    @Column(name = "name")
    private String userName;
    private String password;
}
