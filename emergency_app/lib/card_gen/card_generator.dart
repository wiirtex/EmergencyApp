import 'package:docx_template/docx_template.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// Card Generator class is used for generating document according to
/// template.
/// Usage: use `setTextValue` and `setCheckboxValue` for changing inputs
/// (text field is empty string and checkbox is unchecked by default)
/// Then use `generate` method to get a bytearray of word .docx file
/// and then save it either your own way or use `saveDocument` to save it in
/// the app directory.
class CardGenerator {
  static final CardGenerator _generator = CardGenerator._internal();

  factory CardGenerator() {
    return _generator;
  }

  // Key Map for storing values for text input elements
  static final  _textKeyMap = Map<TextFieldKey, String>();

  // Key Map for storing values for checkbox input elements
  static final  _checkboxKeyMap = Map<CheckBoxFieldKey, bool>();

  // Set the value for corresponding text field key
  void setTextValue(TextFieldKey fieldKey, String value) {
    _textKeyMap[fieldKey] = value;
  }

  // Set the value for corresponding checkbox field key
  void setCheckboxValue(CheckBoxFieldKey fieldKey, bool value) {
    _checkboxKeyMap[fieldKey] = value;
  }

  // Symbol for checked checkboxes
  static const String CHECKBOX_CHECKED = "☒";

  // Symbol for unchecked checkboxes
  static const String CHECKBOX_UNCHECKED = "☐";

  /// Generates a Byte Array for the document with all
  /// fields filled according to provided values.
  /// Fill 'Checkbox' fields with corresponding CHECKBOX_CHECKED and
  /// CHECKBOX_UNCHECKED symbols
  Future<List<int>> generate() async {
    // Loading document template
    final docx = await DocumentLoader.loadDocx('assets/docs/templates/Template_Controlled_Full.docx');

    // Creating Content Object
    Content c = Content();

    // Injecting text values
    for (final e in _textKeyMap.entries) {
      c.add(TextContent(e.key.toString().substring(13), e.value));
    }

    // Injecting checkbox values
    for (final e in _checkboxKeyMap.entries) {
      c.add(TextContent(e.key.toString().substring(17), e.value ? CHECKBOX_CHECKED : CHECKBOX_UNCHECKED));
    }
    return docx.generate(c);
  }

  Future<File> saveDocument(List<int> bytes) async {
    final file = await _createFile();
    file.writeAsBytes(bytes);
  }

  /// Getting an application path via path provider
  /// Corresponding location will be data/com.tsaplyadmitriy.emergency_app/ ...
  Future<String> _getPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  /// Method creates file for writing generated bytearray
  /// The name of the corresponding file is just a timestamp that corresponds
  /// to the moment it was created
  Future<File> _createFile() async {
    final path = await _getPath();
    final file = File('$path/generated/' + DateTime
        .now()
        .millisecondsSinceEpoch
        .toString() + '.docx');
    if (await file.exists()) {
      return file;
    } else {
      return new File('$path/generated/' + DateTime
          .now()
          .millisecondsSinceEpoch
          .toString() + '.docx').create(recursive: true);
    }
  }

  // Singleton initializer
  CardGenerator._internal(){

    /// Initializing all fieldы: checkboxes with an empty unicode box,
    /// text with an empty string
    for (final key in TextFieldKey.values) {
      _textKeyMap[key] = "FILLED";
    }
    for (final key in CheckBoxFieldKey.values) {
      _checkboxKeyMap[key] = false;
    }
    // **************************************************************

    print("Singleton have been created");
  }
}

// Class for loading .docx documents from assets folder
class DocumentLoader {
  /// Major function for loading .docx file from
  /// provided `filepath`
  static Future<DocxTemplate> loadDocx(String filepath) async {
    final loaded = await rootBundle.load(filepath);
    final buffer = loaded.buffer.asUint8List(loaded.offsetInBytes, loaded.lengthInBytes);
    return await DocxTemplate.fromBytes(buffer);
  }
}

