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

  static String m0(item) => "${Intl.select(item, {
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
            "Registering for activity failed"),
        "activityRegistrationSaved":
            MessageLookupByLibrary.simpleMessage("Registration saved"),
        "addedToList": MessageLookupByLibrary.simpleMessage("Added to list"),
        "address": MessageLookupByLibrary.simpleMessage("Address"),
        "ageOver13":
            MessageLookupByLibrary.simpleMessage("Are you 13+ years old?"),
        "answerSaved": MessageLookupByLibrary.simpleMessage("Answer saved"),
        "appName": MessageLookupByLibrary.simpleMessage("FiTeens *DRAFT*"),
        "authenticating": MessageLookupByLibrary.simpleMessage(
            "Authenticating ... Please wait"),
        "benefits": MessageLookupByLibrary.simpleMessage("Benefits"),
        "bookIsRead": MessageLookupByLibrary.simpleMessage("Book read"),
        "bookStatusUpdated":
            MessageLookupByLibrary.simpleMessage("Book status updated"),
        "books": MessageLookupByLibrary.simpleMessage("Books"),
        "btnAvailabilityInfo":
            MessageLookupByLibrary.simpleMessage("Availability information"),
        "btnConfirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "btnContinue": MessageLookupByLibrary.simpleMessage("Continue"),
        "btnDashboard": MessageLookupByLibrary.simpleMessage("Open Dashboard"),
        "btnLogin": MessageLookupByLibrary.simpleMessage("Login"),
        "btnMap": MessageLookupByLibrary.simpleMessage("Map"),
        "btnRead": MessageLookupByLibrary.simpleMessage("Read"),
        "btnReturn": MessageLookupByLibrary.simpleMessage("Return"),
        "btnReturnBook": MessageLookupByLibrary.simpleMessage("Return book"),
        "btnSend": MessageLookupByLibrary.simpleMessage("Send"),
        "btnSetNewPassword":
            MessageLookupByLibrary.simpleMessage("Set Password"),
        "btnShow": MessageLookupByLibrary.simpleMessage("Show"),
        "btnTasks": MessageLookupByLibrary.simpleMessage("Tasks"),
        "btnUseEmail": MessageLookupByLibrary.simpleMessage("Use Email"),
        "btnUsePhone": MessageLookupByLibrary.simpleMessage("Use Phone number"),
        "btnValidateContact": MessageLookupByLibrary.simpleMessage(
            "Validate contact information now"),
        "btnValidateContactLater":
            MessageLookupByLibrary.simpleMessage("Later"),
        "buggers": MessageLookupByLibrary.simpleMessage("Oh buggers"),
        "calendar": MessageLookupByLibrary.simpleMessage("Calendar"),
        "cameraNotAvailable":
            MessageLookupByLibrary.simpleMessage("No camera available"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "cannotOpenStation": MessageLookupByLibrary.simpleMessage(
            "You cannot access this station yet"),
        "cannotSaveEmptyForm":
            MessageLookupByLibrary.simpleMessage("Cannot save empty form"),
        "challengingBooks":
            MessageLookupByLibrary.simpleMessage("Challenging Books"),
        "choose": MessageLookupByLibrary.simpleMessage("Choose"),
        "chooseFile": MessageLookupByLibrary.simpleMessage("Choose file"),
        "chooseStartStation":
            MessageLookupByLibrary.simpleMessage("Choose start station"),
        "city": MessageLookupByLibrary.simpleMessage("City"),
        "codeAccepted": MessageLookupByLibrary.simpleMessage("Code accepted"),
        "codeScanned": MessageLookupByLibrary.simpleMessage("Code scanned"),
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
        "couldNotLoadStation": MessageLookupByLibrary.simpleMessage(
            "Could not load station information, sorry"),
        "couldNotOpenLink":
            MessageLookupByLibrary.simpleMessage("Could not open link"),
        "createAccount": MessageLookupByLibrary.simpleMessage("Create account"),
        "currentStation":
            MessageLookupByLibrary.simpleMessage("Current station"),
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
        "easyBooks": MessageLookupByLibrary.simpleMessage("Easy books"),
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
        "frontCamera": MessageLookupByLibrary.simpleMessage("Front Camera"),
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
        "lineMap": MessageLookupByLibrary.simpleMessage("Line map"),
        "loading": MessageLookupByLibrary.simpleMessage("Loading"),
        "loadingBenefits":
            MessageLookupByLibrary.simpleMessage("Loading benefits"),
        "locationRetrieved":
            MessageLookupByLibrary.simpleMessage("Location retrieved"),
        "locations": MessageLookupByLibrary.simpleMessage("Locations"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "loginFailed": MessageLookupByLibrary.simpleMessage("Login failed"),
        "loginTitle": MessageLookupByLibrary.simpleMessage("Login"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "metroMap": MessageLookupByLibrary.simpleMessage("Metro map"),
        "moderateBooks": MessageLookupByLibrary.simpleMessage("Moderate books"),
        "moreInformation":
            MessageLookupByLibrary.simpleMessage("More information"),
        "myActivities": MessageLookupByLibrary.simpleMessage("My activities"),
        "myBooks": MessageLookupByLibrary.simpleMessage("My booklist"),
        "myCard": MessageLookupByLibrary.simpleMessage("My Card"),
        "myPoints": MessageLookupByLibrary.simpleMessage("My points"),
        "myScore": MessageLookupByLibrary.simpleMessage("My Score"),
        "navitem": m0,
        "no": MessageLookupByLibrary.simpleMessage("no"),
        "noActiveBenefits":
            MessageLookupByLibrary.simpleMessage("No active benefits"),
        "noActivitiesFound": MessageLookupByLibrary.simpleMessage(
            "Could not find any activities"),
        "noContactMethodsFound":
            MessageLookupByLibrary.simpleMessage("No contact methods found"),
        "noDescription": MessageLookupByLibrary.simpleMessage("No description"),
        "noFormsFound": MessageLookupByLibrary.simpleMessage("No forms found"),
        "noResourcesFound": MessageLookupByLibrary.simpleMessage(
            "No resources currently available"),
        "noTasks": MessageLookupByLibrary.simpleMessage("No tasks"),
        "noThankYou": MessageLookupByLibrary.simpleMessage("No thank you"),
        "noUsersFound": MessageLookupByLibrary.simpleMessage("No users found"),
        "noVisitsFound":
            MessageLookupByLibrary.simpleMessage("No visits found"),
        "noVisitsToday":
            MessageLookupByLibrary.simpleMessage("No visits today"),
        "notVerified": MessageLookupByLibrary.simpleMessage("Not verified"),
        "notification": MessageLookupByLibrary.simpleMessage("Notification"),
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "oops": MessageLookupByLibrary.simpleMessage("Oops!"),
        "openStation": MessageLookupByLibrary.simpleMessage("Open station"),
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
        "pleaseEnableCamera": MessageLookupByLibrary.simpleMessage(
            "Please enable camera for scanning QR codes"),
        "pleaseEnterConfirmationKey": MessageLookupByLibrary.simpleMessage(
            "Please enter confirmation key"),
        "pleaseEnterPassword":
            MessageLookupByLibrary.simpleMessage("Please enter password"),
        "pleaseEnterPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Please enter phone number"),
        "pleaseEnterPhoneOrEmail": MessageLookupByLibrary.simpleMessage(
            "Please enter phone number or email address"),
        "pleaseProvideRegistrationCode": MessageLookupByLibrary.simpleMessage(
            "Please provide the registration code given by your school or library"),
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
        "postcode": MessageLookupByLibrary.simpleMessage("Postcode"),
        "previous": MessageLookupByLibrary.simpleMessage("Previous"),
        "priceToOpen": MessageLookupByLibrary.simpleMessage("Price"),
        "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy policy"),
        "processing": MessageLookupByLibrary.simpleMessage("Processing"),
        "qrScanner": MessageLookupByLibrary.simpleMessage("QR Scanner"),
        "rateBook": MessageLookupByLibrary.simpleMessage("Rate book"),
        "ratingSaved": MessageLookupByLibrary.simpleMessage("Rating saved"),
        "readBooksList": MessageLookupByLibrary.simpleMessage("Read books"),
        "readList": MessageLookupByLibrary.simpleMessage("Book list"),
        "readListIsEmpty":
            MessageLookupByLibrary.simpleMessage("Book list is empty!"),
        "readMore": MessageLookupByLibrary.simpleMessage("Read more"),
        "readingProgress": MessageLookupByLibrary.simpleMessage("Your status"),
        "readyToScan": MessageLookupByLibrary.simpleMessage("Scanner ready"),
        "rearCamera": MessageLookupByLibrary.simpleMessage("Rear Camera"),
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
        "returned": MessageLookupByLibrary.simpleMessage("Returned"),
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
        "station": MessageLookupByLibrary.simpleMessage("Station"),
        "stationIsPassed": MessageLookupByLibrary.simpleMessage(
            "You have passed this station"),
        "stationList": MessageLookupByLibrary.simpleMessage("Stations"),
        "submissionRejected":
            MessageLookupByLibrary.simpleMessage("Submission rejected"),
        "subwayMap": MessageLookupByLibrary.simpleMessage("Subway Map"),
        "tasks": MessageLookupByLibrary.simpleMessage("Tasks"),
        "thankyouForFeedback":
            MessageLookupByLibrary.simpleMessage("Thank you for your input!"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "transitToStation":
            MessageLookupByLibrary.simpleMessage("Transit to station"),
        "unknownUser": MessageLookupByLibrary.simpleMessage("unknown user"),
        "unnamed": MessageLookupByLibrary.simpleMessage("Unnamed"),
        "unnamedActivity":
            MessageLookupByLibrary.simpleMessage("Unnamed activity"),
        "unnamedLibraryItem":
            MessageLookupByLibrary.simpleMessage("Unnamed item"),
        "unnamedWebPage": MessageLookupByLibrary.simpleMessage("Untitled page"),
        "untitled": MessageLookupByLibrary.simpleMessage("Untitled"),
        "useCode": MessageLookupByLibrary.simpleMessage("Use code"),
        "userNotFound": MessageLookupByLibrary.simpleMessage("User not found"),
        "validateContactTitle": MessageLookupByLibrary.simpleMessage(
            "Validate contact information"),
        "valueIsRequired":
            MessageLookupByLibrary.simpleMessage("This field is required"),
        "verified": MessageLookupByLibrary.simpleMessage("Verified"),
        "verify": MessageLookupByLibrary.simpleMessage("verify"),
        "visitRemoved": MessageLookupByLibrary.simpleMessage("Visit removed"),
        "welcomeInfo":
            MessageLookupByLibrary.simpleMessage("Show welcome info"),
        "writeAnswerHere":
            MessageLookupByLibrary.simpleMessage("Write your answer here for "),
        "yes": MessageLookupByLibrary.simpleMessage("Yes"),
        "youAreNotOnAnyStation":
            MessageLookupByLibrary.simpleMessage("No station selected"),
        "youHaveOpenedThisStation": MessageLookupByLibrary.simpleMessage(
            "You have opened this station"),
        "youHaveReadThisBook":
            MessageLookupByLibrary.simpleMessage("You have read this book"),
        "youHaveThisBadge":
            MessageLookupByLibrary.simpleMessage("You have this achievement"),
        "yourAnswerHasBeenSaved":
            MessageLookupByLibrary.simpleMessage("Your answer has been saved"),
        "yourPassword": MessageLookupByLibrary.simpleMessage("Your password")
      };
}
