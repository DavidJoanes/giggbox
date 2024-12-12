// ignore_for_file: unnecessary_this, depend_on_referenced_packages
import 'package:intl/intl.dart';

extension StringExtension on String {
  String toTitleCase1() {
    int length = this.split(" ").length;
    int index = 0;
    return length > 1
        ? "${this.split(" ")[index][index].toUpperCase()}${this.split(" ")[index].substring(1).toLowerCase()} ${index + 1 < length ? '${this.split(" ")[index + 1][0].toUpperCase()}${this.split(" ")[index + 1].substring(1).toLowerCase()}' : ''} ${index + 2 < length ? '${this.split(" ")[index + 2][0].toUpperCase()}${this.split(" ")[index + 2].substring(1).toLowerCase()}' : ''} ${index + 3 < length ? '${this.split(" ")[index + 3][0].toUpperCase()}${this.split(" ")[index + 3].substring(1).toLowerCase()}' : ''} ${index + 4 < length ? '${this.split(" ")[index + 4][0].toUpperCase()}${this.split(" ")[index + 4].substring(1).toLowerCase()}' : ''} ${index + 5 < length ? '${this.split(" ")[index + 5][0].toUpperCase()}${this.split(" ")[index + 5].substring(1).toLowerCase()}' : ''} ${index + 6 < length ? '${this.split(" ")[index + 6][0].toUpperCase()}${this.split(" ")[index + 6].substring(1).toLowerCase()}' : ''} ${index + 7 < length ? '${this.split(" ")[index + 7][0].toUpperCase()}${this.split(" ")[index + 7].substring(1).toLowerCase()}' : ''}"
        : "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String toTitleCase2() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String separateByComma() {
    var formatter = NumberFormat('#,###,000');
    return formatter.format(this);
  }

  String toSpacedStrings() {
    int length = this.split("_").length;
    int index = 0;
    return length > 5
        ? "${this.split("_")[index]} ${this.split("_")[1]} ${this.split("_")[2]} ${this.split("_")[3]} ${this.split("_")[4]} ${this.split("_")[5]}"
        : length > 4
            ? "${this.split("_")[index]} ${this.split("_")[1]} ${this.split("_")[2]} ${this.split("_")[3]} ${this.split("_")[4]}"
            : length > 3
                ? "${this.split("_")[index]} ${this.split("_")[1]} ${this.split("_")[2]} ${this.split("_")[3]}"
                : length > 2
                    ? "${this.split("_")[0]} ${this.split("_")[1]} ${this.split("_")[2]}"
                    : length > 1
                        ? "${this.split("_")[0]} ${this.split("_")[1]}"
                        : this.split("_")[index];
  }

  String toUnderscoreStrings() {
    int length = this.split(" ").length;
    int index = 0;
    return length > 5
        ? "${this.split(" ")[index]}_${this.split(" ")[1]}_${this.split(" ")[2]}_${this.split(" ")[3]}_${this.split(" ")[4]}_${this.split(" ")[5]}"
        : length > 4
            ? "${this.split(" ")[index]}_${this.split(" ")[1]}_${this.split(" ")[2]}_${this.split(" ")[3]}_${this.split(" ")[4]}"
            : length > 3
                ? "${this.split(" ")[index]}_${this.split(" ")[1]}_${this.split(" ")[2]}_${this.split(" ")[3]}"
                : length > 2
                    ? "${this.split(" ")[0]}_${this.split(" ")[1]}_${this.split(" ")[2]}"
                    : length > 1
                        ? "${this.split(" ")[0]}_${this.split(" ")[1]}"
                        : this.split(" ")[index];
  }
}
