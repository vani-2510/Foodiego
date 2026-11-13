package com.vani.dao;

import java.util.List;
import com.vani.model.OrderItem;

public interface OrderItemDao {

    void addOrderItem(OrderItem item);

    OrderItem getOrderItem(int orderItemId);

    void updateOrderItem(OrderItem item);

    void deleteOrderItem(int orderItemId);

    List<OrderItem> getAllOrderItems();

    List<OrderItem> getOrderItemsByOrder(int orderId);
}