// Available checkbox keys
enum CheckBoxFieldKey {
  SECTION_6_CHECKBOX_1,
  SECTION_6_CHECKBOX_2,
  SECTION_10_CHECKBOX_1,
  SECTION_10_CHECKBOX_2,
  SECTION_10_CHECKBOX_3,
  SECTION_10_CHECKBOX_4,
  SECTION_11_CHECKBOX_1,
  SECTION_11_CHECKBOX_2,
  SECTION_11_CHECKBOX_3,
  SECTION_11_CHECKBOX_4,
  SECTION_11_CHECKBOX_5,
  SECTION_11_CHECKBOX_6,
  SECTION_11_CHECKBOX_7,
  SECTION_11_CHECKBOX_8,
  SECTION_11_CHECKBOX_9,
  SECTION_11_CHECKBOX_10,
  SECTION_11_CHECKBOX_11,
  SECTION_12_CHECKBOX_1,
  SECTION_12_CHECKBOX_2,
  SECTION_12_CHECKBOX_3,
  SECTION_12_CHECKBOX_4,
  SECTION_12_CHECKBOX_5,
  SECTION_12_CHECKBOX_6,
  SECTION_12_CHECKBOX_7,
  SECTION_12_CHECKBOX_8,
  SECTION_13_CHECKBOX_1,
  SECTION_13_CHECKBOX_2,
  SECTION_13_CHECKBOX_3,
  SECTION_14_CHECKBOX_1,
  SECTION_14_CHECKBOX_2,
  SECTION_14_CHECKBOX_3,
  SECTION_15_CHECKBOX_1,
  SECTION_15_CHECKBOX_2,
  SECTION_15_CHECKBOX_3,
  SECTION_15_CHECKBOX_4,
  SECTION_15_CHECKBOX_5,
  SECTION_16_CHECKBOX_1,
  SECTION_16_CHECKBOX_2,
  SECTION_16_CHECKBOX_3,
  SECTION_16_CHECKBOX_4,
  SECTION_16_CHECKBOX_5,
  SECTION_17_CHECKBOX_1,
  SECTION_17_CHECKBOX_2,
  SECTION_17_CHECKBOX_3,
  SECTION_17_CHECKBOX_4,
  SECTION_17_CHECKBOX_5,
  SECTION_17_CHECKBOX_6,
  SECTION_17_CHECKBOX_7,
  SECTION_17_CHECKBOX_8,
  SECTION_17_CHECKBOX_9,
  SECTION_18_CHECKBOX_1,
  SECTION_18_CHECKBOX_2,
  SECTION_18_CHECKBOX_3,
  SECTION_18_CHECKBOX_4,
  SECTION_18_CHECKBOX_5,
  SECTION_18_CHECKBOX_6,
  SECTION_18_CHECKBOX_7,
  SECTION_18_CHECKBOX_8,
  SECTION_18_CHECKBOX_9,
  SECTION_18_CHECKBOX_10,
  SECTION_18_CHECKBOX_11,
  SECTION_19_CHECKBOX_1,
  SECTION_19_CHECKBOX_2,
  SECTION_22_SUBSECTION_1_CHECKBOX_1,
  SECTION_22_SUBSECTION_1_CHECKBOX_2,
  SECTION_22_SUBSECTION_1_CHECKBOX_3,
  SECTION_22_SUBSECTION_1_CHECKBOX_4,
  SECTION_22_SUBSECTION_1_CHECKBOX_5,
  SECTION_22_SUBSECTION_1_CHECKBOX_6,
  SECTION_22_SUBSECTION_2_CHECKBOX_1,
  SECTION_22_SUBSECTION_2_CHECKBOX_2,
  SECTION_22_SUBSECTION_2_CHECKBOX_3,
  SECTION_22_SUBSECTION_2_CHECKBOX_4,
  SECTION_22_SUBSECTION_3_CHECKBOX_1,
  SECTION_22_SUBSECTION_3_CHECKBOX_2,
  SECTION_22_SUBSECTION_3_CHECKBOX_3,
  SECTION_22_SUBSECTION_3_CHECKBOX_4,
  SECTION_22_SUBSECTION_3_CHECKBOX_5,
  SECTION_22_SUBSECTION_3_CHECKBOX_6,
  SECTION_22_SUBSECTION_4_CHECKBOX_1,
  SECTION_22_SUBSECTION_4_CHECKBOX_2,
  SECTION_22_SUBSECTION_5_CHECKBOX_1,
  SECTION_22_SUBSECTION_5_CHECKBOX_2,
  SECTION_22_SUBSECTION_5_CHECKBOX_3,
  SECTION_22_SUBSECTION_5_CHECKBOX_4,
  SECTION_22_SUBSECTION_5_CHECKBOX_5,
  SECTION_22_SUBSECTION_5_CHECKBOX_6,
  SECTION_22_SUBSECTION_5_CHECKBOX_7,
  SECTION_22_SUBSECTION_5_CHECKBOX_8,
  SECTION_22_SUBSECTION_5_CHECKBOX_9,
  SECTION_22_SUBSECTION_5_CHECKBOX_10,
  SECTION_22_SUBSECTION_5_CHECKBOX_11,
  SECTION_22_SUBSECTION_5_CHECKBOX_12,
  SECTION_22_SUBSECTION_5_CHECKBOX_13,
  SECTION_22_SUBSECTION_5_CHECKBOX_14,
  SECTION_22_SUBSECTION_5_CHECKBOX_15,
  SECTION_22_SUBSECTION_5_CHECKBOX_16,
  SECTION_22_SUBSECTION_5_CHECKBOX_17,
  SECTION_22_SUBSECTION_5_CHECKBOX_18,
  SECTION_22_SUBSECTION_5_CHECKBOX_19,
  SECTION_22_SUBSECTION_5_CHECKBOX_20,
  SECTION_22_SUBSECTION_5_CHECKBOX_21,
  SECTION_22_SUBSECTION_5_CHECKBOX_22,
  SECTION_22_SUBSECTION_5_CHECKBOX_23,
  SECTION_22_SUBSECTION_5_CHECKBOX_24,
  SECTION_22_SUBSECTION_5_CHECKBOX_25,
  SECTION_22_SUBSECTION_5_CHECKBOX_26,
  SECTION_22_SUBSECTION_5_CHECKBOX_27,
  SECTION_22_SUBSECTION_5_CHECKBOX_28,
  SECTION_22_SUBSECTION_5_CHECKBOX_29,
  SECTION_22_SUBSECTION_5_CHECKBOX_30,
  SECTION_22_SUBSECTION_5_CHECKBOX_31,
  SECTION_22_SUBSECTION_5_CHECKBOX_32,
  SECTION_22_SUBSECTION_5_CHECKBOX_33,
  SECTION_22_SUBSECTION_6_CHECKBOX_1,
  SECTION_22_SUBSECTION_6_CHECKBOX_2,
  SECTION_22_SUBSECTION_6_CHECKBOX_3,
  SECTION_22_SUBSECTION_6_CHECKBOX_4,
  SECTION_22_SUBSECTION_7_CHECKBOX_1,
  SECTION_22_SUBSECTION_7_CHECKBOX_2,
  SECTION_22_SUBSECTION_7_CHECKBOX_3,
  SECTION_22_SUBSECTION_7_CHECKBOX_4,
  SECTION_22_SUBSECTION_8_CHECKBOX_1,
  SECTION_22_SUBSECTION_8_CHECKBOX_2,
  SECTION_22_SUBSECTION_8_CHECKBOX_3,
  SECTION_22_SUBSECTION_8_CHECKBOX_4,
  SECTION_22_SUBSECTION_9_CHECKBOX_1,
  SECTION_22_SUBSECTION_9_CHECKBOX_2,
  SECTION_22_SUBSECTION_9_CHECKBOX_3,
  SECTION_22_SUBSECTION_9_CHECKBOX_4,
  SECTION_22_SUBSECTION_9_CHECKBOX_5,
  SECTION_22_SUBSECTION_10_CHECKBOX_1,
  SECTION_22_SUBSECTION_10_CHECKBOX_2,
  SECTION_22_SUBSECTION_10_CHECKBOX_3,
  SECTION_22_SUBSECTION_10_CHECKBOX_4,
  SECTION_22_SUBSECTION_11_CHECKBOX_1,
  SECTION_22_SUBSECTION_11_CHECKBOX_2,
  SECTION_22_SUBSECTION_12_CHECKBOX_1,
  SECTION_22_SUBSECTION_12_CHECKBOX_2,
  SECTION_22_SUBSECTION_12_CHECKBOX_3,
  SECTION_22_SUBSECTION_12_CHECKBOX_4,
  SECTION_22_SUBSECTION_12_CHECKBOX_5,
  SECTION_22_SUBSECTION_12_CHECKBOX_6,
  SECTION_22_SUBSECTION_12_CHECKBOX_7,
  SECTION_22_SUBSECTION_12_CHECKBOX_8,
  SECTION_22_SUBSECTION_12_CHECKBOX_9,
  SECTION_22_SUBSECTION_13_CHECKBOX_1,
  SECTION_22_SUBSECTION_13_CHECKBOX_2,
  SECTION_22_SUBSECTION_14_CHECKBOX_1,
  SECTION_22_SUBSECTION_14_CHECKBOX_2,
  SECTION_22_SUBSECTION_15_CHECKBOX_1,
  SECTION_22_SUBSECTION_15_CHECKBOX_2,
  SECTION_22_SUBSECTION_16_CHECKBOX_1,
  SECTION_22_SUBSECTION_16_CHECKBOX_2,
  SECTION_22_SUBSECTION_16_CHECKBOX_3,
  SECTION_22_SUBSECTION_16_CHECKBOX_4,
  SECTION_22_SUBSECTION_16_CHECKBOX_5,
  SECTION_22_SUBSECTION_16_CHECKBOX_6,
  SECTION_22_SUBSECTION_16_CHECKBOX_7,
  SECTION_22_SUBSECTION_17_CHECKBOX_1,
  SECTION_22_SUBSECTION_17_CHECKBOX_2,
  SECTION_22_SUBSECTION_17_CHECKBOX_3,
  SECTION_22_SUBSECTION_18_CHECKBOX_1,
  SECTION_22_SUBSECTION_18_CHECKBOX_2,
  SECTION_22_SUBSECTION_18_CHECKBOX_3,
  SECTION_22_SUBSECTION_18_CHECKBOX_4,
  SECTION_22_SUBSECTION_19_CHECKBOX_1,
  SECTION_22_SUBSECTION_19_CHECKBOX_2,
  SECTION_22_SUBSECTION_19_CHECKBOX_3,
  SECTION_22_SUBSECTION_19_CHECKBOX_4,
  SECTION_22_SUBSECTION_19_CHECKBOX_5,
  SECTION_22_SUBSECTION_20_CHECKBOX_1,
  SECTION_22_SUBSECTION_20_CHECKBOX_2,
  SECTION_22_SUBSECTION_20_CHECKBOX_3,
  SECTION_22_SUBSECTION_21_CHECKBOX_1,
  SECTION_22_SUBSECTION_21_CHECKBOX_2,
  SECTION_22_SUBSECTION_21_CHECKBOX_3,
  SECTION_22_SUBSECTION_21_CHECKBOX_4,
  SECTION_22_SUBSECTION_21_CHECKBOX_5,
  SECTION_22_SUBSECTION_21_CHECKBOX_6,
  SECTION_22_SUBSECTION_21_CHECKBOX_7,
  SECTION_22_SUBSECTION_22_CHECKBOX_1,
  SECTION_22_SUBSECTION_22_CHECKBOX_2,
  SECTION_22_SUBSECTION_22_CHECKBOX_3,
  SECTION_22_SUBSECTION_22_CHECKBOX_4,
  SECTION_22_SUBSECTION_23_CHECKBOX_1,
  SECTION_22_SUBSECTION_23_CHECKBOX_2,
  SECTION_22_SUBSECTION_23_CHECKBOX_3,
  SECTION_22_SUBSECTION_23_CHECKBOX_4,
  SECTION_22_SUBSECTION_24_CHECKBOX_1,
  SECTION_22_SUBSECTION_24_CHECKBOX_2,
  SECTION_22_SUBSECTION_24_CHECKBOX_3,
  SECTION_22_SUBSECTION_24_CHECKBOX_4,
  SECTION_22_SUBSECTION_24_CHECKBOX_5,
  SECTION_22_SUBSECTION_33_CHECKBOX_1,
  SECTION_22_SUBSECTION_33_CHECKBOX_2,
  SECTION_22_SUBSECTION_33_CHECKBOX_3,
  SECTION_22_SUBSECTION_33_CHECKBOX_4,
  SECTION_22_SUBSECTION_33_CHECKBOX_5,
  SECTION_22_SUBSECTION_33_CHECKBOX_6,
  SECTION_22_SUBSECTION_33_CHECKBOX_7,
  SECTION_22_SUBSECTION_33_CHECKBOX_8,
  SECTION_22_SUBSECTION_33_CHECKBOX_9,
  SECTION_22_SUBSECTION_33_CHECKBOX_10,
  SECTION_22_SUBSECTION_33_CHECKBOX_11,
  SECTION_22_SUBSECTION_33_CHECKBOX_12,
  SECTION_22_SUBSECTION_34_CHECKBOX_1,
  SECTION_22_SUBSECTION_34_CHECKBOX_2,
  SECTION_22_SUBSECTION_35_CHECKBOX_1,
  SECTION_22_SUBSECTION_35_CHECKBOX_2,
  SECTION_24_CHECKBOX_1,
  SECTION_24_CHECKBOX_2,
  SECTION_24_CHECKBOX_3,
  SECTION_24_CHECKBOX_4,
  SECTION_24_CHECKBOX_5,
  SECTION_24_CHECKBOX_6,
  SECTION_24_CHECKBOX_7,
  SECTION_24_CHECKBOX_8,
  SECTION_24_CHECKBOX_9,
  SECTION_24_CHECKBOX_10,
  SECTION_24_CHECKBOX_11,
  SECTION_24_CHECKBOX_12,
  SECTION_24_CHECKBOX_13,
  SECTION_24_CHECKBOX_14,
  SECTION_24_CHECKBOX_15,
  SECTION_24_CHECKBOX_16,
  SECTION_24_CHECKBOX_17,
  SECTION_24_CHECKBOX_18,
  SECTION_24_CHECKBOX_19,
  SECTION_24_CHECKBOX_20,
  SECTION_25_CHECKBOX_1,
  SECTION_25_CHECKBOX_2,
  SECTION_25_CHECKBOX_3,
  SECTION_26_CHECKBOX_1,
  SECTION_26_CHECKBOX_2,
  SECTION_26_CHECKBOX_3,
  SECTION_26_CHECKBOX_4,
  SECTION_26_CHECKBOX_5,
  SECTION_26_CHECKBOX_6,
  SECTION_26_CHECKBOX_7,
  SECTION_26_CHECKBOX_8,
  SECTION_26_CHECKBOX_9,
  SECTION_26_CHECKBOX_10,
  SECTION_26_CHECKBOX_11,
  SECTION_27_CHECKBOX_1,
  SECTION_27_CHECKBOX_2,
  SECTION_27_CHECKBOX_3,
  SECTION_27_CHECKBOX_4,
  SECTION_27_CHECKBOX_5,
  SECTION_27_CHECKBOX_6,
  SECTION_27_CHECKBOX_7,
  SECTION_27_CHECKBOX_8,
  SECTION_27_CHECKBOX_9,
  SECTION_27_CHECKBOX_10,
  SECTION_27_CHECKBOX_11,
  SECTION_32_CHECKBOX_1,
  SECTION_32_CHECKBOX_2,
  SECTION_32_CHECKBOX_3,
  SECTION_33_CHECKBOX_1,
  SECTION_33_CHECKBOX_2,
  SECTION_33_CHECKBOX_3,
  SECTION_34_CHECKBOX_1,
  SECTION_34_CHECKBOX_2,
  SECTION_34_CHECKBOX_3,
  SECTION_34_CHECKBOX_4,
  SECTION_35_SUBSECTION_1_CHECKBOX_1,
  SECTION_35_SUBSECTION_2_CHECKBOX_1,
  SECTION_35_SUBSECTION_3_CHECKBOX_1,
  SECTION_35_SUBSECTION_4_CHECKBOX_1,
  SECTION_35_SUBSECTION_6_CHECKBOX_1,
  SECTION_35_SUBSECTION_7_CHECKBOX_1,
  SECTION_35_SUBSECTION_8_CHECKBOX_1,
  SECTION_35_SUBSECTION_9_CHECKBOX_1,
  SECTION_35_SUBSECTION_9_CHECKBOX_2,
  SECTION_35_SUBSECTION_9_CHECKBOX_3,
  SECTION_35_SUBSECTION_10_CHECKBOX_1,
  SECTION_35_SUBSECTION_10_CHECKBOX_2,
  SECTION_35_SUBSECTION_11_CHECKBOX_1,
  SECTION_35_SUBSECTION_11_CHECKBOX_2,
  SECTION_35_SUBSECTION_11_CHECKBOX_3,
  SECTION_35_SUBSECTION_12_CHECKBOX_1,

}

