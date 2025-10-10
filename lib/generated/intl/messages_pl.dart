// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pl locale. All the
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
  String get localeName => 'pl';

  static String m0(startdate) =>
      "Nie możesz oznaczyć tej aktywności jako wykonanej przed ${startdate}";

  static String m1(startdate) => "Wydarzenie nie może być pominięte przed datą";

  static String m2(item) =>
      "${Intl.select(item, {'home': 'Strona główna', 'calendar': 'Kalendarz', 'routines': 'Plany treningowe', 'mywellbeing': 'Moje samopoczucie', 'library': 'Biblioteka/Zasoby', 'dashboard': 'Panel', 'other': 'Menu:${item}'})}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("O nas"),
    "accountCreated": MessageLookupByLibrary.simpleMessage("Konto utworzone"),
    "accountDeleted": MessageLookupByLibrary.simpleMessage(
      "Konto użytkownika usunięte",
    ),
    "accountDeletion": MessageLookupByLibrary.simpleMessage("Usuwanie konta"),
    "achievements": MessageLookupByLibrary.simpleMessage("Osiągnięcia"),
    "activities": MessageLookupByLibrary.simpleMessage("Aktywności"),
    "activity": MessageLookupByLibrary.simpleMessage("Aktywność"),
    "activityCalendar": MessageLookupByLibrary.simpleMessage(
      "Kalendarz aktywności",
    ),
    "activityLevel": MessageLookupByLibrary.simpleMessage("Poziom aktywności"),
    "activityRecorded": MessageLookupByLibrary.simpleMessage(
      "Aktywność zapisana",
    ),
    "activityRegistrationFailed": MessageLookupByLibrary.simpleMessage(
      "Aktualizacja statusu aktywności nie powiodła się",
    ),
    "activityRegistrationSaved": MessageLookupByLibrary.simpleMessage(
      "Aktywność oznaczona jako wykonana",
    ),
    "addedToList": MessageLookupByLibrary.simpleMessage("Dodane do listy"),
    "addingRoutineFailed": MessageLookupByLibrary.simpleMessage(
      "Dodawanie Planu treningowego do kalendarza nie powiodło się",
    ),
    "address": MessageLookupByLibrary.simpleMessage("Adres"),
    "ageOver13": MessageLookupByLibrary.simpleMessage(
      "Czy masz 13 lat lub więcej?",
    ),
    "alreadyDone": MessageLookupByLibrary.simpleMessage("Już wykonane"),
    "answerDate": MessageLookupByLibrary.simpleMessage("Data odpowiedzi"),
    "answerSaved": MessageLookupByLibrary.simpleMessage("Odpowiedź zapisana"),
    "appName": MessageLookupByLibrary.simpleMessage("FiTeens"),
    "authenticating": MessageLookupByLibrary.simpleMessage(
      "Uwierzytelnianie... Proszę czekać",
    ),
    "btnAddToCalendar": MessageLookupByLibrary.simpleMessage(
      "Dodaj do kalendarza",
    ),
    "btnConfirm": MessageLookupByLibrary.simpleMessage("Potwierdź"),
    "btnContinue": MessageLookupByLibrary.simpleMessage("Kontynuuj"),
    "btnDashboard": MessageLookupByLibrary.simpleMessage("Otwórz panel"),
    "btnLogin": MessageLookupByLibrary.simpleMessage("Zaloguj się"),
    "btnMarkAsDone": MessageLookupByLibrary.simpleMessage(
      "Oznacz jako wykonane",
    ),
    "btnReturn": MessageLookupByLibrary.simpleMessage("Powrót"),
    "btnReturnBook": MessageLookupByLibrary.simpleMessage("Zwróć książkę"),
    "btnSend": MessageLookupByLibrary.simpleMessage("Wyślij"),
    "btnSetNewPassword": MessageLookupByLibrary.simpleMessage("Ustaw hasło"),
    "btnShow": MessageLookupByLibrary.simpleMessage("Pokaż"),
    "btnSkip": MessageLookupByLibrary.simpleMessage("Pomiń"),
    "btnTasks": MessageLookupByLibrary.simpleMessage("Zadania"),
    "btnUseEmail": MessageLookupByLibrary.simpleMessage("Użyj adresu e-mail"),
    "btnUsePhone": MessageLookupByLibrary.simpleMessage("Użyj numeru telefonu"),
    "btnValidateContact": MessageLookupByLibrary.simpleMessage(
      "Zweryfikuj informacje kontaktowe teraz",
    ),
    "btnValidateContactLater": MessageLookupByLibrary.simpleMessage("Później"),
    "calendar": MessageLookupByLibrary.simpleMessage("Kalendarz"),
    "calendarUpdated": MessageLookupByLibrary.simpleMessage(
      "Kalendarz zaktualizowany",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Anuluj"),
    "cannotSaveEmptyForm": MessageLookupByLibrary.simpleMessage(
      "Nie można zapisać pustego formularza",
    ),
    "challenges": MessageLookupByLibrary.simpleMessage("Wyzwania"),
    "choose": MessageLookupByLibrary.simpleMessage("Wybierz"),
    "chooseFile": MessageLookupByLibrary.simpleMessage("Wybierz plik"),
    "clickPictureToChooseAvatar": MessageLookupByLibrary.simpleMessage(
      "Kliknij zdjęcie, aby wybrać awatar",
    ),
    "codeAccepted": MessageLookupByLibrary.simpleMessage("Kod zaakceptowany"),
    "codeScanned": MessageLookupByLibrary.simpleMessage("Kod zeskanowany"),
    "collectedBadges": MessageLookupByLibrary.simpleMessage("Zebrane odznaki"),
    "confirmDeletingAccount": MessageLookupByLibrary.simpleMessage(
      "Potwierdź usunięcie konta użytkownika",
    ),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("Potwierdź hasło"),
    "confirmationKey": MessageLookupByLibrary.simpleMessage(
      "Klucz potwierdzenia",
    ),
    "contactInformation": MessageLookupByLibrary.simpleMessage(
      "Informacje kontaktowe",
    ),
    "contactInformationValidated": MessageLookupByLibrary.simpleMessage(
      "Informacje kontaktowe zweryfikowane",
    ),
    "contactMethod": MessageLookupByLibrary.simpleMessage("Metoda kontaktu"),
    "contactMethods": MessageLookupByLibrary.simpleMessage("Metody kontaktu"),
    "contentNotFound": MessageLookupByLibrary.simpleMessage(
      "Nie znaleziono treści",
    ),
    "couldNotOpenLink": MessageLookupByLibrary.simpleMessage(
      "Nie można otworzyć linku",
    ),
    "createAccount": MessageLookupByLibrary.simpleMessage("Utwórz konto"),
    "dateRange": MessageLookupByLibrary.simpleMessage("Zakres dat"),
    "deleteAccount": MessageLookupByLibrary.simpleMessage("Usuń konto"),
    "deleteYourAccount": MessageLookupByLibrary.simpleMessage(
      "Usuń swoje konto",
    ),
    "deletingAccountCannotUndone": MessageLookupByLibrary.simpleMessage(
      "Konto użytkownika zostanie natychmiast usunięte. Tej operacji nie można cofnąć.",
    ),
    "deletingAccountFailed": MessageLookupByLibrary.simpleMessage(
      "Nie udało się usunąć konta",
    ),
    "discover": MessageLookupByLibrary.simpleMessage("Odkryj"),
    "downloadCertificate": MessageLookupByLibrary.simpleMessage(
      "Pobierz certyfikat",
    ),
    "downloadOpenBadge": MessageLookupByLibrary.simpleMessage(
      "Pobierz Open Badge",
    ),
    "edit": MessageLookupByLibrary.simpleMessage("Edytuj"),
    "email": MessageLookupByLibrary.simpleMessage("E-mail"),
    "emailOrPhoneNumber": MessageLookupByLibrary.simpleMessage(
      "E-mail lub numer telefonu",
    ),
    "enterGroupCode": MessageLookupByLibrary.simpleMessage(
      "Wprowadź kod grupy",
    ),
    "enterNewCode": MessageLookupByLibrary.simpleMessage("Wprowadź nowy kod"),
    "enterPassword": MessageLookupByLibrary.simpleMessage("Wprowadź hasło"),
    "error": MessageLookupByLibrary.simpleMessage("Błąd"),
    "errorsInForm": MessageLookupByLibrary.simpleMessage(
      "Błędy w treści formularza",
    ),
    "eventCannotBeMarkedBeforeDate": m0,
    "eventCannotBeSkippedBeforeDate": m1,
    "eventInFuture": MessageLookupByLibrary.simpleMessage(
      "Aktywność jest zaplanowana na przyszłość",
    ),
    "eventLog": MessageLookupByLibrary.simpleMessage("Dziennik aktywności"),
    "failedToSaveAnswer": MessageLookupByLibrary.simpleMessage(
      "Nie udało się zapisać odpowiedzi",
    ),
    "feedback": MessageLookupByLibrary.simpleMessage("Opinia"),
    "feedbackSent": MessageLookupByLibrary.simpleMessage("Opinia wysłana"),
    "fieldCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
      "Pole nie może być puste",
    ),
    "firstName": MessageLookupByLibrary.simpleMessage("Imię"),
    "flashOff": MessageLookupByLibrary.simpleMessage("Wyłącz flash"),
    "flashOn": MessageLookupByLibrary.simpleMessage("Włącz flash"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Zapomniałeś hasła?",
    ),
    "formIsEmpty": MessageLookupByLibrary.simpleMessage("Formularz jest pusty"),
    "forms": MessageLookupByLibrary.simpleMessage("Formularze"),
    "getCode": MessageLookupByLibrary.simpleMessage("Otrzymaj kod"),
    "great": MessageLookupByLibrary.simpleMessage("Świetnie!"),
    "groupCode": MessageLookupByLibrary.simpleMessage("Kod grupy"),
    "guardianInfo": MessageLookupByLibrary.simpleMessage("Informacje opiekuna"),
    "guardianName": MessageLookupByLibrary.simpleMessage("Imię opiekuna"),
    "guardianPhone": MessageLookupByLibrary.simpleMessage("Telefon opiekuna"),
    "healthyFood": MessageLookupByLibrary.simpleMessage("Zdrowe jedzenie"),
    "healthyLifestyle": MessageLookupByLibrary.simpleMessage(
      "Zdrowy styl życia",
    ),
    "joinedToGroup": MessageLookupByLibrary.simpleMessage(
      "Dołączyłeś do nowej grupy",
    ),
    "joiningGroupFailed": MessageLookupByLibrary.simpleMessage(
      "Nie udało się dołączyć do grupy o podanym kodzie",
    ),
    "joiningToUserGroup": MessageLookupByLibrary.simpleMessage(
      "Dołączanie do nowej grupy",
    ),
    "lastName": MessageLookupByLibrary.simpleMessage("Nazwisko"),
    "library": MessageLookupByLibrary.simpleMessage("Biblioteka"),
    "libraryIsEmpty": MessageLookupByLibrary.simpleMessage(
      "Biblioteka jest pusta",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Ładowanie"),
    "locations": MessageLookupByLibrary.simpleMessage("Lokalizacje"),
    "login": MessageLookupByLibrary.simpleMessage("Zaloguj się"),
    "loginFailed": MessageLookupByLibrary.simpleMessage(
      "Logowanie nie powiodło się",
    ),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Logowanie"),
    "logout": MessageLookupByLibrary.simpleMessage("Wyloguj się"),
    "month": MessageLookupByLibrary.simpleMessage("Miesiąc"),
    "moreInformation": MessageLookupByLibrary.simpleMessage(
      "Więcej informacji",
    ),
    "myActivities": MessageLookupByLibrary.simpleMessage("Moje aktywności"),
    "myPoints": MessageLookupByLibrary.simpleMessage("Moje punkty"),
    "myScore": MessageLookupByLibrary.simpleMessage("Moje wyniki"),
    "navitem": m2,
    "next": MessageLookupByLibrary.simpleMessage("Dalej"),
    "no": MessageLookupByLibrary.simpleMessage("nie"),
    "noActivitiesFound": MessageLookupByLibrary.simpleMessage(
      "Nie znaleziono żadnych aktywności",
    ),
    "noContactMethodsFound": MessageLookupByLibrary.simpleMessage(
      "Nie znaleziono metod kontaktu",
    ),
    "noDescription": MessageLookupByLibrary.simpleMessage("Brak opisu"),
    "noEventsFound": MessageLookupByLibrary.simpleMessage(
      "Nie znaleziono żadnych wydarzeń",
    ),
    "noFormsFound": MessageLookupByLibrary.simpleMessage(
      "Nie znaleziono żadnych formularzy",
    ),
    "noResourcesFound": MessageLookupByLibrary.simpleMessage(
      "Obecnie brak dostępnych treści",
    ),
    "noRoutinesFound": MessageLookupByLibrary.simpleMessage(
      "Nie znaleziono żadnych Planów treningowych",
    ),
    "noTasks": MessageLookupByLibrary.simpleMessage("Brak zadań"),
    "noThankYou": MessageLookupByLibrary.simpleMessage("Nie, dziękuję"),
    "noUsersFound": MessageLookupByLibrary.simpleMessage(
      "Nie znaleziono żadnych użytkowników",
    ),
    "noVisitsFound": MessageLookupByLibrary.simpleMessage(
      "Nie znaleziono wizyt",
    ),
    "notVerified": MessageLookupByLibrary.simpleMessage("Niezweryfikowany"),
    "notification": MessageLookupByLibrary.simpleMessage("Powiadomienie"),
    "ok": MessageLookupByLibrary.simpleMessage("Ok"),
    "oops": MessageLookupByLibrary.simpleMessage("Ups!"),
    "otherItems": MessageLookupByLibrary.simpleMessage("Inne"),
    "pageContent": MessageLookupByLibrary.simpleMessage("Zawartość strony"),
    "pageCount": MessageLookupByLibrary.simpleMessage("Liczba stron:"),
    "participants": MessageLookupByLibrary.simpleMessage("Uczestnicy"),
    "password": MessageLookupByLibrary.simpleMessage("Hasło"),
    "passwordChanged": MessageLookupByLibrary.simpleMessage("Hasło zmienione"),
    "passwordIsRequired": MessageLookupByLibrary.simpleMessage(
      "Hasło jest wymagane",
    ),
    "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
      "Hasło i potwierdzenie nie pasują do siebie",
    ),
    "pause": MessageLookupByLibrary.simpleMessage("Pauza"),
    "phone": MessageLookupByLibrary.simpleMessage("Telefon"),
    "phoneOrEmail": MessageLookupByLibrary.simpleMessage("Telefon lub e-mail"),
    "physicalActivities": MessageLookupByLibrary.simpleMessage(
      "Aktywności fizyczne",
    ),
    "pleaseCompleteFormProperly": MessageLookupByLibrary.simpleMessage(
      "Proszę poprawnie wypełnić formularz",
    ),
    "pleaseEnterConfirmationKey": MessageLookupByLibrary.simpleMessage(
      "Proszę wprowadzić klucz potwierdzenia",
    ),
    "pleaseEnterPassword": MessageLookupByLibrary.simpleMessage(
      "Proszę wprowadzić hasło",
    ),
    "pleaseEnterPhoneNumber": MessageLookupByLibrary.simpleMessage(
      "Proszę wprowadzić numer telefonu",
    ),
    "pleaseEnterPhoneOrEmail": MessageLookupByLibrary.simpleMessage(
      "Proszę wprowadzić numer telefonu lub adres e-mail",
    ),
    "pleaseProvideValidEmail": MessageLookupByLibrary.simpleMessage(
      "Proszę podać poprawny adres e-mail",
    ),
    "pleaseProvideValidPhoneNumber": MessageLookupByLibrary.simpleMessage(
      "Proszę podać poprawny numer telefonu",
    ),
    "pleaseProvideValidPhoneOrEmail": MessageLookupByLibrary.simpleMessage(
      "Proszę podać poprawny numer telefonu lub adres e-mail",
    ),
    "pleaseProvideYourName": MessageLookupByLibrary.simpleMessage(
      "Proszę podać swoje imię",
    ),
    "pleaseWaitRegistering": MessageLookupByLibrary.simpleMessage(
      "Rejestrowanie konta, proszę czekać",
    ),
    "pleaseWaitSendingCode": MessageLookupByLibrary.simpleMessage(
      "Proszę czekać, wysyłanie kodu",
    ),
    "previous": MessageLookupByLibrary.simpleMessage("Poprzedni"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Polityka prywatności",
    ),
    "processing": MessageLookupByLibrary.simpleMessage("Przetwarzanie"),
    "ratingSaved": MessageLookupByLibrary.simpleMessage("Ocena zapisana"),
    "readMore": MessageLookupByLibrary.simpleMessage("Czytaj więcej"),
    "references": MessageLookupByLibrary.simpleMessage("Odnośniki"),
    "refresh": MessageLookupByLibrary.simpleMessage("Odśwież"),
    "registrationFailed": MessageLookupByLibrary.simpleMessage(
      "Rejestracja nie powiodła się",
    ),
    "requestFailed": MessageLookupByLibrary.simpleMessage(
      "Żądanie nie powiodło się",
    ),
    "requestNewCode": MessageLookupByLibrary.simpleMessage("Otrzymaj nowy kod"),
    "requestNewPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Otrzymaj nowe hasło",
    ),
    "resources": MessageLookupByLibrary.simpleMessage("Zasoby"),
    "resume": MessageLookupByLibrary.simpleMessage("Wznów"),
    "retrievingCoordinates": MessageLookupByLibrary.simpleMessage(
      "Pobieranie współrzędnych",
    ),
    "routineAddedToCalendar": MessageLookupByLibrary.simpleMessage(
      "Plan treningowy dodany do kalendarza",
    ),
    "routines": MessageLookupByLibrary.simpleMessage("Plany treningowe"),
    "routines_title": MessageLookupByLibrary.simpleMessage(
      "Nazwa Planu treningowego",
    ),
    "saveAnswer": MessageLookupByLibrary.simpleMessage("Zapisz odpowiedź"),
    "saveData": MessageLookupByLibrary.simpleMessage("Zapisz dane"),
    "savingDataFailed": MessageLookupByLibrary.simpleMessage(
      "Nie udało się zapisać danych",
    ),
    "scanCode": MessageLookupByLibrary.simpleMessage("Skanuj kod"),
    "score": MessageLookupByLibrary.simpleMessage("Wynik"),
    "scoreListIsEmpty": MessageLookupByLibrary.simpleMessage(
      "Brak zdobytych punktów",
    ),
    "sendAnswer": MessageLookupByLibrary.simpleMessage("Wyślij odpowiedź"),
    "settings": MessageLookupByLibrary.simpleMessage("Ustawienia"),
    "signUp": MessageLookupByLibrary.simpleMessage("Zarejestruj się"),
    "startAssessment": MessageLookupByLibrary.simpleMessage(
      "Rozpocznij nowy test",
    ),
    "tasks": MessageLookupByLibrary.simpleMessage("Zadania"),
    "thankyouForFeedback": MessageLookupByLibrary.simpleMessage(
      "Dziękujemy za Twoją opinię!",
    ),
    "today": MessageLookupByLibrary.simpleMessage("Dzisiaj"),
    "twoWeeks": MessageLookupByLibrary.simpleMessage("Dwa tygodnie"),
    "unknownUser": MessageLookupByLibrary.simpleMessage("nieznany użytkownik"),
    "unnamed": MessageLookupByLibrary.simpleMessage("Bez nazwy"),
    "unnamedActivity": MessageLookupByLibrary.simpleMessage("Bez nazwy"),
    "unnamedLibraryItem": MessageLookupByLibrary.simpleMessage(
      "Element biblioteki bez nazwy",
    ),
    "unnamedRoutine": MessageLookupByLibrary.simpleMessage(
      "Plan treningowy bez nazwy",
    ),
    "unnamedWebPage": MessageLookupByLibrary.simpleMessage("Strona bez tytułu"),
    "untitled": MessageLookupByLibrary.simpleMessage("Bez tytułu"),
    "useCode": MessageLookupByLibrary.simpleMessage("Użyj kodu"),
    "userInformation": MessageLookupByLibrary.simpleMessage(
      "Informacje o użytkowniku",
    ),
    "userNotFound": MessageLookupByLibrary.simpleMessage(
      "Użytkownik nie znaleziony",
    ),
    "validateContactTitle": MessageLookupByLibrary.simpleMessage(
      "Zweryfikuj informacje kontaktowe",
    ),
    "valueIsRequired": MessageLookupByLibrary.simpleMessage(
      "To pole jest wymagane",
    ),
    "verified": MessageLookupByLibrary.simpleMessage("Zweryfikowany"),
    "verify": MessageLookupByLibrary.simpleMessage("zweryfikuj"),
    "visitRemoved": MessageLookupByLibrary.simpleMessage("Wizyta usunięta"),
    "week": MessageLookupByLibrary.simpleMessage("Tydzień"),
    "welcomeInfo": MessageLookupByLibrary.simpleMessage(
      "Pokaż informacje powitalne",
    ),
    "writeAnswerHere": MessageLookupByLibrary.simpleMessage(
      "Napisz swoją odpowiedź tutaj",
    ),
    "yes": MessageLookupByLibrary.simpleMessage("Tak"),
    "youHaveThisBadge": MessageLookupByLibrary.simpleMessage("Masz tą Odznakę"),
    "yourAnswerHasBeenSaved": MessageLookupByLibrary.simpleMessage(
      "Twoja odpowiedź została zapisana",
    ),
    "yourLogDates": MessageLookupByLibrary.simpleMessage("Daty zapisów"),
    "yourPassword": MessageLookupByLibrary.simpleMessage("Twoje hasło"),
  };
}
