package com.udacity.capstone.tours;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AppController {

    @Autowired
    private TourRepository tourRepository;

    @GetMapping(value = {"/"})
    public String index(Model model) {
        this.tourRepository.findAll().forEach(System.out::println);
        model.addAttribute("tours", this.tourRepository.findAll());
        return "index";
    }
}
