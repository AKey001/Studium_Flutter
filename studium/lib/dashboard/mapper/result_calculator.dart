import 'package:studium/modules/models/models.dart';

double? calculateAverage(List<Module> modules) {
  if (modules.isNotEmpty) {
    int count = modules.where((element) => element.grade != null).length;
    double sum = 0;
    for (Module module in modules) {
      num grade = module.grade ?? 0;
      if (grade > 0.0) {
        sum += grade;
      }
    }
    return sum/count;
  } else {
    return null;
  }
}

String calculateAverageString(List<Module> modules) {
  double? average = calculateAverage(modules);

  if (average != null) {
    return average.toStringAsFixed(2);
  } else {
    return '-.-';
  }
}

String calculateResult(List<Module> modules) {
  if (modules.isEmpty) {
   return '-.-';
  } else {
    double sumWeightings =  modules.where((element) => element.grade != null).fold(0, (previousValue, element) => previousValue + element.weighting);
    double sumWeightedGrades = modules.fold(0, (previousValue, element) => previousValue + element.weighting * (element.grade ?? 0.0));

    double result = sumWeightedGrades / sumWeightings;
    return result.toStringAsFixed(3);
  }

}