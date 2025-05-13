class Config {
  // Static variable to track the current flavor
  static String _currentFlavor = 'production';

  // Setter method to set the flavor from main files
  static void setFlavor(String flavor) {
    _currentFlavor = flavor;
  }

  // Getter for the current flavor
  static String get flavor => _currentFlavor;

  // A map containing configuration details for each environment.
  static final Map<String, dynamic> config = {
    'development': {
      'apiUrl': 'https://wecareroot.ddns.net:5300/',
      'enableLogging': true,
    },
    'staging': {
      'apiUrl': 'https://wecareroot.ddns.net:5300/',
      'enableLogging': true,
    },
    'production': {
      'apiUrl': 'https://wecareroot.ddns.net:5300/',
      'enableLogging': false,
    },
  };

  // Retrieves the configuration value based on the key and current flavor.
  static dynamic get(String key) =>
      (config[flavor] as Map<String, dynamic>?)?[key];
}
