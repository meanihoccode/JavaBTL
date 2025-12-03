package com.javaweb.api.web;

import com.javaweb.exception.MyException;
import com.javaweb.model.dto.RegisterDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api/auth")
public class RegisterAPI {

    @Autowired
    private IUserService userService;

    @PostMapping("/register")
    public ResponseEntity<ResponseDTO> register(@Valid @RequestBody RegisterDTO registerDTO,
                                                BindingResult bindingResult) {
        ResponseDTO response = new ResponseDTO();

        // Validate
        if (bindingResult.hasErrors()) {
            List<String> errors = new ArrayList<>();
            bindingResult.getAllErrors().forEach(error -> {
                errors.add(error.getDefaultMessage());
            });
            response.setMessage("Validation failed");
            response.setDetails(errors);
            return ResponseEntity.badRequest().body(response);
        }

        try {
            // Gọi service register
            userService.register(registerDTO);
            response.setMessage("Đăng ký thành công. Vui lòng đăng nhập!");
            return ResponseEntity.ok(response);
        } catch (MyException e) {
            response.setMessage("Đăng ký thất bại");
            List<String> errors = new ArrayList<>();
            errors.add(e.getMessage());
            response.setDetails(errors);
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        } catch (Exception e) {
            response.setMessage("Lỗi hệ thống");
            List<String> errors = new ArrayList<>();
            errors.add(e.getMessage());
            response.setDetails(errors);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
}

