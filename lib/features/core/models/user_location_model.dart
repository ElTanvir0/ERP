class UserLocation {
  late final String userId;
  late final String userType;
  late final String datetime;

  late final String latitude;
  late final String longitude;

  UserLocation();

  UserLocation.fromMap(Map m) {
    this.userId = m['user_id'];
    this.userType = m['user_type'];
    this.longitude = m['longitude'];
    this.latitude = m['latitude'];
    this.datetime = m['date'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> m = Map<String, dynamic>();
    m['user_id'] = this.userId;
    m['user_type'] = this.userType;
    m['longitude'] = this.longitude;
    m['latitude'] = this.latitude;
    m['date'] = this.datetime;

    return m;
  }
}
