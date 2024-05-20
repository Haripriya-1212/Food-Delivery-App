class api{
  static const hostConnect = "http://192.168.29.119:8888/dbmsP";
  static const hostConnectUser = "$hostConnect/user";

  // signup user
  static const signUp = "$hostConnectUser/signUp.php";
  static const login = "$hostConnectUser/login.php";
  static const getOrderData = "$hostConnect/getOrderData.php";
  static const getMenu = "$hostConnect/getMenu.php";
  static const placeOrder = "$hostConnect/insertOrder.php";
  static const validateEmail = "$hostConnectUser/validateEmail.php";
}