package com.javaweb.security;

import com.javaweb.constant.SystemConstant;
import com.javaweb.security.utils.SecurityUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@Component
public class CustomSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
            throws IOException {
        String targetUrl = determineTargetUrl(authentication);
        if (response.isCommitted()) {
            System.out.println("Can't redirect");
            return;
        }
        redirectStrategy.sendRedirect(request, response, targetUrl);
    }

    public String determineTargetUrl(Authentication authentication) {
        String url = "";
        List<String> roles = SecurityUtils.getAuthorities();
        System.out.println("DEBUG - User roles: " + roles);

        if (isAdmin(roles)) {
            url = SystemConstant.ADMIN_HOME;
            System.out.println("DEBUG - Redirecting MANAGER to: " + url);
        } else if (isStaff(roles)) {
            url = SystemConstant.ADMIN_HOME;  // STAFF cũng vào admin
            System.out.println("DEBUG - Redirecting STAFF to: " + url);
        } else if (isGuest(roles)) {
            url = SystemConstant.HOME;  // GUEST vào trang chủ
            System.out.println("DEBUG - Redirecting GUEST to: " + url);
        } else {
            url = "/login";  // Fallback
            System.out.println("DEBUG - No role matched, fallback to: " + url);
        }
        return url;
    }

    public void setRedirectStrategy(RedirectStrategy redirectStrategy) {
        this.redirectStrategy = redirectStrategy;
    }

    public RedirectStrategy getRedirectStrategy() {
        return redirectStrategy;
    }

    private boolean isAdmin(List<String> roles) {
        if (roles.contains(SystemConstant.MANAGER_ROLE)) {
            return true;
        }
        return false;
    }

    private boolean isStaff(List<String> roles) {
        if (roles.contains(SystemConstant.STAFF_ROLE)) {
            return true;
        }
        return false;
    }

    private boolean isGuest(List<String> roles) {
        if (roles.contains("ROLE_GUEST")) {
            return true;
        }
        return false;
    }
}
