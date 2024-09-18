import ballerina/grpc;
import ballerina/time;

listener grpc:Listener ep = new (9090);

type CartItem record {
    readonly string user_id;
    readonly string sku;
    int quantity;
};

table<Product> key(sku) productTable = table [];
table<User> key(user_id) userTable = table [];
table<CartItem> key(user_id, sku) cartTable = table []; // Use both user_id and sku as composite key
table<Order> key(order_id) orderTable = table [];

@grpc:Descriptor {value: SHOPPING_DESC}
service "ShoppingService" on ep {

    remote function add_product(Product value) returns ProductResponse|error {
        error? addNewProduct = productTable.add(value);
        if addNewProduct is error {
            return addNewProduct;
        } else {
            return {message: "Product successfully added"};
        }
    }

    remote function update_product(Product value) returns UserResponse|error {
        error? addNewProduct = productTable.put(value);
        if addNewProduct is error {
            return addNewProduct;
        } else {
            return {message: "product successfully updated"};
        }
    }

    remote function search_product(string value) returns Product|error {
        Product getproduct = productTable.get(value);
        if (getproduct.name === "") {

            return error("product cannot be found");
        } else {
            return getproduct;
        }
    }

    remote function add_to_cart(CartRequest value) returns CartResponse|error {
        CartItem newItem = {user_id: value.user_id, sku: value.sku, quantity: value.quantity};
            error? addItem = cartTable.add(newItem);
            if addItem is error {
                return addItem;
            }
             return {message: "Item successfully added to cart"};

    }

    remote function place_order(UserId value) returns OrderResponse|error {
         // Filter all items in the cart for the given user

        // Create a new order
        Order newOrder = {order_id: generateOrderId(), user_id: value.user_id};
        error? addOrder = orderTable.add(newOrder);
        if addOrder is error {
            return addOrder;
        }

       

        return {message: "Order successfully placed"};
    }
    

    remote function create_users(stream<User, grpc:Error?> clientStream) returns UserResponse|error {
        // Consume the stream and add each user to the userTable
        check clientStream.forEach(function(User user) {
            // Assuming userTable is a table or some collection where users are stored
            error? addUser = userTable.add(user);
            if addUser is error {
                // Stop the operation and return the error if something goes wrong
                return ();
            }
        });

        // If the loop is completed successfully, return a success message
        return {message: "The user was successfully created"};
    }

    remote function remove_product(string value) returns stream<Product, error?>|error {
        stream<Product, error?> productStream = stream from var product in productTable.toArray()
            select product;
           Product deletedProduct = productTable.remove(value);
        return productStream;
    }

    remote function list_available_products() returns stream<Product, error?>|error {
        stream<Product, error?> productStream = stream from var product in productTable.toArray()
            select product;
             
              
        return productStream;
    }
    // Function to generate a unique order ID

}

function generateOrderId() returns string {
    return "ORDER-" + time:utcToString(time:utcNow());
}

