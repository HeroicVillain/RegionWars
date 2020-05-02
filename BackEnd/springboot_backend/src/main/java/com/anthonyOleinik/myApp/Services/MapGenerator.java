package com.anthonyOleinik.myApp.Services;

import com.anthonyOleinik.myApp.entities.GameState.Tile;
import org.springframework.stereotype.Service;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@Service
public class MapGenerator{
    FastNoise fNoise = new FastNoise();
    public int dimensions;
    public int playerSize;

    public MapGenerator(){super();}
    public MapGenerator(int playerSize, int seed){
        this.playerSize = playerSize;
        this.dimensions = playerSize + (new Random(seed).nextInt(3) * 2 + 1);
        fNoise.SetSeed(seed);
        fNoise.SetFrequency(0.15f);
    }
    //TODO: finish splitting up initialize board into separate functions

    List<Float> makeCircleNoise(){
        List<Float> tmp = new ArrayList<>();
        int center = (int)dimensions/2;
        //Since we are using a square board, we can get O(n) by using modulo here.
        for (int i = 0; i < dimensions * dimensions; i++) {
            int x = Math.abs(i % dimensions);
            int y = Math.abs(i / dimensions);
                //Simple squaring
                float distanceX = (center - x) * (center - x);
                float distanceY = (center - y) * (center - y);
                DecimalFormat df = new DecimalFormat("0.00");
                float distanceToCenter = (float)Math.sqrt(distanceX + distanceY);
                //Divide by dimensions again to keep it in bounds ie. 0 < distance < 1
                distanceToCenter *= (1-fNoise.GetSimplex(x, y));
                distanceToCenter = distanceToCenter / (dimensions*.95f);
                System.out.println("[X:"+x+" Y:"+y+"]Noise value: " +df.format(distanceToCenter) );
                tmp.add(Float.parseFloat(df.format(distanceToCenter)));
            }
        return tmp;
    }

    List<Tile> PlayerSpawns(){
        int mod = dimensions;
        int mid = dimensions /2;

        final List<Tile> Spawns = new ArrayList<>();
        Spawns.add(new Tile(0,0, 20));
        Spawns.add(new Tile(0, mod-1, 20));
        Spawns.add(new Tile(mod-1, 0, 20));
        Spawns.add(new Tile(mod-1,mod-1, 20));

        //6 players
        Spawns.add(new Tile(0, mid, 20));
        Spawns.add(new Tile(mod-1, mid, 20));

        //8 players
        Spawns.add(new Tile(mid,0, 20));
        Spawns.add(new Tile(mid, mod-1, 20));
        return Spawns;
    }

    public List<Tile> CreateBoard() {
        List<Tile> tiles = new ArrayList<>();
        List<Float> randomized = makeCircleNoise();
        final int mod = dimensions;
        final int tmpArea = dimensions * dimensions;
        List<Tile> spawn = PlayerSpawns();

        //create tiles
        for (int i = 0; i < tmpArea; ++i) {
            int x = Math.abs(i % mod);
            int y = Math.abs(i / mod);
            Tile tmpTile = new Tile(x,y, 0);
            //using the random noise in a circle around center
            if(randomized.get(i) > 0.15){
                tmpTile.setOwner(-1);
                tmpTile.setTroops(2);
                tmpTile.setTroopGeneration(0);
            }
            if(randomized.get(i) > 0.35){
                tmpTile.setOwner(-1);
                tmpTile.setTroops(3);
                tmpTile.setTroopGeneration(1);
            }
            if(randomized.get(i) > .7){
                tmpTile.setOwner(-1);
                tmpTile.setTroops(5);
                tmpTile.setTroopGeneration(2);
            }
            //if the noise is great than .8
            //set terrain to impassable
            if(randomized.get(i) >= .80){
                tmpTile.setOwner(-2);
                tmpTile.setTroops(0);
                tmpTile.setTroopGeneration(0);
            }
            if(randomized.get(i) <= 0.15){
                tmpTile.setOwner(-3);
                tmpTile.setTroops(0);
                tmpTile.setTroopGeneration(0);
            }
            if(x == dimensions/2 && y == dimensions/2){
                tmpTile.setOwner(-1);
                tmpTile.setTroops(25);
                tmpTile.setTroopGeneration(4);
                tmpTile.setMoneyGeneration(50);
            }
            tiles.add(tmpTile);
        }


        //set player starting tiles, I think this works.
        for(int i = 0; i < playerSize; i++){
            Tile tmp = spawn.get(i);
            int tileIndex = tiles.indexOf(tmp);
            tiles.set(tileIndex, tmp);
            tiles.get(tileIndex).setOwner(i);
            tiles.get(tileIndex).setTroopGeneration(5);
            tiles.get(tileIndex).setMoneyGeneration(10);
        }

        return tiles;
    }


}
