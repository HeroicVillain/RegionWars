package com.anthonyOleinik.myApp.entities;

import javax.persistence.*;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Set;

@Entity
@Table(name = "Roles")
public class RolesEntity implements Serializable {

    @Id
    @Column(name = "role_id", unique = false)
    private int Id;

    @Column(nullable = false)
    private String roleName = "Anonymous";

    @OneToMany(mappedBy = "role")
    private Set<UserEntity> users;

    public RolesEntity(){}

    public RolesEntity(int roleId){
        this.Id = roleId;
    }

    public int getId() {
        return Id;
    }

    public String getRoleName() {
        return roleName;
    }
    public void setRoleName(String val) {
        this.roleName = val;
    }

    public String toString(){
        return this.roleName;
    }
}
