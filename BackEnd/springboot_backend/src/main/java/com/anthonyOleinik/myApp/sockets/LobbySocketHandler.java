package com.anthonyOleinik.myApp.sockets;

import com.anthonyOleinik.myApp.entities.GameState.GameState;
import com.anthonyOleinik.myApp.sockets.socketMessages.LobbyMessage;
import com.google.gson.*;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.util.*;

@Component
public class LobbySocketHandler extends TextWebSocketHandler {
    private final Gson gson = new GsonBuilder().serializeNulls().create();


    //holds web socket connections
    ArrayList<WebSocketSession> sessions = new ArrayList<>();
    //parrellel to sessions; holds the player nums.
    ArrayList<Integer> sessionToLobbyNum = new ArrayList<>();

    @Override
    public void handleTextMessage(WebSocketSession ___, TextMessage __){
        //Lobby delegator does not take input messages, only output!
        return;
    }


    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        int numPlayersInLobby = sessionToLobbyNum.size();
        sessionToLobbyNum.add(numPlayersInLobby);
        sessions.add(session);
        playerCountUpdated();
        //+ 1  cause we just added one.
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        sessionToLobbyNum.remove(sessions.indexOf(session));
        int playerIndex = sessions.indexOf(session);
        //remove player from the waitingPlayers list in game controller.
        sessions.remove(session);
        playerCountUpdated();
    }

    /// called when a new player joins the lobby.
    // delegates out the proper lobby message to each user.
    protected void playerCountUpdated() throws IOException {
        for (WebSocketSession session : sessions){
            int playerNum = sessionToLobbyNum.get(sessions.indexOf(session));
            LobbyMessage message = new LobbyMessage(sessionToLobbyNum.size(), playerNum);
            //send the proper message to each player in the lobby
            session.sendMessage(new TextMessage(gson.toJson(message)));
        }

        //if we have atleast the required numbe of players,
        //we can begin sending gamestates to the first n players
        if (sessionToLobbyNum.size() >= 4){
            sendGameState();
        }
    }

    private void sendGameState() throws IOException {
        ArrayList<Integer> playerIds = new ArrayList<>();
        ArrayList<String> userNames = new ArrayList<>();
        for (int i = 0; i < 4; i++){
            playerIds.add(sessionToLobbyNum.get(i));
            userNames.add(sessions.get(i).getHandshakeHeaders().get("user").get(0));
        }
        //this could be changed to instead use their googIDs so we can get their account info
        //from the database
        GameState newGameState = new GameState(userNames);

        //adds "type" property
        JsonElement gameStateMessage = gson.toJsonTree(newGameState);
        gameStateMessage.getAsJsonObject().addProperty("type", "gamestate");
        TextMessage packagedGamestate = new TextMessage(gson.toJson(gameStateMessage));

        for (int i = 0; i < 4; i++){
            sessions.get(i).sendMessage(packagedGamestate);
        }
    }
}

