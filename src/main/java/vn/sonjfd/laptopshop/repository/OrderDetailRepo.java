package vn.sonjfd.laptopshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.sonjfd.laptopshop.domain.OrderDetail;

public interface OrderDetailRepo extends JpaRepository<OrderDetail, Long> {
    List<OrderDetail> getOderDetailByOrderId(long id);
}
