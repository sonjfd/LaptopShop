package vn.sonjfd.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.sonjfd.laptopshop.domain.Role;

@Repository
public interface RoleRepo extends JpaRepository<Role, Long> {

}
