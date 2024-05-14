package com.example.luxevuehotel.service;

import com.example.luxevuehotel.exception.UserAlreadyExistsException;
import com.example.luxevuehotel.model.User;

import java.util.List;

public interface IUserService {
    User registerUser(User user) throws UserAlreadyExistsException;
    List<User> getUsers();
    void deleteUser(String email);
    User getUser(String email);
    boolean existsByEmail(String email);
}
