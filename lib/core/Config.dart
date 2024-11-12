class Config {
  // Reads the FLAVOR environment variable and defaults to 'production' if not provided.
  static final String flavor = String.fromEnvironment('FLAVOR', defaultValue: 'production');

  // A map containing configuration details for each environment.
  static final Map<String, dynamic> config = {
    'development': {
      'apiUrl': 'https://dev.example.com',
      'enableLogging': true,
    },
    'staging': {
      'apiUrl': 'https://staging.example.com',
      'enableLogging': true,
    },
    'production': {
      'apiUrl': 'https://api.example.com',
      'enableLogging': false,
    },
  };

  // Retrieves the configuration value based on the key and current flavor.
  static dynamic get(String key) => config[flavor]?[key];
}
