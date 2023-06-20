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

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Activities`
  String get activities {
    return Intl.message(
      'Activities',
      name: 'activities',
      desc: '',
      args: [],
    );
  }

  /// `Activity`
  String get activity {
    return Intl.message(
      'Activity',
      name: 'activity',
      desc: '',
      args: [],
    );
  }

  /// `Activity calendar`
  String get activityCalendar {
    return Intl.message(
      'Activity calendar',
      name: 'activityCalendar',
      desc: '',
      args: [],
    );
  }

  /// `Registration saved`
  String get activityRegistrationSaved {
    return Intl.message(
      'Registration saved',
      name: 'activityRegistrationSaved',
      desc: '',
      args: [],
    );
  }

  /// `Registering for activity failed`
  String get activityRegistrationFailed {
    return Intl.message(
      'Registering for activity failed',
      name: 'activityRegistrationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Activity recorded`
  String get activityRecorded {
    return Intl.message(
      'Activity recorded',
      name: 'activityRecorded',
      desc: '',
      args: [],
    );
  }

  /// `Visit removed`
  String get visitRemoved {
    return Intl.message(
      'Visit removed',
      name: 'visitRemoved',
      desc: '',
      args: [],
    );
  }

  /// `Account created`
  String get accountCreated {
    return Intl.message(
      'Account created',
      name: 'accountCreated',
      desc: '',
      args: [],
    );
  }

  /// `Account Deletion`
  String get accountDeletion {
    return Intl.message(
      'Account Deletion',
      name: 'accountDeletion',
      desc: '',
      args: [],
    );
  }

  /// `Achievements`
  String get achievements {
    return Intl.message(
      'Achievements',
      name: 'achievements',
      desc: '',
      args: [],
    );
  }

  /// `Activity level`
  String get activityLevel {
    return Intl.message(
      'Activity level',
      name: 'activityLevel',
      desc: '',
      args: [],
    );
  }

  /// `Added to list`
  String get addedToList {
    return Intl.message(
      'Added to list',
      name: 'addedToList',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Are you 13+ years old?`
  String get ageOver13 {
    return Intl.message(
      'Are you 13+ years old?',
      name: 'ageOver13',
      desc: '',
      args: [],
    );
  }

  /// `Answer saved`
  String get answerSaved {
    return Intl.message(
      'Answer saved',
      name: 'answerSaved',
      desc: '',
      args: [],
    );
  }

  /// `FiTeens *DRAFT*`
  String get appName {
    return Intl.message(
      'FiTeens *DRAFT*',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Authenticating ... Please wait`
  String get authenticating {
    return Intl.message(
      'Authenticating ... Please wait',
      name: 'authenticating',
      desc: '',
      args: [],
    );
  }

  /// `Benefits`
  String get benefits {
    return Intl.message(
      'Benefits',
      name: 'benefits',
      desc: '',
      args: [],
    );
  }

  /// `Books`
  String get books {
    return Intl.message(
      'Books',
      name: 'books',
      desc: '',
      args: [],
    );
  }

  /// `Book read`
  String get bookIsRead {
    return Intl.message(
      'Book read',
      name: 'bookIsRead',
      desc: '',
      args: [],
    );
  }

  /// `Book status updated`
  String get bookStatusUpdated {
    return Intl.message(
      'Book status updated',
      name: 'bookStatusUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Availability information`
  String get btnAvailabilityInfo {
    return Intl.message(
      'Availability information',
      name: 'btnAvailabilityInfo',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get btnConfirm {
    return Intl.message(
      'Confirm',
      name: 'btnConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get btnContinue {
    return Intl.message(
      'Continue',
      name: 'btnContinue',
      desc: '',
      args: [],
    );
  }

  /// `Open Dashboard`
  String get btnDashboard {
    return Intl.message(
      'Open Dashboard',
      name: 'btnDashboard',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get btnLogin {
    return Intl.message(
      'Login',
      name: 'btnLogin',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get btnMap {
    return Intl.message(
      'Map',
      name: 'btnMap',
      desc: '',
      args: [],
    );
  }

  /// `Show`
  String get btnShow {
    return Intl.message(
      'Show',
      name: 'btnShow',
      desc: '',
      args: [],
    );
  }

  /// `Read`
  String get btnRead {
    return Intl.message(
      'Read',
      name: 'btnRead',
      desc: '',
      args: [],
    );
  }

  /// `Return`
  String get btnReturn {
    return Intl.message(
      'Return',
      name: 'btnReturn',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get btnSend {
    return Intl.message(
      'Send',
      name: 'btnSend',
      desc: '',
      args: [],
    );
  }

  /// `Set Password`
  String get btnSetNewPassword {
    return Intl.message(
      'Set Password',
      name: 'btnSetNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Return book`
  String get btnReturnBook {
    return Intl.message(
      'Return book',
      name: 'btnReturnBook',
      desc: '',
      args: [],
    );
  }

  /// `Tasks`
  String get btnTasks {
    return Intl.message(
      'Tasks',
      name: 'btnTasks',
      desc: '',
      args: [],
    );
  }

  /// `Use Email`
  String get btnUseEmail {
    return Intl.message(
      'Use Email',
      name: 'btnUseEmail',
      desc: '',
      args: [],
    );
  }

  /// `Use Phone number`
  String get btnUsePhone {
    return Intl.message(
      'Use Phone number',
      name: 'btnUsePhone',
      desc: '',
      args: [],
    );
  }

  /// `Validate contact information now`
  String get btnValidateContact {
    return Intl.message(
      'Validate contact information now',
      name: 'btnValidateContact',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get btnValidateContactLater {
    return Intl.message(
      'Later',
      name: 'btnValidateContactLater',
      desc: '',
      args: [],
    );
  }

  /// `Oh buggers`
  String get buggers {
    return Intl.message(
      'Oh buggers',
      name: 'buggers',
      desc: '',
      args: [],
    );
  }

  /// `Calendar`
  String get calendar {
    return Intl.message(
      'Calendar',
      name: 'calendar',
      desc: '',
      args: [],
    );
  }

  /// `No camera available`
  String get cameraNotAvailable {
    return Intl.message(
      'No camera available',
      name: 'cameraNotAvailable',
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

  /// `You cannot access this station yet`
  String get cannotOpenStation {
    return Intl.message(
      'You cannot access this station yet',
      name: 'cannotOpenStation',
      desc: '',
      args: [],
    );
  }

  /// `Challenging Books`
  String get challengingBooks {
    return Intl.message(
      'Challenging Books',
      name: 'challengingBooks',
      desc: '',
      args: [],
    );
  }

  /// `Choose`
  String get choose {
    return Intl.message(
      'Choose',
      name: 'choose',
      desc: '',
      args: [],
    );
  }

  /// `Choose file`
  String get chooseFile {
    return Intl.message(
      'Choose file',
      name: 'chooseFile',
      desc: '',
      args: [],
    );
  }

  /// `Choose start station`
  String get chooseStartStation {
    return Intl.message(
      'Choose start station',
      name: 'chooseStartStation',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Code scanned`
  String get codeScanned {
    return Intl.message(
      'Code scanned',
      name: 'codeScanned',
      desc: '',
      args: [],
    );
  }

  /// `Code accepted`
  String get codeAccepted {
    return Intl.message(
      'Code accepted',
      name: 'codeAccepted',
      desc: '',
      args: [],
    );
  }

  /// `Confirm user account deletion`
  String get confirmDeletingAccount {
    return Intl.message(
      'Confirm user account deletion',
      name: 'confirmDeletingAccount',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirmPassword {
    return Intl.message(
      'Confirm password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation key`
  String get confirmationKey {
    return Intl.message(
      'Confirmation key',
      name: 'confirmationKey',
      desc: '',
      args: [],
    );
  }

  /// `Contact methods`
  String get contactMethods {
    return Intl.message(
      'Contact methods',
      name: 'contactMethods',
      desc: '',
      args: [],
    );
  }

  /// `Contact method`
  String get contactMethod {
    return Intl.message(
      'Contact method',
      name: 'contactMethod',
      desc: '',
      args: [],
    );
  }

  /// `Contact information`
  String get contactInformation {
    return Intl.message(
      'Contact information',
      name: 'contactInformation',
      desc: '',
      args: [],
    );
  }

  /// `Contact validated`
  String get contactInformationValidated {
    return Intl.message(
      'Contact validated',
      name: 'contactInformationValidated',
      desc: '',
      args: [],
    );
  }

  /// `Content not found`
  String get contentNotFound {
    return Intl.message(
      'Content not found',
      name: 'contentNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Could not load station information, sorry`
  String get couldNotLoadStation {
    return Intl.message(
      'Could not load station information, sorry',
      name: 'couldNotLoadStation',
      desc: '',
      args: [],
    );
  }

  /// `Could not open link`
  String get couldNotOpenLink {
    return Intl.message(
      'Could not open link',
      name: 'couldNotOpenLink',
      desc: '',
      args: [],
    );
  }

  /// `Create account`
  String get createAccount {
    return Intl.message(
      'Create account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Current station`
  String get currentStation {
    return Intl.message(
      'Current station',
      name: 'currentStation',
      desc: '',
      args: [],
    );
  }

  /// `Date range`
  String get dateRange {
    return Intl.message(
      'Date range',
      name: 'dateRange',
      desc: '',
      args: [],
    );
  }

  /// `The user account is removed immediately. This action cannot be undone.`
  String get deletingAccountCannotUndone {
    return Intl.message(
      'The user account is removed immediately. This action cannot be undone.',
      name: 'deletingAccountCannotUndone',
      desc: '',
      args: [],
    );
  }

  /// `Delete your account`
  String get deleteYourAccount {
    return Intl.message(
      'Delete your account',
      name: 'deleteYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Delete account`
  String get deleteAccount {
    return Intl.message(
      'Delete account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Failed to delete account`
  String get deletingAccountFailed {
    return Intl.message(
      'Failed to delete account',
      name: 'deletingAccountFailed',
      desc: '',
      args: [],
    );
  }

  /// `Download Open Badge`
  String get downloadOpenBadge {
    return Intl.message(
      'Download Open Badge',
      name: 'downloadOpenBadge',
      desc: '',
      args: [],
    );
  }

  /// `Download Certificate`
  String get downloadCertificate {
    return Intl.message(
      'Download Certificate',
      name: 'downloadCertificate',
      desc: '',
      args: [],
    );
  }

  /// `User account deleted`
  String get accountDeleted {
    return Intl.message(
      'User account deleted',
      name: 'accountDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Discover`
  String get discover {
    return Intl.message(
      'Discover',
      name: 'discover',
      desc: '',
      args: [],
    );
  }

  /// `Easy books`
  String get easyBooks {
    return Intl.message(
      'Easy books',
      name: 'easyBooks',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
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

  /// `Email or Phone number`
  String get emailOrPhoneNumber {
    return Intl.message(
      'Email or Phone number',
      name: 'emailOrPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter new code`
  String get enterNewCode {
    return Intl.message(
      'Enter new code',
      name: 'enterNewCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Group Code here`
  String get enterGroupCode {
    return Intl.message(
      'Enter your Group Code here',
      name: 'enterGroupCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter password`
  String get enterPassword {
    return Intl.message(
      'Enter password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Event Log`
  String get eventLog {
    return Intl.message(
      'Event Log',
      name: 'eventLog',
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

  /// `Errors in form contents`
  String get errorsInForm {
    return Intl.message(
      'Errors in form contents',
      name: 'errorsInForm',
      desc: '',
      args: [],
    );
  }

  /// `Could not save your answer`
  String get failedToSaveAnswer {
    return Intl.message(
      'Could not save your answer',
      name: 'failedToSaveAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get feedback {
    return Intl.message(
      'Feedback',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `Feedback sent`
  String get feedbackSent {
    return Intl.message(
      'Feedback sent',
      name: 'feedbackSent',
      desc: '',
      args: [],
    );
  }

  /// `Field cannot be empty`
  String get fieldCannotBeEmpty {
    return Intl.message(
      'Field cannot be empty',
      name: 'fieldCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for your input!`
  String get thankyouForFeedback {
    return Intl.message(
      'Thank you for your input!',
      name: 'thankyouForFeedback',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get firstName {
    return Intl.message(
      'First name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Flash On`
  String get flashOn {
    return Intl.message(
      'Flash On',
      name: 'flashOn',
      desc: '',
      args: [],
    );
  }

  /// `Flash Off`
  String get flashOff {
    return Intl.message(
      'Flash Off',
      name: 'flashOff',
      desc: '',
      args: [],
    );
  }

  /// `Form is empty`
  String get formIsEmpty {
    return Intl.message(
      'Form is empty',
      name: 'formIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Cannot save empty form`
  String get cannotSaveEmptyForm {
    return Intl.message(
      'Cannot save empty form',
      name: 'cannotSaveEmptyForm',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forms`
  String get forms {
    return Intl.message(
      'Forms',
      name: 'forms',
      desc: '',
      args: [],
    );
  }

  /// `Front Camera`
  String get frontCamera {
    return Intl.message(
      'Front Camera',
      name: 'frontCamera',
      desc: '',
      args: [],
    );
  }

  /// `Get code`
  String get getCode {
    return Intl.message(
      'Get code',
      name: 'getCode',
      desc: '',
      args: [],
    );
  }

  /// `Great!`
  String get great {
    return Intl.message(
      'Great!',
      name: 'great',
      desc: '',
      args: [],
    );
  }

  /// `Group code`
  String get groupCode {
    return Intl.message(
      'Group code',
      name: 'groupCode',
      desc: '',
      args: [],
    );
  }

  /// `Guardian Information`
  String get guardianInfo {
    return Intl.message(
      'Guardian Information',
      name: 'guardianInfo',
      desc: '',
      args: [],
    );
  }

  /// `Guardian phone`
  String get guardianPhone {
    return Intl.message(
      'Guardian phone',
      name: 'guardianPhone',
      desc: '',
      args: [],
    );
  }

  /// `Guardian name`
  String get guardianName {
    return Intl.message(
      'Guardian name',
      name: 'guardianName',
      desc: '',
      args: [],
    );
  }

  /// `Healthy lifestyle`
  String get healthyLifestyle {
    return Intl.message(
      'Healthy lifestyle',
      name: 'healthyLifestyle',
      desc: '',
      args: [],
    );
  }

  /// `Healthy food`
  String get healthyFood {
    return Intl.message(
      'Healthy food',
      name: 'healthyFood',
      desc: '',
      args: [],
    );
  }

  /// `Failed to join group with given code`
  String get joiningGroupFailed {
    return Intl.message(
      'Failed to join group with given code',
      name: 'joiningGroupFailed',
      desc: '',
      args: [],
    );
  }

  /// `You have joined a new group`
  String get joinedToGroup {
    return Intl.message(
      'You have joined a new group',
      name: 'joinedToGroup',
      desc: '',
      args: [],
    );
  }

  /// `Joining to new Group`
  String get joiningToUserGroup {
    return Intl.message(
      'Joining to new Group',
      name: 'joiningToUserGroup',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get lastName {
    return Intl.message(
      'Last name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Line map`
  String get lineMap {
    return Intl.message(
      'Line map',
      name: 'lineMap',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get loading {
    return Intl.message(
      'Loading',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Loading benefits`
  String get loadingBenefits {
    return Intl.message(
      'Loading benefits',
      name: 'loadingBenefits',
      desc: '',
      args: [],
    );
  }

  /// `Location retrieved`
  String get locationRetrieved {
    return Intl.message(
      'Location retrieved',
      name: 'locationRetrieved',
      desc: '',
      args: [],
    );
  }

  /// `Locations`
  String get locations {
    return Intl.message(
      'Locations',
      name: 'locations',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Login failed`
  String get loginFailed {
    return Intl.message(
      'Login failed',
      name: 'loginFailed',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginTitle {
    return Intl.message(
      'Login',
      name: 'loginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Metro map`
  String get metroMap {
    return Intl.message(
      'Metro map',
      name: 'metroMap',
      desc: '',
      args: [],
    );
  }

  /// `Moderate books`
  String get moderateBooks {
    return Intl.message(
      'Moderate books',
      name: 'moderateBooks',
      desc: '',
      args: [],
    );
  }

  /// `More information`
  String get moreInformation {
    return Intl.message(
      'More information',
      name: 'moreInformation',
      desc: '',
      args: [],
    );
  }

  /// `My activities`
  String get myActivities {
    return Intl.message(
      'My activities',
      name: 'myActivities',
      desc: '',
      args: [],
    );
  }

  /// `My Card`
  String get myCard {
    return Intl.message(
      'My Card',
      name: 'myCard',
      desc: '',
      args: [],
    );
  }

  /// `My booklist`
  String get myBooks {
    return Intl.message(
      'My booklist',
      name: 'myBooks',
      desc: '',
      args: [],
    );
  }

  /// `My points`
  String get myPoints {
    return Intl.message(
      'My points',
      name: 'myPoints',
      desc: '',
      args: [],
    );
  }

  /// `My Score`
  String get myScore {
    return Intl.message(
      'My Score',
      name: 'myScore',
      desc: '',
      args: [],
    );
  }

  /// `no`
  String get no {
    return Intl.message(
      'no',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Could not find any activities`
  String get noActivitiesFound {
    return Intl.message(
      'Could not find any activities',
      name: 'noActivitiesFound',
      desc: '',
      args: [],
    );
  }

  /// `No active benefits`
  String get noActiveBenefits {
    return Intl.message(
      'No active benefits',
      name: 'noActiveBenefits',
      desc: '',
      args: [],
    );
  }

  /// `No contact methods found`
  String get noContactMethodsFound {
    return Intl.message(
      'No contact methods found',
      name: 'noContactMethodsFound',
      desc: '',
      args: [],
    );
  }

  /// `No description`
  String get noDescription {
    return Intl.message(
      'No description',
      name: 'noDescription',
      desc: '',
      args: [],
    );
  }

  /// `No resources currently available`
  String get noResourcesFound {
    return Intl.message(
      'No resources currently available',
      name: 'noResourcesFound',
      desc: '',
      args: [],
    );
  }

  /// `No forms found`
  String get noFormsFound {
    return Intl.message(
      'No forms found',
      name: 'noFormsFound',
      desc: '',
      args: [],
    );
  }

  /// `No visits today`
  String get noVisitsToday {
    return Intl.message(
      'No visits today',
      name: 'noVisitsToday',
      desc: '',
      args: [],
    );
  }

  /// `No visits found`
  String get noVisitsFound {
    return Intl.message(
      'No visits found',
      name: 'noVisitsFound',
      desc: '',
      args: [],
    );
  }

  /// `No users found`
  String get noUsersFound {
    return Intl.message(
      'No users found',
      name: 'noUsersFound',
      desc: '',
      args: [],
    );
  }

  /// `No tasks`
  String get noTasks {
    return Intl.message(
      'No tasks',
      name: 'noTasks',
      desc: '',
      args: [],
    );
  }

  /// `No thank you`
  String get noThankYou {
    return Intl.message(
      'No thank you',
      name: 'noThankYou',
      desc: '',
      args: [],
    );
  }

  /// `Not verified`
  String get notVerified {
    return Intl.message(
      'Not verified',
      name: 'notVerified',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
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

  /// `Oops!`
  String get oops {
    return Intl.message(
      'Oops!',
      name: 'oops',
      desc: '',
      args: [],
    );
  }

  /// `Open station`
  String get openStation {
    return Intl.message(
      'Open station',
      name: 'openStation',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get otherItems {
    return Intl.message(
      'Other',
      name: 'otherItems',
      desc: '',
      args: [],
    );
  }

  /// `Page content`
  String get pageContent {
    return Intl.message(
      'Page content',
      name: 'pageContent',
      desc: '',
      args: [],
    );
  }

  /// `Page count:`
  String get pageCount {
    return Intl.message(
      'Page count:',
      name: 'pageCount',
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

  /// `Password changed`
  String get passwordChanged {
    return Intl.message(
      'Password changed',
      name: 'passwordChanged',
      desc: '',
      args: [],
    );
  }

  /// `Password and confirmation do not match`
  String get passwordsDontMatch {
    return Intl.message(
      'Password and confirmation do not match',
      name: 'passwordsDontMatch',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get passwordIsRequired {
    return Intl.message(
      'Password is required',
      name: 'passwordIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Participants`
  String get participants {
    return Intl.message(
      'Participants',
      name: 'participants',
      desc: '',
      args: [],
    );
  }

  /// `Pause`
  String get pause {
    return Intl.message(
      'Pause',
      name: 'pause',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Phone or Email`
  String get phoneOrEmail {
    return Intl.message(
      'Phone or Email',
      name: 'phoneOrEmail',
      desc: '',
      args: [],
    );
  }

  /// `Physical activities`
  String get physicalActivities {
    return Intl.message(
      'Physical activities',
      name: 'physicalActivities',
      desc: '',
      args: [],
    );
  }

  /// `Please complete the form properly`
  String get pleaseCompleteFormProperly {
    return Intl.message(
      'Please complete the form properly',
      name: 'pleaseCompleteFormProperly',
      desc: '',
      args: [],
    );
  }

  /// `Please enable camera for scanning QR codes`
  String get pleaseEnableCamera {
    return Intl.message(
      'Please enable camera for scanning QR codes',
      name: 'pleaseEnableCamera',
      desc: '',
      args: [],
    );
  }

  /// `Please enter password`
  String get pleaseEnterPassword {
    return Intl.message(
      'Please enter password',
      name: 'pleaseEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter confirmation key`
  String get pleaseEnterConfirmationKey {
    return Intl.message(
      'Please enter confirmation key',
      name: 'pleaseEnterConfirmationKey',
      desc: '',
      args: [],
    );
  }

  /// `Registering account, please wait`
  String get pleaseWaitRegistering {
    return Intl.message(
      'Registering account, please wait',
      name: 'pleaseWaitRegistering',
      desc: '',
      args: [],
    );
  }

  /// `Please provide a valid email address`
  String get pleaseProvideValidEmail {
    return Intl.message(
      'Please provide a valid email address',
      name: 'pleaseProvideValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter phone number`
  String get pleaseEnterPhoneNumber {
    return Intl.message(
      'Please enter phone number',
      name: 'pleaseEnterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter phone number or email address`
  String get pleaseEnterPhoneOrEmail {
    return Intl.message(
      'Please enter phone number or email address',
      name: 'pleaseEnterPhoneOrEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please provide the registration code given by your school or library`
  String get pleaseProvideRegistrationCode {
    return Intl.message(
      'Please provide the registration code given by your school or library',
      name: 'pleaseProvideRegistrationCode',
      desc: '',
      args: [],
    );
  }

  /// `Please provide a valid phone number`
  String get pleaseProvideValidPhoneNumber {
    return Intl.message(
      'Please provide a valid phone number',
      name: 'pleaseProvideValidPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please provide a valid phone number or email address`
  String get pleaseProvideValidPhoneOrEmail {
    return Intl.message(
      'Please provide a valid phone number or email address',
      name: 'pleaseProvideValidPhoneOrEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please provide your name`
  String get pleaseProvideYourName {
    return Intl.message(
      'Please provide your name',
      name: 'pleaseProvideYourName',
      desc: '',
      args: [],
    );
  }

  /// `Please wait, sending code`
  String get pleaseWaitSendingCode {
    return Intl.message(
      'Please wait, sending code',
      name: 'pleaseWaitSendingCode',
      desc: '',
      args: [],
    );
  }

  /// `Postcode`
  String get postcode {
    return Intl.message(
      'Postcode',
      name: 'postcode',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get previous {
    return Intl.message(
      'Previous',
      name: 'previous',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get priceToOpen {
    return Intl.message(
      'Price',
      name: 'priceToOpen',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Processing`
  String get processing {
    return Intl.message(
      'Processing',
      name: 'processing',
      desc: '',
      args: [],
    );
  }

  /// `QR Scanner`
  String get qrScanner {
    return Intl.message(
      'QR Scanner',
      name: 'qrScanner',
      desc: '',
      args: [],
    );
  }

  /// `Rate book`
  String get rateBook {
    return Intl.message(
      'Rate book',
      name: 'rateBook',
      desc: '',
      args: [],
    );
  }

  /// `Read books`
  String get readBooksList {
    return Intl.message(
      'Read books',
      name: 'readBooksList',
      desc: '',
      args: [],
    );
  }

  /// `Book list`
  String get readList {
    return Intl.message(
      'Book list',
      name: 'readList',
      desc: '',
      args: [],
    );
  }

  /// `Book list is empty!`
  String get readListIsEmpty {
    return Intl.message(
      'Book list is empty!',
      name: 'readListIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Rating saved`
  String get ratingSaved {
    return Intl.message(
      'Rating saved',
      name: 'ratingSaved',
      desc: '',
      args: [],
    );
  }

  /// `Read more`
  String get readMore {
    return Intl.message(
      'Read more',
      name: 'readMore',
      desc: '',
      args: [],
    );
  }

  /// `Your status`
  String get readingProgress {
    return Intl.message(
      'Your status',
      name: 'readingProgress',
      desc: '',
      args: [],
    );
  }

  /// `Scanner ready`
  String get readyToScan {
    return Intl.message(
      'Scanner ready',
      name: 'readyToScan',
      desc: '',
      args: [],
    );
  }

  /// `Rear Camera`
  String get rearCamera {
    return Intl.message(
      'Rear Camera',
      name: 'rearCamera',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get refresh {
    return Intl.message(
      'Refresh',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `Registration failed`
  String get registrationFailed {
    return Intl.message(
      'Registration failed',
      name: 'registrationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Request failed`
  String get requestFailed {
    return Intl.message(
      'Request failed',
      name: 'requestFailed',
      desc: '',
      args: [],
    );
  }

  /// `Get new code`
  String get requestNewCode {
    return Intl.message(
      'Get new code',
      name: 'requestNewCode',
      desc: '',
      args: [],
    );
  }

  /// `Get new Password`
  String get requestNewPasswordTitle {
    return Intl.message(
      'Get new Password',
      name: 'requestNewPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Resume`
  String get resume {
    return Intl.message(
      'Resume',
      name: 'resume',
      desc: '',
      args: [],
    );
  }

  /// `Resources`
  String get resources {
    return Intl.message(
      'Resources',
      name: 'resources',
      desc: '',
      args: [],
    );
  }

  /// `Retrieving coordinates`
  String get retrievingCoordinates {
    return Intl.message(
      'Retrieving coordinates',
      name: 'retrievingCoordinates',
      desc: '',
      args: [],
    );
  }

  /// `Returned`
  String get returned {
    return Intl.message(
      'Returned',
      name: 'returned',
      desc: '',
      args: [],
    );
  }

  /// `Routines`
  String get routines {
    return Intl.message(
      'Routines',
      name: 'routines',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save data`
  String get savingDataFailed {
    return Intl.message(
      'Failed to save data',
      name: 'savingDataFailed',
      desc: '',
      args: [],
    );
  }

  /// `Scan Code`
  String get scanCode {
    return Intl.message(
      'Scan Code',
      name: 'scanCode',
      desc: '',
      args: [],
    );
  }

  /// `Score`
  String get score {
    return Intl.message(
      'Score',
      name: 'score',
      desc: '',
      args: [],
    );
  }

  /// `Save data`
  String get saveData {
    return Intl.message(
      'Save data',
      name: 'saveData',
      desc: '',
      args: [],
    );
  }

  /// `Save answer`
  String get saveAnswer {
    return Intl.message(
      'Save answer',
      name: 'saveAnswer',
      desc: '',
      args: [],
    );
  }

  /// `No score earned yet`
  String get scoreListIsEmpty {
    return Intl.message(
      'No score earned yet',
      name: 'scoreListIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Send answer`
  String get sendAnswer {
    return Intl.message(
      'Send answer',
      name: 'sendAnswer',
      desc: '',
      args: [],
    );
  }

  /// `settings`
  String get settings {
    return Intl.message(
      'settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message(
      'Sign up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Station`
  String get station {
    return Intl.message(
      'Station',
      name: 'station',
      desc: '',
      args: [],
    );
  }

  /// `You have passed this station`
  String get stationIsPassed {
    return Intl.message(
      'You have passed this station',
      name: 'stationIsPassed',
      desc: '',
      args: [],
    );
  }

  /// `Stations`
  String get stationList {
    return Intl.message(
      'Stations',
      name: 'stationList',
      desc: '',
      args: [],
    );
  }

  /// `Subway Map`
  String get subwayMap {
    return Intl.message(
      'Subway Map',
      name: 'subwayMap',
      desc: '',
      args: [],
    );
  }

  /// `Submission rejected`
  String get submissionRejected {
    return Intl.message(
      'Submission rejected',
      name: 'submissionRejected',
      desc: '',
      args: [],
    );
  }

  /// `Tasks`
  String get tasks {
    return Intl.message(
      'Tasks',
      name: 'tasks',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Transit to station`
  String get transitToStation {
    return Intl.message(
      'Transit to station',
      name: 'transitToStation',
      desc: '',
      args: [],
    );
  }

  /// `Unnamed activity`
  String get unnamedActivity {
    return Intl.message(
      'Unnamed activity',
      name: 'unnamedActivity',
      desc: '',
      args: [],
    );
  }

  /// `Unnamed`
  String get unnamed {
    return Intl.message(
      'Unnamed',
      name: 'unnamed',
      desc: '',
      args: [],
    );
  }

  /// `Unnamed item`
  String get unnamedLibraryItem {
    return Intl.message(
      'Unnamed item',
      name: 'unnamedLibraryItem',
      desc: '',
      args: [],
    );
  }

  /// `Untitled page`
  String get unnamedWebPage {
    return Intl.message(
      'Untitled page',
      name: 'unnamedWebPage',
      desc: '',
      args: [],
    );
  }

  /// `unknown user`
  String get unknownUser {
    return Intl.message(
      'unknown user',
      name: 'unknownUser',
      desc: '',
      args: [],
    );
  }

  /// `Use code`
  String get useCode {
    return Intl.message(
      'Use code',
      name: 'useCode',
      desc: '',
      args: [],
    );
  }

  /// `User not found`
  String get userNotFound {
    return Intl.message(
      'User not found',
      name: 'userNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Untitled`
  String get untitled {
    return Intl.message(
      'Untitled',
      name: 'untitled',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get valueIsRequired {
    return Intl.message(
      'This field is required',
      name: 'valueIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Validate contact information`
  String get validateContactTitle {
    return Intl.message(
      'Validate contact information',
      name: 'validateContactTitle',
      desc: '',
      args: [],
    );
  }

  /// `Verified`
  String get verified {
    return Intl.message(
      'Verified',
      name: 'verified',
      desc: '',
      args: [],
    );
  }

  /// `verify`
  String get verify {
    return Intl.message(
      'verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Show welcome info`
  String get welcomeInfo {
    return Intl.message(
      'Show welcome info',
      name: 'welcomeInfo',
      desc: '',
      args: [],
    );
  }

  /// `Write your answer here for `
  String get writeAnswerHere {
    return Intl.message(
      'Write your answer here for ',
      name: 'writeAnswerHere',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No station selected`
  String get youAreNotOnAnyStation {
    return Intl.message(
      'No station selected',
      name: 'youAreNotOnAnyStation',
      desc: '',
      args: [],
    );
  }

  /// `You have read this book`
  String get youHaveReadThisBook {
    return Intl.message(
      'You have read this book',
      name: 'youHaveReadThisBook',
      desc: '',
      args: [],
    );
  }

  /// `You have opened this station`
  String get youHaveOpenedThisStation {
    return Intl.message(
      'You have opened this station',
      name: 'youHaveOpenedThisStation',
      desc: '',
      args: [],
    );
  }

  /// `You have this achievement`
  String get youHaveThisBadge {
    return Intl.message(
      'You have this achievement',
      name: 'youHaveThisBadge',
      desc: '',
      args: [],
    );
  }

  /// `Your answer has been saved`
  String get yourAnswerHasBeenSaved {
    return Intl.message(
      'Your answer has been saved',
      name: 'yourAnswerHasBeenSaved',
      desc: '',
      args: [],
    );
  }

  /// `Your password`
  String get yourPassword {
    return Intl.message(
      'Your password',
      name: 'yourPassword',
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
      Locale.fromSubtags(languageCode: 'fi'),
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
