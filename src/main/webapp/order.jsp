<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="true" %>

<%@ page import="java.math.BigDecimal" %>

<%
    // Verify customer login
    if (session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.html");
        return;
    }

    Object orderIdObject = session.getAttribute("lastOrderId");
    Object totalObject = session.getAttribute("lastOrderTotal");
    Object itemCountObject = session.getAttribute("lastOrderItemCount");

    if (orderIdObject == null || totalObject == null || itemCountObject == null) {

        response.sendRedirect(request.getContextPath() + "/callRestaurantServlet" );
        return;
    }

    int orderId = (Integer) orderIdObject;
    BigDecimal total = (BigDecimal) totalObject;
    int itemCount = (Integer) itemCountObject;

    String username = (String) session.getAttribute("username");

    if (username == null) {
        username = "Customer";
    }

    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Order Confirmed | FoodieGo</title>

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

/* Navbar */

.navbar {
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

.nav-link {
    color: white;
    text-decoration: none;
}

.nav-link:hover {
    color: #ff386b;
}

/* Main container */

.container {
    max-width: 750px;
    margin: 65px auto;
    padding: 20px;
}

.success-card {
    background: #24242d;
    border: 1px solid #363640;
    border-radius: 16px;
    padding: 40px;
    text-align: center;
}

/* Success icon */

.success-icon {
    width: 90px;
    height: 90px;

    margin: 0 auto 25px;

    display: flex;
    align-items: center;
    justify-content: center;

    background: rgba(35, 201, 130, 0.12);
    border: 2px solid #23c982;
    border-radius: 50%;

    color: #23c982;
    font-size: 48px;
    font-weight: bold;
}

h1 {
    color: #23c982;
    margin-bottom: 12px;
    font-size: 30px;
}

.subtitle {
    color: #c4c4d0;
    line-height: 1.7;
}

/* Order details */

.order-details {
    margin-top: 30px;
    padding: 22px;

    background: #19191f;
    border: 1px solid #363640;
    border-radius: 10px;

    text-align: left;
}

.order-details h2 {
    margin-top: 0;
    margin-bottom: 20px;
    font-size: 21px;
}

.detail-row {
    display: flex;
    justify-content: space-between;
    gap: 15px;

    padding: 13px 0;

    border-bottom: 1px solid #363640;
}

.detail-label {
    color: #c4c4d0;
}

.detail-value {
    text-align: right;
    font-weight: bold;
}

.order-total {
    color: #23c982;
    font-size: 23px;
}

/* Status */

.status {
    display: inline-block;
    margin-top: 22px;
    padding: 9px 18px;

    background: rgba(35, 201, 130, 0.12);
    color: #23c982;

    border-radius: 20px;
    font-weight: bold;
}

/* Buttons */

.buttons {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    gap: 15px;

    margin-top: 30px;
}

.btn {
    display: inline-block;
    padding: 14px 23px;

    background: #ff386b;
    color: white;

    border-radius: 8px;
    text-decoration: none;
    font-weight: bold;

    transition: 0.3s;
}

.btn:hover {
    background: #e9275b;
    transform: translateY(-2px);
}

.btn-secondary {
    background: transparent;
    border: 1px solid #ff386b;
    color: #ff7897;
}

.btn-secondary:hover {
    background: #ff386b;
    color: white;
}

/* Footer */

.footer {
    margin-top: 30px;
    color: #9292a0;
    font-size: 13px;
}

@media(max-width: 600px) {

    .container {
        margin: 25px auto;
    }

    .success-card {
        padding: 25px 18px;
    }

    h1 {
        font-size: 24px;
    }

    .detail-row {
        font-size: 14px;
    }

}

</style>

</head>

<body>

<!-- Navbar -->

<nav class="navbar">

    <a class="logo"
       href="<%= contextPath %>/index.jsp">
        FoodieGo
    </a>

    <a class="nav-link"
       href="<%= contextPath %>/callRestaurantServlet">
        Restaurants
    </a>

</nav>


<!-- Order confirmation -->

<main class="container">

    <section class="success-card">

        <div class="success-icon">
            ✓
        </div>

        <h1>Order Placed Successfully!</h1>

        <p class="subtitle">

            Thank you, <strong><%= username %></strong>!

            Your order has been successfully placed.

            We appreciate your order with FoodieGo.

        </p>


        <!-- Order details -->

        <div class="order-details">

            <h2>Order Details</h2>

            <div class="detail-row">

                <span class="detail-label">
                    Order ID
                </span>

                <span class="detail-value">
                    #<%= orderId %>
                </span>

            </div>


            <div class="detail-row">

                <span class="detail-label">
                    Customer
                </span>

                <span class="detail-value">
                    <%= username %>
                </span>

            </div>


            <div class="detail-row">

                <span class="detail-label">
                    Total Items
                </span>

                <span class="detail-value">
                    <%= itemCount %>
                </span>

            </div>


            <div class="detail-row">

                <span class="detail-label">
                    Payment Method
                </span>

                <span class="detail-value">
                    Cash on Delivery
                </span>

            </div>


            <div class="detail-row">

                <span class="detail-label">
                    Order Status
                </span>

                <span class="detail-value">
                    Placed
                </span>

            </div>


            <div class="detail-row"
                 style="border-bottom:none;">

                <span class="detail-label">
                    Total Amount
                </span>

                <span class="order-total">
                    ₹<%= total.toPlainString() %>
                </span>

            </div>

        </div>


        <div class="status">
            ✓ Order Confirmed
        </div>


        <!-- Navigation buttons -->

        <div class="buttons">

            <a class="btn"
               href="<%= contextPath %>/callRestaurantServlet">

                Continue Shopping

            </a>

            <a class="btn btn-secondary"
               href="<%= contextPath %>/index.jsp">

                Go to Home

            </a>

        </div>


        <p class="footer">

            Thank you for choosing FoodieGo!

        </p>

    </section>

</main>


<script>

// Clear the cart only after the order has been confirmed.

sessionStorage.removeItem("foodieGoCart");

</script>

</body>

</html>
