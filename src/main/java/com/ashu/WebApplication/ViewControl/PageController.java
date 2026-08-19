package com.ashu.WebApplication.ViewControl;

import com.ashu.WebApplication.DataModel.JobPost;
import com.ashu.WebApplication.Security.Model.User;
import com.ashu.WebApplication.Security.Service.UserDetailService;
import com.ashu.WebApplication.Service.UserService;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.model.ChatModel;
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.ai.chat.prompt.PromptTemplate;
import org.springframework.ai.converter.BeanOutputConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.lang.reflect.Type;
import java.util.List;
import java.util.Map;

@Controller
public class PageController {

    private ChatClient chatClient;
    public PageController(ChatModel model)
    {
        this.chatClient= ChatClient.create(model);
    }

    @Autowired
    private UserDetailService userDetailsService;

    @PostMapping("/register")
    public String saveNewUser(@RequestBody User user){
        userDetailsService.saveUser(user);
        return "redirect:/home";
    }

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

    @GetMapping("/findjob")
    @ResponseBody
    public List<JobPost> getJobs(@RequestParam String type)
    {
        BeanOutputConverter<List<JobPost>> BC = new BeanOutputConverter<>(new ParameterizedTypeReference<List<JobPost>>() {});
        
        String prompt = "find top 5 companies that are currently recruiting {type}\n{format}";
        PromptTemplate promptTemplate = new PromptTemplate(prompt);
        Prompt prompt1 = promptTemplate.create(Map.of("type", type, "format", BC.getFormat()));

        List<JobPost> j1 = BC.convert(chatClient.prompt(prompt1).call().content());

        return j1;
    }
}
