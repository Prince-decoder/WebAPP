package com.ashu.WebApplication.Service;

import com.ashu.WebApplication.DataModel.JobPost;
import com.ashu.WebApplication.Repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserRepository ur;

    public void addJob(JobPost p)
    {
        ur.addjob(p);
    }
    public List<JobPost> getAlljobs()
    {
        return ur.getAllJobs();
    }
}
