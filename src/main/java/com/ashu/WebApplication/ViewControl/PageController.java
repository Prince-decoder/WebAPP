package com.ashu.WebApplication.ViewControl;

import com.ashu.WebApplication.DataModel.JobPost;
import com.ashu.WebApplication.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

@Controller
public class PageController {


    @Autowired
    private UserService us;

    @GetMapping({"/","/home"})
    public String home()
    {
        return "home";
    }

    @GetMapping("/addjob")
    public String addJob()
    {
        return "addjob";
    }

    @GetMapping("/contact")
    public String contact()
    {
        return "Contact";
    }

    @GetMapping("/viewalljobs")
    public String getAll(Model m)
    {
        List<JobPost> jobs= us.getAlljobs();
        m.addAttribute("jobPosts",jobs);
        return "viewalljobs";
    }

    @PostMapping("handleForm")
    public String formhandler(JobPost jobPost)
    {
        us.addJob(jobPost);
        return "success";
    }

    @GetMapping("/load")
    public String load()
    {
        us.load();
        return "Success";
    }
}
