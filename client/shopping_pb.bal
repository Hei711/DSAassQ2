import ballerina/grpc;
import ballerina/protobuf;
import ballerina/protobuf.types.empty;
import ballerina/protobuf.types.wrappers;

public const string SHOPPING_DESC = "0A0E73686F7070696E672E70726F746F120873686F7070696E671A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F22A6010A0750726F6475637412120A046E616D6518012001280952046E616D6512200A0B6465736372697074696F6E180220012809520B6465736372697074696F6E12140A0570726963651803200128025205707269636512250A0E73746F636B5F7175616E74697479180420012805520D73746F636B5175616E7469747912100A03736B751805200128095203736B7512160A067374617475731806200128095206737461747573221D0A0950726F64756374496412100A03736B751801200128095203736B75222B0A0F50726F64756374526573706F6E736512180A076D65737361676518012001280952076D657373616765223C0A0B50726F647563744C697374122D0A0870726F647563747318012003280B32112E73686F7070696E672E50726F64756374520870726F647563747322380A0B436172745265717565737412170A07757365725F6964180120012809520675736572496412100A03736B751802200128095203736B7522410A0C43617274526573706F6E736512180A076D65737361676518012001280952076D65737361676512170A07757365725F6964180220012809520675736572496422500A0D4F72646572526573706F6E736512180A076D65737361676518012001280952076D65737361676512250A056F7264657218022001280B320F2E73686F7070696E672E4F7264657252056F7264657222690A054F7264657212190A086F726465725F696418012001280952076F726465724964122D0A0870726F647563747318022003280B32112E73686F7070696E672E50726F64756374520870726F647563747312160A06737461747573180320012809520673746174757322470A045573657212170A07757365725F6964180120012809520675736572496412120A046E616D6518022001280952046E616D6512120A04726F6C651803200128095204726F6C65224E0A0C55736572526573706F6E736512180A076D65737361676518012001280952076D65737361676512240A05757365727318022003280B320E2E73686F7070696E672E557365725205757365727322210A0655736572496412170A07757365725F69641801200128095206757365724964328D040A0F53686F7070696E6753657276696365123B0A0B6164645F70726F6475637412112E73686F7070696E672E50726F647563741A192E73686F7070696E672E50726F64756374526573706F6E7365123B0A0E7570646174655F70726F6475637412112E73686F7070696E672E50726F647563741A162E73686F7070696E672E55736572526573706F6E736512430A0E72656D6F76655F70726F64756374121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A112E73686F7070696E672E50726F64756374300112460A176C6973745F617661696C61626C655F70726F647563747312162E676F6F676C652E70726F746F6275662E456D7074791A112E73686F7070696E672E50726F64756374300112410A0E7365617263685F70726F64756374121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A112E73686F7070696E672E50726F64756374123C0A0B6164645F746F5F6361727412152E73686F7070696E672E43617274526571756573741A162E73686F7070696E672E43617274526573706F6E736512380A0B706C6163655F6F7264657212102E73686F7070696E672E5573657249641A172E73686F7070696E672E4F72646572526573706F6E736512380A0C6372656174655F7573657273120E2E73686F7070696E672E557365721A162E73686F7070696E672E55736572526573706F6E73652801620670726F746F33";

