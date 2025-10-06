package vn.sonjfd.laptopshop.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import vn.sonjfd.laptopshop.domain.Role;
import vn.sonjfd.laptopshop.domain.User;
import vn.sonjfd.laptopshop.repository.OrderRepo;
import vn.sonjfd.laptopshop.repository.ProductRepo;
import vn.sonjfd.laptopshop.domain.DTO.RegisterDTO;
import vn.sonjfd.laptopshop.repository.RoleRepo;
import vn.sonjfd.laptopshop.repository.UserRepo;

@Service
public class UserService {

    private final OrderRepo orderRepo;

    private final ProductRepo productRepo;
    private final UserRepo userRepo;
    private final RoleRepo roleRepo;

    public UserService(UserRepo userRepo, RoleRepo roleRepo, ProductRepo productRepo, OrderRepo orderRepo) {
        this.userRepo = userRepo;
        this.roleRepo = roleRepo;
        this.productRepo = productRepo;
        this.orderRepo = orderRepo;
    }

    public Page<User> getAllUser(Pageable pageable) {
        return userRepo.findAll(pageable);
    }

    public void saveUser(User user) {
        userRepo.save(user);
    }

    public User getUserByID(long id) {
        return userRepo.findById(id).get();
    }

    public void deleteUser(long id) {
        userRepo.deleteById(id);
    }

    public List<Role> getAllRoles() {
        return roleRepo.findAll();
    }

    public Role getRoleById(long id) {
        return roleRepo.findById(id).get();
    }

    public User registerDTOtoUser(RegisterDTO registerDTO) {
        User user = new User();
        user.setFullName(registerDTO.getFirstName() + " " + registerDTO.getLastName());
        user.setEmail(registerDTO.getEmail());
        return user;
    }

    public boolean checkEmailExist(String email) {
        return userRepo.existsByEmail(email);
    }

    public User getUserByEmail(String email) {
        return userRepo.findByEmail(email);
    }

    public long countUsers() {
        return this.userRepo.count();
    }

    public long countProducts() {
        return this.productRepo.count();
    }

    public long countOrders() {
        return this.orderRepo.count();
    }

}
