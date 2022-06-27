class Config {
  static const String appName = "Artenativ";
  //static const String apiURL = '192.168.178.37:4000';
  //static const String apiURL = '192.168.188.85:4000'; //OFFICE LOCAL VERSION
  //static const String apiURL = 'artenativ.herokuapp.com'; //PROD_URL HEROKU
  static const String apiURL = 'api.artenativ.de'; //PROD_URL
  //static const String apiURL = '10.0.0.7:4000'; //PROD_URL
  static const loginAPI = "/users/login";
  static const registerAPI = "/users/register";
  static const userProfileAPI = "/users/user-Profile";
  static const addartikelAPI = "/artikel/addartikel";
  static const findartikelAPI = "/findartikel/";
  static const updateartikelAPI = "/findartikel/";
  static const getAllArticleAPI = "/artikel/allartikel";
  static const internartikelidAPI = "/artikel/internartikelid";
  //static const addartikelimageAPI = "/artikel/upload";
  static const addartikelimageAPI = "/upload";
}
