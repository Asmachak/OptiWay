late String imageUrl = 'assets/red.png';

String setVehicleImage(String color) {
  if (color.contains('Color(0xffffffff)')) {
    return 'assets/white.png';
  } else if (color.contains('Color(0xff000000)')) {
    return 'assets/black.png';
  } else if (color.contains('Color(0xffffeb3b)')) {
    return 'assets/yellow.png';
  } else if (color.contains('Color(0xffff0000)')) {
    return 'assets/red.png';
  } else if (color.contains('Color(0xff808080)')) {
    return 'assets/grey.png';
  } else if (color.contains('Color(0xff4caf50)')) {
    return 'assets/green.png';
  } else if (color.contains('Color(0xff2196f3)')) {
    return 'assets/blue.png';
  }
  return imageUrl; // Return default image URL if no condition matches
}
