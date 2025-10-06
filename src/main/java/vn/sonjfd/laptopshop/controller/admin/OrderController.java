package vn.sonjfd.laptopshop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.sonjfd.laptopshop.domain.Order;
import vn.sonjfd.laptopshop.domain.OrderDetail;
import vn.sonjfd.laptopshop.service.OrderService;

@Controller
public class OrderController {
    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping("/admin/order")
    public String getDashboard(Model model, @RequestParam("page") Optional<String> pageOptional) {
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
        Pageable pageAble = PageRequest.of(page - 1, 10);
        Page<Order> prs = orderService.getAllOrder(pageAble);
        List<Order> orders = prs.getContent();
        model.addAttribute("orders", orders);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", prs.getTotalPages());
        return "admin/order/show";
    }

    @GetMapping("/admin/order/view/{id}")
    public String getOderDetail(Model model, @PathVariable("id") long id) {
        List<OrderDetail> orderDetails = orderService.getOrderDetailsById(id);
        model.addAttribute("orderDetails", orderDetails);
        return "admin/order/detail";

    }

    @GetMapping("/admin/order/update/{id}")
    public String getUpdatePage(Model model, @PathVariable("id") long id) {
        Order newOrder = orderService.getOrderById(id);
        model.addAttribute("newOrder", newOrder);
        return "admin/order/update";
    }

    @PostMapping("/admin/order/update")
    public String updateStatusOrder(Model model, @ModelAttribute("newOrder") Order newOrder, RedirectAttributes a) {
        Order order = orderService.getOrderById(newOrder.getId());
        order.setStatus(newOrder.getStatus());
        orderService.saveOrder(order);
        a.addFlashAttribute("messageUpdate", "Cập nhật trạng tái thành công");
        return "redirect:/admin/order";
    }

    @GetMapping("/admin/order/delete/{id}")
    public String deleteOrder(Model model, @PathVariable("id") long id, RedirectAttributes a) {
        Order order = orderService.getOrderById(id);
        List<OrderDetail> orderDetails = order.getOrderDetails();
        orderService.deleteAllOrderDetail(orderDetails);
        orderService.deleteOrder(order);
        a.addFlashAttribute("messageDelete", "Xoá order thành công");
        return "redirect:/admin/order";
    }
}
