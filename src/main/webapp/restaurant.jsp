<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@
  page import="java.util.*, com.vani.model.Restaurant"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FoodieGo | Restaurants</title>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

:root {
	--background: #19191f;
	--surface: #24242d;
	--pink: #ff386b;
	--text: #ffffff;
	--muted: #b4b4c2;
	--green: #23c982;
}

body {
	font-family: Arial, Helvetica, sans-serif;
	background: var(--background);
	color: var(--text);
}

a {
	color: inherit;
	text-decoration: none;
}

/* Navigation */
.navbar {
	height: 75px;
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 0 7%;
	background: #222128;
	border-bottom: 1px solid #33333b;
}

.logo {
	font-size: 28px;
	font-weight: 800;
	color: var(--pink);
}

.nav-links {
	display: flex;
	gap: 30px;
	align-items: center;
}

.nav-links a {
	font-size: 15px;
	color: #eeeeF4;
	transition: color 0.2s;
}

.nav-links a:hover, .nav-links a.active {
	color: var(--pink);
}

/* Hero section */
.hero {
	min-height: 300px;
	display: flex;
	justify-content: center;
	align-items: center;
	text-align: center;
	padding: 50px 20px;
	background: linear-gradient(rgba(15, 15, 20, 0.60),
		rgba(15, 15, 20, 0.70)),
		url("https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=1800&q=85")
		center/cover no-repeat;
}

.hero-content {
	width: 100%;
	max-width: 720px;
}

.hero h1 {
	font-size: clamp(30px, 4vw, 46px);
	margin-bottom: 15px;
}

.hero p {
	color: #eeeeee;
	font-size: 16px;
	margin-bottom: 28px;
}

.search-box {
	display: flex;
	max-width: 560px;
	margin: auto;
	background: white;
	border-radius: 8px;
	overflow: hidden;
}

.search-box input {
	flex: 1;
	min-width: 0;
	padding: 16px;
	border: none;
	outline: none;
	color: #25252c;
	font-size: 15px;
}

.search-box button {
	padding: 0 28px;
	border: none;
	background: var(--pink);
	color: white;
	font-size: 15px;
	font-weight: bold;
	cursor: pointer;
}

.search-box button:hover {
	background: #e9275b;
}

/* Page content */
.container {
	max-width: 1500px;
	margin: auto;
	padding: 36px 7% 60px;
}

.section-heading {
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: 15px;
	margin-bottom: 24px;
}

.section-heading h2 {
	font-size: 27px;
}

.section-heading span {
	color: var(--muted);
	font-size: 14px;
}

/* Filters */
.filters {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
	margin-bottom: 27px;
}

.filter-btn {
	padding: 10px 18px;
	border: 1px solid #42424d;
	border-radius: 25px;
	background: var(--surface);
	color: #eeeeF4;
	cursor: pointer;
	font-size: 14px;
}

.filter-btn:hover, .filter-btn.active {
	background: var(--pink);
	border-color: var(--pink);
	color: white;
}

/* Restaurant cards */
.restaurant-grid {
	display: grid;
	grid-template-columns: repeat(4, minmax(0, 1fr));
	gap: 23px;
}

.restaurant-card {
	display: block;
	color: inherit;
	text-decoration: none;
	cursor: pointer;
}

.restaurant-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 10px 28px rgba(0, 0, 0, 0.30);
}

.image-container {
	position: relative;
	height: 165px;
	overflow: hidden;
}

.restaurant-image {
	width: 100%;
	height: 100%;
	object-fit: cover;
	transition: transform 0.3s;
}

.restaurant-card:hover .restaurant-image {
	transform: scale(1.06);
}

.offer-badge {
	position: absolute;
	top: 12px;
	left: 12px;
	padding: 7px 10px;
	border-radius: 5px;
	background: var(--pink);
	color: white;
	font-size: 12px;
	font-weight: bold;
}

.restaurant-info {
	padding: 16px;
}

.restaurant-title {
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: 8px;
	margin-bottom: 10px;
}

.restaurant-title h3 {
	font-size: 18px;
	overflow-wrap: anywhere;
}

.rating {
	flex-shrink: 0;
	padding: 6px 8px;
	background: var(--green);
	color: #092e20;
	border-radius: 6px;
	font-weight: bold;
	font-size: 12px;
}

