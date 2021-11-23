class Weather {
  num temp;
  String description;
  String icon;
  String main;
  //double rain = 0.0;

  Weather({
    required this.temp,
    required this.description,
    required this.icon,
    required this.main,
    //required this.rain,
  });

  factory Weather.fromJson(Map json) {
    return Weather(
      temp: json['main']['temp'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      main: json['weather'][0]['main'],
      //rain: json['weather']['rain']
    );
  }
}

class Daily {
  //1
  double tempmax0;
  double tempmin0;
  String description0;
  String icon0;
  int date0;
  double morn0;
  double day0;
  double eve0;

  double tempmax1;
  double tempmin1;
  String description1;
  String icon1;
  int date1;
  double morn1;
  double day1;
  double eve1;

  double tempmax2;
  double tempmin2;
  String description2;
  String icon2;
  int date2;
  double morn2;
  double day2;
  double eve2;

  int date3;
  String icon3;
  String description3;
  double morn3;
  double day3;
  double eve3;

  int date4;
  String icon4;
  String description4;
  double morn4;
  double day4;
  double eve4;

  Daily({
    required this.tempmax0,
    required this.tempmin0,
    required this.description0,
    required this.icon0,
    required this.date0,
    required this.morn0,
    required this.day0,
    required this.eve0,
    required this.tempmax1,
    required this.tempmin1,
    required this.description1,
    required this.icon1,
    required this.date1,
    required this.morn1,
    required this.day1,
    required this.eve1,
    required this.tempmax2,
    required this.tempmin2,
    required this.description2,
    required this.icon2,
    required this.date2,
    required this.morn2,
    required this.day2,
    required this.eve2,
    required this.date3,
    required this.icon3,
    required this.description3,
    required this.morn3,
    required this.day3,
    required this.eve3,
    required this.date4,
    required this.icon4,
    required this.description4,
    required this.morn4,
    required this.day4,
    required this.eve4,
  });

  factory Daily.fromJson(Map json) {
    return Daily(
      tempmax0: (json['daily'][0]['temp']['max']) - 273.15,
      tempmin0: (json['daily'][0]['temp']['min']) - 273.15,
      description0: json['daily'][0]['weather'][0]['description'],
      icon0: json['daily'][0]['weather'][0]['icon'],
      date0: json['daily'][0]['dt'],
      morn0: (json['daily'][0]['temp']['morn']) - 273.15,
      day0: (json['daily'][0]['temp']['day']) - 273.15,
      eve0: (json['daily'][0]['temp']['eve']) - 273.15,
      tempmax1: (json['daily'][1]['temp']['max']) - 273.15,
      tempmin1: (json['daily'][1]['temp']['min']) - 273.15,
      description1: json['daily'][1]['weather'][0]['description'],
      icon1: json['daily'][1]['weather'][0]['icon'],
      date1: json['daily'][1]['dt'],
      morn1: (json['daily'][1]['temp']['morn']) - 273.15,
      day1: (json['daily'][1]['temp']['day']) - 273.15,
      eve1: (json['daily'][1]['temp']['eve']) - 273.15,
      tempmax2: (json['daily'][2]['temp']['max']) - 273.15,
      tempmin2: (json['daily'][2]['temp']['min']) - 273.15,
      description2: json['daily'][2]['weather'][0]['description'],
      icon2: json['daily'][2]['weather'][0]['icon'],
      date2: json['daily'][2]['dt'],
      morn2: (json['daily'][2]['temp']['morn']) - 273.15,
      day2: (json['daily'][2]['temp']['day']) - 273.15,
      eve2: (json['daily'][2]['temp']['eve']) - 273.15,
      date3: json['daily'][3]['dt'],
      icon3: json['daily'][3]['weather'][0]['icon'],
      description3: json['daily'][3]['weather'][0]['description'],
      morn3: (json['daily'][3]['temp']['morn']) - 273.15,
      day3: (json['daily'][3]['temp']['day']) - 273.15,
      eve3: (json['daily'][3]['temp']['eve']) - 273.15,
      date4: json['daily'][4]['dt'],
      icon4: json['daily'][4]['weather'][0]['icon'],
      description4: json['daily'][4]['weather'][0]['description'],
      morn4: (json['daily'][4]['temp']['morn']) - 273.15,
      day4: (json['daily'][4]['temp']['day']) - 273.15,
      eve4: (json['daily'][4]['temp']['eve']) - 273.15,
    );
  }
}
