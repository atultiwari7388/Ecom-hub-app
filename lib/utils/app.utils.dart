class AppConstants {
  //app name
  static const String APP_NAME = "Ecom hub";

  //app version
  static const double APP_VERSION = 0.1;

  //app base urls
  static const String App_Url = "https://ecom-backend-node-api.herokuapp.com/";
  static const String BASE_URL = "https://ecom-backend-node-api.herokuapp.com";

  // app token
  static const String TOKEN = "x-auth-token";

  //for user authentication
  static const String SIGN_UP = "$BASE_URL/api/signup";
  static const String SIGN_IN = "$BASE_URL/api/signin";
  static const String TOKEN_IS_VALID = "$BASE_URL/tokenIsValid";

  //for category Products

  static const String GET_CATEGORIES = "$BASE_URL/api/products?category";
  static const String GET_FASHION_CATEGORIES =
      "$BASE_URL/api/products?category=Fashion";

  static const String GET_MOBILES_CATEGORIES =
      "$BASE_URL/api/products?category=Mobiles";

  static const String GET_ELECTRONICS_CATEGORIES =
      "$BASE_URL/api/products?category=Electronics";

  static const String GET_APPLIANCES_CATEGORIES =
      "$BASE_URL/api/products?category=Appliances";

  static const String GET_BOOKS_CATEGORIES =
      "$BASE_URL/api/products?category=Books";

  static const String GET_HOME_CATEGORIES =
      "$BASE_URL/api/products?category=Home";

  static const String GET_BEAUTY_CATEGORIES =
      "$BASE_URL/api/products?category=Beauty";

  static const String GET_FURNITURE_CATEGORIES =
      "$BASE_URL/api/products?category=Furniture";

  static const String GET_SPORTS_CATEGORIES =
      "$BASE_URL/api/products?category=Sports";

  //for cart
  static const String ADD_TO_CART = "$BASE_URL/api/add-to-cart";
  static const String REMOVE_FROM_CART = "$BASE_URL/api/remove-from-cart";
  static const String RATE_PRODUCTS = "$BASE_URL/api/rate-product";

  //for search products
  static const String SEARCH_PRODUCTS = "$BASE_URL/api/products/search/";

  //for orders
  static const String FETCH_MY_ORDERS = "$BASE_URL/api/orders/me";
  static const String SAVE_USER_ADDRESS = "$BASE_URL/api/save-user-address";
  static const String PLACE_ORDER = "$BASE_URL/api/order";
}
