<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="true" %>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>My Cart | FoodieGo</title>

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #19191f;
    color: white;
}

/* Navigation */

.navbar {
    padding: 18px 7%;
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

.back-link {
    color: #ff7897;
    text-decoration: none;
}

.back-link:hover {
    color: #ff386b;
}

/* Main container */

.container {
    max-width: 1100px;
    margin: auto;
    padding: 40px 5%;
}

h1 {
    margin-bottom: 30px;
}

/* Cart item */

.cart-item {
    display: flex;
    align-items: center;
    gap: 20px;
    padding: 20px;
    margin-bottom: 18px;

    background: #24242d;
    border: 1px solid #363640;
    border-radius: 12px;
}

.cart-item img {
    width: 110px;
    height: 100px;
    object-fit: cover;
    border-radius: 9px;
    background: #30303a;
}

.item-details {
    flex: 1;
    min-width: 0;
}

.item-details h3 {
    margin-top: 0;
    font-size: 20px;
}

.item-details p {
    color: #c4c4d0;
}

/* Price */

.price {
    color: #23c982 !important;
    font-weight: bold;
}

/* Quantity */

.quantity-controls {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-top: 12px;
}

.quantity-controls button {
    width: 32px;
    height: 32px;

    border: none;
    border-radius: 6px;

    background: #ff386b;
    color: white;

    font-size: 18px;
    cursor: pointer;
}

.quantity-controls button:hover {
    background: #e9275b;
}

.quantity {
    font-size: 16px;
    font-weight: bold;
}

/* Remove button */

.remove-btn {
    margin-top: 12px;
    padding: 8px 13px;

    background: transparent;
    color: #ff7897;

    border: 1px solid #ff386b;
    border-radius: 6px;

    cursor: pointer;
}

.remove-btn:hover {
    background: #ff386b;
    color: white;
}

/* Order summary */

.summary {
    margin-top: 30px;
    padding: 25px;

    background: #24242d;
    border: 1px solid #363640;
    border-radius: 12px;
}

.summary h2 {
    margin-top: 0;
}

.summary-row {
    display: flex;
    justify-content: space-between;
    gap: 15px;
    margin: 15px 0;
}

.total {
    font-size: 23px;
    font-weight: bold;
    color: #23c982;
}

/* Checkout */

.checkout-btn {
    width: 100%;
    padding: 15px;
    margin-top: 15px;

    border: none;
    border-radius: 8px;

    background: #ff386b;
    color: white;

    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
}

.checkout-btn:hover {
    background: #e9275b;
}

/* Empty cart */

.empty-cart {
    padding: 50px 20px;
    text-align: center;

    background: #24242d;
    border-radius: 12px;
}

.empty-cart p {
    color: #c4c4d0;
}

.empty-cart a {
    display: inline-block;
    margin-top: 15px;
    padding: 12px 20px;

    background: #ff386b;
    color: white;

    border-radius: 8px;
    text-decoration: none;
}

.empty-cart a:hover {
    background: #e9275b;
}

/* Responsive */

@media(max-width: 600px) {

    .cart-item {
        align-items: flex-start;
        flex-wrap: wrap;
    }

    .cart-item img {
        width: 85px;
        height: 85px;
    }

    .container {
        padding: 25px 4%;
    }

    .logo {
        font-size: 23px;
    }

}

</style>

</head>

<body>

<!-- Navigation -->

<nav class="navbar">

    <a href="index.jsp" class="logo">
        FoodieGo
    </a>

    <a href="callRestaurantServlet" class="back-link">
        Continue Shopping
    </a>

</nav>


<!-- Cart content -->

<main class="container">

    <h1>🛒 My Shopping Cart</h1>

    <div id="cartItems"></div>


    <!-- Order summary -->

    <div id="cartSummary" class="summary" style="display:none;">

        <h2>Order Summary</h2>

        <div class="summary-row">

            <span>Total Items</span>

            <span id="totalItems">0</span>

        </div>


        <div class="summary-row">

            <span>Subtotal</span>

            <span id="subtotal">₹0.00</span>

        </div>


        <div class="summary-row">

            <span>Delivery Fee</span>

            <span id="delivery">₹40.00</span>

        </div>


        <hr>


        <div class="summary-row total">

            <span>Total Amount</span>

            <span id="grandTotal">₹0.00</span>

        </div>


        <button
            class="checkout-btn"
            type="button"
            onclick="checkout()">

            Proceed to Checkout

        </button>

    </div>

</main>


<script>

/* ----------------------------------
   LOAD CART FROM SESSION STORAGE
---------------------------------- */

let cart = [];

try {

    cart = JSON.parse(
        sessionStorage.getItem("foodieGoCart") || "[]"
    );

    if (!Array.isArray(cart)) {
        cart = [];
    }

} catch (error) {

    cart = [];

}


/* ----------------------------------
   ESCAPE HTML
---------------------------------- */

function escapeHtml(value) {

    return String(value ?? "").replace(/[&<>"']/g, function(char) {

        return {
            "&": "&amp;",
            "<": "&lt;",
            ">": "&gt;",
            '"': "&quot;",
            "'": "&#39;"
        }[char];

    });

}


/* ----------------------------------
   DISPLAY CART ITEMS
---------------------------------- */

function displayCart() {

    const cartItems =
        document.getElementById("cartItems");

    const summary =
        document.getElementById("cartSummary");

    cartItems.innerHTML = "";


    /* Empty cart */

    if (cart.length === 0) {

        summary.style.display = "none";

        cartItems.innerHTML =

            '<div class="empty-cart">' +

                '<h2>Your cart is empty!</h2>' +

                '<p>Looks like you have not added any food yet.</p>' +

                '<a href="callRestaurantServlet">' +

                    'Explore Restaurants' +

                '</a>' +

            '</div>';

        return;

    }


    summary.style.display = "block";


    let totalItems = 0;

    let subtotal = 0;


    /* Display every cart item */

    cart.forEach(function(item, index) {

        const quantity = Math.max(
            0,
            Number(item.quantity) || 0
        );

        const price = Math.max(
            0,
            Number(item.price) || 0
        );

        totalItems += quantity;

        subtotal += price * quantity;


        cartItems.innerHTML +=

            '<div class="cart-item">' +

                '<img src="' + escapeHtml(item.image) +
                '" alt="' + escapeHtml(item.name) + '">' +

                '<div class="item-details">' +

                    '<h3>' +
                        escapeHtml(item.name) +
                    '</h3>' +

                    '<p>Price: ₹' +
                        price.toFixed(2) +
                    '</p>' +

                    '<div class="quantity-controls">' +

                        '<button type="button" ' +
                            'onclick="changeQuantity(' +
                            index + ', -1)">' +
                            '-' +
                        '</button>' +

                        '<span class="quantity">' +
                            quantity +
                        '</span>' +

                        '<button type="button" ' +
                            'onclick="changeQuantity(' +
                            index + ', 1)">' +
                            '+' +
                        '</button>' +

                    '</div>' +

                    '<p class="price">' +

                        'Total: ₹' +
                        (price * quantity).toFixed(2) +

                    '</p>' +

                    '<button type="button" ' +
                        'class="remove-btn" ' +
                        'onclick="removeItem(' +
                        index + ')">' +

                        'Remove' +

                    '</button>' +

                '</div>' +

            '</div>';

    });


    /* Calculate bill */

    const delivery = 40;

    const grandTotal = subtotal + delivery;


    document.getElementById("totalItems").textContent = totalItems;


    document.getElementById("subtotal").textContent = "₹" + subtotal.toFixed(2);


    document.getElementById("delivery").textContent = "₹" + delivery.toFixed(2);


    document.getElementById("grandTotal").textContent = "₹" + grandTotal.toFixed(2);

}


/* ----------------------------------
   INCREASE / DECREASE QUANTITY
---------------------------------- */

function changeQuantity(index, amount) {

    if (!cart[index]) {
        return;
    }

    cart[index].quantity = Number(cart[index].quantity) + amount;


    if (cart[index].quantity <= 0) {

        cart.splice(index, 1);

    }

    saveCart();

}


/* ----------------------------------
   REMOVE ITEM
---------------------------------- */

function removeItem(index) {

    if (index < 0 || index >= cart.length) {
        return;
    }

    cart.splice(index, 1);

    saveCart();

}


/* ----------------------------------
   SAVE CART
---------------------------------- */

function saveCart() {

    sessionStorage.setItem( "foodieGoCart", JSON.stringify(cart));

    displayCart();

}


/* ----------------------------------
   CHECKOUT
---------------------------------- */

function checkout() {

    if (cart.length === 0) {
        alert("Your cart is empty!");
        return;
    }

    window.location.href = "checkoutServlet";
}


/* ----------------------------------
   INITIALIZE CART PAGE
---------------------------------- */

displayCart();

</script>

</body>

</html>