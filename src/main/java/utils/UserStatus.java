package utils;

/** Avoid using boolean for cases where multiple outcomes exist (e.g., success, failure, validation errors). Instead, return meaningful status codes or enum constants. */
public enum UserStatus {
    SUCCESS(200),
    EMAIL_ALREADY_EXISTS(409),
    PHONE_ALREADY_EXISTS(409),
    INTERNAL_SERVER_ERROR(500);

    private final int code;

    UserStatus(int code) {
        this.code = code;
    }
}
