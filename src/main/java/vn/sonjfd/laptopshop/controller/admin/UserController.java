package vn.sonjfd.laptopshop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.validation.Valid;
import vn.sonjfd.laptopshop.domain.Role;
import vn.sonjfd.laptopshop.domain.User;
import vn.sonjfd.laptopshop.service.UploadService;
import vn.sonjfd.laptopshop.service.UserService;

@Controller
public class UserController {

    private final UserService userService;
    private final UploadService uploadService;
    private final PasswordEncoder passwordEncoder;

    public UserController(UserService userService, UploadService uploadService,
            PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.uploadService = uploadService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/admin/user")
    public String getListUserPage(Model model, @RequestParam("page") Optional<String> pathOptional) {
        int page = 1;
        try {
            if (pathOptional.isPresent()) {
                page = Integer.parseInt(pathOptional.get());
            } else {
                page = 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        Pageable pageable = PageRequest.of(page - 1, 10);
        Page<User> prs = userService.getAllUser(pageable);
        List<User> users = prs.getContent();
        model.addAttribute("users", users);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", prs.getTotalPages());
        return "admin/user/show";
    }

    @GetMapping("/admin/user/create")
    public String getUserPage(Model model) {
        List<Role> roles = userService.getAllRoles();
        model.addAttribute("roles", roles);
        model.addAttribute("user", new User());
        return "admin/user/create";
    }

    @PostMapping("/admin/user/create")
    public String createUser(@ModelAttribute("user") @Valid User user, BindingResult binding,
            @RequestParam(value = "fileImg", required = false) MultipartFile file,
            Model model, RedirectAttributes a) {
        List<FieldError> errors = binding.getFieldErrors();
        for (FieldError e : errors) {
            System.out.println(e.getField() + " " + e.getDefaultMessage());
        }

        if (binding.hasErrors()) {
            List<Role> roles = userService.getAllRoles();
            model.addAttribute("roles", roles);
            return "admin/user/create";
        }
        String avatar = uploadService.handleSaveUploadFile(file, "avatar", null);
        String hashPassword = passwordEncoder.encode(user.getPassword());
        Role role = userService.getRoleById(user.getRole().getId());
        user.setAvatar(avatar);
        user.setPassword(hashPassword);
        user.setRole(role);
        userService.saveUser(user);
        a.addFlashAttribute("messageCreateUser", "Tạo mới người dùng thành công");
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/{id}")
    public String getUserDetailPage(@PathVariable("id") long id, Model model) {
        User user = userService.getUserByID(id);
        model.addAttribute("user", user);
        return "admin/user/user-detail";
    }

    @GetMapping("/admin/user/update/{id}")
    public String getUpdateUserPage(@PathVariable("id") long id, Model model) {
        User user = userService.getUserByID(id);
        model.addAttribute("user", user);
        return "admin/user/update";
    }

    @PostMapping("/admin/user/update")
    public String updateUser(@ModelAttribute("user") @Valid User user, BindingResult binding,
            @RequestParam(value = "fileImg", required = false) MultipartFile file,
            Model model, RedirectAttributes a) {
        List<FieldError> errors = binding.getFieldErrors();
        for (FieldError e : errors) {
            System.out.println(e.getField() + " " + e.getDefaultMessage());
        }

        if (binding.hasErrors()) {
            return "admin/user/update";
        }
        User currentUser = userService.getUserByID(user.getId());
        String avatar = uploadService.handleSaveUploadFile(file, "avatar", currentUser.getAvatar());
        if (currentUser != null) {
            currentUser.setFullName(user.getFullName());
            currentUser.setPhone(user.getPhone());
            currentUser.setPassword(currentUser.getPassword());
            currentUser.setAvatar(avatar);
            userService.saveUser(currentUser);
            a.addFlashAttribute("messageUpdateUser", "Cập nhật thành người dùng thành công");
        }

        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/delete/{id}")
    public String deleteUser(@PathVariable("id") long id) {
        userService.deleteUser(id);
        return "redirect:/admin/user";
    }

}
