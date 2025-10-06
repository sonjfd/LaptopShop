package vn.sonjfd.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.sonjfd.laptopshop.domain.Cart;
import vn.sonjfd.laptopshop.domain.CartDetail;
import vn.sonjfd.laptopshop.domain.Product;

@Repository
public interface CartDetailRepo extends JpaRepository<CartDetail, Long> {
    boolean existsByCartAndProduct(Cart cart, Product product);

    CartDetail findByCartAndProduct(Cart cart, Product product);

    void deleteCartDetailById(long id);

}
