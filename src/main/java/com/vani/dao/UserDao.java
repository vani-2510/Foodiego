package com.vani.dao;

import java.util.List;

import com.vani.model.User;

public interface UserDao {

    int addUser(User user);

    User getUser(int userId);

    User getUserByUsername(String username);

    User getUserByEmail(String email); 

    void updateUser(User user);

    void deleteUser(int userId);

    List<User> getAllUser();
    
    boolean updateProfile(User user);
}