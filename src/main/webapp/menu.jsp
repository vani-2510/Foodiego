
<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="true" %>

<%@ page import="java.util.List" %>
<%@ page import="com.vani.model.Restaurant" %>
<%@ page import="com.vani.model.Menu" %>

<%!
    public String escapeHtml(String value) {
        if (value == null) {
            return "";
        }

        return value.replace("&", "&amp;")
                    .replace("\"", "&quot;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("'", "&#39;");
    }
%>

<%
    Restaurant restaurant =
        (Restaurant) request.getAttribute("restaurant");

    List<Menu> menus =
        (List<Menu>) request.getAttribute("menus");

    if (restaurant == null || menus == null) {
        response.sendRedirect(
            request.getContextPath() + "/callRestaurantServlet"
        );
        return;
    }

    String context = request.getContextPath();

    int availableCount = 0;

    for (Menu item : menus) {
        if (item.isAvailable()) {
            availableCount++;
        }
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title><%= escapeHtml(restaurant.getName()) %> | FoodieGo Menu</title>

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #19191f;
    color: #fff;
}

/* Navigation */

nav {
    padding: 18px 7%;
    background: #222128;
    border-bottom: 1px solid #363640;

    display: flex;
    justify-content: space-between;
    align-items: center;
}

.nav-left,
.nav-right {
    display: flex;
    align-items: center;
    gap: 22px;
}

.logo {
    color: #ff386b;
    font-size: 28px;
    font-weight: bold;
    text-decoration: none;
}

.nav-link {
    color: white;
    text-decoration: none;
}

.nav-link:hover {
    color: #ff386b;
}

.cart-link {
    background: #ff386b;
    color: white;
    padding: 11px 20px;
    border-radius: 8px;
    text-decoration: none;
    font-weight: bold;
    transition: 0.3s;
}

.cart-link:hover {
    background: #e9275b;
    transform: translateY(-2px);
}

/* Restaurant hero */

.hero {
    padding: 45px 7%;
    background: linear-gradient(120deg, #30232c, #19191f);
}

.back {
    color: #ff7897;
    text-decoration: none;
}

.hero h1 {
    font-size: 38px;
    margin-bottom: 12px;
}

.hero p {
    color: #c4c4d0;
    line-height: 1.7;
}

/* Main container */

.container {
    max-width: 1400px;
    margin: auto;
    padding: 35px 5%;
}

.heading {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 15px;
    flex-wrap: wrap;
    margin-bottom: 25px;
}

.heading h2 {
    margin: 0;
}

#search {
    width: 280px;
    max-width: 100%;
    padding: 13px 16px;
    background: #24242d;
    border: 1px solid #41414c;
    border-radius: 8px;
    color: white;
    font-size: 15px;
}

/* Menu cards */

.menu-grid {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 22px;
    align-items: stretch;
}

.menu-card {
    display: grid;
    grid-template-columns: minmax(120px, 155px) minmax(0, 1fr);
    gap: 20px;
    align-items: start;
    padding: 18px;
    background: #24242d;
    border: 1px solid #363640;
    border-radius: 12px;
    min-width: 0;
}

.dish-image {
    display: block;
    width: 100%;
    height: 155px;
    object-fit: cover;
    border-radius: 10px;
    background: #30303a;
}

.dish-info {
    min-width: 0;
    overflow-wrap: break-word;
}

.dish-info h3 {
    margin: 0 0 12px;
    font-size: 20px;
    line-height: 1.35;
}

.description {
    color: #c4c4d0;
    line-height: 1.6;
    overflow-wrap: break-word;
}

.rating {
    color: #23c982;
    font-size: 14px;
}

.dish-bottom {
    display: flex;
    align-items: center;
    justify-content: space-between;
    flex-wrap: wrap;
    gap: 10px;
    margin-top: 20px;
}

.price {
    font-size: 21px;
    font-weight: bold;
}

.availability {
    font-size: 12px;
    color: #23c982;
}

/* Add to Cart */

.add-to-cart-btn {
    width: 100%;
    margin-top: 18px;
    padding: 12px 18px;
    background: #ff386b;
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 15px;
    font-weight: bold;
    cursor: pointer;
    transition: 0.3s;
}

.add-to-cart-btn:hover {
    background: #e9275b;
    transform: translateY(-2px);
}

.add-to-cart-btn:disabled {
    background: #555;
    cursor: not-allowed;
    transform: none;
}

/* Empty message */

.empty {
    color: #c4c4d0;
    padding: 30px 0;
}

.cart-message {
    display: none;
    margin-bottom: 20px;
    padding: 13px 16px;
    background: rgba(35, 201, 130, 0.12);
    border: 1px solid #23c982;
    border-radius: 8px;
    color: #23c982;
}

/* Responsive */

@media(max-width: 950px) {

    .menu-grid {
        grid-template-columns: 1fr;
    }

}

@media(max-width: 600px) {

    nav {
        padding: 16px 5%;
        flex-wrap: wrap;
        gap: 15px;
    }

    .nav-left,
    .nav-right {
        gap: 12px;
    }

    .logo {
        font-size: 24px;
    }

    .nav-link {
        font-size: 13px;
    }

    .cart-link {
        padding: 9px 13px;
        font-size: 13px;
    }

}

@media(max-width: 480px) {

    .hero h1 {
        font-size: 28px;
    }

    .menu-card {
        grid-template-columns: 1fr;
    }

    .dish-image {
        height: 220px;
    }

    .heading {
        align-items: stretch;
    }

    #search {
        width: 100%;
    }

}

