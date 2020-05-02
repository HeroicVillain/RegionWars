package com.anthonyOleinik.myApp.sockets;

import com.anthonyOleinik.myApp.entities.GameState.GameState;
import com.anthonyOleinik.myApp.entities.GameState.InGameUser;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArrayList;

@Component
public class GameSocketHandler extends TextWebSocketHandler {
    //holds playerID to websocketSession
    HashMap<Integer, WebSocketSession> playerIDtoSession = new HashMap<>();

    //conviencence, so we can loop through and send to right people
    List<WebSocketSession> sessions = new CopyOnWriteArrayList<>();

    Gson gson = new GsonBuilder().serializeNulls().create();

    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message)
            throws InterruptedException, IOException {
            Map<String, String> map = gson.fromJson(message.getPayload(), Map.class);
            if (map.containsKey("type")){
                if (map.get("type").equals("chat")) {
                    System.out.println("[Game Socket Handler] message type determined: chat");
                    sendToAllPlayers(message);
                } else if (map.get("type").equals("gamestate")) {
                    GameState state = gson.fromJson(message.getPayload(), GameState.class);
                    state.increment();
                    //adds "type" property
                    JsonElement gameStateMessage = gson.toJsonTree(state);
                    gameStateMessage.getAsJsonObject().addProperty("type", "gamestate");
                    TextMessage packagedGamestate = new TextMessage(gson.toJson(gameStateMessage));

                    //sends gamestate
                    sendGameStateToAppropriatePlayers(state, packagedGamestate);
                }
            } else {
                System.out.println("[Game Socket Handler] message type NOT determined");
                throw new NoSuchFieldError("No type field in message. each message must have type field.");
        }
    }


    //test
    private void sendGameStateToAppropriatePlayers(GameState state, TextMessage message) throws IOException {
        for (InGameUser user : state.getUsers()){
            sendMessageToId(user.getTurnID(), message);
        }
    }

    private void sendToAllPlayers(TextMessage message) throws  IOException {
        for (WebSocketSession session : sessions){
            session.sendMessage(message);
        }
    }

    private void sendMessageToId(int id, TextMessage message) throws IOException {
        if (playerIDtoSession.get(id) == null){ //safeguard just in case the player leaves
            return;
        }
        playerIDtoSession.get(id).sendMessage(message);
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        session.setTextMessageSizeLimit(100000);
        Integer newPlayerId = Integer.parseInt(session.getHandshakeHeaders().get("id").get(0));
        sessions.add(session);
        playerIDtoSession.put(newPlayerId, session);
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        sessions.remove(session);
        //TODO must remove from map too
    }
}