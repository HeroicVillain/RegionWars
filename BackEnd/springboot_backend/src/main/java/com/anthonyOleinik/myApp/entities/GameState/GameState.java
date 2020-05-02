package com.anthonyOleinik.myApp.entities.GameState;

import java.util.*;

public class GameState {
    private List<InGameUser> users = new ArrayList<>();
    private GameBoard board;
    private String gameID;

    private int mapSeed = new Random().nextInt(9999);
    private int turn = 0;
    private int currPlayer;

    private final int initTroop = 20;
    private final int initTroopGen = 5;
    private final int initMoneyGen = 10;

    private final int initAITroop = 5;
    private final int initAITroopGen = 1;
    private final int initAIMoneyGen = 0;

    private boolean gameOver = false;
    private int winner;

    //TODO: if we want to re-integrate account creation
    //we can pass the goog id in handhake headers and find their account
    //from that, then we can pass a user account into InGameUser instead.
    public GameState(ArrayList<String> playerNames){
        ArrayList<Integer> playerIds = new ArrayList<>();
        this.currPlayer = 0;
        for (int i = 0; i < playerNames.size(); i++){
            InGameUser tmp = new InGameUser(playerNames.get(i));
            tmp.setTurnID(i);
            playerIds.add(i);
            this.users.add(tmp);
        }
        this.board = new GameBoard(playerIds, initTroop, initAITroop, mapSeed);
    }

    public void checkWinner(){
        HashMap<Integer, Integer> playerTiles = new HashMap<>();
        for(int i = 0; i < this.getUsers().size(); i++){
            playerTiles.put(i, 0);
        }
        for(Tile tile : board.getTiles()) {
            if(tile.getOwner() > -1) {
                //TODO: make this more elegant
                //right now im using a hashmap of the players and increasing
                //an int by 1 per tile they own
                int currValue = playerTiles.get(tile.getOwner());
                playerTiles.replace(tile.getOwner(), currValue + 1);
            }
        }
        //check if players own 35% of the board
        playerTiles.keySet().forEach((userid) -> {
            if(playerTiles.get(userid) > board.getTiles().size()*.35){
                winner = userid;
                gameOver = true;
            }
        });
    }

    public void increment(){
        //increment current turn
        boolean foundSelf = false;
        boolean updatedSelf = false;
        for (InGameUser user : this.getUsers()){
            if (user.getTurnID() == this.currPlayer){
                foundSelf = true;
                continue;
            }
            if (foundSelf && !updatedSelf){
                this.currPlayer = user.getTurnID();
                updatedSelf = true;
            }
        }

        if (!updatedSelf){
            currPlayer = this.users.get(0).getTurnID();
            //grow all troops
            for (Tile tile : this.board.getTiles()){
                if (tile.getOwner() > -1){
                    tile.addTroops(initTroopGen + tile.getTroopGeneration());
                } else if(tile.getOwner() == -1) {
                    tile.addTroops(initAITroopGen + tile.getTroopGeneration());
                }else{
                    //do nothing for now, this is impassable terrain
                }
                for(Active active : tile.getActivesList()){
                    active.duration--;
                }
            }
            checkWinner();
        }

        System.out.println("new current player: " + currPlayer);

        //increase money of current player,
        for (InGameUser user : this.getUsers()){
            if (user.getTurnID() == this.currPlayer){
                user.addMoney(initMoneyGen);
            }
        }

        //increiment the rest
        turn++;
    }


    public GameBoard getBoard() {
        return board;
    }

    public int getCurrPlayer() {
        return currPlayer;
    }

    public int getTurn() {
        return turn;
    }

    public List<InGameUser> getUsers() {
        return users;
    }

    public String getGameID() {
        return gameID;
    }
    public int getInitTroop() {
        return initTroop;
    }
    public int getInitTroopGen() {
        return initTroopGen;
    }

    public int getInitMoneyGen() {
        return initMoneyGen;
    }

    public void setBoard(GameBoard board) {
        this.board = board;
    }

    public void setUsers(List<InGameUser> users) {
        this.users = users;
    }

    public void setGameID(String gameID) {
        this.gameID = gameID;
    }

    public void setTurn(int turn) {
        this.turn = turn;
    }

    public void setCurrPlayer(int currPlayer) {
        this.currPlayer = currPlayer;
    }

    public int getMapSeed() {
        return mapSeed;
    }

    public Integer getWinner() {
        return winner;
    }

    public void setWinner(Integer winner) {
        this.winner = winner;
    }

    public boolean isGameOver() {
        return gameOver;
    }

    public void setGameOver(boolean gameOver) {
        this.gameOver = gameOver;
    }
}

