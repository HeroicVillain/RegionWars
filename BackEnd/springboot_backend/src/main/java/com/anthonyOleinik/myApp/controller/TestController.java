package com.anthonyOleinik.myApp.controller;

import org.springframework.http.MediaType;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
public class TestController {
    //please do not delete this. I use it in a unit test!
    //requires formData.get("test").get(0)
    @PostMapping(path = "/test", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public String httpTest(@RequestBody MultiValueMap<String, String> formData){
        return "{\"test\": \"" + formData.get("test").get(0) + "\"}";
    }
}

