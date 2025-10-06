package vn.sonjfd.laptopshop.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import vn.sonjfd.laptopshop.domain.Order;
import vn.sonjfd.laptopshop.domain.OrderDetail;
import vn.sonjfd.laptopshop.domain.User;
import vn.sonjfd.laptopshop.repository.OrderDetailRepo;
import vn.sonjfd.laptopshop.repository.OrderRepo;

@Service
public class OrderService {
    private final OrderRepo orderRepo;
    private final OrderDetailRepo orderDetailRepo;

    public OrderService(OrderRepo orderRepo, OrderDetailRepo orderDetailRepo) {
        this.orderRepo = orderRepo;
        this.orderDetailRepo = orderDetailRepo;
    }

    public Page<Order> getAllOrder(Pageable pageable) {
        return orderRepo.findAll(pageable);
    }

    public List<Order> fetchOrderByUser(User user) {
        return orderRepo.findByUser(user);
    }

    public List<OrderDetail> getOrderDetailsById(long id) {
        return orderDetailRepo.getOderDetailByOrderId(id);
    }

    public Order getOrderById(long id) {
        return orderRepo.findById(id).get();
    }

    public void saveOrder(Order order) {
        orderRepo.save(order);
    }

    public void deleteAllOrderDetail(List<OrderDetail> orderDetails) {
        orderDetailRepo.deleteAll(orderDetails);
    }

    public void deleteOrder(Order order) {
        orderRepo.delete(order);
    }

}
