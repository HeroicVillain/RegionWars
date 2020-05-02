package com.anthonyOleinik.myApp.Repositories;

import com.anthonyOleinik.myApp.entities.FactionEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface FactionRepository extends JpaRepository<FactionEntity, Integer> {
    @Query(value = "select * from factions where team = :team or faction_id= :id", nativeQuery = true)
    Optional<FactionEntity> FindTeam(@Param("team") String team, @Param("id") int id);

}
