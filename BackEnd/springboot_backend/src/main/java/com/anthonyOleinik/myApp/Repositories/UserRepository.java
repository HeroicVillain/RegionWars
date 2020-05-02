package com.anthonyOleinik.myApp.Repositories;

import com.anthonyOleinik.myApp.entities.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<UserEntity, String> {

    @Query(value = "select * from account where username = :user", nativeQuery = true)
    Optional<UserEntity> FindByUsername(@Param("user") String username);

}
