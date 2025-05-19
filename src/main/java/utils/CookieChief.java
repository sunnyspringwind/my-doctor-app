package utils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;

public class CookieChief {
    public static Cookie makeCookie(String name, String value, Integer days) {
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(days * 24 * 60 * 60); // days to seconds
        cookie.setHttpOnly(true);
        cookie.setPath("/");
        return cookie;
    }

    public static Cookie makeCookieWithMinutes(String name, String value, Integer minutes) {
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(minutes * 60); // minutes to seconds
        cookie.setHttpOnly(true);
        cookie.setPath("/");
        return cookie;
    }

    /** check for stored cooke and retrieve*/
    public static Cookie[] storedCookies(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("email") || cookie.getName().equals("role")) {
                    // Process cookies if needed
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