public isolated client class ShoppingServiceClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, SHOPPING_DESC);
    }

    isolated remote function add_product(Product|ContextProduct req) returns ProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/add_product", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductResponse>result;
    }

    isolated remote function add_productContext(Product|ContextProduct req) returns ContextProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/add_product", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductResponse>result, headers: respHeaders};
    }

    isolated remote function update_product(Product|ContextProduct req) returns UserResponse|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/update_product", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <UserResponse>result;
    }

    isolated remote function update_productContext(Product|ContextProduct req) returns ContextUserResponse|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/update_product", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <UserResponse>result, headers: respHeaders};
    }

    isolated remote function search_product(string|wrappers:ContextString req) returns Product|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/search_product", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Product>result;
    }

    isolated remote function search_productContext(string|wrappers:ContextString req) returns ContextProduct|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/search_product", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Product>result, headers: respHeaders};
    }

    isolated remote function add_to_cart(CartRequest|ContextCartRequest req) returns CartResponse|grpc:Error {
        map<string|string[]> headers = {};
        CartRequest message;
        if req is ContextCartRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/add_to_cart", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <CartResponse>result;
    }

    isolated remote function add_to_cartContext(CartRequest|ContextCartRequest req) returns ContextCartResponse|grpc:Error {
        map<string|string[]> headers = {};
        CartRequest message;
        if req is ContextCartRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/add_to_cart", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <CartResponse>result, headers: respHeaders};
    }

    isolated remote function place_order(UserId|ContextUserId req) returns OrderResponse|grpc:Error {
        map<string|string[]> headers = {};
        UserId message;
        if req is ContextUserId {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/place_order", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <OrderResponse>result;
    }

    isolated remote function place_orderContext(UserId|ContextUserId req) returns ContextOrderResponse|grpc:Error {
        map<string|string[]> headers = {};
        UserId message;
        if req is ContextUserId {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/place_order", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <OrderResponse>result, headers: respHeaders};
    }

    isolated remote function create_users() returns Create_usersStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("shopping.ShoppingService/create_users");
        return new Create_usersStreamingClient(sClient);
    }

    isolated remote function remove_product(string|wrappers:ContextString req) returns stream<Product, grpc:Error?>|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("shopping.ShoppingService/remove_product", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        ProductStream outputStream = new ProductStream(result);
        return new stream<Product, grpc:Error?>(outputStream);
    }

    isolated remote function remove_productContext(string|wrappers:ContextString req) returns ContextProductStream|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("shopping.ShoppingService/remove_product", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        ProductStream outputStream = new ProductStream(result);
        return {content: new stream<Product, grpc:Error?>(outputStream), headers: respHeaders};
    }

    isolated remote function list_available_products() returns stream<Product, grpc:Error?>|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("shopping.ShoppingService/list_available_products", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        ProductStream outputStream = new ProductStream(result);
        return new stream<Product, grpc:Error?>(outputStream);
    }

    isolated remote function list_available_productsContext() returns ContextProductStream|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("shopping.ShoppingService/list_available_products", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        ProductStream outputStream = new ProductStream(result);
        return {content: new stream<Product, grpc:Error?>(outputStream), headers: respHeaders};
    }
}

public isolated client class Create_usersStreamingClient {
    private final grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendUser(User message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextUser(ContextUser message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveUserResponse() returns UserResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return <UserResponse>payload;
        }
    }

    isolated remote function receiveContextUserResponse() returns ContextUserResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: <UserResponse>payload, headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public class ProductStream {
    private stream<anydata, grpc:Error?> anydataStream;

    public isolated function init(stream<anydata, grpc:Error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns record {|Product value;|}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if streamValue is () {
            return streamValue;
        } else if streamValue is grpc:Error {
            return streamValue;
        } else {
            record {|Product value;|} nextRecord = {value: <Product>streamValue.value};
            return nextRecord;
        }
    }

    public isolated function close() returns grpc:Error? {
        return self.anydataStream.close();
    }
}

public type ContextUserStream record {|
    stream<User, error?> content;
    map<string|string[]> headers;
|};

public type ContextProductStream record {|
    stream<Product, error?> content;
    map<string|string[]> headers;
|};

public type ContextUserResponse record {|
    UserResponse content;
    map<string|string[]> headers;
|};

public type ContextUser record {|
    User content;
    map<string|string[]> headers;
|};

public type ContextUserId record {|
    UserId content;
    map<string|string[]> headers;
|};

public type ContextCartRequest record {|
    CartRequest content;
    map<string|string[]> headers;
|};

public type ContextProduct record {|
    Product content;
    map<string|string[]> headers;
|};

public type ContextProductResponse record {|
    ProductResponse content;
    map<string|string[]> headers;
|};

public type ContextOrderResponse record {|
    OrderResponse content;
    map<string|string[]> headers;
|};

public type ContextCartResponse record {|
    CartResponse content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type ProductList record {|
    Product[] products = [];
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type Order record {|
    string order_id = "";
    Product[] products = [];
    string status = "";
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type UserResponse record {|
    string message = "";
    User[] users = [];
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type User record {|
    string user_id = "";
    string name = "";
    string role = "";
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type UserId record {|
    string user_id = "";
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type CartRequest record {|
    string user_id = "";
    string sku = "";
    
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type Product record {|
    string name = "";
    string description = "";
    float price = 0.0;
    int stock_quantity = 0;
    string sku = "";
    string status = "";
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type ProductResponse record {|
    string message = "";
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type ProductId record {|
    string sku = "";
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type OrderResponse record {|
    string message = "";
    Order 'order = {};
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type CartResponse record {|
    string message = "";
    string user_id = "";
|};

