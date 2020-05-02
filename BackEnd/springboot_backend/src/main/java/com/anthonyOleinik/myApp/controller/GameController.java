package com.anthonyOleinik.myApp.controller;

import com.anthonyOleinik.myApp.Repositories.UserRepository;
import com.anthonyOleinik.myApp.entities.GameState.GameState;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.ArrayList;
import java.util.Random;


@RestController
public class GameController {

    @Autowired
    UserRepository userRepo;

    @GetMapping("/game/placeholder/")
    public GameState DefaultGame(){
        ArrayList<String> tmp = new ArrayList<>();
        tmp.add("Anonymous" + String.format("%04d", new Random().nextInt(10000)));
        tmp.add("Anonymous" + String.format("%04d", new Random().nextInt(10000)));
        tmp.add("Anonymous" + String.format("%04d", new Random().nextInt(10000)));
        tmp.add("Anonymous" + String.format("%04d", new Random().nextInt(10000)));
        return new GameState(tmp);
    }

}