.cuisine {
	color: var(--muted);
	font-size: 13px;
	margin-bottom: 13px;
	min-height: 16px;
}

.restaurant-meta {
	display: flex;
	justify-content: space-between;
	gap: 8px;
	font-size: 12px;
	color: #eeeeF4;
	padding-bottom: 13px;
	border-bottom: 1px solid #393943;
}

.restaurant-meta span {
	overflow-wrap: anywhere;
}

.restaurant-offer {
	padding-top: 13px;
	color: var(--pink);
	font-size: 13px;
	font-weight: bold;
}

.view-menu {
	display: block;
	width: 100%;
	margin-top: 14px;
	padding: 11px;
	border: 1px solid var(--pink);
	border-radius: 6px;
	background: transparent;
	color: var(--pink);
	font-weight: bold;
	cursor: pointer;
}

.view-menu:hover {
	background: var(--pink);
	color: white;
}

.empty-message {
	display: none;
	text-align: center;
	color: var(--muted);
	padding: 50px 10px;
	grid-column: 1/-1;
}

/* Footer */
footer {
	padding: 25px 7%;
	text-align: center;
	background: #222128;
	color: var(--muted);
	font-size: 14px;
}

footer span {
	color: var(--pink);
}

/* Responsive design */
@media ( max-width : 1100px) {
	.restaurant-grid {
		grid-template-columns: repeat(3, minmax(0, 1fr));
	}
	.container {
		padding-left: 4%;
		padding-right: 4%;
	}
}

@media ( max-width : 750px) {
	.navbar {
		height: auto;
		padding: 18px 5%;
		align-items: flex-start;
		gap: 15px;
		flex-direction: column;
	}
	.nav-links {
		gap: 18px;
		flex-wrap: wrap;
	}
	.restaurant-grid {
		grid-template-columns: repeat(2, minmax(0, 1fr));
		gap: 14px;
	}
	.image-container {
		height: 140px;
	}
	.restaurant-info {
		padding: 12px;
	}
	.restaurant-title {
		align-items: flex-start;
		flex-direction: column;
	}
	.hero {
		min-height: 280px;
	}
	.section-heading h2 {
		font-size: 23px;
	}
}

@media ( max-width : 430px) {
	.restaurant-grid {
		grid-template-columns: 1fr;
	}
	.image-container {
		height: 200px;
	}
	.search-box button {
		padding: 0 16px;
	}
	.container {
		padding-top: 25px;
	}
}
</style>
</head>

