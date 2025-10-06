package vn.sonjfd.laptopshop.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import jakarta.servlet.http.HttpSession;
import vn.sonjfd.laptopshop.domain.Cart;
import vn.sonjfd.laptopshop.domain.CartDetail;
import vn.sonjfd.laptopshop.domain.Order;
import vn.sonjfd.laptopshop.domain.OrderDetail;
import vn.sonjfd.laptopshop.domain.Product;
import vn.sonjfd.laptopshop.domain.User;
import vn.sonjfd.laptopshop.domain.DTO.OrderDTO;
import vn.sonjfd.laptopshop.domain.DTO.ProductCriteriaDTO;
import vn.sonjfd.laptopshop.repository.CartDetailRepo;
import vn.sonjfd.laptopshop.repository.CartRepo;
import vn.sonjfd.laptopshop.repository.OrderDetailRepo;
import vn.sonjfd.laptopshop.repository.OrderRepo;
import vn.sonjfd.laptopshop.repository.ProductRepo;
import vn.sonjfd.laptopshop.service.Specification.ProductSpecs;

@Service
public class ProductService {

    private final ProductRepo productRepo;
    private final CartRepo cartRepo;
    private final CartDetailRepo cartDetailRepo;
    private final UserService userService;
    private final OrderRepo orderRepo;
    private final OrderDetailRepo orderDetailRepo;

    public ProductService(ProductRepo productRepo, CartRepo cartRepo, CartDetailRepo cartDetailRepo,
            UserService userService, OrderRepo orderRepo, OrderDetailRepo orderDetailRepo) {
        this.productRepo = productRepo;
        this.cartRepo = cartRepo;
        this.cartDetailRepo = cartDetailRepo;
        this.userService = userService;
        this.orderRepo = orderRepo;
        this.orderDetailRepo = orderDetailRepo;
    }

    public Page<Product> getAllProducts(Pageable pageable) {
        return productRepo.findAll(pageable);
    }

    public Page<Product> getAllProductsWithSpec(Pageable pageable, ProductCriteriaDTO productCriteriaDTO) {
        if (productCriteriaDTO.getTarget() == null && productCriteriaDTO.getFactory() == null
                && productCriteriaDTO.getPrice() == null) {
            return productRepo.findAll(pageable);
        }
        Specification<Product> combinedSpec = Specification.where(null);

        if (productCriteriaDTO.getFactory() != null && productCriteriaDTO.getFactory().isPresent()) {
            Specification<Product> currentSpec = ProductSpecs.matchListFactory(productCriteriaDTO.getFactory().get());
            combinedSpec = combinedSpec.and(currentSpec);
        }

        if (productCriteriaDTO.getTarget() != null && productCriteriaDTO.getTarget().isPresent()) {
            Specification<Product> currentSpec = ProductSpecs.matchListTarget(productCriteriaDTO.getTarget().get());
            combinedSpec = combinedSpec.and(currentSpec);
        }

        if (productCriteriaDTO.getPrice() != null && productCriteriaDTO.getPrice().isPresent()) {
            Specification<Product> currentSpec = this.buildPriceSpecification(productCriteriaDTO.getPrice().get());
            combinedSpec = combinedSpec.and(currentSpec);
        }
        return productRepo.findAll(combinedSpec, pageable);
    }

    public Specification<Product> buildPriceSpecification(List<String> price) {
        Specification<Product> combinedSpec = Specification.where(null);
        for (String p : price) {
            double min = 0;
            double max = 0;

            switch (p) {
                case "duoi-10-trieu":
                    min = 0;
                    max = 10000000;
                    break;
                case "10-15-trieu":
                    min = 10000000;
                    max = 15000000;
                    break;
                case "15-20-trieu":
                    min = 15000000;
                    max = 20000000;
                    break;
                case "tren-20-trieu":
                    min = 20000000;
                    max = 200000000;
                    break;
            }

            if (min != 0 && max != 0) {
                Specification<Product> rangeSpec = ProductSpecs.matchMultiplePrice(min, max);
                combinedSpec = combinedSpec.or(rangeSpec);
            }
        }

        return combinedSpec;
    }

