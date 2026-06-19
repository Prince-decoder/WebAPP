package com.ashu.WebApplication.ViewControl;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {


    @GetMapping({"/","/home"})
    public String home()
    {
        System.out.println("I'm here");
        return "home";
    }
}
