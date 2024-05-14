// Login.js
import React, { useState } from "react";
import { Link, useLocation, useNavigate } from "react-router-dom";

const Login = () => {
  const [errorMessage, setErrorMessage] = useState("");
  const [login, setLogin] = useState({
    email: "",
    password: ""
  });

  const navigate = useNavigate();
  const location = useLocation();
  const redirectUrl = location.state?.path || "/";

  const handleInputChange = (e) => {
    setLogin({ ...login, [e.target.name]: e.target.value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    
    // Check if the entered credentials are for admin
    if (login.email === "khadijaezzahidi@gmail.com" && login.password === "khadija") {
      // If admin credentials, redirect to admin panel
      navigate("/admin");
    } else if (login.email === "ayda@gmail.com" && login.password === "ayda") {
      // If specific user, navigate to profile page
      navigate("/profile");
    } else {
      // If not admin credentials or specific user, navigate to the specified redirect URL
      navigate(redirectUrl, { replace: true });
    }
  };

  return (
    <section className="container col-6 mt-5 mb-5">
      {errorMessage && <p className="alert alert-danger">{errorMessage}</p>}
      <h2>Login</h2>
      <form onSubmit={handleSubmit}>
        <div className="row mb-3">
          <label htmlFor="email" className="col-sm-2 col-form-label">
            Email
          </label>
          <div>
            <input
              id="email"
              name="email"
              type="email"
              className="form-control"
              value={login.email}
              onChange={handleInputChange}
            />
          </div>
        </div>

        <div className="row mb-3">
          <label htmlFor="password" className="col-sm-2 col-form-label">
            Password
          </label>
          <div>
            <input
              id="password"
              name="password"
              type="password"
              className="form-control"
              value={login.password}
              onChange={handleInputChange}
            />
          </div>
        </div>

        <div className="mb-3">
          <button type="submit" className="btn btn-hotel" style={{ marginRight: "10px" }}>
            Login
          </button>
          <span style={{ marginLeft: "10px" }}>
            Don't have an account yet? <Link to={"/register"}>Register</Link>
          </span>
        </div>
      </form>
    </section>
  );
};

export default Login;
