package com.anthonyOleinik.myApp.Repositories;

import com.anthonyOleinik.myApp.entities.UserConnections;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ConnectionsRepository extends JpaRepository<UserConnections, String> {

    @Query(value = "select * from account_connections where google_token = :id", nativeQuery = true)
    Optional<UserConnections> FindByGID(@Param("id") String googId);

    @Query(value = "select * from account_connections where facebook_token = :id", nativeQuery = true)
    Optional<UserConnections> FindByFBID(@Param("id") String fbId);

}
