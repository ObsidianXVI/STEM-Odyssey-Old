part of stem_odyssey;

class Utils {}

void timedAction(int seconds, void Function() callback) {
  Future.delayed(Duration(seconds: seconds), callback);
}
