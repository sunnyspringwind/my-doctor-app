// utils/ServiceResponse.java
package utils;

public class ServiceResponse<T> {
    private StatusCode status;
    private T data;

    public ServiceResponse(StatusCode status, T data) {
        this.status = status;
        this.data = data;
    }

    public ServiceResponse(StatusCode status) {
        this(status, null);
    }

    public StatusCode getStatus() {
        return status;
    }

    public T getData() {
        return data;
    }
}
