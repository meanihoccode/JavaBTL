package com.javaweb.controller.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller(value = "registerControllerOfWeb")
public class RegisterController {

    @GetMapping(value = "/register")
    public ModelAndView registerPage() {
        ModelAndView mav = new ModelAndView("register");
        return mav;
    }
}

