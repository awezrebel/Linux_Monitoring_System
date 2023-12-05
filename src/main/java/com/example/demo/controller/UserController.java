package com.example.demo.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.annotation.Secured;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.model.UserEvent;
import com.example.demo.repo.LoginRepo;
import com.example.demo.repo.UserEventRepo;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;


@CrossOrigin(origins = "http://192.168.234.130:8080/rawdata")
@RestController
public class UserController {


	@Autowired
    private LoginRepo loginrepo;


	@Autowired
	private UserEventRepo usereventrepo;

    @GetMapping("/login")
    public ModelAndView showLoginPage() {
        ModelAndView modelAndView = new ModelAndView("index");
        // add model attributes if needed
        return modelAndView;
    }

 
	
	
	
	 @PostMapping("/login")
	    public ModelAndView login(@RequestParam String username, @RequestParam String password,  HttpSession session ) {
	      
		  boolean loginSuccessful =  false;
		 int User_id = loginrepo.findByUsername(username).get().getUserId();

			if(loginrepo.getById(User_id).getPassword().equals(password)) {
				loginSuccessful =  true;
				System.out.println("Login Succesfull For "+username);
				 
			} 
		 
	 
			 if (loginSuccessful) {
				  
				 session.setAttribute("username", username);
		            return new ModelAndView("redirect:/data"); 
			    } else {
			    	 ModelAndView modelAndView = new ModelAndView("index");
			            modelAndView.addObject("error", "Invalid credentials");
			            return modelAndView;
			    }

	    }
	 
	 
	@Secured("dssadmin")
	@GetMapping("/data")
	public ModelAndView showEventDetails() {
	    List<UserEvent> events = usereventrepo.findAll();
 
	    ObjectMapper objectMapper = new ObjectMapper();
	    String jsonEvents;
	    try {
	        jsonEvents = objectMapper.writeValueAsString(events);
	    } catch (JsonProcessingException e) {
	        // Handle the exception appropriately (log it, return an error response, etc.)
	        e.printStackTrace();
	        return new ModelAndView("error");
	    }

	    ModelAndView modelAndView = new ModelAndView("home");

	    // Add the JSON string as a model attribute
	    modelAndView.addObject("events", jsonEvents);

	    return modelAndView;
	}

	@GetMapping("/rawdata")
	public List<UserEvent> event() {
	  
return usereventrepo.findAll();
	     
	}
	 @Value("${script.path}")
	    private String scriptPath;
	
	  @GetMapping("/runscript")
	    public String runShellScript() {
	        try {
	            // Replace "your_script.sh" with the actual name of your shell script
	        	  ProcessBuilder processBuilder = new ProcessBuilder("sh", scriptPath);

	            processBuilder.redirectErrorStream(true);

	            Process process = processBuilder.start();

	            // Wait for the script to finish and get the exit code
	            int exitCode = process.waitFor();

	            // Read the output of the script
	            StringBuilder output = new StringBuilder();
	            try (BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()))) {
	                String line;
	                while ((line = reader.readLine()) != null) {
	                    output.append(line).append("\n");
	                }
	            }

	            // You can handle the exitCode and output as needed
	            if (exitCode == 0) {
	                return "Script executed successfully. Output:\n" + output.toString();
	            } else {
	                return "Script execution failed. Exit Code: " + exitCode + "\nOutput:\n" + output.toString();
	            }
	        } catch (IOException | InterruptedException e) {
	            e.printStackTrace();
	            return "Error executing script: " + e.getMessage();
	        }
	    }
	   @GetMapping("/logout")
	    public ModelAndView showLogoutPage() {
	        ModelAndView modelAndView = new ModelAndView("index");
	        // add model attributes if needed
	        return modelAndView;
	    }



}
