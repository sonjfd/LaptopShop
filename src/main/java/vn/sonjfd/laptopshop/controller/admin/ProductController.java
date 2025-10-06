package vn.sonjfd.laptopshop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
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
import vn.sonjfd.laptopshop.domain.Product;
import vn.sonjfd.laptopshop.service.ProductService;
import vn.sonjfd.laptopshop.service.UploadService;

@Controller
public class ProductController {

    private ProductService productService;
    private UploadService uploadService;

    public ProductController(ProductService productService, UploadService uploadService) {
        this.productService = productService;
        this.uploadService = uploadService;
    }

    @GetMapping("/admin/product")
    public String getListProduct(Model model, @RequestParam("page") Optional<String> pageOptional) {
        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                page = Integer.parseInt(pageOptional.get());
            } else {
                page = 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        Pageable pageable = PageRequest.of(page - 1, 4);
        Page<Product> prs = productService.getAllProducts(pageable);
        List<Product> products = prs.getContent();
        model.addAttribute("products", products);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", prs.getTotalPages());
        return "admin/product/show";
    }

    @GetMapping("/admin/product/create")
    public String getCreateProductPage(Model model) {
        Product p = new Product();
        p.setPrice(1000);
        p.setQuantity(1);
        model.addAttribute("product", p);
        return "admin/product/create";
    }

    @PostMapping("/admin/product/create")
    public String saveProduct(@RequestParam(value = "fileImg", required = false) MultipartFile file,
            @ModelAttribute("product") @Valid Product product, BindingResult binding,
            RedirectAttributes redirectAttributes) {
        List<FieldError> errors = binding.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(error.getField() + " " + error.getDefaultMessage());
        }
        if (binding.hasErrors()) {
            return "/admin/product/create";
        }

        String img = uploadService.handleSaveUploadFile(file, "product", null);
        product.setImage(img);
        product.setSold(0);
        productService.saveProduct(product);
        redirectAttributes.addFlashAttribute("messageCreateSuccess", "Thêm sản phẩm thành công");
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/update/{id}")
    public String getUpdateProductPage(@PathVariable("id") long id, Model model) {
        Product product = productService.getProduct(id);
        model.addAttribute("product", product);
        return "admin/product/update";
    }

    @PostMapping("/admin/product/update")
    public String updateProduct(Model model, @ModelAttribute("product") Product p,
            @RequestParam(value = "fileImg", required = false) MultipartFile file, RedirectAttributes a) {
        Product product = productService.getProduct(p.getId());
        String img = uploadService.handleSaveUploadFile(file, "product", product.getImage());
        product.setName(p.getName());
        product.setPrice(p.getPrice());
        product.setDetailDesc(p.getDetailDesc());
        product.setShortDesc(p.getShortDesc());
        product.setQuantity(p.getQuantity());
        product.setFactory(p.getFactory());
        product.setTarget(p.getTarget());
        product.setImage(img);
        productService.saveProduct(product);
        a.addFlashAttribute("updateSuccess", "Đã cập nhật sản phẩm thành công");
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/delete/{id}")
    public String deleteProduct(@PathVariable("id") long id, RedirectAttributes re) {
        Product product = productService.getProduct(id);
        productService.deleteProduct(product);
        re.addFlashAttribute("deleteSuccess", "Xoá sẳn phẩm thành công");
        return "redirect:/admin/product";
    }

}
