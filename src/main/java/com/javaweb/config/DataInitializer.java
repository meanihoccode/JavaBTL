package com.javaweb.config;

import com.javaweb.entity.RoleEntity;
import com.javaweb.repository.RoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

@Component
public class DataInitializer {

    @Autowired
    private RoleRepository roleRepository;

    @PostConstruct
    public void initializeData() {
        System.out.println("=== DataInitializer: Bắt đầu kiểm tra dữ liệu ===");

        // Thêm role GUEST nếu chưa tồn tại
        try {
            RoleEntity guestRole = null;
            try {
                guestRole = roleRepository.findOneByCode("GUEST");
            } catch (Exception e) {
                System.out.println("GUEST role chưa tồn tại hoặc có lỗi khi tìm kiếm");
            }

            if (guestRole != null) {
                System.out.println("✓ GUEST role đã tồn tại");
                return;
            }

            // Thêm GUEST role vào hệ thống
            RoleEntity newRole = new RoleEntity();
            newRole.setCode("GUEST");
            newRole.setName("Khách");
            roleRepository.save(newRole);
            System.out.println("✓ GUEST role đã được thêm vào hệ thống thành công");
        } catch (Exception e) {
            System.err.println("✗ Lỗi khi xử lý GUEST role: " + e.getMessage());
            e.printStackTrace();
        }
    }
}