</style>

</head>

<body>

<!-- Navigation -->

<nav>

    <div class="nav-left">

        <a class="logo"
           href="<%= context %>/index.jsp">
            FoodieGo
        </a>

        <a class="nav-link"
           href="<%= context %>/callRestaurantServlet">
            Restaurants
        </a>

        <a class="nav-link"
           href="<%= context %>/profile.jsp">
            Profile
        </a>

    </div>

    <div class="nav-right">

        <a class="cart-link"
           href="<%= context %>/cart.jsp">

            🛒 Cart (
            <span id="cartCount">0</span>
            )

        </a>

    </div>

</nav>


<!-- Restaurant details -->

<header class="hero">

    <a class="back"
       href="<%= context %>/callRestaurantServlet">

        &larr; Back to Restaurants

    </a>

    <h1>
        <%= escapeHtml(restaurant.getName()) %>
    </h1>

    <p>

        &#9733;
        <%= restaurant.getRating() %>

        &nbsp; | &nbsp;

        <%= restaurant.getEta() == null ? "Delivery time unavailable" : escapeHtml(restaurant.getEta()) %>

        <br>

        <%= restaurant.getAddress() == null ? "" : escapeHtml(restaurant.getAddress()) %>

        <br>

        <%= restaurant.getCusineType() == null ? "" : escapeHtml(restaurant.getCusineType()) %>

    </p>

</header>


<!-- Menu section -->

<main class="container">

    <div class="heading">

        <h2>
            Our Menu (<%= availableCount %> items)
        </h2>

        <input
            id="search"
            type="search"
            placeholder="Search for dishes..."
            aria-label="Search for dishes">

    </div>


    <!-- Add to cart message -->

    <div id="cartMessage"
         class="cart-message"
         role="status"
         aria-live="polite">
    </div>


    <!-- Menu grid -->

    <div class="menu-grid" id="menuGrid">

        <%

        for (Menu item : menus) {

            if (!item.isAvailable()) {
                continue;
            }

            String itemName =
                item.getItemName() == null ? "" : item.getItemName();

            String description = item.getDescription() == null ? "" : item.getDescription();

            String image = item.getImagePath();

            if (image == null || image.trim().isEmpty()) {
                image = "/images/Chicken Biryani.jpg";
            }

            String imageUrl;

            if (image.startsWith("http://") || image.startsWith("https://")) {

                imageUrl = image;

            } else if (image.startsWith(context + "/")) {

                imageUrl = image;

            } else if (image.startsWith("/")) {

                imageUrl = context + image;

            } else {

                imageUrl = context + "/" + image;

            }

            String safeName = escapeHtml(itemName);
            String safeDescription = escapeHtml(description);
            String safeImage = escapeHtml(imageUrl);

        %>

        <article class="menu-card"
                 data-name="<%= safeName %>"
                 data-description="<%= safeDescription %>">

            <img
                class="dish-image"
                src="<%= safeImage %>"
                alt="<%= safeName %>"
                loading="lazy">


            <div class="dish-info">

                <h3>
                    <%= safeName %>
                </h3>

                <p class="description">
                    <%= safeDescription %>
                </p>

                <p class="rating">
                    &#9733;
                    <%= item.getRatings() %>
                </p>


                <div class="dish-bottom">

                    <span class="price">
                        &#8377;<%= item.getPrice() %>
                    </span>

                    <span class="availability">
                        Available
                    </span>

                </div>


                <!-- Add to Cart button -->

                <button
                    type="button"
                    class="add-to-cart-btn"
                    data-menu-id="<%= item.getMenuId() %>"
                    data-restaurant-id="<%= item.getRestaurantId() %>"
                    data-name="<%= safeName %>"
                    data-price="<%= item.getPrice() %>"
                    data-image="<%= safeImage %>">

                    + Add to Cart

                </button>

            </div>

        </article>

        <%

        }

        %>

    </div>


    <!-- No search results -->

    <p class="empty"
       id="emptyMessage"
       style="display:none;">

        No dishes found.

    </p>


    <% if (availableCount == 0) { %>

        <p class="empty">

            No available menu items have been added
            for this restaurant yet.

        </p>

    <% } %>

