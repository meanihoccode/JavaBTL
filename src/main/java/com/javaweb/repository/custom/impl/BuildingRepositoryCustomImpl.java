package com.javaweb.repository.custom.impl;

import com.javaweb.builder.BuildingSearchBuilder;
import com.javaweb.entity.BuildingEntity;
import com.javaweb.repository.custom.BuildingRepositoryCustom;
import org.springframework.context.annotation.Primary;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.lang.reflect.Field;
import java.util.List;
import java.util.stream.Collectors;

@Repository
@Primary
public class BuildingRepositoryCustomImpl implements BuildingRepositoryCustom {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public Page<BuildingEntity> findAll(BuildingSearchBuilder buildingSearchBuilder, Pageable pageable) {
        // Xây dựng câu SQL để truy vấn dữ liệu
        StringBuilder sql = new StringBuilder("SELECT b.* FROM building AS b");
        joinQuery(buildingSearchBuilder, sql);
        sql.append(" WHERE 1 = 1");
        whereQueryNormal(buildingSearchBuilder, sql);
        whereQuerySpecial(buildingSearchBuilder, sql);
        sql.append(" GROUP BY b.id");

        // Tính tổng số bản ghi không phân trang
        int totalItems = countTotalItem(buildingSearchBuilder);

        // Thêm LIMIT và OFFSET cho phân trang
        sql.append(" LIMIT ").append(pageable.getPageSize());
        sql.append(" OFFSET ").append(pageable.getOffset());

        // Tạo truy vấn và thực thi
        Query query = entityManager.createNativeQuery(sql.toString(), BuildingEntity.class);
        List<BuildingEntity> buildings = query.getResultList();

        // Tạo Page<BuildingEntity> trả về
        return new PageImpl<>(buildings, pageable, totalItems);
    }

    @Override
    public int countTotalItem(BuildingSearchBuilder buildingSearchBuilder) {
        // Xây dựng câu truy vấn để đếm tổng số bản ghi
        StringBuilder sql = new StringBuilder("SELECT COUNT(DISTINCT b.id) FROM building AS b");
        joinQuery(buildingSearchBuilder, sql);
        sql.append(" WHERE 1 = 1");
        whereQueryNormal(buildingSearchBuilder, sql);
        whereQuerySpecial(buildingSearchBuilder, sql);

        // Tạo và thực thi truy vấn đếm
        Query query = entityManager.createNativeQuery(sql.toString());
        Number result = (Number) query.getSingleResult();
        return result != null ? result.intValue() : 0;
    }

    public void joinQuery(BuildingSearchBuilder buildingSearchBuilder, StringBuilder join) {
        Long staffId = buildingSearchBuilder.getStaffId();
        if (staffId != null) {
            join.append(" INNER JOIN assignmentbuilding AS a ON b.id = a.buildingid");
        }
        Integer startArea = buildingSearchBuilder.getStartArea();
        Integer endArea = buildingSearchBuilder.getEndArea();
        if (startArea != null || endArea != null) {
            join.append(" INNER JOIN rentarea AS r ON b.id = r.buildingid");
        }
    }

    public void whereQueryNormal(BuildingSearchBuilder buildingSearchBuilder, StringBuilder where) {
        try {
            Field[] fields = BuildingSearchBuilder.class.getDeclaredFields();
            for (Field field : fields) {
                field.setAccessible(true);
                String fieldName = field.getName();
                if (!fieldName.equals("staffId") && !fieldName.equals("typeCode") && !fieldName.startsWith("start")
                        && !fieldName.startsWith("end")) {
                    Object value = field.get(buildingSearchBuilder);
                    if (value != null) {
                        if (field.getType() == Long.class || field.getType() == Integer.class) {
                            where.append(" AND b.").append(fieldName).append(" = ").append(value);
                        } else if (field.getType() == String.class ) {
                            where.append(" AND b.").append(fieldName).append(" LIKE '%").append(value).append("%'");
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void whereQuerySpecial(BuildingSearchBuilder buildingSearchBuilder, StringBuilder where) {
        Long staffId = buildingSearchBuilder.getStaffId();
        if (staffId != null) {
            where.append(" AND a.staffid = ").append(staffId);
        }

        Integer startArea = buildingSearchBuilder.getStartArea();
        Integer endArea = buildingSearchBuilder.getEndArea();
        if (startArea != null) {
            where.append(" AND r.value >= ").append(startArea);
        }
        if (endArea != null) {
            where.append(" AND r.value <= ").append(endArea);
        }

        Integer startRentPrice = buildingSearchBuilder.getStartRentPrice();
        Integer endRentPrice = buildingSearchBuilder.getEndRentPrice();
        if (startRentPrice != null) {
            where.append(" AND b.rentprice >= ").append(startRentPrice);
        }
        if (endRentPrice != null) {
            where.append(" AND b.rentprice <= ").append(endRentPrice);
        }

        List<String> typeCode = buildingSearchBuilder.getTypeCode();
        if (typeCode != null && !typeCode.isEmpty()) {
            String typeConditions = typeCode.stream()
                    .map(code -> "b.type LIKE '%" + code + "%'")
                    .collect(Collectors.joining(" OR "));
            where.append(" AND (").append(typeConditions).append(")");
        }
    }
}