    public void saveProduct(Product p) {
        productRepo.save(p);
    }

    public void deleteProduct(Product p) {
        productRepo.delete(p);
    }

    public Product getProduct(long id) {
        return productRepo.findById(id).get();
    }

    public void addProductToCart(String email, long id, HttpSession session, long quantity) {
        User user = userService.getUserByEmail(email);
        if (user != null) {
            Cart cart = cartRepo.findByUser(user);
            if (cart == null) {
                cart = new Cart();
                cart.setUser(user);
                cart.setSum(0);
                cart = cartRepo.save(cart);
            }

            Product p = productRepo.findById(id).orElseThrow();
            CartDetail oDetail = cartDetailRepo.findByCartAndProduct(cart, p);

            if (oDetail == null) {
                CartDetail cd = new CartDetail();
                cd.setCart(cart);
                cd.setProduct(p);
                cd.setPrice(p.getPrice());
                cd.setQuantity(quantity);
                cartDetailRepo.save(cd);

                cart.setSum(cart.getSum() + 1);
                cartRepo.save(cart);
                cd.setCart(cart);
                session.setAttribute("quantity", cart.getSum());
            } else {
                oDetail.setQuantity(oDetail.getQuantity() + quantity);
                cartDetailRepo.save(oDetail);
            }
        }
    }

    public Cart getCartByUser(User user) {
        return cartRepo.findByUser(user);
    }

    public List<CartDetail> getAllCartDetails() {
        return cartDetailRepo.findAll();
    }

    public void deleteCartDetail(long id, HttpSession session) {
        CartDetail detail = cartDetailRepo.findById(id).get();
        Cart cart = detail.getCart();
        cart.setSum(cart.getSum() - 1);
        cartRepo.save(cart);
        session.setAttribute("quantity", cart.getSum());
        cartDetailRepo.delete(detail);

    }

    public void updateCartBeforeCheckOut(List<CartDetail> cartDetails) {
        for (CartDetail cd : cartDetails) {
            CartDetail newCartDetail = cartDetailRepo.findById(cd.getId()).get();
            newCartDetail.setQuantity(cd.getQuantity());
            cartDetailRepo.save(newCartDetail);
        }
    }

    public void handlePlaceOrder(User user, HttpSession session, String name, String address, String phone) {

        Cart cart = cartRepo.findByUser(user);
        if (cart != null) {
            List<CartDetail> cartDetails = cart.getCartDetails();
            if (cartDetails != null) {

                Order order = new Order();
                order.setUser(user);
                order.setReceiverName(name);
                order.setReceiverAddress(address);
                order.setReceiverPhone(phone);
                order.setStatus("PENDING");
                double sum = 0;
                for (CartDetail cd : cartDetails) {
                    sum += cd.getPrice();
                }
                order.setTotalPrice(sum);
                order = orderRepo.save(order);

                for (CartDetail cd : cartDetails) {
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setOrder(order);
                    orderDetail.setProduct(cd.getProduct());
                    orderDetail.setPrice(cd.getPrice());
                    orderDetail.setQuantity(cd.getQuantity());
                    orderDetailRepo.save(orderDetail);
                }

                for (CartDetail cd : cartDetails) {
                    cartDetailRepo.deleteById(cd.getId());
                }

                cartRepo.deleteById(cart.getId());

                session.setAttribute("quantity", 0);

            }
        }
    }

    public Order orderDTOtoOrder(OrderDTO o) {
        Order order = new Order();
        order.setReceiverName(o.getReceiverName());
        order.setReceiverAddress(o.getReceiverAddress());
        order.setReceiverPhone(o.getReceiverPhone());
        return order;
    }

}
