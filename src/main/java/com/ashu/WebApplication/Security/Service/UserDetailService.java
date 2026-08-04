package com.ashu.WebApplication.Security.Service;

import com.ashu.WebApplication.Security.Model.User;
import com.ashu.WebApplication.Security.Model.UserDetailImplementation;
import com.ashu.WebApplication.Security.Repository.ClientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserDetailService implements UserDetailsService {

    @Autowired
    private ClientRepository clientRepository;
    private BCryptPasswordEncoder bCryptPasswordEncoder= new BCryptPasswordEncoder(12);

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException
    {
        User user= clientRepository.findByUsername(username);
        if(user==null)
        {
            throw new UsernameNotFoundException(username);
        }
        else
        {
            return new UserDetailImplementation(user);
        }
    }

    public void saveUser(User user)
    {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        clientRepository.save(user);
    }
}
