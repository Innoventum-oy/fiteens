// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(startdate) =>
      "You cannot mark this activity as done before ${startdate}";

  static String m1(startdate) =>
      "You cannot skip this activity before ${startdate}";

  static String m2(item) => "${Intl.select(item, {
            'home': 'Home',
            'calendar': 'Calendar',
            'routines': 'Routines',
            'mywellbeing': 'My Well-being',
            'library': 'Library/Resources',
            'dashboard': 'Dashboard',
            'other': 'Menu:${item}',
          })}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("About"),
        "accountCreated":
            MessageLookupByLibrary.simpleMessage("Account created"),
        "accountDeleted":
            MessageLookupByLibrary.simpleMessage("User account deleted"),
        "accountDeletion":
            MessageLookupByLibrary.simpleMessage("Account Deletion"),
        "achievements": MessageLookupByLibrary.simpleMessage("Achievements"),
        "activities": MessageLookupByLibrary.simpleMessage("Activities"),
        "activity": MessageLookupByLibrary.simpleMessage("Activity"),
        "activityCalendar":
            MessageLookupByLibrary.simpleMessage("Activity calendar"),
        "activityLevel": MessageLookupByLibrary.simpleMessage("Activity level"),
        "activityRecorded":
            MessageLookupByLibrary.simpleMessage("Activity recorded"),
        "activityRegistrationFailed": MessageLookupByLibrary.simpleMessage(
            "Updating activity status failed"),
        "activityRegistrationSaved":
            MessageLookupByLibrary.simpleMessage("Activity marked as done"),
        "addedToList": MessageLookupByLibrary.simpleMessage("Added to list"),
        "addingRoutineFailed": MessageLookupByLibrary.simpleMessage(
            "Adding routine to calendar failed"),
        "address": MessageLookupByLibrary.simpleMessage("Address"),
        "ageOver13":
            MessageLookupByLibrary.simpleMessage("Are you 13+ years old?"),
        "alreadyDone": MessageLookupByLibrary.simpleMessage("Already done"),
        "answerDate": MessageLookupByLibrary.simpleMessage("Answer date"),
        "answerSaved": MessageLookupByLibrary.simpleMessage("Answer saved"),
        "appName": MessageLookupByLibrary.simpleMessage("FiTeens"),
        "authenticating": MessageLookupByLibrary.simpleMessage(
            "Authenticating ... Please wait"),
        "btnAddToCalendar":
            MessageLookupByLibrary.simpleMessage("Add to calendar"),
        "btnConfirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "btnContinue": MessageLookupByLibrary.simpleMessage("Continue"),
        "btnDashboard": MessageLookupByLibrary.simpleMessage("Open Dashboard"),
        "btnLogin": MessageLookupByLibrary.simpleMessage("Login"),
        "btnMarkAsDone": MessageLookupByLibrary.simpleMessage("Mark as done"),
        "btnReturn": MessageLookupByLibrary.simpleMessage("Return"),
        "btnReturnBook": MessageLookupByLibrary.simpleMessage("Return book"),
        "btnSend": MessageLookupByLibrary.simpleMessage("Send"),
        "btnSetNewPassword":
            MessageLookupByLibrary.simpleMessage("Set Password"),
        "btnShow": MessageLookupByLibrary.simpleMessage("Show"),
        "btnSkip": MessageLookupByLibrary.simpleMessage("Skip"),
        "btnTasks": MessageLookupByLibrary.simpleMessage("Tasks"),
        "btnUseEmail": MessageLookupByLibrary.simpleMessage("Use Email"),
        "btnUsePhone": MessageLookupByLibrary.simpleMessage("Use Phone number"),
        "btnValidateContact": MessageLookupByLibrary.simpleMessage(
            "Validate contact information now"),
        "btnValidateContactLater":
            MessageLookupByLibrary.simpleMessage("Later"),
        "calendar": MessageLookupByLibrary.simpleMessage("Calendar"),
        "calendarUpdated":
            MessageLookupByLibrary.simpleMessage("Calendar updated"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "cannotSaveEmptyForm":
            MessageLookupByLibrary.simpleMessage("Cannot save empty form"),
        "challenges": MessageLookupByLibrary.simpleMessage("Challenges"),
        "choose": MessageLookupByLibrary.simpleMessage("Choose"),
        "chooseFile": MessageLookupByLibrary.simpleMessage("Choose file"),
        "clickPictureToChooseAvatar": MessageLookupByLibrary.simpleMessage(
            "Click picture to choose an avatar"),
        "codeAccepted": MessageLookupByLibrary.simpleMessage("Code accepted"),
        "codeScanned": MessageLookupByLibrary.simpleMessage("Code scanned"),
        "collectedBadges":
            MessageLookupByLibrary.simpleMessage("Collected badges"),
        "confirmDeletingAccount": MessageLookupByLibrary.simpleMessage(
            "Confirm user account deletion"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirm password"),
        "confirmationKey":
            MessageLookupByLibrary.simpleMessage("Confirmation key"),
        "contactInformation":
            MessageLookupByLibrary.simpleMessage("Contact information"),
        "contactInformationValidated":
            MessageLookupByLibrary.simpleMessage("Contact validated"),
        "contactMethod": MessageLookupByLibrary.simpleMessage("Contact method"),
        "contactMethods":
            MessageLookupByLibrary.simpleMessage("Contact methods"),
        "contentNotFound":
            MessageLookupByLibrary.simpleMessage("Content not found"),
        "couldNotOpenLink":
            MessageLookupByLibrary.simpleMessage("Could not open link"),
        "createAccount": MessageLookupByLibrary.simpleMessage("Create account"),
        "dateRange": MessageLookupByLibrary.simpleMessage("Date range"),
        "deleteAccount": MessageLookupByLibrary.simpleMessage("Delete account"),
        "deleteYourAccount":
            MessageLookupByLibrary.simpleMessage("Delete your account"),
        "deletingAccountCannotUndone": MessageLookupByLibrary.simpleMessage(
            "The user account is removed immediately. This action cannot be undone."),
        "deletingAccountFailed":
            MessageLookupByLibrary.simpleMessage("Failed to delete account"),
        "discover": MessageLookupByLibrary.simpleMessage("Discover"),
        "downloadCertificate":
            MessageLookupByLibrary.simpleMessage("Download Certificate"),
        "downloadOpenBadge":
            MessageLookupByLibrary.simpleMessage("Download Open Badge"),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailOrPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Email or Phone number"),
        "enterGroupCode":
            MessageLookupByLibrary.simpleMessage("Enter your Group Code here"),
        "enterNewCode": MessageLookupByLibrary.simpleMessage("Enter new code"),
        "enterPassword": MessageLookupByLibrary.simpleMessage("Enter password"),
        "error": MessageLookupByLibrary.simpleMessage("Error"),
        "errorsInForm":
            MessageLookupByLibrary.simpleMessage("Errors in form contents"),
        "eventCannotBeMarkedBeforeDate": m0,
        "eventCannotBeSkippedBeforeDate": m1,
        "eventInFuture": MessageLookupByLibrary.simpleMessage(
            "The activity is planned in the future"),
        "eventLog": MessageLookupByLibrary.simpleMessage("Event Log"),
        "failedToSaveAnswer":
            MessageLookupByLibrary.simpleMessage("Could not save your answer"),
        "feedback": MessageLookupByLibrary.simpleMessage("Feedback"),
        "feedbackSent": MessageLookupByLibrary.simpleMessage("Feedback sent"),
        "fieldCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("Field cannot be empty"),
        "firstName": MessageLookupByLibrary.simpleMessage("First name"),
        "flashOff": MessageLookupByLibrary.simpleMessage("Flash Off"),
        "flashOn": MessageLookupByLibrary.simpleMessage("Flash On"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Forgot password?"),
        "formIsEmpty": MessageLookupByLibrary.simpleMessage("Form is empty"),
        "forms": MessageLookupByLibrary.simpleMessage("Forms"),
        "getCode": MessageLookupByLibrary.simpleMessage("Get code"),
        "great": MessageLookupByLibrary.simpleMessage("Great!"),
        "groupCode": MessageLookupByLibrary.simpleMessage("Group code"),
        "guardianInfo":
            MessageLookupByLibrary.simpleMessage("Guardian Information"),
        "guardianName": MessageLookupByLibrary.simpleMessage("Guardian name"),
        "guardianPhone": MessageLookupByLibrary.simpleMessage("Guardian phone"),
        "healthyFood": MessageLookupByLibrary.simpleMessage("Healthy food"),
        "healthyLifestyle":
            MessageLookupByLibrary.simpleMessage("Healthy lifestyle"),
        "joinedToGroup":
            MessageLookupByLibrary.simpleMessage("You have joined a new group"),
        "joiningGroupFailed": MessageLookupByLibrary.simpleMessage(
            "Failed to join group with given code"),
        "joiningToUserGroup":
            MessageLookupByLibrary.simpleMessage("Joining to new Group"),
        "lastName": MessageLookupByLibrary.simpleMessage("Last name"),
        "library": MessageLookupByLibrary.simpleMessage("Library"),
        "libraryIsEmpty":
            MessageLookupByLibrary.simpleMessage("Library is empty"),
        "loading": MessageLookupByLibrary.simpleMessage("Loading"),
        "locations": MessageLookupByLibrary.simpleMessage("Locations"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "loginFailed": MessageLookupByLibrary.simpleMessage("Login failed"),
        "loginTitle": MessageLookupByLibrary.simpleMessage("Login"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "month": MessageLookupByLibrary.simpleMessage("Month"),
        "moreInformation":
            MessageLookupByLibrary.simpleMessage("More information"),
        "myActivities": MessageLookupByLibrary.simpleMessage("My activities"),
        "myPoints": MessageLookupByLibrary.simpleMessage("My points"),
        "myScore": MessageLookupByLibrary.simpleMessage("My Score"),
        "navitem": m2,
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "no": MessageLookupByLibrary.simpleMessage("no"),
        "noActivitiesFound": MessageLookupByLibrary.simpleMessage(
            "Could not find any activities"),
        "noContactMethodsFound":
            MessageLookupByLibrary.simpleMessage("No contact methods found"),
        "noDescription": MessageLookupByLibrary.simpleMessage("No description"),
        "noFormsFound": MessageLookupByLibrary.simpleMessage("No forms found"),
        "noResourcesFound": MessageLookupByLibrary.simpleMessage(
            "No resources currently available"),
        "noRoutinesFound":
            MessageLookupByLibrary.simpleMessage("No routines found"),
        "noTasks": MessageLookupByLibrary.simpleMessage("No tasks"),
        "noThankYou": MessageLookupByLibrary.simpleMessage("No thank you"),
        "noUsersFound": MessageLookupByLibrary.simpleMessage("No users found"),
        "noVisitsFound":
            MessageLookupByLibrary.simpleMessage("No visits found"),
        "notVerified": MessageLookupByLibrary.simpleMessage("Not verified"),
        "notification": MessageLookupByLibrary.simpleMessage("Notification"),
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "oops": MessageLookupByLibrary.simpleMessage("Oops!"),
        "otherItems": MessageLookupByLibrary.simpleMessage("Other"),
        "pageContent": MessageLookupByLibrary.simpleMessage("Page content"),
        "pageCount": MessageLookupByLibrary.simpleMessage("Page count:"),
        "participants": MessageLookupByLibrary.simpleMessage("Participants"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordChanged":
            MessageLookupByLibrary.simpleMessage("Password changed"),
        "passwordIsRequired":
            MessageLookupByLibrary.simpleMessage("Password is required"),
        "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
            "Password and confirmation do not match"),
        "pause": MessageLookupByLibrary.simpleMessage("Pause"),
        "phone": MessageLookupByLibrary.simpleMessage("Phone"),
        "phoneOrEmail": MessageLookupByLibrary.simpleMessage("Phone or Email"),
        "physicalActivities":
            MessageLookupByLibrary.simpleMessage("Physical activities"),
        "pleaseCompleteFormProperly": MessageLookupByLibrary.simpleMessage(
            "Please complete the form properly"),
        "pleaseEnterConfirmationKey": MessageLookupByLibrary.simpleMessage(
            "Please enter confirmation key"),
        "pleaseEnterPassword":
            MessageLookupByLibrary.simpleMessage("Please enter password"),
        "pleaseEnterPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Please enter phone number"),
        "pleaseEnterPhoneOrEmail": MessageLookupByLibrary.simpleMessage(
            "Please enter phone number or email address"),
        "pleaseProvideValidEmail": MessageLookupByLibrary.simpleMessage(
            "Please provide a valid email address"),
        "pleaseProvideValidPhoneNumber": MessageLookupByLibrary.simpleMessage(
            "Please provide a valid phone number"),
        "pleaseProvideValidPhoneOrEmail": MessageLookupByLibrary.simpleMessage(
            "Please provide a valid phone number or email address"),
        "pleaseProvideYourName":
            MessageLookupByLibrary.simpleMessage("Please provide your name"),
        "pleaseWaitRegistering": MessageLookupByLibrary.simpleMessage(
            "Registering account, please wait"),
        "pleaseWaitSendingCode":
            MessageLookupByLibrary.simpleMessage("Please wait, sending code"),
        "previous": MessageLookupByLibrary.simpleMessage("Previous"),
        "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy policy"),
        "processing": MessageLookupByLibrary.simpleMessage("Processing"),
        "ratingSaved": MessageLookupByLibrary.simpleMessage("Rating saved"),
        "readMore": MessageLookupByLibrary.simpleMessage("Read more"),
        "refresh": MessageLookupByLibrary.simpleMessage("Refresh"),
        "registrationFailed":
            MessageLookupByLibrary.simpleMessage("Registration failed"),
        "requestFailed": MessageLookupByLibrary.simpleMessage("Request failed"),
        "requestNewCode": MessageLookupByLibrary.simpleMessage("Get new code"),
        "requestNewPasswordTitle":
            MessageLookupByLibrary.simpleMessage("Get new Password"),
        "resources": MessageLookupByLibrary.simpleMessage("Resources"),
        "resume": MessageLookupByLibrary.simpleMessage("Resume"),
        "retrievingCoordinates":
            MessageLookupByLibrary.simpleMessage("Retrieving coordinates"),
        "routineAddedToCalendar":
            MessageLookupByLibrary.simpleMessage("Routine added to calendar"),
        "routines": MessageLookupByLibrary.simpleMessage("Routines"),
        "routines_title": MessageLookupByLibrary.simpleMessage("Routines"),
        "saveAnswer": MessageLookupByLibrary.simpleMessage("Save answer"),
        "saveData": MessageLookupByLibrary.simpleMessage("Save data"),
        "savingDataFailed":
            MessageLookupByLibrary.simpleMessage("Failed to save data"),
        "scanCode": MessageLookupByLibrary.simpleMessage("Scan Code"),
        "score": MessageLookupByLibrary.simpleMessage("Score"),
        "scoreListIsEmpty":
            MessageLookupByLibrary.simpleMessage("No score earned yet"),
        "sendAnswer": MessageLookupByLibrary.simpleMessage("Send answer"),
        "settings": MessageLookupByLibrary.simpleMessage("settings"),
        "signUp": MessageLookupByLibrary.simpleMessage("Sign up"),
        "startAssessment":
            MessageLookupByLibrary.simpleMessage("Start new assessment"),
        "tasks": MessageLookupByLibrary.simpleMessage("Tasks"),
        "thankyouForFeedback":
            MessageLookupByLibrary.simpleMessage("Thank you for your input!"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "twoWeeks": MessageLookupByLibrary.simpleMessage("Two weeks"),
        "unknownUser": MessageLookupByLibrary.simpleMessage("unknown user"),
        "unnamed": MessageLookupByLibrary.simpleMessage("Unnamed"),
        "unnamedActivity":
            MessageLookupByLibrary.simpleMessage("Unnamed activity"),
        "unnamedLibraryItem":
            MessageLookupByLibrary.simpleMessage("Unnamed item"),
        "unnamedRoutine":
            MessageLookupByLibrary.simpleMessage("Untitled routine"),
        "unnamedWebPage": MessageLookupByLibrary.simpleMessage("Untitled page"),
        "untitled": MessageLookupByLibrary.simpleMessage("Untitled"),
        "useCode": MessageLookupByLibrary.simpleMessage("Use code"),
        "userInformation":
            MessageLookupByLibrary.simpleMessage("User information"),
        "userNotFound": MessageLookupByLibrary.simpleMessage("User not found"),
        "validateContactTitle": MessageLookupByLibrary.simpleMessage(
            "Validate contact information"),
        "valueIsRequired":
            MessageLookupByLibrary.simpleMessage("This field is required"),
        "verified": MessageLookupByLibrary.simpleMessage("Verified"),
        "verify": MessageLookupByLibrary.simpleMessage("verify"),
        "visitRemoved": MessageLookupByLibrary.simpleMessage("Visit removed"),
        "week": MessageLookupByLibrary.simpleMessage("Week"),
        "welcomeInfo":
            MessageLookupByLibrary.simpleMessage("Show welcome info"),
        "writeAnswerHere":
            MessageLookupByLibrary.simpleMessage("Write your answer here for "),
        "yes": MessageLookupByLibrary.simpleMessage("Yes"),
        "youHaveThisBadge":
            MessageLookupByLibrary.simpleMessage("You have this achievement"),
        "yourAnswerHasBeenSaved":
            MessageLookupByLibrary.simpleMessage("Your answer has been saved"),
        "yourPassword": MessageLookupByLibrary.simpleMessage("Your password")
      };
}