</main>


<!-- JavaScript -->

<script>

// Global cart variable

let cart = [];


// Safely load cart

function loadCart() {

    try {

        const storedCart = sessionStorage.getItem("foodieGoCart");

        const parsedCart = JSON.parse(storedCart || "[]");

        return Array.isArray(parsedCart)
            ? parsedCart
            : [];

    } catch (error) {

        console.error("Unable to load cart:", error);

        return [];

    }

}


// Initialize global cart

cart = loadCart();


// Save cart to sessionStorage

function saveCart() {

    try {

        sessionStorage.setItem(
            "foodieGoCart",
            JSON.stringify(cart)
        );

        return true;

    } catch (error) {

        console.error("Unable to save cart:", error);

        alert("Unable to save cart. Please try again.");

        return false;

    }

}


// Update cart counter

function updateCartCount() {

    const totalItems = cart.reduce(
        function(total, item) {

            return total + Number(item.quantity || 0);

        },
        0
    );

    document.getElementById("cartCount").textContent =
        totalItems;

}


// Display success message

function showCartMessage(message) {

    const messageElement = document.getElementById("cartMessage");

    messageElement.textContent = message;

    messageElement.style.display = "block";

}


// Add food item to cart

function addToCart(button) {

    const menuId = Number(button.dataset.menuId);

    const restaurantId = Number(button.dataset.restaurantId);

    const name = button.dataset.name;

    const price = Number(button.dataset.price);

    const image = button.dataset.image || "";


    // Validate selected item

    if (
        !Number.isInteger(menuId) || menuId <= 0 || !Number.isInteger(restaurantId) || restaurantId <= 0 || !Number.isFinite(price) || price < 0 ) {

        alert("Invalid food item.");

        return;

    }


    // Reload current cart before modifying

    cart = loadCart();


    // Do not allow items from different restaurants

    if (
        cart.length > 0 &&
        Number(cart[0].restaurantId) !== restaurantId
    ) {

        alert(
            "You can order from only one restaurant at a time. " +
            "Please clear your existing cart before selecting another restaurant."
        );

        return;

    }


    // Find existing item

    const existingItem = cart.find(
        function(item) {

            return Number(item.menuId) === menuId;

        }
    );


    if (existingItem) {

        existingItem.quantity = Number(existingItem.quantity) + 1;

    } else {

        // Add new item

        cart.push({

            menuId: menuId,

            restaurantId: restaurantId,

            name: name,

            price: price,

            image: image,

            quantity: 1

        });

    }


    // Save updated cart

    if (!saveCart()) {
        return;
    }


    // Refresh cart counter

    updateCartCount();


    // Show confirmation

    showCartMessage(name + " added to your cart successfully!");

}


// Attach Add to Cart click handlers

document.querySelectorAll(".add-to-cart-btn")
    .forEach(function(button) {

        button.addEventListener("click", function() {

                addToCart(this);

            }
        );

    });


// Search food items

const search = document.getElementById("search");

const cards = document.querySelectorAll(".menu-card");

const emptyMessage = document.getElementById("emptyMessage");


search.addEventListener("input", function() {

    const query = this.value.toLowerCase().trim();

    let visibleCount = 0;


    cards.forEach(function(card) {

        const name =
            (card.dataset.name || "").toLowerCase();

        const description = (card.dataset.description || "").toLowerCase();

        const matched = name.includes(query) ||
            description.includes(query);


        card.style.display = matched ? "" : "none";


        if (matched) {
            visibleCount++;
        }

    });


    emptyMessage.style.display = visibleCount === 0 ? "block" : "none";

});


// Initialize cart counter when page opens

updateCartCount();

</script>

</body>

</html>
