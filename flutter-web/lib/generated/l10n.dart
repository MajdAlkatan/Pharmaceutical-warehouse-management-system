// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome Back...`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back...',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Login To Continue`
  String get loginToContinue {
    return Intl.message(
      'Login To Continue',
      name: 'loginToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Number`
  String get number {
    return Intl.message(
      'Number',
      name: 'number',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `LOGIN`
  String get login {
    return Intl.message(
      'LOGIN',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Put Midicen`
  String get putMidicen {
    return Intl.message(
      'Put Midicen',
      name: 'putMidicen',
      desc: '',
      args: [],
    );
  }

  /// `Section Name`
  String get sectionName {
    return Intl.message(
      'Section Name',
      name: 'sectionName',
      desc: '',
      args: [],
    );
  }

  /// `Section Image`
  String get sectionImage {
    return Intl.message(
      'Section Image',
      name: 'sectionImage',
      desc: '',
      args: [],
    );
  }

  /// `Update Section`
  String get updateSection {
    return Intl.message(
      'Update Section',
      name: 'updateSection',
      desc: '',
      args: [],
    );
  }

  /// `Dialog Title`
  String get dialogTitle {
    return Intl.message(
      'Dialog Title',
      name: 'dialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Dialog Description`
  String get dialogDescription {
    return Intl.message(
      'Dialog Description',
      name: 'dialogDescription',
      desc: '',
      args: [],
    );
  }

  /// `Okay`
  String get okay {
    return Intl.message(
      'Okay',
      name: 'okay',
      desc: '',
      args: [],
    );
  }

  /// `Put Section`
  String get putSection {
    return Intl.message(
      'Put Section',
      name: 'putSection',
      desc: '',
      args: [],
    );
  }

  /// `Trade Name`
  String get tradeName {
    return Intl.message(
      'Trade Name',
      name: 'tradeName',
      desc: '',
      args: [],
    );
  }

  /// `Sientific Name`
  String get sientificName {
    return Intl.message(
      'Sientific Name',
      name: 'sientificName',
      desc: '',
      args: [],
    );
  }

  /// `Manufacture Name`
  String get manufactureName {
    return Intl.message(
      'Manufacture Name',
      name: 'manufactureName',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Expiration`
  String get expiration {
    return Intl.message(
      'Expiration',
      name: 'expiration',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Image`
  String get image {
    return Intl.message(
      'Image',
      name: 'image',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `In preparation`
  String get inPreparation {
    return Intl.message(
      'In preparation',
      name: 'inPreparation',
      desc: '',
      args: [],
    );
  }

  /// `Has been sent`
  String get hasBeenSent {
    return Intl.message(
      'Has been sent',
      name: 'hasBeenSent',
      desc: '',
      args: [],
    );
  }

  /// `It was received`
  String get itWasReceived {
    return Intl.message(
      'It was received',
      name: 'itWasReceived',
      desc: '',
      args: [],
    );
  }

  /// `Date:`
  String get date {
    return Intl.message(
      'Date:',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `?`
  String get question {
    return Intl.message(
      '?',
      name: 'question',
      desc: '',
      args: [],
    );
  }

  /// `Change State:`
  String get changeState {
    return Intl.message(
      'Change State:',
      name: 'changeState',
      desc: '',
      args: [],
    );
  }

  /// `Change the state of bill :`
  String get changeTheStateOfBill {
    return Intl.message(
      'Change the state of bill :',
      name: 'changeTheStateOfBill',
      desc: '',
      args: [],
    );
  }

  /// `Cant update the state`
  String get cantUpdateTheState {
    return Intl.message(
      'Cant update the state',
      name: 'cantUpdateTheState',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Medicine Name`
  String get medicineName {
    return Intl.message(
      'Medicine Name',
      name: 'medicineName',
      desc: '',
      args: [],
    );
  }

  /// `Total:`
  String get total {
    return Intl.message(
      'Total:',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Admin Name`
  String get adminName {
    return Intl.message(
      'Admin Name',
      name: 'adminName',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Bills`
  String get bills {
    return Intl.message(
      'Bills',
      name: 'bills',
      desc: '',
      args: [],
    );
  }

  /// `Reports`
  String get reprots {
    return Intl.message(
      'Reports',
      name: 'reprots',
      desc: '',
      args: [],
    );
  }

  /// `Users`
  String get users {
    return Intl.message(
      'Users',
      name: 'users',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Sing Out`
  String get singOut {
    return Intl.message(
      'Sing Out',
      name: 'singOut',
      desc: '',
      args: [],
    );
  }

  /// `Reborts:`
  String get Reborts {
    return Intl.message(
      'Reborts:',
      name: 'Reborts',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get userName {
    return Intl.message(
      'User Name',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `qazswsx cqaswdefrgthyjukilo;p'[zaxscdvfbgnhjm,kl.;/qswdefrgthyjukilo;p[/'.`
  String get rebort {
    return Intl.message(
      'qazswsx cqaswdefrgthyjukilo;p\'[zaxscdvfbgnhjm,kl.;/qswdefrgthyjukilo;p[/\'.',
      name: 'rebort',
      desc: '',
      args: [],
    );
  }

  /// `The payment was made`
  String get thePaymentWasMade {
    return Intl.message(
      'The payment was made',
      name: 'thePaymentWasMade',
      desc: '',
      args: [],
    );
  }

  /// `Payment has not been made`
  String get paymentHasNotBeenMade {
    return Intl.message(
      'Payment has not been made',
      name: 'paymentHasNotBeenMade',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Medicine added successfully.`
  String get medicineAddedSuccessfully {
    return Intl.message(
      'Medicine added successfully.',
      name: 'medicineAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Failed to add medicine.`
  String get failedToAddMedicine {
    return Intl.message(
      'Failed to add medicine.',
      name: 'failedToAddMedicine',
      desc: '',
      args: [],
    );
  }

  /// `Report number:`
  String get reportNumber {
    return Intl.message(
      'Report number:',
      name: 'reportNumber',
      desc: '',
      args: [],
    );
  }

  /// `The best selling medicine:`
  String get medicineId {
    return Intl.message(
      'The best selling medicine:',
      name: 'medicineId',
      desc: '',
      args: [],
    );
  }

  /// `The most interactive user:`
  String get userId {
    return Intl.message(
      'The most interactive user:',
      name: 'userId',
      desc: '',
      args: [],
    );
  }

  /// `The most section purchased from it :`
  String get sectionId {
    return Intl.message(
      'The most section purchased from it :',
      name: 'sectionId',
      desc: '',
      args: [],
    );
  }

  /// `Quantity of medicine sold :`
  String get medicineMany {
    return Intl.message(
      'Quantity of medicine sold :',
      name: 'medicineMany',
      desc: '',
      args: [],
    );
  }

  /// `Unpaid bills :`
  String get billsDidntK {
    return Intl.message(
      'Unpaid bills :',
      name: 'billsDidntK',
      desc: '',
      args: [],
    );
  }

  /// `The average time that bills spend it :`
  String get time {
    return Intl.message(
      'The average time that bills spend it :',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Created At:`
  String get createdAt {
    return Intl.message(
      'Created At:',
      name: 'createdAt',
      desc: '',
      args: [],
    );
  }

  /// `Updated At:`
  String get updatedAt {
    return Intl.message(
      'Updated At:',
      name: 'updatedAt',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
