
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.vani.model.User"%>
<%@ page import="com.vani.dao.UserDao"%>
<%@ page import="com.vani.daoimplementation.UserDAOImpl"%>

<%
    // Check login session
    if (session.getAttribute("userId") == null) {
        response.sendRedirect(
            request.getContextPath() + "/login.html"
        );
        return;
    }

    int userId = (Integer) session.getAttribute("userId");

    // Fetch customer details from database
    UserDao userDao = new UserDAOImpl();
    User user = userDao.getUser(userId);

    if (user == null) {
        response.sendError(
            HttpServletResponse.SC_NOT_FOUND,
            "User profile not found."
        );
        return;
    }

    String name = user.getName() == null ? "" : user.getName();
    String username = user.getUsername() == null ? "" : user.getUsername();
    String email = user.getEmail() == null ? "" : user.getEmail();
    String phone = user.getPhone() == null ? "" : user.getPhone();
    String address = user.getAddress() == null ? "" : user.getAddress();

    String role = user.getRole() == null ? "Customer" : user.getRole();

    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>My Profile | FoodieGo</title>

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

/* Navbar */
.navbar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 18px 7%;
	background: #222128;
	border-bottom: 1px solid #393943;
}

.logo {
	color: #ff386b;
	font-size: 29px;
	font-weight: 800;
	text-decoration: none;
}

.nav-links {
	display: flex;
	gap: 25px;
}

.nav-links a {
	color: white;
	text-decoration: none;
}

.nav-links a:hover {
	color: #ff386b;
}

/* Main layout */
.profile-container {
	max-width: 1050px;
	margin: 45px auto;
	padding: 20px;
}

.page-title {
	margin-bottom: 25px;
}

.page-title h1 {
	font-size: 30px;
	color: #ff386b;
	margin-bottom: 8px;
}

.page-title p {
	color: #a9a9b5;
}

/* Profile card */
.profile-card {
	display: grid;
	grid-template-columns: 270px 1fr;
	background: #24242d;
	border: 1px solid #393943;
	border-radius: 16px;
	overflow: hidden;
}

/* Sidebar */
.profile-sidebar {
	padding: 35px 25px;
	background: #202029;
	border-right: 1px solid #393943;
	text-align: center;
}

.avatar {
	width: 105px;
	height: 105px;
	margin: 0 auto 18px;
	display: flex;
	align-items: center;
	justify-content: center;
	border-radius: 50%;
	background: rgba(255, 56, 107, 0.15);
	border: 2px solid #ff386b;
	font-size: 45px;
}

.profile-sidebar h2 {
	font-size: 21px;
	margin-bottom: 8px;
}

.profile-sidebar p {
	color: #a9a9b5;
	font-size: 14px;
	overflow-wrap: anywhere;
}

.account-badge {
	display: inline-block;
	margin-top: 18px;
	padding: 7px 15px;
	border-radius: 20px;
	background: rgba(255, 56, 107, 0.15);
	color: #ff7295;
	font-size: 12px;
	font-weight: bold;
}

/* Profile details */
.profile-content {
	padding: 35px;
}

.content-heading {
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: 15px;
	margin-bottom: 28px;
}

.content-heading h2 {
	font-size: 22px;
}

.content-heading p {
	color: #a9a9b5;
	font-size: 13px;
	margin-top: 7px;
}

.details-grid {
	display: grid;
	grid-template-columns: repeat(2, minmax(0, 1fr));
	gap: 22px;
}

.detail-box {
	padding: 18px;
	background: #19191f;
	border: 1px solid #393943;
	border-radius: 10px;
	min-width: 0;
}

.detail-label {
	display: block;
	margin-bottom: 10px;
	color: #a9a9b5;
	font-size: 13px;
}

.detail-value {
	font-size: 15px;
	font-weight: bold;
	overflow-wrap: anywhere;
}

.address-box {
	grid-column: 1/-1;
}

/* Buttons */
.profile-actions {
	display: flex;
	flex-wrap: wrap;
	gap: 14px;
	margin-top: 30px;
}

.btn {
	display: inline-block;
	padding: 13px 22px;
	border-radius: 8px;
	text-decoration: none;
	font-weight: bold;
	transition: 0.3s;
}

.primary-btn {
	background: #ff386b;
	color: white;
}

