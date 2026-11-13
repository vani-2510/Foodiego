
<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="com.vani.model.User" %>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.html");
        return;
    }

    User user = (User) request.getAttribute("user");

    if (user == null) {
        response.sendRedirect(
            request.getContextPath() + "/editProfileServlet"
        );
        return;
    }

    String name = user.getName() == null ? "" : user.getName();
    String email = user.getEmail() == null ? "" : user.getEmail();
    String phone = user.getPhone() == null ? "" : user.getPhone();
    String address = user.getAddress() == null ? "" : user.getAddress();
    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Edit Profile | FoodieGo</title>

<style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background: #19191f;
    color: white;
    min-height: 100vh;
}

.navbar {
    padding: 18px 7%;
    background: #222128;
    border-bottom: 1px solid #393943;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.logo {
    color: #ff386b;
    font-size: 28px;
    font-weight: bold;
    text-decoration: none;
}

.navbar a:last-child {
    color: white;
    text-decoration: none;
}

.container {
    max-width: 650px;
    margin: 45px auto;
    padding: 20px;
}

.form-card {
    padding: 35px;
    background: #24242d;
    border: 1px solid #393943;
    border-radius: 15px;
}

h1 {
    color: #ff386b;
    margin-bottom: 10px;
}

.subtitle {
    color: #aaaab8;
    margin-bottom: 30px;
    line-height: 1.5;
}

.form-group {
    margin-bottom: 22px;
}

label {
    display: block;
    margin-bottom: 9px;
    font-size: 14px;
    color: #ddddE5;
}

input, textarea {
    width: 100%;
    padding: 14px;
    border: 1px solid #41414c;
    border-radius: 8px;
    background: #19191f;
    color: white;
    outline: none;
    font-size: 15px;
}

input:focus, textarea:focus {
    border-color: #ff386b;
}

textarea {
    min-height: 110px;
    resize: vertical;
}

.message {
    margin-bottom: 20px;
    padding: 12px;
    border-radius: 7px;
    background: rgba(255, 56, 107, 0.12);
    color: #ff8ca8;
    font-size: 14px;
}

.actions {
    display: flex;
    gap: 12px;
    flex-wrap: wrap;
    margin-top: 28px;
}

button, .cancel-btn {
    padding: 13px 22px;
    border-radius: 8px;
    font-weight: bold;
    font-size: 14px;
    text-decoration: none;
    cursor: pointer;
}

button {
    background: #ff386b;
    color: white;
    border: none;
}

button:hover {
    background: #e9275b;
}

.cancel-btn {
    background: transparent;
    color: #ff7897;
    border: 1px solid #ff386b;
}

@media(max-width: 500px) {
    .form-card {
        padding: 24px 18px;
    }
}

</style>

</head>

<body>

<header class="navbar">

    <a href="<%= contextPath %>/index.jsp" class="logo">
        FoodieGo
    </a>

    <a href="<%= contextPath %>/profile.jsp">
        My Profile
    </a>

</header>


<main class="container">

    <section class="form-card">

        <h1>Edit Profile</h1>

        <p class="subtitle">
            Update your personal information and delivery address.
        </p>

        <% if ("required".equals(request.getParameter("error"))) { %>

            <div class="message">
                Please enter your name and email address.
            </div>

        <% } else if ("invalid".equals(request.getParameter("error"))) { %>

            <div class="message">
                Please check your details. Some values are invalid or too long.
            </div>

        <% } else if ("database".equals(request.getParameter("error"))) { %>

            <div class="message">
                Unable to save your profile. Please try again.
            </div>

        <% } %>


        <form method="post"
              action="<%= contextPath %>/editProfileServlet">

            <div class="form-group">

                <label for="name">Full Name *</label>

                <input
                    type="text"
                    id="name"
                    name="name"
                    value="<%= name.replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;") %>"
                    maxlength="100"
                    required>

            </div>


            <div class="form-group">

                <label for="email">Email Address *</label>

                <input
                    type="email"
                    id="email"
                    name="email"
                    value="<%= email.replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;") %>"
                    maxlength="150"
                    required>

            </div>


            <div class="form-group">

                <label for="phone">Phone Number</label>

                <input
                    type="tel"
                    id="phone"
                    name="phone"
                    value="<%= phone.replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;") %>"
                    maxlength="20"
                    placeholder="Enter your phone number">

            </div>


            <div class="form-group">

                <label for="address">Delivery Address</label>

                <textarea
                    id="address"
                    name="address"
                    maxlength="500"
                    placeholder="Enter your complete delivery address"><%= address.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;") %></textarea>

            </div>


            <div class="actions">

                <button type="submit">
                    Save Changes
                </button>

                <a href="<%= contextPath %>/profile.jsp"
                   class="cancel-btn">
                    Cancel
                </a>

            </div>

        </form>

    </section>

</main>

</body>
</html>
