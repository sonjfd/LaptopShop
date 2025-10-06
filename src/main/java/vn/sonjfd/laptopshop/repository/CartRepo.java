package vn.sonjfd.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.sonjfd.laptopshop.domain.Cart;
import vn.sonjfd.laptopshop.domain.User;

@Repository
public interface CartRepo extends JpaRepository<Cart, Long> {
    Cart findByUser(User user);
}
