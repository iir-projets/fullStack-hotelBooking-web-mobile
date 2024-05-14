import React, { createContext, useState, useContext } from "react";
import jwt_decode from "jwt-decode";

export const AuthContext = createContext({
  token: null,
  user: null,
  handleLogin: (token) => {},
  handleLogout: () => {},
});

export const AuthProvider = ({ children }) => {
  const [token, setToken] = useState(localStorage.getItem("token"));
  const [user, setUser] = useState(token ? jwt_decode(token) : null);

  const handleLogin = (token) => {
    localStorage.setItem("token", token);
    setToken(token);
    setUser(jwt_decode(token));
  };

  const handleLogout = () => {
    localStorage.removeItem("token");
    setToken(null);
    setUser(null);
  };

  return (
    <AuthContext.Provider value={{ token, user, handleLogin, handleLogout }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  return useContext(AuthContext);
};
