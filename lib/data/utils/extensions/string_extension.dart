import 'dart:io';

import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html_parser;
import 'package:path/path.dart' as path;

import '../utils.dart';

extension StringExt on String {
  String replacePercentage(int newPercentage) {
    return replaceAll('{percentage}', '$newPercentage%');
  }

  String sanitizeHtml() {
    // Parse the HTML string
    dom.Document document = html_parser.parse(this);

    // Convert <br> tags to newline
    document.querySelectorAll('br').forEach((element) {
      element.replaceWith(dom.Text('\n'));
    });

    // Extract the text content
    String sanitizedText = document.body?.text ?? '';

    return sanitizedText;
  }

  String getFutureDate(String daysToAdd) {
    if (daysToAdd.isEmpty || int.tryParse(daysToAdd) == null) {
      throw FormatException('Invalid input for days');
    }

    final now = DateTime.now();
    final futureDate = now.add(Duration(days: int.parse(daysToAdd)));

    final monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    final month = monthNames[futureDate.month - 1];
    final day = futureDate.day;
    final year = futureDate.year;

    return '$month $day, $year';
  }

  String get compactFileName {
    final fileName = path.basename(this);
    if (fileName.length > 20) {
      /// the format result is filenam..ename.jpg
      final split = fileName.split('.');
      final name = split.first;
      final ext = split.last;
      return '${name.substring(0, 10)}..${name.substring(name.length - 5)}.$ext';
    }
    return fileName;
  }

  String get fileSize {
    final File file = File(this);
    final size = file.lengthSync();
    return formatBytes(size, 1);
  }

  String sentenceCase() {
    if (isEmpty) {
      return this;
    }

    // Split the string into sentences
    List<String> sentences = split(RegExp(r'(?<=[.!?])\s+'));

    // Capitalize the first letter of each sentence
    List<String> capitalizedSentences = sentences.map((sentence) {
      if (sentence.isEmpty) {
        return sentence;
      }
      return sentence[0].toUpperCase() + sentence.substring(1).toLowerCase();
    }).toList();

    // Join the sentences back together
    return capitalizedSentences.join(' ');
  }
}
