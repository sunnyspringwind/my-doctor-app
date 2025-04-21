package utils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;

public class CookieChief {
    public static Cookie makeCookie(String name, String value, Integer days) {
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(days * 24 * 60 * 60); // 7 days
        cookie.setHttpOnly(true);
        cookie.setPath("/");
        return cookie;
    }

    /** check for stored cooke and retrieve*/
    public static Cookie[] storedCookies(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        String rememberedEmail = null;
        String rememberedRole = null;

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("email")) {
                    rememberedEmail = cookie.getValue();
                } else if (cookie.getName().equals("role")) {
                    rememberedRole = cookie.getValue();
                }
            }
        }
        return cookies;
    }

    public static Cookie deleteCookie(Cookie cookie) {
        cookie.setMaxAge(0);
        cookie.setHttpOnly(true);
        cookie.setPath("/");
        return cookie;
    }


}