<body>

	<!-- Navigation -->
	<nav class="navbar">
		<a href="<%= request.getContextPath() %>/index.jsp" class="logo">FoodieGo</a>

		<div class="nav-links">
			<a href="<%= request.getContextPath() %>/index.jsp">Home</a> <a
				href="<%= request.getContextPath() %>/callRestaurantServlet"lass="active">Restaurants</a> <a
				href="<%= request.getContextPath() %>/login.html">Login</a> <a
				href="<%= request.getContextPath() %>/register.html"
				class="signup-btn">Sign Up</a>
		</div>
	</nav>

	<!-- Hero section -->
	<section class="hero">
		<div class="hero-content">
			<h1>Discover the best food near you</h1>
			<p>Order from top-rated restaurants in your city</p>

			<form class="search-box" id="searchForm">
				<input type="search" id="searchInput"
					placeholder="Search for restaurant, cuisine or dish..."
					aria-label="Search restaurants">
				<button type="submit">Search</button>
			</form>
		</div>
	</section>

	<!-- Restaurant listing -->
	<main class="container">

		<div class="section-heading">
			<h2>Popular Restaurants</h2>
			<span id="restaurantCount">12 restaurants</span>
		</div>

		<div class="filters">
			<button class="filter-btn active" data-filter="all">All</button>
			<button class="filter-btn" data-filter="biryani">Biryani</button>
			<button class="filter-btn" data-filter="pizza">Pizza</button>
			<button class="filter-btn" data-filter="burger">Burgers</button>
			<button class="filter-btn" data-filter="indian">Indian</button>
			<button class="filter-btn" data-filter="rating">Rating 4.5+</button>
		</div>


		<section class="restaurant-grid" id="restaurantGrid">

			<%
			List<Restaurant> allRestaurants = (List<Restaurant>) request.getAttribute("allRestaurants");

			if (allRestaurants != null && !allRestaurants.isEmpty()) {
				for (Restaurant restaurant : allRestaurants) {
					if (!restaurant.isActive()) {
				continue;
					}

					String name = restaurant.getName() == null ? "" : restaurant.getName();

					String cuisine = restaurant.getCusineType() == null ? "" : restaurant.getCusineType();

					String address = restaurant.getAddress() == null ? "" : restaurant.getAddress();

					String imagePath = restaurant.getImagePath();

					if (imagePath == null || imagePath.isBlank()) {
				imagePath = "https://placehold.co/600x400?text=Restaurant";
					}

					String safeName = name.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");

					String safeCuisine = cuisine.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"",
					"&quot;");

					String safeAddress = address.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"",
					"&quot;");
			%>
			<a class="restaurant-card"
				href="<%=request.getContextPath()%>/menu?restaurantId=<%=restaurant.getRestaurantId()%>">
				<div class="image-container">
					<img class="restaurant-image"
						src="<%=imagePath.replace("\"", "&quot;")%>" alt="<%=safeName%>"
						loading="lazy"
						onerror="this.onerror=null;this.src='https://placehold.co/600x400?text=Restaurant';">

					<span class="offer-badge">Popular</span>
				</div>

				<div class="restaurant-info">
					<div class="restaurant-title">
						<h3><%=safeName%></h3>
						<span class="rating"> &#9733; <%=restaurant.getRating()%>
						</span>
					</div>

					<p class="cuisine"><%=safeCuisine%></p>

					<div class="restaurant-meta">
						<span><%=safeAddress%></span> <span><%=restaurant.getEta() == null ? "ETA unavailable" : restaurant.getEta()%></span>
					</div>

					<p class="restaurant-offer">
						<%=restaurant.getPhone() == null ? "" : restaurant.getPhone()%>
					</p>

					<span class="view-menu">View Menu</span>
				</div>

			</a>
			<%
			}
			} else {
			%>

			<p class="empty-message" style="display: block">No restaurants
				found.</p>

			<%
			}
			%>

		</section>

	</main>

	<footer>
		<p>
			Made with <span>♥</span> by FoodieGo | Fresh food, delivered with
			love.
		</p>
	</footer>

	<script>
        const searchForm = document.getElementById("searchForm");
        const searchInput = document.getElementById("searchInput");
        const cards = [...document.querySelectorAll(".restaurant-card")];
        const filterButtons = document.querySelectorAll(".filter-btn");
        const restaurantCount = document.getElementById("restaurantCount");
        const emptyMessage = document.getElementById("emptyMessage");

        let activeFilter = "all";

        function filterRestaurants() {
            const query = searchInput.value.trim().toLowerCase();
            let visibleCount = 0;

            cards.forEach(card => {
                const name = card.dataset.name.toLowerCase();
                const cuisine = card.dataset.cuisine.toLowerCase();
                const rating = Number(card.dataset.rating);

                const matchesSearch =
                    name.includes(query) || cuisine.includes(query);

                let matchesFilter = true;

                if (activeFilter === "biryani") {
                    matchesFilter = cuisine.includes("biryani");
                } else if (activeFilter === "pizza") {
                    matchesFilter = cuisine.includes("pizza");
                } else if (activeFilter === "burger") {
                    matchesFilter = cuisine.includes("burger");
                } else if (activeFilter === "indian") {
                    matchesFilter = cuisine.includes("indian");
                } else if (activeFilter === "rating") {
                    matchesFilter = rating >= 4.5;
                }

                const visible = matchesSearch && matchesFilter;
                card.style.display = visible ? "" : "none";

                if (visible) visibleCount++;
            });

            restaurantCount.textContent =
                visibleCount + (visibleCount === 1 ? " restaurant" : " restaurants");

            emptyMessage.style.display =
                visibleCount === 0 ? "block" : "none";
        }

        searchForm.addEventListener("submit", function(event) {
            event.preventDefault();
            filterRestaurants();
        });

        searchInput.addEventListener("input", filterRestaurants);

        filterButtons.forEach(button => {
            button.addEventListener("click", function() {
                filterButtons.forEach(item => item.classList.remove("active"));
                this.classList.add("active");
                activeFilter = this.dataset.filter;
                filterRestaurants();
            });
        });

    
    </script>

</body>
</html>
>
</html>