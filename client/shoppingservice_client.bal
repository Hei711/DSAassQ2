import ballerina/io;

ShoppingServiceClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    // Display a menu for user interaction
    while (true) {
        io:println("\nLibrary Management System Menu:");
        io:println("1. Add Product");
        io:println("2. Create User");
        io:println("3. Update Product");
        io:println("4. Locate Product");
        io:println("5. Remove Product");
        io:println("6. List Available Products");
        io:println("7. Add to Cart");
        io:println("8. Place Order");
        io:println("9. Exit");

        string choice = io:readln("Enter your choice: ");

        match choice {
            "1" => {
                // Add product
                Product addProductRequest = check getProductDetailsFromUser();
                ProductResponse addProductResponse = check ep->add_product(addProductRequest);
                io:println(addProductResponse.message);
            }
            "2" => {
                // Create product
                User createUserRequest = getUserDetailsFromUser();
                Create_usersStreamingClient createUserResponse = check ep->create_users();
                io:println(Create_usersStreamingClient);
            }
            "3" => {
                // Update product
                Product updateProductRequest = check getProductDetailsFromUser();
                UserResponse updateProductResponse = check ep->update_product(updateProductRequest);
                io:println(updateProductResponse.message);
            }
            "4" => {
                // Locate product
                string locateProductRequest = io:readln("Enter name of Product to search: ");
                Product searchProductResponse = check ep->search_product(locateProductRequest);
                io:println("Product: " + searchProductResponse.name);
            }
            "5" => {
                // Remove product
                string removeProductRequest = io:readln("Enter name of the product to remove: ");
                stream<Product, error?> removeProductResponse = check ep->remove_product(removeProductRequest);
                check removeProductResponse.forEach(function (Product value) {
                    io:println("Removed Product: " + value.name);
                });
            }
            "6" => {
                // List Available products
                stream<Product, error?> listAvailableProductsResponse = check ep->list_available_products();
                check listAvailableProductsResponse.forEach(function (Product value) {
                    io:println("Available Products: " + value.name);
                });
            }
            "7" => {
                // Add to Cart
                CartRequest addToCartRequest = getCartDetailsFromUser();
                CartResponse addToCartResponse = check ep->add_to_cart(addToCartRequest);
                io:println(addToCartResponse.message);
            }
            "8" => {
                // Place Order
                UserId placeOrderRequest = getUserIdFromUser();
                OrderResponse placeOrderResponse = check ep->place_order(placeOrderRequest);
                io:println(placeOrderResponse.message);
            }
            "9" => {
                // Exit
                io:println("Exiting Library Management System.");
                return;
            }
            _ => {
                io:println("Invalid choice. Please select a valid option.");
            }
        }
    }
}


function getProductDetailsFromUser() returns Product|error {
    io:println("\nEnter Product Details:");
    string name = io:readln("Name: ");
    string description = io:readln("Description: ");
    
    // Handle conversion with error handling
    float price = check float:fromString(io:readln("Price: "));
    int stock_quantity = check int:fromString(io:readln("Stock Quantity: "));
    
    string sku = io:readln("SKU: ");
    string status = io:readln("Status: ");
    
    Product productDetails = {
        name: name,
        description: description,
        price: price,
        stock_quantity: stock_quantity,
        sku: sku,
        status: status
    };
    return productDetails;
}

function getUserDetailsFromUser() returns User {
    io:println("\nEnter User Details:");
    string userId = io:readln("User ID: ");

    User userRequest = {
        user_id: userId
    };
    return userRequest;
}
function getCartDetailsFromUser() returns CartRequest {
    io:println("\nEnter Cart Details:");
    string userId = io:readln("User ID: ");
    string sku = io:readln("SKU of Product: ");
    

    CartRequest cartRequest = {
        user_id: userId,
        sku: sku
        
    };
    return cartRequest;
}

function getUserIdFromUser() returns UserId {
    io:println("\nEnter User ID for placing order:");
    string userId = io:readln("User ID: ");
    
    UserId userIdRequest = {
        user_id: userId
    };
    return userIdRequest;
}

