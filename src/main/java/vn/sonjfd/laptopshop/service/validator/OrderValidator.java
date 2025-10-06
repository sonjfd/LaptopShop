package vn.sonjfd.laptopshop.service.validator;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import vn.sonjfd.laptopshop.domain.DTO.OrderDTO;

public class OrderValidator implements ConstraintValidator<OrderChecked, OrderDTO> {

    @Override
    public boolean isValid(OrderDTO value, ConstraintValidatorContext context) {
        boolean valid = true;
        // Kiểm tra receiverName
        if (value.getReceiverName() == null || value.getReceiverName().trim().isEmpty()) {
            context.buildConstraintViolationWithTemplate("Tên người nhận không được để trống")
                    .addPropertyNode("receiverName")
                    .addConstraintViolation();
            valid = false;
        }

        // Kiểm tra receiverPhone
        if (value.getReceiverPhone() == null || value.getReceiverPhone().trim().isEmpty()) {
            context.buildConstraintViolationWithTemplate("Số điện thoại không được để trống")
                    .addPropertyNode("receiverPhone")
                    .addConstraintViolation();
            valid = false;
        }

        // Kiểm tra receiverAddress
        if (value.getReceiverAddress() == null || value.getReceiverAddress().trim().isEmpty()) {
            context.buildConstraintViolationWithTemplate("Địa chỉ không được để trống")
                    .addPropertyNode("receiverAddress")
                    .addConstraintViolation();
            valid = false;
        }

        return valid;
    }

}
