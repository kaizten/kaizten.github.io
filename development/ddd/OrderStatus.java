import java.util.Random;

public enum OrderStatus {

    CREATED,
    SHIPPED,
    DELIVERED,
    CANCELLED;

    public static OrderStatus fromString(String stringToCheck) {
        if (stringToCheck == null) {
            throw new IllegalArgumentException();
        }
        stringToCheck = stringToCheck.trim().toUpperCase();
        for (OrderStatus orderStatus : values()) {
            if (orderStatus.name().equals(stringToCheck)) {
                return orderStatus;
            }
        }
        throw new IllegalArgumentException();
    }

    public static int indexOf(String stringToCheck) {
        return OrderStatus
                .fromString(stringToCheck)
                .ordinal();
    }

    public static boolean isValid(String stringToCheck) {
        if (stringToCheck == null) {
            return false;
        }
        stringToCheck = stringToCheck.trim().toUpperCase();
        for (OrderStatus orderStatus : values()) {
            if (orderStatus.name().equals(stringToCheck)) {
                return true;
            }
        }
        return false;
    }

    public static OrderStatus random() {
        return values()[new Random().nextInt(values().length)];
    }
}