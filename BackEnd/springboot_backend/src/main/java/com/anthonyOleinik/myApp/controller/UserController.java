package com.anthonyOleinik.myApp.controller;


import com.anthonyOleinik.myApp.Repositories.ConnectionsRepository;
import com.anthonyOleinik.myApp.Repositories.FactionRepository;
import com.anthonyOleinik.myApp.Repositories.RolesRepository;
import com.anthonyOleinik.myApp.Repositories.UserRepository;
import com.anthonyOleinik.myApp.entities.FactionEntity;
import com.anthonyOleinik.myApp.entities.RolesEntity;
import com.anthonyOleinik.myApp.entities.UserConnections;
import com.anthonyOleinik.myApp.entities.UserEntity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;
import java.util.UUID;

@RestController
public class UserController {
    //get, post, put, delete & patch lol
    //objects auto convert to JSONs.. useful!
    //like flask's jsonify(obj)
    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    @Autowired
    UserRepository userRepo;

    @Autowired
    RolesRepository roleRepo;

    @Autowired
    FactionRepository factionRepo;

    @Autowired
    ConnectionsRepository connectionsRepo;


    //region User Creation

    //For testing purposes, uses a get input to read paramaters in url
    //uses that as username and posts to database with placeholder data
    @GetMapping("/TestUser/{username}")
    public boolean TestUser(@PathVariable String username) {
        UserEntity user = new UserEntity();
        if(username != null) {
            try {
                user.setFaction(factionRepo.getOne(2));
                user.setRole(roleRepo.getOne(1));
                user.setUsername(username);
            } catch (Throwable e) {
                logger.error("Data passed to controller is invalid", e);
                return false;
            }
        }else{
            logger.error("Data passed to controller is null");
            return false;
        }

        try{
            userRepo.save(user);
            connectionsRepo.save(new UserConnections(user, "",""));
            logger.info("Created user "+ user.getId() + " with role "+ user.getRole().toString());
            return true;
        }catch (Throwable e){
            logger.error("Failed to create user", e);
            return false;
        }
    }


    //Takes form data as key:pair values, then gets that data as input for a
    //new user, default role of 1(User) and saves it to db, also saves a new
    //connections entry in account_connections table with a foreign key(user ID) linking the two
    @PostMapping(path = "/users",
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public String CreateUser(@RequestBody MultiValueMap<String, String> formData) {
        UserEntity user;
        UserConnections conns;
        if(formData != null) {
            try {
                user = new UserEntity(formData.get("Username").get(0),
                        new RolesEntity(1),
                        new FactionEntity(Integer.parseInt(formData.get("Faction").get(0))));
                conns = new UserConnections(user,
                        formData.get("googToken").get(0),
                        formData.get("fbToken").get(0));
                user.setConnections(conns);
            } catch (Throwable e) {
                logger.error("Data passed to controller is invalid", e);
                return "Invalid data passed to server.";
            }
        }else{
            logger.error("Data passed to controller is null");
            return "Data passed to controller is null.";
        }

        try{
            userRepo.save(user);
            connectionsRepo.save(conns);
            logger.info(user.getUsername() +" successfully created an account.");
            return "users/"+ user.getUsername()+"/details";
        }catch (Throwable e){
            logger.error("Failed to create user", e);
            return "empty";
        }
    }
    //endregion


    //region Get User Data

    //Probably a better way to get google/fb token, unsure at the moment.
    //Queries the connections repo for the gogole id, uses that to query user repo for
    //the user, other wise return null
    @GetMapping(path = "/users/goog/{token}/")
    public UserEntity queryGoogleId(@PathVariable("token") String id) {
        try{
            UserEntity user = userRepo.findById(connectionsRepo.FindByGID(id).
                    orElseThrow(() -> new IllegalArgumentException()).getUserId()).get();
            if(user != null){
                logger.info("User: "+ user.getUsername() + " logged in.");
                return user;
            }else{
                return null;
            }
        }catch(Exception e){
            logger.info("User doesn't exist.");
            return null;
        }
    }

    //Queries the connections repo for the fb id, uses that to query user repo for
    //the user, other wise return null
    @GetMapping(path = "/users/fb/{token}")
    public Optional<UserEntity> queryFbId(@PathVariable("token") String id) {
        try{
            return userRepo.findById(connectionsRepo.FindByFBID(id).
                    orElseThrow(() -> new IllegalArgumentException()).getUserId());
        }catch(Exception e){
            logger.info("User doesn't exist.");
            return null;
        }
    }

    //returns user based on user ID or their username, otherwise
    //throw an IllegalArgumentexception
    @GetMapping("/users/{id}/")
    public UserEntity user(@PathVariable String id) {
        try{
            UUID tester = UUID.fromString(id);
            return userRepo.findById(id)
                    .orElseThrow(() -> new IllegalArgumentException());
        }catch(Exception e){
            return userRepo.FindByUsername(id)
                    .orElseThrow(() -> new IllegalArgumentException());
        }
    }

    //this is for testing purposes, returns user data as a string.
    @GetMapping("/users/{id}/details")
    public String userDetails(@PathVariable("id") String id) {
        UserEntity user;
        try{
            UUID tester = UUID.fromString(id);
            user = userRepo.findById(id)
                    .orElseThrow(() -> new IllegalArgumentException());
        }catch(Exception e){
            user = userRepo.FindByUsername(id)
                    .orElseThrow(() -> new IllegalArgumentException());
        }
        return user.toString();
    }
    //endregion

    @GetMapping("/test")
    public String test() {
        return "TEST2";
    }
}
