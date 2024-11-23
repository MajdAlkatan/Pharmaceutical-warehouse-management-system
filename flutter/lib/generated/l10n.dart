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

  /// `SING IN`
  String get singIn {
    return Intl.message(
      'SING IN',
      name: 'singIn',
      desc: '',
      args: [],
    );
  }

  /// `REGISTER`
  String get regester {
    return Intl.message(
      'REGISTER',
      name: 'regester',
      desc: '',
      args: [],
    );
  }

  /// `forgot your password?`
  String get forgot {
    return Intl.message(
      'forgot your password?',
      name: 'forgot',
      desc: '',
      args: [],
    );
  }

  /// `Dont have an account?`
  String get Dont {
    return Intl.message(
      'Dont have an account?',
      name: 'Dont',
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

  /// `Sphilezed`
  String get sphilezed {
    return Intl.message(
      'Sphilezed',
      name: 'sphilezed',
      desc: '',
      args: [],
    );
  }

  /// `Name of th epharmacy`
  String get pharmacyName {
    return Intl.message(
      'Name of th epharmacy',
      name: 'pharmacyName',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
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

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Already have an`
  String get haveAccount {
    return Intl.message(
      'Already have an',
      name: 'haveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `family Doctor`
  String get appBar {
    return Intl.message(
      'family Doctor',
      name: 'appBar',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
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

  /// `Favorate`
  String get favorate {
    return Intl.message(
      'Favorate',
      name: 'favorate',
      desc: '',
      args: [],
    );
  }

  /// `Dumy`
  String get dumy {
    return Intl.message(
      'Dumy',
      name: 'dumy',
      desc: '',
      args: [],
    );
  }

  /// `logout`
  String get logout {
    return Intl.message(
      'logout',
      name: 'logout',
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

  /// `Order saved successfully.`
  String get orderSaved {
    return Intl.message(
      'Order saved successfully.',
      name: 'orderSaved',
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

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save the order.`
  String get failedsaved {
    return Intl.message(
      'Failed to save the order.',
      name: 'failedsaved',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while saving the order.`
  String get savingError {
    return Intl.message(
      'An error occurred while saving the order.',
      name: 'savingError',
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

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Details Page`
  String get detailsPage {
    return Intl.message(
      'Details Page',
      name: 'detailsPage',
      desc: '',
      args: [],
    );
  }

  /// `The Scientific name`
  String get scientificName {
    return Intl.message(
      'The Scientific name',
      name: 'scientificName',
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

  /// `The manufacture company`
  String get manufactureCompany {
    return Intl.message(
      'The manufacture company',
      name: 'manufactureCompany',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `The Price`
  String get thePrice {
    return Intl.message(
      'The Price',
      name: 'thePrice',
      desc: '',
      args: [],
    );
  }

  /// `Expriation date`
  String get expriationDate {
    return Intl.message(
      'Expriation date',
      name: 'expriationDate',
      desc: '',
      args: [],
    );
  }

  /// `Quantity Available`
  String get quantityAvailable {
    return Intl.message(
      'Quantity Available',
      name: 'quantityAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Add To Cart`
  String get addToCart {
    return Intl.message(
      'Add To Cart',
      name: 'addToCart',
      desc: '',
      args: [],
    );
  }

  /// `Bills Page`
  String get billsPage {
    return Intl.message(
      'Bills Page',
      name: 'billsPage',
      desc: '',
      args: [],
    );
  }

  /// `date`
  String get date {
    return Intl.message(
      'date',
      name: 'date',
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

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
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

  /// `Report`
  String get report {
    return Intl.message(
      'Report',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  /// `My Cart`
  String get myCart {
    return Intl.message(
      'My Cart',
      name: 'myCart',
      desc: '',
      args: [],
    );
  }

  /// `No Bills Availabel`
  String get noBillsAvailable {
    return Intl.message(
      'No Bills Availabel',
      name: 'noBillsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `My Favorites`
  String get myFavorites {
    return Intl.message(
      'My Favorites',
      name: 'myFavorites',
      desc: '',
      args: [],
    );
  }

  /// `Failed to Add to Favorites`
  String get failedToAddToFavorites {
    return Intl.message(
      'Failed to Add to Favorites',
      name: 'failedToAddToFavorites',
      desc: '',
      args: [],
    );
  }

  /// `Add to favorites`
  String get addToFavorites {
    return Intl.message(
      'Add to favorites',
      name: 'addToFavorites',
      desc: '',
      args: [],
    );
  }

  /// `My Reports`
  String get myReports {
    return Intl.message(
      'My Reports',
      name: 'myReports',
      desc: '',
      args: [],
    );
  }

  /// `No data available`
  String get noDataAvailable {
    return Intl.message(
      'No data available',
      name: 'noDataAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Medicin Many:`
  String get medicinMany {
    return Intl.message(
      'Medicin Many:',
      name: 'medicinMany',
      desc: '',
      args: [],
    );
  }

  /// `Bills Didnt pay:`
  String get billsDidntK {
    return Intl.message(
      'Bills Didnt pay:',
      name: 'billsDidntK',
      desc: '',
      args: [],
    );
  }

  /// `created At:`
  String get createdAt {
    return Intl.message(
      'created At:',
      name: 'createdAt',
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
