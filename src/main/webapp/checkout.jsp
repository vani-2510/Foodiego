<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="true"%>

<%
// Mandatory login validation
if (session.getAttribute("userId") == null) {

	session.setAttribute("redirectAfterLogin", request.getContextPath() + "/checkoutServlet");

	response.sendRedirect(request.getContextPath() + "/login.html?message=loginRequired");

	return;
}

String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Checkout | FoodieGo</title>

<style>

/* General styling */
* {
	box-sizing: border-box;
}

body {
	margin: 0;
	font-family: Arial, sans-serif;
	background: #19191f;
	color: white;
}

/* Navbar */
header {
	padding: 20px 7%;
	background: #222128;
	border-bottom: 1px solid #363640;
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

.nav-links {
	display: flex;
	align-items: center;
	gap: 25px;
}

.nav-links a {
	color: white;
	text-decoration: none;
}

.nav-links a:hover {
	color: #ff386b;
}

/* Main container */
.container {
	max-width: 850px;
	margin: 35px auto;
	padding: 25px;
}

h1 {
	margin-top: 0;
	margin-bottom: 25px;
}

h2 {
	margin-top: 0;
}

/* Cards */
.card {
	background: #24242d;
	border: 1px solid #363640;
	border-radius: 12px;
	padding: 25px;
	margin-bottom: 22px;
}

/* Cart items */
.item {
	display: flex;
	justify-content: space-between;
	gap: 15px;
	padding: 13px 0;
	border-bottom: 1px solid #41414c;
}

.item:last-child {
	border-bottom: none;
}

.muted {
	color: #c4c4d0;
}

.total {
	color: #23c982;
	font-size: 22px;
	font-weight: bold;
}

/* Payment section */
label {
	display: block;
	margin-bottom: 10px;
	font-size: 15px;
}

select {
	width: 100%;
	padding: 15px;
	background: #19191f;
	color: white;
	border: 1px solid #41414c;
	border-radius: 8px;
	margin: 10px 0 18px;
	font-size: 15px;
	outline: none;
	cursor: pointer;
}

select:focus {
	border-color: #ff386b;
}

/* UPI information */
.upi-info {
	display: none;
	padding: 18px;
	margin-bottom: 20px;
	background: #19191f;
	border: 1px solid #41414c;
	border-radius: 9px;
}

.upi-info h3 {
	color: #ff386b;
	margin-top: 0;
}

.upi-info p {
	color: #c4c4d0;
	line-height: 1.6;
	font-size: 14px;
}

.upi-apps {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
	margin-top: 15px;
}

.upi-app {
	padding: 9px 14px;
	border-radius: 7px;
	background: #30303b;
	border: 1px solid #41414c;
	font-size: 13px;
}

/* Buttons */
button {
	width: 100%;
	padding: 16px;
	background: #ff386b;
	color: white;
	border: none;
	border-radius: 8px;
	font-weight: bold;
	font-size: 17px;
	cursor: pointer;
	transition: 0.3s;
}

button:hover {
	background: #e9275b;
}

button:disabled {
	background: #555;
	cursor: not-allowed;
}

/* Messages */
.error {
	color: #ff7897;
	margin-bottom: 15px;
	font-size: 14px;
	line-height: 1.5;
}

.success-note {
	color: #23c982;
	font-size: 13px;
	margin-top: 12px;
}

/* Footer */
.footer {
	text-align: center;
	color: #9292a0;
	padding: 20px;
	font-size: 13px;
}

/* Responsive design */
@media ( max-width : 600px) {
	.container {
		padding: 18px;
		margin: 20px auto;
	}
	.card {
		padding: 20px;
	}
	header {
		padding: 17px 5%;
	}
	.logo {
		font-size: 24px;
	}
	.nav-links {
		gap: 12px;
		font-size: 13px;
	}
}
</style>

</head>

<body>

	<!-- Navbar -->

	<header>

		<a class="logo" href="<%=contextPath%>/index.jsp"> FoodieGo </a>

		<nav class="nav-links">

			<a href="<%=contextPath%>/callRestaurantServlet"> Restaurants </a>

			<a href="<%=contextPath%>/profile.jsp"> Profile </a>

		</nav>

	</header>


	<!-- Checkout page -->

	<main class="container">

		<h1>Checkout</h1>


		<!-- Order details -->

		<div class="card">

			<h2>Order Details</h2>

			<div id="items"></div>

			<p class="muted">Delivery Fee: ₹40.00</p>

			<p class="total" id="total">Total: ₹0.00</p>

		</div>


		<!-- Payment method -->

		<div class="card">

			<h2>Payment Method</h2>

			<form id="orderForm" method="post"
				action="<%=contextPath%>/checkoutServlet">

				<label for="paymentMode"> Select Payment Method </label> <select
					id="paymentMode" name="paymentMode" required>

					<option value="Cash on Delivery">Cash on Delivery</option>

					<option value="UPI">Pay using UPI</option>

				</select>


				<!-- UPI information -->

				<div id="upiInfo" class="upi-info">

					<h3>Pay using UPI</h3>

					<p>Choose your preferred UPI application.</p>

					<div class="upi-apps">

						<span class="upi-app"> Google Pay </span> <span class="upi-app">
							PhonePe </span> <span class="upi-app"> Paytm </span> <span
							class="upi-app"> BHIM </span>

					</div>

					<p>Online UPI payment is currently unavailable. Please select
						Cash on Delivery to place your order.</p>

				</div>


				<!-- Hidden cart fields -->

				<div id="hiddenFields"></div>


				<!-- Error message -->

				<p id="error" class="error" role="alert" aria-live="polite"></p>


				<!-- Submit button -->

				<button type="submit" id="placeOrderBtn">Place Order</button>

			</form>

		</div>

	</main>


	<!-- Footer -->

	<footer class="footer"> Made with ❤️ by FoodieGo. Fresh food,
		delivered with love. </footer>


	<!-- JavaScript -->

	<script>

// Load cart from sessionStorage

let cart = [];

try {

    cart = JSON.parse(
        sessionStorage.getItem("foodieGoCart") || "[]"
    );

    if (!Array.isArray(cart)) {
        cart = [];
    }

} catch (e) {

    cart = [];

}


// DOM elements

const itemsContainer = document.getElementById("items");

const hiddenFields = document.getElementById("hiddenFields");

const error = document.getElementById("error");

const paymentMode = document.getElementById("paymentMode");

const upiInfo = document.getElementById("upiInfo");

const orderForm = document.getElementById("orderForm");

const placeOrderBtn = document.getElementById("placeOrderBtn");


// Validate cart

function validateCart() {

    if (cart.length === 0 || cart.length > 100) {
        return false;
    }

    for (const item of cart) {

        if (!item || typeof item !== "object") {
            return false;
        }

        const menuId = Number(item.menuId);

        const quantity = Number(item.quantity);

        const price = Number(item.price);

        if (
            !Number.isInteger(menuId) ||
            menuId <= 0 ||

            !Number.isInteger(quantity) ||
            quantity <= 0 ||
            quantity > 100 ||

            !Number.isFinite(price) ||
            price < 0
        ) {

            return false;
        }

    }

    return true;

}


// Display order items

function showCheckout() {

    itemsContainer.innerHTML = "";

    let subtotal = 0;

    if (cart.length === 0) {

        error.textContent = "Your cart is empty. Please add food items.";

        placeOrderBtn.disabled = true;

        return;

    }

    if (!validateCart()) {

        error.textContent = "Invalid cart information. Please return to the menu.";

        placeOrderBtn.disabled = true;

        return;

    }


    // Display each item

    cart.forEach(function(item) {

        const quantity = Number(item.quantity);

        const price = Number(item.price);

        const itemTotal = price * quantity;

        subtotal += itemTotal;


        const row = document.createElement("div");

        row.className = "item";


        const name = document.createElement("span");

        name.textContent =
            (item.name || "Food item") + " × " + quantity;


        const amount = document.createElement("strong");

        amount.textContent =
            "₹" + itemTotal.toFixed(2);


        row.appendChild(name);

        row.appendChild(amount);

        itemsContainer.appendChild(row);

    });


    // Calculate total

    const grandTotal = subtotal + 40;

    document.getElementById("total").textContent =
        "Total: ₹" + grandTotal.toFixed(2);

}


// Toggle UPI information

function toggleUPI() {

    error.textContent = "";

    if (paymentMode.value === "UPI") {

        upiInfo.style.display = "block";

        placeOrderBtn.textContent =
            "Continue with UPI";

    } else {

        upiInfo.style.display = "none";

        placeOrderBtn.textContent =
            "Place Order";

    }

}


// Payment selection event

paymentMode.addEventListener(
    "change",
    toggleUPI
);


// Add hidden form fields

function addHiddenField(name, value) {

    const input = document.createElement("input");

    input.type = "hidden";

    input.name = name;

    input.value = value;

    hiddenFields.appendChild(input);

}


// Submit order form


orderForm.addEventListener("submit", function(event) {

    error.textContent = "";
    hiddenFields.innerHTML = "";

    // Validate cart
    if (!validateCart()) {
        event.preventDefault();

        error.textContent = "Your cart is empty or invalid.";
        return;
    }

    // Block UPI until gateway integration
    if (paymentMode.value === "UPI") {
        event.preventDefault();

        error.textContent = "UPI payment is currently unavailable. Please select Cash on Delivery.";

        return;
    }

    // Generate itemCount hidden field
    const countInput = document.createElement("input");
    countInput.type = "hidden";
    countInput.name = "itemCount";
    countInput.value = String(cart.length);

    hiddenFields.appendChild(countInput);

    // Generate menu IDs and quantities
    cart.forEach(function(item, index) {

        const menuInput = document.createElement("input");
        menuInput.type = "hidden";
        menuInput.name = "menuId_" + index;
        menuInput.value = String(item.menuId);

        hiddenFields.appendChild(menuInput);

        const quantityInput = document.createElement("input");
        quantityInput.type = "hidden";
        quantityInput.name = "quantity_" + index;
        quantityInput.value = String(item.quantity);

        hiddenFields.appendChild(quantityInput);

    });

});



// Initial page rendering

showCheckout();

toggleUPI();

</script>

</body>

</html>
