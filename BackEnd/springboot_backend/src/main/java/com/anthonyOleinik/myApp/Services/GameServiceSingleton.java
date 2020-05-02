package com.anthonyOleinik.myApp.Services;

import com.anthonyOleinik.myApp.entities.GameState.GameState;
import org.springframework.web.socket.WebSocketSession;

import java.util.ArrayList;
import java.util.HashMap;

public class GameServiceSingleton {
    private static GameServiceSingleton singleton = null;
    private MapGenerator generator = new MapGenerator();

    //necessary for singleton
    public static GameServiceSingleton getGameServiceInstance() {
        if (singleton == null){
            singleton = new GameServiceSingleton();
        }
        return singleton;
    }
    //end singleton pattern necessities







    //keeps track of all active games.
    //K = gameID, V = currentGameState
    HashMap<Integer, GameState> activeGames = new HashMap<>();

    //keep track of all the sessions
    public HashMap<Integer, ArrayList<WebSocketSession>> gameSessions = new HashMap<>();

    //tracks all players currently waiting in the lobby.
    // the value is the username tied to the session.
    public ArrayList<String> waitingPlayers = new ArrayList<>();



}
