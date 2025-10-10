import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_et.dart';
import 'app_localizations_fi.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('et'),
    Locale('fi'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt')
  ];

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @accountCreated.
  ///
  /// In en, this message translates to:
  /// **'Account created'**
  String get accountCreated;

  /// No description provided for @accountDeleted.
  ///
  /// In en, this message translates to:
  /// **'User account deleted'**
  String get accountDeleted;

  /// No description provided for @accountDeletion.
  ///
  /// In en, this message translates to:
  /// **'Account Deletion'**
  String get accountDeletion;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @activities.
  ///
  /// In en, this message translates to:
  /// **'Activities'**
  String get activities;

  /// No description provided for @activity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get activity;

  /// No description provided for @activityCalendar.
  ///
  /// In en, this message translates to:
  /// **'Activity calendar'**
  String get activityCalendar;

  /// No description provided for @activityLevel.
  ///
  /// In en, this message translates to:
  /// **'Activity level'**
  String get activityLevel;

  /// No description provided for @activityRecorded.
  ///
  /// In en, this message translates to:
  /// **'Activity recorded'**
  String get activityRecorded;

  /// No description provided for @activityRegistrationFailed.
  ///
  /// In en, this message translates to:
  /// **'Updating activity status failed'**
  String get activityRegistrationFailed;

  /// No description provided for @activityRegistrationSaved.
  ///
  /// In en, this message translates to:
  /// **'Activity marked as done'**
  String get activityRegistrationSaved;

  /// No description provided for @addedToList.
  ///
  /// In en, this message translates to:
  /// **'Added to list'**
  String get addedToList;

  /// No description provided for @addingRoutineFailed.
  ///
  /// In en, this message translates to:
  /// **'Adding routine to calendar failed'**
  String get addingRoutineFailed;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @ageOver13.
  ///
  /// In en, this message translates to:
  /// **'Are you 13+ years old?'**
  String get ageOver13;

  /// No description provided for @alreadyDone.
  ///
  /// In en, this message translates to:
  /// **'Already done'**
  String get alreadyDone;

  /// No description provided for @answerDate.
  ///
  /// In en, this message translates to:
  /// **'Answer date'**
  String get answerDate;

  /// No description provided for @answerSaved.
  ///
  /// In en, this message translates to:
  /// **'Answer saved'**
  String get answerSaved;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'FiTeens'**
  String get appName;

  /// No description provided for @authenticating.
  ///
  /// In en, this message translates to:
  /// **'Authenticating ... Please wait'**
  String get authenticating;

  /// No description provided for @btnAddToCalendar.
  ///
  /// In en, this message translates to:
  /// **'Add to calendar'**
  String get btnAddToCalendar;

  /// No description provided for @btnConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get btnConfirm;

  /// No description provided for @btnContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get btnContinue;

  /// No description provided for @btnDashboard.
  ///
  /// In en, this message translates to:
  /// **'Open Dashboard'**
  String get btnDashboard;

  /// No description provided for @btnLogin.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get btnLogin;

  /// No description provided for @btnMarkAsDone.
  ///
  /// In en, this message translates to:
  /// **'Mark as done'**
  String get btnMarkAsDone;

  /// No description provided for @btnReturn.
  ///
  /// In en, this message translates to:
  /// **'Return'**
  String get btnReturn;

  /// No description provided for @btnReturnBook.
  ///
  /// In en, this message translates to:
  /// **'Return book'**
  String get btnReturnBook;

  /// No description provided for @btnSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get btnSend;

  /// No description provided for @btnSetNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Set Password'**
  String get btnSetNewPassword;

  /// No description provided for @btnShow.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get btnShow;

  /// No description provided for @btnSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get btnSkip;

  /// No description provided for @btnTasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get btnTasks;

  /// No description provided for @btnUseEmail.
  ///
  /// In en, this message translates to:
  /// **'Use Email'**
  String get btnUseEmail;

  /// No description provided for @btnUsePhone.
  ///
  /// In en, this message translates to:
  /// **'Use Phone number'**
  String get btnUsePhone;

  /// No description provided for @btnValidateContact.
  ///
  /// In en, this message translates to:
  /// **'Validate contact information now'**
  String get btnValidateContact;

  /// No description provided for @btnValidateContactLater.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get btnValidateContactLater;

  /// No description provided for @calendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar;

  /// No description provided for @calendarUpdated.
  ///
  /// In en, this message translates to:
  /// **'Calendar updated'**
  String get calendarUpdated;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @cannotSaveEmptyForm.
  ///
  /// In en, this message translates to:
  /// **'Cannot save empty form'**
  String get cannotSaveEmptyForm;

  /// No description provided for @challenges.
  ///
  /// In en, this message translates to:
  /// **'Challenges'**
  String get challenges;

  /// No description provided for @choose.
  ///
  /// In en, this message translates to:
  /// **'Choose'**
  String get choose;

  /// No description provided for @chooseFile.
  ///
  /// In en, this message translates to:
  /// **'Choose file'**
  String get chooseFile;

  /// No description provided for @clickPictureToChooseAvatar.
  ///
  /// In en, this message translates to:
  /// **'Click picture to choose an avatar'**
  String get clickPictureToChooseAvatar;

  /// No description provided for @codeAccepted.
  ///
  /// In en, this message translates to:
  /// **'Code accepted'**
  String get codeAccepted;

  /// No description provided for @codeScanned.
  ///
  /// In en, this message translates to:
  /// **'Code scanned'**
  String get codeScanned;

  /// No description provided for @collectedBadges.
  ///
  /// In en, this message translates to:
  /// **'Collected badges'**
  String get collectedBadges;

  /// No description provided for @confirmDeletingAccount.
  ///
  /// In en, this message translates to:
  /// **'Confirm user account deletion'**
  String get confirmDeletingAccount;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @confirmationKey.
  ///
  /// In en, this message translates to:
  /// **'Confirmation key'**
  String get confirmationKey;

  /// No description provided for @contactInformation.
  ///
  /// In en, this message translates to:
  /// **'Contact information'**
  String get contactInformation;

  /// No description provided for @contactInformationValidated.
  ///
  /// In en, this message translates to:
  /// **'Contact validated'**
  String get contactInformationValidated;

  /// No description provided for @contactMethod.
  ///
  /// In en, this message translates to:
  /// **'Contact method'**
  String get contactMethod;

  /// No description provided for @contactMethods.
  ///
  /// In en, this message translates to:
  /// **'Contact methods'**
  String get contactMethods;

  /// No description provided for @contentNotFound.
  ///
  /// In en, this message translates to:
  /// **'Content not found'**
  String get contentNotFound;

  /// No description provided for @couldNotOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Could not open link'**
  String get couldNotOpenLink;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @dateRange.
  ///
  /// In en, this message translates to:
  /// **'Date range'**
  String get dateRange;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccount;

  /// No description provided for @deleteYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete your account'**
  String get deleteYourAccount;

  /// No description provided for @deletingAccountCannotUndone.
  ///
  /// In en, this message translates to:
  /// **'The user account is removed immediately. This action cannot be undone.'**
  String get deletingAccountCannotUndone;

  /// No description provided for @deletingAccountFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete account'**
  String get deletingAccountFailed;

  /// No description provided for @discover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get discover;

  /// No description provided for @downloadCertificate.
  ///
  /// In en, this message translates to:
  /// **'Download Certificate'**
  String get downloadCertificate;

  /// No description provided for @downloadOpenBadge.
  ///
  /// In en, this message translates to:
  /// **'Download Open Badge'**
  String get downloadOpenBadge;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailOrPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Email or Phone number'**
  String get emailOrPhoneNumber;

  /// No description provided for @enterGroupCode.
  ///
  /// In en, this message translates to:
  /// **'Enter your Group Code here'**
  String get enterGroupCode;

  /// No description provided for @enterNewCode.
  ///
  /// In en, this message translates to:
  /// **'Enter new code'**
  String get enterNewCode;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enterPassword;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @errorsInForm.
  ///
  /// In en, this message translates to:
  /// **'Errors in form contents'**
  String get errorsInForm;

  /// No description provided for @eventCannotBeMarkedBeforeDate.
  ///
  /// In en, this message translates to:
  /// **'You cannot mark this activity as done before {startdate}'**
  String eventCannotBeMarkedBeforeDate(String startdate);

  /// No description provided for @eventCannotBeSkippedBeforeDate.
  ///
  /// In en, this message translates to:
  /// **'You cannot skip this activity before {startdate}'**
  String eventCannotBeSkippedBeforeDate(String startdate);

  /// No description provided for @eventInFuture.
  ///
  /// In en, this message translates to:
  /// **'The activity is planned in the future'**
  String get eventInFuture;

  /// No description provided for @eventLog.
  ///
  /// In en, this message translates to:
  /// **'Event Log'**
  String get eventLog;

  /// No description provided for @failedToSaveAnswer.
  ///
  /// In en, this message translates to:
  /// **'Could not save your answer'**
  String get failedToSaveAnswer;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @feedbackSent.
  ///
  /// In en, this message translates to:
  /// **'Feedback sent'**
  String get feedbackSent;

  /// No description provided for @fieldCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Field cannot be empty'**
  String get fieldCannotBeEmpty;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// No description provided for @flashOff.
  ///
  /// In en, this message translates to:
  /// **'Flash Off'**
  String get flashOff;

  /// No description provided for @flashOn.
  ///
  /// In en, this message translates to:
  /// **'Flash On'**
  String get flashOn;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @formIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Form is empty'**
  String get formIsEmpty;

  /// No description provided for @forms.
  ///
  /// In en, this message translates to:
  /// **'Forms'**
  String get forms;

  /// No description provided for @getCode.
  ///
  /// In en, this message translates to:
  /// **'Get code'**
  String get getCode;

  /// No description provided for @great.
  ///
  /// In en, this message translates to:
  /// **'Great!'**
  String get great;

  /// No description provided for @groupCode.
  ///
  /// In en, this message translates to:
  /// **'Group code'**
  String get groupCode;

  /// No description provided for @guardianInfo.
  ///
  /// In en, this message translates to:
  /// **'Guardian Information'**
  String get guardianInfo;

  /// No description provided for @guardianName.
  ///
  /// In en, this message translates to:
  /// **'Guardian name'**
  String get guardianName;

  /// No description provided for @guardianPhone.
  ///
  /// In en, this message translates to:
  /// **'Guardian phone'**
  String get guardianPhone;

  /// No description provided for @healthyFood.
  ///
  /// In en, this message translates to:
  /// **'Healthy food'**
  String get healthyFood;

  /// No description provided for @healthyLifestyle.
  ///
  /// In en, this message translates to:
  /// **'Healthy lifestyle'**
  String get healthyLifestyle;

  /// No description provided for @joinedToGroup.
  ///
  /// In en, this message translates to:
  /// **'You have joined a new group'**
  String get joinedToGroup;

  /// No description provided for @joiningGroupFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to join group with given code'**
  String get joiningGroupFailed;

  /// No description provided for @joiningToUserGroup.
  ///
  /// In en, this message translates to:
  /// **'Joining to new Group'**
  String get joiningToUserGroup;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastName;

  /// No description provided for @library.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get library;

  /// No description provided for @libraryIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Library is empty'**
  String get libraryIsEmpty;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @locations.
  ///
  /// In en, this message translates to:
  /// **'Locations'**
  String get locations;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get loginFailed;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @moreInformation.
  ///
  /// In en, this message translates to:
  /// **'More information'**
  String get moreInformation;

  /// No description provided for @myActivities.
  ///
  /// In en, this message translates to:
  /// **'My activities'**
  String get myActivities;

  /// No description provided for @myPoints.
  ///
  /// In en, this message translates to:
  /// **'My points'**
  String get myPoints;

  /// No description provided for @myScore.
  ///
  /// In en, this message translates to:
  /// **'My Score'**
  String get myScore;

  /// Menu navigation items map
  ///
  /// In en, this message translates to:
  /// **'{item, select, home{Home} calendar{Calendar} routines{Routines} mywellbeing{My Well-being} library{Library/Resources} dashboard{Dashboard} other{Menu:{item}}}'**
  String navitem(String item);

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'no'**
  String get no;

  /// No description provided for @noActivitiesFound.
  ///
  /// In en, this message translates to:
  /// **'Could not find any activities'**
  String get noActivitiesFound;

  /// No description provided for @noContactMethodsFound.
  ///
  /// In en, this message translates to:
  /// **'No contact methods found'**
  String get noContactMethodsFound;

  /// No description provided for @noDescription.
  ///
  /// In en, this message translates to:
  /// **'No description'**
  String get noDescription;

  /// No description provided for @noEventsFound.
  ///
  /// In en, this message translates to:
  /// **'No events found'**
  String get noEventsFound;

  /// No description provided for @noFormsFound.
  ///
  /// In en, this message translates to:
  /// **'No forms found'**
  String get noFormsFound;

  /// No description provided for @noResourcesFound.
  ///
  /// In en, this message translates to:
  /// **'No resources currently available'**
  String get noResourcesFound;

  /// No description provided for @noRoutinesFound.
  ///
  /// In en, this message translates to:
  /// **'No routines found'**
  String get noRoutinesFound;

  /// No description provided for @noTasks.
  ///
  /// In en, this message translates to:
  /// **'No tasks'**
  String get noTasks;

  /// No description provided for @noThankYou.
  ///
  /// In en, this message translates to:
  /// **'No thank you'**
  String get noThankYou;

  /// No description provided for @noUsersFound.
  ///
  /// In en, this message translates to:
  /// **'No users found'**
  String get noUsersFound;

  /// No description provided for @noVisitsFound.
  ///
  /// In en, this message translates to:
  /// **'No visits found'**
  String get noVisitsFound;

  /// No description provided for @notVerified.
  ///
  /// In en, this message translates to:
  /// **'Not verified'**
  String get notVerified;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @oops.
  ///
  /// In en, this message translates to:
  /// **'Oops!'**
  String get oops;

  /// No description provided for @otherItems.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get otherItems;

  /// No description provided for @pageContent.
  ///
  /// In en, this message translates to:
  /// **'Page content'**
  String get pageContent;

  /// No description provided for @pageCount.
  ///
  /// In en, this message translates to:
  /// **'Page count:'**
  String get pageCount;

  /// No description provided for @participants.
  ///
  /// In en, this message translates to:
  /// **'Participants'**
  String get participants;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordChanged.
  ///
  /// In en, this message translates to:
  /// **'Password changed'**
  String get passwordChanged;

  /// No description provided for @passwordIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordIsRequired;

  /// No description provided for @passwordsDontMatch.
  ///
  /// In en, this message translates to:
  /// **'Password and confirmation do not match'**
  String get passwordsDontMatch;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @phoneOrEmail.
  ///
  /// In en, this message translates to:
  /// **'Phone or Email'**
  String get phoneOrEmail;

  /// No description provided for @physicalActivities.
  ///
  /// In en, this message translates to:
  /// **'Physical activities'**
  String get physicalActivities;

  /// No description provided for @pleaseCompleteFormProperly.
  ///
  /// In en, this message translates to:
  /// **'Please complete the form properly'**
  String get pleaseCompleteFormProperly;

  /// No description provided for @pleaseEnterConfirmationKey.
  ///
  /// In en, this message translates to:
  /// **'Please enter confirmation key'**
  String get pleaseEnterConfirmationKey;

  /// No description provided for @pleaseEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter password'**
  String get pleaseEnterPassword;

  /// No description provided for @pleaseEnterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter phone number'**
  String get pleaseEnterPhoneNumber;

  /// No description provided for @pleaseEnterPhoneOrEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter phone number or email address'**
  String get pleaseEnterPhoneOrEmail;

  /// No description provided for @pleaseProvideValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please provide a valid email address'**
  String get pleaseProvideValidEmail;

  /// No description provided for @pleaseProvideValidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please provide a valid phone number'**
  String get pleaseProvideValidPhoneNumber;

  /// No description provided for @pleaseProvideValidPhoneOrEmail.
  ///
  /// In en, this message translates to:
  /// **'Please provide a valid phone number or email address'**
  String get pleaseProvideValidPhoneOrEmail;

  /// No description provided for @pleaseProvideYourName.
  ///
  /// In en, this message translates to:
  /// **'Please provide your name'**
  String get pleaseProvideYourName;

  /// No description provided for @pleaseWaitRegistering.
  ///
  /// In en, this message translates to:
  /// **'Registering account, please wait'**
  String get pleaseWaitRegistering;

  /// No description provided for @pleaseWaitSendingCode.
  ///
  /// In en, this message translates to:
  /// **'Please wait, sending code'**
  String get pleaseWaitSendingCode;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicy;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get processing;

  /// No description provided for @ratingSaved.
  ///
  /// In en, this message translates to:
  /// **'Rating saved'**
  String get ratingSaved;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get readMore;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @references.
  ///
  /// In en, this message translates to:
  /// **'References'**
  String get references;

  /// No description provided for @registrationFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed'**
  String get registrationFailed;

  /// No description provided for @requestFailed.
  ///
  /// In en, this message translates to:
  /// **'Request failed'**
  String get requestFailed;

  /// No description provided for @requestNewCode.
  ///
  /// In en, this message translates to:
  /// **'Get new code'**
  String get requestNewCode;

  /// No description provided for @requestNewPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Get new Password'**
  String get requestNewPasswordTitle;

  /// No description provided for @resources.
  ///
  /// In en, this message translates to:
  /// **'Resources'**
  String get resources;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// No description provided for @retrievingCoordinates.
  ///
  /// In en, this message translates to:
  /// **'Retrieving coordinates'**
  String get retrievingCoordinates;

  /// No description provided for @routineAddedToCalendar.
  ///
  /// In en, this message translates to:
  /// **'Routine added to calendar'**
  String get routineAddedToCalendar;

  /// No description provided for @routines.
  ///
  /// In en, this message translates to:
  /// **'Routines'**
  String get routines;

  /// No description provided for @routines_title.
  ///
  /// In en, this message translates to:
  /// **'Routines'**
  String get routines_title;

  /// No description provided for @saveAnswer.
  ///
  /// In en, this message translates to:
  /// **'Save answer'**
  String get saveAnswer;

  /// No description provided for @saveData.
  ///
  /// In en, this message translates to:
  /// **'Save data'**
  String get saveData;

  /// No description provided for @savingDataFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to save data'**
  String get savingDataFailed;

  /// No description provided for @scanCode.
  ///
  /// In en, this message translates to:
  /// **'Scan Code'**
  String get scanCode;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score;

  /// No description provided for @scoreListIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No score earned yet'**
  String get scoreListIsEmpty;

  /// No description provided for @sendAnswer.
  ///
  /// In en, this message translates to:
  /// **'Send answer'**
  String get sendAnswer;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'settings'**
  String get settings;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @startAssessment.
  ///
  /// In en, this message translates to:
  /// **'Start new assessment'**
  String get startAssessment;

  /// No description provided for @tasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasks;

  /// No description provided for @thankyouForFeedback.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your input!'**
  String get thankyouForFeedback;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @twoWeeks.
  ///
  /// In en, this message translates to:
  /// **'Two weeks'**
  String get twoWeeks;

  /// No description provided for @unknownUser.
  ///
  /// In en, this message translates to:
  /// **'unknown user'**
  String get unknownUser;

  /// No description provided for @unnamed.
  ///
  /// In en, this message translates to:
  /// **'Unnamed'**
  String get unnamed;

  /// No description provided for @unnamedActivity.
  ///
  /// In en, this message translates to:
  /// **'Unnamed activity'**
  String get unnamedActivity;

  /// No description provided for @unnamedLibraryItem.
  ///
  /// In en, this message translates to:
  /// **'Unnamed item'**
  String get unnamedLibraryItem;

  /// No description provided for @unnamedRoutine.
  ///
  /// In en, this message translates to:
  /// **'Untitled routine'**
  String get unnamedRoutine;

  /// No description provided for @unnamedWebPage.
  ///
  /// In en, this message translates to:
  /// **'Untitled page'**
  String get unnamedWebPage;

  /// No description provided for @untitled.
  ///
  /// In en, this message translates to:
  /// **'Untitled'**
  String get untitled;

  /// No description provided for @useCode.
  ///
  /// In en, this message translates to:
  /// **'Use code'**
  String get useCode;

  /// No description provided for @userInformation.
  ///
  /// In en, this message translates to:
  /// **'User information'**
  String get userInformation;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get userNotFound;

  /// No description provided for @validateContactTitle.
  ///
  /// In en, this message translates to:
  /// **'Validate contact information'**
  String get validateContactTitle;

  /// No description provided for @valueIsRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get valueIsRequired;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'verify'**
  String get verify;

  /// No description provided for @visitRemoved.
  ///
  /// In en, this message translates to:
  /// **'Visit removed'**
  String get visitRemoved;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @welcomeInfo.
  ///
  /// In en, this message translates to:
  /// **'Show welcome info'**
  String get welcomeInfo;

  /// No description provided for @writeAnswerHere.
  ///
  /// In en, this message translates to:
  /// **'Write your answer here for '**
  String get writeAnswerHere;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @youHaveThisBadge.
  ///
  /// In en, this message translates to:
  /// **'You have this achievement'**
  String get youHaveThisBadge;

  /// No description provided for @yourAnswerHasBeenSaved.
  ///
  /// In en, this message translates to:
  /// **'Your answer has been saved'**
  String get yourAnswerHasBeenSaved;

  /// No description provided for @yourPassword.
  ///
  /// In en, this message translates to:
  /// **'Your password'**
  String get yourPassword;

  /// No description provided for @yourLogDates.
  ///
  /// In en, this message translates to:
  /// **'Your log dates'**
  String get yourLogDates;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'en',
        'es',
        'et',
        'fi',
        'nl',
        'pl',
        'pt'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'et':
      return AppLocalizationsEt();
    case 'fi':
      return AppLocalizationsFi();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
