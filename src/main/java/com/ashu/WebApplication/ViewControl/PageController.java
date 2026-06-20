package com.ashu.WebApplication.ViewControl;

import com.ashu.WebApplication.DataModel.JobPost;
import com.ashu.WebApplication.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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

    @PostMapping("viewalljobs")
    public String Delete(JobPost jobPost)
    {
        us.delete(jobPost);
        return "redirect:/viewalljobs";
    }

    @GetMapping("/addjob")
    public String addJob()
    {
        return "addjob";
    }

    @PostMapping("handleForm")
    public String handle(JobPost jobPost)
    {
        us.addJob(jobPost);
        return "success";
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


    @DeleteMapping("/viewalljobs")
    public String delete(JobPost jobPost)
    {
        us.delete(jobPost);
        return "redirect:/viewalljobs";
    }


    @GetMapping("jobPosts/Keyword/{keyword}")
    public String search(@PathVariable("keyword") String keyword,Model m)
    {
        m.addAttribute("jobPosts",us.jobsearch(keyword));
        return "searched";
    }


    @GetMapping("/load")
    public String load()
    {
        us.load();
        return "redirect:/viewalljobs";
    }
}
