package com.anthonyOleinik.myApp.entities.GameState;

import com.anthonyOleinik.myApp.Services.MapGenerator;

import java.util.ArrayList;
import java.util.List;

public class GameBoard {
    private int dimensions;
    private List<Tile> tiles = new ArrayList<Tile>();
    MapGenerator mapGenerator;
    public GameBoard(ArrayList<Integer> playerIds, int initPlayerTroops, int initAiTroops, int mapSeed){
        mapGenerator = new MapGenerator(playerIds.size(), mapSeed);
        this.tiles = mapGenerator.CreateBoard();
        this.dimensions = mapGenerator.dimensions;
    }


    public int getDimensions() {
        return dimensions;
    }

    public List<Tile> getTiles() {
        return tiles;
    }

    public Tile getTile(int x, int y) throws IndexOutOfBoundsException {
        for (Tile tile : tiles){
            if (tile.x == x && tile.y == y){
                return tile;
            }
        }
        throw new IndexOutOfBoundsException("Tile index out of bounds");
    }

    public void setTiles(List<Tile> tiles) {
        this.tiles = tiles;
    }

    public void setDimensions(int dimensions) {
        this.dimensions = dimensions;
    }
}
