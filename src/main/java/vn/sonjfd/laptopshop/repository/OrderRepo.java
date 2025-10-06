package vn.sonjfd.laptopshop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import vn.sonjfd.laptopshop.domain.Order;
import vn.sonjfd.laptopshop.domain.User;

public interface OrderRepo extends JpaRepository<Order, Long> {
    List<Order> findByUser(User user);

    Page<Order> findAll(Pageable pageable);
}
