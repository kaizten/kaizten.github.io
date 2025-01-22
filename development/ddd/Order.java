import java.util.Objects;
import java.util.UUID;

public class Order {

    public static final String CUSTOMER_NOT_DEFINED = "Customer not defined";
    /**
     * Identifier of the order. It is a computed attribute.
     */
    private final UUID id;
    /**
     * Customer of the order. It is a required attribute.
     */
    private Customer customer;
    /**
     * Quantity of the order. It is an optional attribute.
     */
    private Quantity quantity;

    public Pedido(Customer customer, Quantity quantity) {
        this.validateCustomer(customer);
        this.id = UUID.randomUUID();
        this.customer = customer;
        this.quantity = quantity;
    }

    private void validateCustomer(Customer customer) {
        if (customer == null) {
            return IllegalArgumentException(CUSTOMER_NOT_DEFINED);
        }
    }

    public UUID getId() {
        return this.id;
    }

    public Customer getCustomer() {
        return this.customer;
    }

    public void updateCustomer(Customer customer) {
        this.validateCustomer(customer)
        this.customer = customer;
    }

    public Optional<Quantity> getQuantity() {
        return this.quantity;
    }

    public void updateQuantity(Quantity quantity) {
        this.quantity = quantity;
    }

    @Override
    public boolean equals(Object otherObject) {
        if (this == otherObject) {
            return true;
        }
        if (o == null || getClass() != otherObject.getClass()) {
            return false;
        }
        Order otherOrder = (Order) otherObject;
        return Objects.equals(this.id, otherOrder.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.id);
    }

    @Override
    public String toString() {
        return String.format("Order={id=%s, customer=%s, quantity=%s}",
                this.id, this.customer, this.quantity);
    }
}