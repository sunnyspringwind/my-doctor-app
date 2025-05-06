package utils;

public enum StatusCode {
    SUCCESS(200),
    EMAIL_ALREADY_EXISTS(409),
    PHONE_ALREADY_EXISTS(409),
    APPOINTMENT_ALREADY_EXISTS(409),
    NOT_FOUND(404),
    APPOINTMENT_CREATION_FAILED(500),
    APPOINTMENT_UPDATE_FAILED(500),
    APPOINTMENT_DELETION_FAILED(500),
    INVALID_APPOINTMENT_TIME(400),
    INVALID_DOCTOR_ID(400),
    INVALID_PATIENT_ID(400),
    UNAUTHORIZED_ACCESS(401),
    FORBIDDEN_ACTION(403),
    INTERNAL_SERVER_ERROR(500),
    BAD_REQUEST(400);
    private final int code;

    StatusCode(int code) {
        this.code = code;
    }

    public int getCode() {
        return code;
    }
}