.primary-btn:hover {
	background: #e9275b;
	transform: translateY(-2px);
}

.secondary-btn {
	background: transparent;
	color: #ff7897;
	border: 1px solid #ff386b;
}

.secondary-btn:hover {
	background: #ff386b;
	color: white;
}

/* Footer */
footer {
	padding: 25px;
	text-align: center;
	color: #9999a5;
	font-size: 13px;
}

footer span {
	color: #ff386b;
}

/* Responsive */
@media ( max-width : 750px) {
	.profile-card {
		grid-template-columns: 1fr;
	}
	.profile-sidebar {
		border-right: none;
		border-bottom: 1px solid #393943;
	}
	.profile-content {
		padding: 25px 18px;
	}
}

@media ( max-width : 480px) {
	.navbar {
		padding: 17px 5%;
	}
	.details-grid {
		grid-template-columns: 1fr;
	}
	.address-box {
		grid-column: auto;
	}
	.content-heading {
		align-items: flex-start;
		flex-direction: column;
	}
	.profile-container {
		margin-top: 20px;
	}
}
</style>

</head>

<body>

	<!-- Navbar -->

	<header class="navbar">

		<a href="<%= contextPath %>/index.jsp" class="logo"> FoodieGo </a>

		<nav class="nav-links">

			<a href="<%= contextPath %>/index.jsp"> Home </a> <a
				href="<%= contextPath %>/callRestaurantServlet"> Restaurants </a>

		</nav>

	</header>


	<!-- Profile -->

	<main class="profile-container">

		<div class="page-title">

			<h1>My Account</h1>

			<p>Manage your personal information and delivery details.</p>

		</div>


		<section class="profile-card">


			<!-- Sidebar -->

			<aside class="profile-sidebar">

				<div class="avatar">👤</div>

				<h2><%= name %></h2>

				<p>
					@<%= username %></p>

				<span class="account-badge"> <%= role %>
				</span>

			</aside>


			<!-- Profile information -->

			<div class="profile-content">

				<div class="content-heading">

					<div>

						<h2>Personal Information</h2>

						<p>Your registered FoodieGo account details.</p>

					</div>

				</div>


				<div class="details-grid">


					<!-- Full name -->

					<div class="detail-box">

						<span class="detail-label"> Full Name </span>

						<div class="detail-value">
							<%= name.isEmpty() ? "Not provided" : name %>
						</div>

					</div>


					<!-- Username -->

					<div class="detail-box">

						<span class="detail-label"> Username </span>

						<div class="detail-value">
							<%= username.isEmpty() ? "Not provided" : username %>
						</div>

					</div>


					<!-- Email -->

					<div class="detail-box">

						<span class="detail-label"> Email Address </span>

						<div class="detail-value">
							<%= email.isEmpty() ? "Not provided" : email %>
						</div>

					</div>


					<!-- Phone -->

					<div class="detail-box">

						<span class="detail-label"> Phone Number </span>

						<div class="detail-value">
							<%= phone.isEmpty() ? "Not provided" : phone %>
						</div>

					</div>


					<!-- User ID -->

					<div class="detail-box">

						<span class="detail-label"> Customer ID </span>

						<div class="detail-value">
							#<%= userId %>
						</div>

					</div>


					<!-- Account type -->

					<div class="detail-box">

						<span class="detail-label"> Account Type </span>

						<div class="detail-value">
							<%= role %>
						</div>

					</div>


					<!-- Address -->

					<div class="detail-box address-box">

						<span class="detail-label"> <span>📍</span> Delivery
							Address
						</span>

						<div class="detail-value">
							<%= address.isEmpty()
                                ? "No delivery address added yet."
                                : address %>
						</div>

					</div>


				</div>


				<!-- Actions -->


				<div class="profile-actions">

					<a href="<%= contextPath %>/editProfileServlet"
						class="btn primary-btn"> ✏️ Edit Profile </a> <a
						href="<%= contextPath %>/callRestaurantServlet"
						class="btn secondary-btn"> Browse Restaurants </a> <a
						href="<%= contextPath %>/index.jsp" class="btn secondary-btn">
						Back to Home </a>

				</div>


			</div>

		</section>

	</main>


	<footer>
		Made with <span>♥</span> by FoodieGo. Fresh food, delivered with love.
	</footer>

</body>
</html>