// Available text keys
enum TextFieldKey{
  SECTION_0_TEXT_1,
  SECTION_1_TEXT_1,
  SECTION_2_TEXT_1,
  SECTION_3_TEXT_1,
  SECTION_4_TEXT_1,
  SECTION_4_TEXT_2,
  SECTION_4_TEXT_3,
  SECTION_4_TEXT_4,
  SECTION_4_TEXT_5,
  SECTION_4_TEXT_6,
  SECTION_4_TEXT_7,
  SECTION_4_TEXT_8,
  SECTION_4_TEXT_9,
  SECTION_4_TEXT_10,
  SECTION_4_TEXT_11,
  SECTION_4_TEXT_12,
  SECTION_5_TEXT_1,
  SECTION_5_TEXT_2,
  SECTION_5_TEXT_3,
  SECTION_5_TEXT_4,
  SECTION_5_TEXT_5,
  SECTION_5_TEXT_6,
  SECTION_6_TEXT_1,
  SECTION_6_TEXT_2,
  SECTION_6_TEXT_3,
  SECTION_6_TEXT_4,
  SECTION_6_TEXT_5,
  SECTION_6_TEXT_6,
  SECTION_6_TEXT_7,
  SECTION_6_TEXT_8,
  SECTION_6_TEXT_9,
  SECTION_6_TEXT_10,
  SECTION_7_TEXT_1,
  SECTION_7_TEXT_2,
  SECTION_8_TEXT_1,
  SECTION_9_TEXT_1,
  SECTION_10_TEXT_1,
  SECTION_10_TEXT_2,
  SECTION_11_TEXT_1,
  SECTION_12_TEXT_1,
  SECTION_15_TEXT_1,
  SECTION_16_TEXT_1,
  SECTION_16_TEXT_2,
  SECTION_16_TEXT_3,
  SECTION_16_TEXT_4,
  SECTION_16_TEXT_5,
  SECTION_17_TEXT_1,
  SECTION_18_TEXT_1,
  SECTION_20_TEXT_1,
  SECTION_20_TEXT_2,
  SECTION_21_TEXT_1,
  SECTION_21_TEXT_2,
  SECTION_21_TEXT_3,
  SECTION_22_SUBSECTION_1_TEXT_1,
  SECTION_22_SUBSECTION_3_TEXT_1,
  SECTION_22_SUBSECTION_6_TEXT_1,
  SECTION_22_SUBSECTION_7_TEXT_1,
  SECTION_22_SUBSECTION_8_TEXT_1,
  SECTION_22_SUBSECTION_9_TEXT_1,
  SECTION_22_SUBSECTION_14_TEXT_1,
  SECTION_22_SUBSECTION_15_TEXT_1,
  SECTION_22_SUBSECTION_16_TEXT_1,
  SECTION_22_SUBSECTION_17_TEXT_1,
  SECTION_22_SUBSECTION_20_TEXT_1,
  SECTION_22_SUBSECTION_21_TEXT_1,
  SECTION_22_SUBSECTION_22_TEXT_1,
  SECTION_22_SUBSECTION_24_TEXT_1,
  SECTION_22_SUBSECTION_24_TEXT_2,
  SECTION_22_SUBSECTION_25_TEXT_1,
  SECTION_22_SUBSECTION_26_TEXT_1,
  SECTION_22_SUBSECTION_27_TEXT_1,
  SECTION_22_SUBSECTION_28_TEXT_1,
  SECTION_22_SUBSECTION_29_TEXT_1,
  SECTION_22_SUBSECTION_30_TEXT_1,
  SECTION_22_SUBSECTION_31_TEXT_1,
  SECTION_22_SUBSECTION_32_TEXT_1,
  SECTION_22_SUBSECTION_33_TEXT_1,
  SECTION_22_SUBSECTION_33_TEXT_2,
  SECTION_22_SUBSECTION_34_TEXT_1,
  SECTION_22_SUBSECTION_35_TEXT_1,
  SECTION_22_SUBSECTION_36_TEXT_1,
  SECTION_22_SUBSECTION_37_TEXT_1,
  SECTION_23_SUBSECTION_1_TEXT_1,
  SECTION_23_SUBSECTION_1_TEXT_2,
  SECTION_23_SUBSECTION_1_TEXT_3,
  SECTION_23_SUBSECTION_2_TEXT_1,
  SECTION_23_SUBSECTION_2_TEXT_2,
  SECTION_23_SUBSECTION_2_TEXT_3,
  SECTION_23_SUBSECTION_2_TEXT_4,
  SECTION_23_SUBSECTION_2_TEXT_5,
  SECTION_23_SUBSECTION_2_TEXT_6,
  SECTION_23_SUBSECTION_2_TEXT_7,
  SECTION_23_SUBSECTION_2_TEXT_8,
  SECTION_23_SUBSECTION_2_TEXT_9,
  SECTION_23_SUBSECTION_2_TEXT_10,
  SECTION_23_SUBSECTION_2_TEXT_11,
  SECTION_23_SUBSECTION_2_TEXT_12,
  SECTION_23_SUBSECTION_2_TEXT_13,
  SECTION_23_SUBSECTION_2_TEXT_14,
  SECTION_23_SUBSECTION_2_TEXT_15,
  SECTION_23_SUBSECTION_2_TEXT_16,
  SECTION_23_SUBSECTION_2_TEXT_17,
  SECTION_23_SUBSECTION_2_TEXT_18,
  SECTION_23_SUBSECTION_2_TEXT_19,
  SECTION_23_SUBSECTION_2_TEXT_20,
  SECTION_23_SUBSECTION_2_TEXT_21,
  SECTION_23_SUBSECTION_2_TEXT_22,
  SECTION_23_SUBSECTION_2_TEXT_23,
  SECTION_23_SUBSECTION_2_TEXT_24,
  SECTION_23_SUBSECTION_2_TEXT_25,
  SECTION_23_SUBSECTION_2_TEXT_26,
  SECTION_23_SUBSECTION_2_TEXT_27,
  SECTION_23_SUBSECTION_2_TEXT_28,
  SECTION_23_SUBSECTION_2_TEXT_29,
  SECTION_23_SUBSECTION_2_TEXT_30,
  SECTION_23_SUBSECTION_2_TEXT_31,
  SECTION_23_SUBSECTION_2_TEXT_32,
  SECTION_23_SUBSECTION_2_TEXT_33,
  SECTION_24_TEXT_1,
  SECTION_26_TEXT_1,
  SECTION_27_TEXT_1,
  SECTION_28_TEXT_1,
  SECTION_28_TEXT_2,
  SECTION_28_TEXT_3,
  SECTION_28_TEXT_4,
  SECTION_28_TEXT_5,
  SECTION_28_TEXT_6,
  SECTION_28_TEXT_7,
  SECTION_29_TEXT_1,
  SECTION_30_TEXT_1,
  SECTION_30_TEXT_2,
  SECTION_31_TEXT_1,
  SECTION_31_TEXT_2,
  SECTION_32_TEXT_1,
  SECTION_33_TEXT_1,
  SECTION_33_TEXT_2,
  SECTION_33_TEXT_3,
  SECTION_35_SUBSECTION_2_TEXT_1,
  SECTION_35_SUBSECTION_2_TEXT_2,
  SECTION_35_SUBSECTION_3_TEXT_1,
  SECTION_35_SUBSECTION_4_TEXT_1,
  SECTION_35_SUBSECTION_4_TEXT_2,
  SECTION_35_SUBSECTION_5_TEXT_1,
  SECTION_35_SUBSECTION_6_TEXT_1,
  SECTION_35_SUBSECTION_7_TEXT_1,
  SECTION_35_SUBSECTION_8_TEXT_1,
  SECTION_35_SUBSECTION_10_TEXT_1,
  SECTION_36_TEXT_1,
  SECTION_37_TEXT_1,
  SECTION_38_TEXT_1,
  SECTION_38_TEXT_2,
  SECTION_38_TEXT_3,
  SECTION_38_TEXT_4,
  SECTION_38_TEXT_5,
  SECTION_38_TEXT_6,
}