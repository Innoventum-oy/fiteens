// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a nl locale. All the
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
  String get localeName => 'nl';

  static String m0(startdate) =>
      "Je kunt deze activiteit pas als voltooid markeren na ${startdate}";

  static String m1(startdate) =>
      "Het evenement kan niet worden overgeslagen vóór de datum";

  static String m2(item) =>
      "${Intl.select(item, {'home': 'Home', 'calendar': 'Kalender', 'routines': 'Routines', 'mywellbeing': 'Mijn welzijn', 'library': 'Bibliotheek/Middelen', 'dashboard': 'Dashboard', 'other': 'Menu:${item}'})}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("Over"),
    "accountCreated": MessageLookupByLibrary.simpleMessage(
      "Account aangemaakt",
    ),
    "accountDeleted": MessageLookupByLibrary.simpleMessage(
      "Gebruikersaccount verwijderd",
    ),
    "accountDeletion": MessageLookupByLibrary.simpleMessage(
      "Account verwijderen",
    ),
    "achievements": MessageLookupByLibrary.simpleMessage("Prestaties"),
    "activities": MessageLookupByLibrary.simpleMessage("Activiteiten"),
    "activity": MessageLookupByLibrary.simpleMessage("Activiteit"),
    "activityCalendar": MessageLookupByLibrary.simpleMessage(
      "Activiteitenkalender",
    ),
    "activityLevel": MessageLookupByLibrary.simpleMessage("Activiteitsniveau"),
    "activityRecorded": MessageLookupByLibrary.simpleMessage(
      "Activiteit opgenomen",
    ),
    "activityRegistrationFailed": MessageLookupByLibrary.simpleMessage(
      "Het bijwerken van de activiteitsstatus is mislukt",
    ),
    "activityRegistrationSaved": MessageLookupByLibrary.simpleMessage(
      "Activiteit gemarkeerd als voltooid",
    ),
    "addedToList": MessageLookupByLibrary.simpleMessage("Toegevoegd aan lijst"),
    "addingRoutineFailed": MessageLookupByLibrary.simpleMessage(
      "Het toevoegen van routine aan de kalender is mislukt",
    ),
    "address": MessageLookupByLibrary.simpleMessage("Adres"),
    "ageOver13": MessageLookupByLibrary.simpleMessage(
      "Ben je ouder dan 13 jaar?",
    ),
    "alreadyDone": MessageLookupByLibrary.simpleMessage("Al gedaan"),
    "answerDate": MessageLookupByLibrary.simpleMessage("Antwoorddatum"),
    "answerSaved": MessageLookupByLibrary.simpleMessage("Antwoord opgeslagen"),
    "appName": MessageLookupByLibrary.simpleMessage("FiTeens"),
    "authenticating": MessageLookupByLibrary.simpleMessage(
      "Authenticeren ... Even geduld aub",
    ),
    "btnAddToCalendar": MessageLookupByLibrary.simpleMessage(
      "Toevoegen aan kalender",
    ),
    "btnConfirm": MessageLookupByLibrary.simpleMessage("Bevestigen"),
    "btnContinue": MessageLookupByLibrary.simpleMessage("Doorgaan"),
    "btnDashboard": MessageLookupByLibrary.simpleMessage("Dashboard openen"),
    "btnLogin": MessageLookupByLibrary.simpleMessage("Inloggen"),
    "btnMarkAsDone": MessageLookupByLibrary.simpleMessage(
      "Marker als voltooid",
    ),
    "btnReturn": MessageLookupByLibrary.simpleMessage("Terug"),
    "btnReturnBook": MessageLookupByLibrary.simpleMessage("Boek retourneren"),
    "btnSend": MessageLookupByLibrary.simpleMessage("Verzenden"),
    "btnSetNewPassword": MessageLookupByLibrary.simpleMessage(
      "Wachtwoord instellen",
    ),
    "btnShow": MessageLookupByLibrary.simpleMessage("Tonen"),
    "btnSkip": MessageLookupByLibrary.simpleMessage("Overslaan"),
    "btnTasks": MessageLookupByLibrary.simpleMessage("Taken"),
    "btnUseEmail": MessageLookupByLibrary.simpleMessage("E-mail gebruiken"),
    "btnUsePhone": MessageLookupByLibrary.simpleMessage(
      "Telefoonnummer gebruiken",
    ),
    "btnValidateContact": MessageLookupByLibrary.simpleMessage(
      "Valideer contactgegevens nu",
    ),
    "btnValidateContactLater": MessageLookupByLibrary.simpleMessage("Later"),
    "calendar": MessageLookupByLibrary.simpleMessage("Kalender"),
    "calendarUpdated": MessageLookupByLibrary.simpleMessage(
      "Kalender bijgewerkt",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Annuleren"),
    "cannotSaveEmptyForm": MessageLookupByLibrary.simpleMessage(
      "Kan geen leeg formulier opslaan",
    ),
    "challenges": MessageLookupByLibrary.simpleMessage("Uitdagingen"),
    "choose": MessageLookupByLibrary.simpleMessage("Kiezen"),
    "chooseFile": MessageLookupByLibrary.simpleMessage("Bestand kiezen"),
    "clickPictureToChooseAvatar": MessageLookupByLibrary.simpleMessage(
      "Klik op de afbeelding om een avatar te kiezen",
    ),
    "codeAccepted": MessageLookupByLibrary.simpleMessage("Code geaccepteerd"),
    "codeScanned": MessageLookupByLibrary.simpleMessage("Code gescand"),
    "collectedBadges": MessageLookupByLibrary.simpleMessage(
      "Verzamelde badges",
    ),
    "confirmDeletingAccount": MessageLookupByLibrary.simpleMessage(
      "Bevestig het verwijderen van het gebruikersaccount",
    ),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "Wachtwoord bevestigen",
    ),
    "confirmationKey": MessageLookupByLibrary.simpleMessage(
      "Bevestigingssleutel",
    ),
    "contactInformation": MessageLookupByLibrary.simpleMessage(
      "Contactinformatie",
    ),
    "contactInformationValidated": MessageLookupByLibrary.simpleMessage(
      "Contactgegevens gevalideerd",
    ),
    "contactMethod": MessageLookupByLibrary.simpleMessage("Contactmethode"),
    "contactMethods": MessageLookupByLibrary.simpleMessage("Contactmethoden"),
    "contentNotFound": MessageLookupByLibrary.simpleMessage(
      "Inhoud niet gevonden",
    ),
    "couldNotOpenLink": MessageLookupByLibrary.simpleMessage(
      "Kan de link niet openen",
    ),
    "createAccount": MessageLookupByLibrary.simpleMessage("Account aanmaken"),
    "dateRange": MessageLookupByLibrary.simpleMessage("Datumreeks"),
    "deleteAccount": MessageLookupByLibrary.simpleMessage(
      "Account verwijderen",
    ),
    "deleteYourAccount": MessageLookupByLibrary.simpleMessage(
      "Verwijder je account",
    ),
    "deletingAccountCannotUndone": MessageLookupByLibrary.simpleMessage(
      "Het gebruikersaccount wordt onmiddellijk verwijderd. Deze actie kan niet ongedaan worden gemaakt.",
    ),
    "deletingAccountFailed": MessageLookupByLibrary.simpleMessage(
      "Het verwijderen van het account is mislukt",
    ),
    "discover": MessageLookupByLibrary.simpleMessage("Ontdekken"),
    "downloadCertificate": MessageLookupByLibrary.simpleMessage(
      "Certificaat downloaden",
    ),
    "downloadOpenBadge": MessageLookupByLibrary.simpleMessage(
      "Open Badge downloaden",
    ),
    "edit": MessageLookupByLibrary.simpleMessage("Bewerken"),
    "email": MessageLookupByLibrary.simpleMessage("E-mail"),
    "emailOrPhoneNumber": MessageLookupByLibrary.simpleMessage(
      "E-mail of telefoonnummer",
    ),
    "enterGroupCode": MessageLookupByLibrary.simpleMessage(
      "Voer hier je groepscode in",
    ),
    "enterNewCode": MessageLookupByLibrary.simpleMessage("Voer nieuwe code in"),
    "enterPassword": MessageLookupByLibrary.simpleMessage(
      "Wachtwoord invoeren",
    ),
    "error": MessageLookupByLibrary.simpleMessage("Fout"),
    "errorsInForm": MessageLookupByLibrary.simpleMessage(
      "Fouten in de formulierinhoud",
    ),
    "eventCannotBeMarkedBeforeDate": m0,
    "eventCannotBeSkippedBeforeDate": m1,
    "eventInFuture": MessageLookupByLibrary.simpleMessage(
      "De activiteit is gepland in de toekomst",
    ),
    "eventLog": MessageLookupByLibrary.simpleMessage("Gebeurtenislogboek"),
    "failedToSaveAnswer": MessageLookupByLibrary.simpleMessage(
      "Kon je antwoord niet opslaan",
    ),
    "feedback": MessageLookupByLibrary.simpleMessage("Feedback"),
    "feedbackSent": MessageLookupByLibrary.simpleMessage("Feedback verzonden"),
    "fieldCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
      "Veld mag niet leeg zijn",
    ),
    "firstName": MessageLookupByLibrary.simpleMessage("Voornaam"),
    "flashOff": MessageLookupByLibrary.simpleMessage("Flash uit"),
    "flashOn": MessageLookupByLibrary.simpleMessage("Flash aan"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Wachtwoord vergeten?",
    ),
    "formIsEmpty": MessageLookupByLibrary.simpleMessage("Formulier is leeg"),
    "forms": MessageLookupByLibrary.simpleMessage("Formulieren"),
    "getCode": MessageLookupByLibrary.simpleMessage("Code ophalen"),
    "great": MessageLookupByLibrary.simpleMessage("Geweldig!"),
    "groupCode": MessageLookupByLibrary.simpleMessage("Groepscode"),
    "guardianInfo": MessageLookupByLibrary.simpleMessage("Informatie voogd"),
    "guardianName": MessageLookupByLibrary.simpleMessage("Naam voogd"),
    "guardianPhone": MessageLookupByLibrary.simpleMessage("Telefoon voogd"),
    "healthyFood": MessageLookupByLibrary.simpleMessage("Gezond eten"),
    "healthyLifestyle": MessageLookupByLibrary.simpleMessage(
      "Gezonde levensstijl",
    ),
    "joinedToGroup": MessageLookupByLibrary.simpleMessage(
      "Je bent lid geworden van een nieuwe groep",
    ),
    "joiningGroupFailed": MessageLookupByLibrary.simpleMessage(
      "Het is niet gelukt om lid te worden van de groep met de opgegeven code",
    ),
    "joiningToUserGroup": MessageLookupByLibrary.simpleMessage(
      "Lid worden van nieuwe groep",
    ),
    "lastName": MessageLookupByLibrary.simpleMessage("Achternaam"),
    "library": MessageLookupByLibrary.simpleMessage("Bibliotheek"),
    "libraryIsEmpty": MessageLookupByLibrary.simpleMessage(
      "De bibliotheek is leeg",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Laden"),
    "locations": MessageLookupByLibrary.simpleMessage("Locaties"),
    "login": MessageLookupByLibrary.simpleMessage("Inloggen"),
    "loginFailed": MessageLookupByLibrary.simpleMessage("Inloggen mislukt"),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Inloggen"),
    "logout": MessageLookupByLibrary.simpleMessage("Uitloggen"),
    "month": MessageLookupByLibrary.simpleMessage("Maand"),
    "moreInformation": MessageLookupByLibrary.simpleMessage("Meer informatie"),
    "myActivities": MessageLookupByLibrary.simpleMessage("Mijn activiteiten"),
    "myPoints": MessageLookupByLibrary.simpleMessage("Mijn punten"),
    "myScore": MessageLookupByLibrary.simpleMessage("Mijn score"),
    "navitem": m2,
    "next": MessageLookupByLibrary.simpleMessage("Volgende"),
    "no": MessageLookupByLibrary.simpleMessage("nee"),
    "noActivitiesFound": MessageLookupByLibrary.simpleMessage(
      "Geen activiteiten gevonden",
    ),
    "noContactMethodsFound": MessageLookupByLibrary.simpleMessage(
      "Geen contactmethoden gevonden",
    ),
    "noDescription": MessageLookupByLibrary.simpleMessage("Geen beschrijving"),
    "noEventsFound": MessageLookupByLibrary.simpleMessage(
      "Geen evenementen gevonden",
    ),
    "noFormsFound": MessageLookupByLibrary.simpleMessage(
      "Geen formulieren gevonden",
    ),
    "noResourcesFound": MessageLookupByLibrary.simpleMessage(
      "Geen middelen beschikbaar",
    ),
    "noRoutinesFound": MessageLookupByLibrary.simpleMessage(
      "Geen routines gevonden",
    ),
    "noTasks": MessageLookupByLibrary.simpleMessage("Geen taken"),
    "noThankYou": MessageLookupByLibrary.simpleMessage("Nee bedankt"),
    "noUsersFound": MessageLookupByLibrary.simpleMessage(
      "Geen gebruikers gevonden",
    ),
    "noVisitsFound": MessageLookupByLibrary.simpleMessage(
      "Geen bezoeken gevonden",
    ),
    "notVerified": MessageLookupByLibrary.simpleMessage("Niet geverifieerd"),
    "notification": MessageLookupByLibrary.simpleMessage("Melding"),
    "ok": MessageLookupByLibrary.simpleMessage("Ok"),
    "oops": MessageLookupByLibrary.simpleMessage("Oeps!"),
    "otherItems": MessageLookupByLibrary.simpleMessage("Overige"),
    "pageContent": MessageLookupByLibrary.simpleMessage("Pagina-inhoud"),
    "pageCount": MessageLookupByLibrary.simpleMessage("Aantal pagina\'s:"),
    "participants": MessageLookupByLibrary.simpleMessage("Deelnemers"),
    "password": MessageLookupByLibrary.simpleMessage("Wachtwoord"),
    "passwordChanged": MessageLookupByLibrary.simpleMessage(
      "Wachtwoord gewijzigd",
    ),
    "passwordIsRequired": MessageLookupByLibrary.simpleMessage(
      "Wachtwoord is verplicht",
    ),
    "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
      "Wachtwoord en bevestiging komen niet overeen",
    ),
    "pause": MessageLookupByLibrary.simpleMessage("Pauze"),
    "phone": MessageLookupByLibrary.simpleMessage("Telefoon"),
    "phoneOrEmail": MessageLookupByLibrary.simpleMessage("Telefoon of e-mail"),
    "physicalActivities": MessageLookupByLibrary.simpleMessage(
      "Fysieke activiteiten",
    ),
    "pleaseCompleteFormProperly": MessageLookupByLibrary.simpleMessage(
      "Vul het formulier correct in",
    ),
    "pleaseEnterConfirmationKey": MessageLookupByLibrary.simpleMessage(
      "Voer de bevestigingssleutel in",
    ),
    "pleaseEnterPassword": MessageLookupByLibrary.simpleMessage(
      "Voer een wachtwoord in",
    ),
    "pleaseEnterPhoneNumber": MessageLookupByLibrary.simpleMessage(
      "Voer telefoonnummer in",
    ),
    "pleaseEnterPhoneOrEmail": MessageLookupByLibrary.simpleMessage(
      "Voer telefoonnummer of e-mailadres in",
    ),
    "pleaseProvideValidEmail": MessageLookupByLibrary.simpleMessage(
      "Geef een geldig e-mailadres op",
    ),
    "pleaseProvideValidPhoneNumber": MessageLookupByLibrary.simpleMessage(
      "Geef een geldig telefoonnummer op",
    ),
    "pleaseProvideValidPhoneOrEmail": MessageLookupByLibrary.simpleMessage(
      "Geef een geldig telefoonnummer of e-mailadres op",
    ),
    "pleaseProvideYourName": MessageLookupByLibrary.simpleMessage(
      "Geef je naam op",
    ),
    "pleaseWaitRegistering": MessageLookupByLibrary.simpleMessage(
      "Account registreren, even geduld aub",
    ),
    "pleaseWaitSendingCode": MessageLookupByLibrary.simpleMessage(
      "Even geduld, code wordt verzonden",
    ),
    "previous": MessageLookupByLibrary.simpleMessage("Vorige"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacybeleid"),
    "processing": MessageLookupByLibrary.simpleMessage("Verwerken"),
    "ratingSaved": MessageLookupByLibrary.simpleMessage(
      "Beoordeling opgeslagen",
    ),
    "readMore": MessageLookupByLibrary.simpleMessage("Lees meer"),
    "references": MessageLookupByLibrary.simpleMessage("Referenties"),
    "refresh": MessageLookupByLibrary.simpleMessage("Vernieuwen"),
    "registrationFailed": MessageLookupByLibrary.simpleMessage(
      "Registratie mislukt",
    ),
    "requestFailed": MessageLookupByLibrary.simpleMessage("Verzoek mislukt"),
    "requestNewCode": MessageLookupByLibrary.simpleMessage(
      "Nieuwe code aanvragen",
    ),
    "requestNewPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Nieuw wachtwoord aanvragen",
    ),
    "resources": MessageLookupByLibrary.simpleMessage("Middelen"),
    "resume": MessageLookupByLibrary.simpleMessage("Hervatten"),
    "retrievingCoordinates": MessageLookupByLibrary.simpleMessage(
      "Coördinaten ophalen",
    ),
    "routineAddedToCalendar": MessageLookupByLibrary.simpleMessage(
      "Routine toegevoegd aan kalender",
    ),
    "routines": MessageLookupByLibrary.simpleMessage("Routines"),
    "routines_title": MessageLookupByLibrary.simpleMessage("Routines"),
    "saveAnswer": MessageLookupByLibrary.simpleMessage("Antwoord opslaan"),
    "saveData": MessageLookupByLibrary.simpleMessage("Gegevens opslaan"),
    "savingDataFailed": MessageLookupByLibrary.simpleMessage(
      "Het opslaan van gegevens is mislukt",
    ),
    "scanCode": MessageLookupByLibrary.simpleMessage("Code scannen"),
    "score": MessageLookupByLibrary.simpleMessage("Score"),
    "scoreListIsEmpty": MessageLookupByLibrary.simpleMessage(
      "Nog geen score behaald",
    ),
    "sendAnswer": MessageLookupByLibrary.simpleMessage("Antwoord verzenden"),
    "settings": MessageLookupByLibrary.simpleMessage("Instellingen"),
    "signUp": MessageLookupByLibrary.simpleMessage("Aanmelden"),
    "startAssessment": MessageLookupByLibrary.simpleMessage(
      "Nieuwe beoordeling starten",
    ),
    "tasks": MessageLookupByLibrary.simpleMessage("Taken"),
    "thankyouForFeedback": MessageLookupByLibrary.simpleMessage(
      "Bedankt voor je input!",
    ),
    "today": MessageLookupByLibrary.simpleMessage("Vandaag"),
    "twoWeeks": MessageLookupByLibrary.simpleMessage("Twee weken"),
    "unknownUser": MessageLookupByLibrary.simpleMessage("Onbekende gebruiker"),
    "unnamed": MessageLookupByLibrary.simpleMessage("Naamloos"),
    "unnamedActivity": MessageLookupByLibrary.simpleMessage(
      "Naamloze activiteit",
    ),
    "unnamedLibraryItem": MessageLookupByLibrary.simpleMessage("Naamloos item"),
    "unnamedRoutine": MessageLookupByLibrary.simpleMessage("Naamloze routine"),
    "unnamedWebPage": MessageLookupByLibrary.simpleMessage("Naamloze pagina"),
    "untitled": MessageLookupByLibrary.simpleMessage("Zonder titel"),
    "useCode": MessageLookupByLibrary.simpleMessage("Code gebruiken"),
    "userInformation": MessageLookupByLibrary.simpleMessage(
      "Gebruikersinformatie",
    ),
    "userNotFound": MessageLookupByLibrary.simpleMessage(
      "Gebruiker niet gevonden",
    ),
    "validateContactTitle": MessageLookupByLibrary.simpleMessage(
      "Valideer contactgegevens",
    ),
    "valueIsRequired": MessageLookupByLibrary.simpleMessage(
      "Dit veld is verplicht",
    ),
    "verified": MessageLookupByLibrary.simpleMessage("Geverifieerd"),
    "verify": MessageLookupByLibrary.simpleMessage("verifiëren"),
    "visitRemoved": MessageLookupByLibrary.simpleMessage("Bezoek verwijderd"),
    "week": MessageLookupByLibrary.simpleMessage("Week"),
    "welcomeInfo": MessageLookupByLibrary.simpleMessage(
      "Welkomstinformatie weergeven",
    ),
    "writeAnswerHere": MessageLookupByLibrary.simpleMessage(
      "Schrijf hier je antwoord voor ",
    ),
    "yes": MessageLookupByLibrary.simpleMessage("Ja"),
    "youHaveThisBadge": MessageLookupByLibrary.simpleMessage(
      "Je hebt deze prestatie",
    ),
    "yourAnswerHasBeenSaved": MessageLookupByLibrary.simpleMessage(
      "Je antwoord is opgeslagen",
    ),
    "yourLogDates": MessageLookupByLibrary.simpleMessage("Je logboekdata"),
    "yourPassword": MessageLookupByLibrary.simpleMessage("Je wachtwoord"),
  };
}
