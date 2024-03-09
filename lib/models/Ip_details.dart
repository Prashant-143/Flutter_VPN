class IPDetails {
  late final String country;
  late final String countryCode;
  late final String region;
  late final String regionName;
  late final String city;
  late final String zip;
  late final double lat;
  late final double lon;
  late final String timezone;
  late final String isp;
  late final String query;

  IPDetails({
    required this.country,
    required this.countryCode,
    required this.region,
    required this.regionName,
    required this.city,
    required this.lat,
    required this.lon,
    required this.zip,
    required this.timezone,
    required this.isp,
    required this.query,
  });

  IPDetails.fromJson(Map<String, dynamic> json) {
    country = json['country'] ?? '';
    regionName = json['regionName'] ?? '';
    city = json['city'] ?? '';
    zip = json['zip'] ?? ' - - - - ';
    lat = json['lat'] ?? 00;
    lon = json['lon'] ?? 00;
    timezone = json['timezone'] ?? 'Unknown';
    isp = json['isp'] ?? 'Unknown';
    query = json['query'] ?? 'Not available';
  }
}
