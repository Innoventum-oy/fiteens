// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fi locale. All the
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
  String get localeName => 'fi';

  static String m0(startdate) =>
      "Voit merkitä tapahtuman suoritetuksi aikaisintaan ${startdate}";

  static String m1(startdate) => "Tapahtumaa ei voi ohittaa ennen päivämäärää";

  static String m2(item) => "${Intl.select(item, {
            'calendar': 'Kalenteri',
            'routines': 'Harjoitusohjelma',
            'mywellbeing': 'Oma hyvinvointi',
            'library': 'Resurssikirjasto',
            'home': 'Etusivu',
            'other': 'Valikko:${item}',
          })}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Tietoja"),
        "accountCreated": MessageLookupByLibrary.simpleMessage("Tili luotu"),
        "accountDeleted":
            MessageLookupByLibrary.simpleMessage("Käyttäjätili poistettu"),
        "accountDeletion":
            MessageLookupByLibrary.simpleMessage("Tilin poistaminen"),
        "achievements": MessageLookupByLibrary.simpleMessage("Saavutukset"),
        "activities": MessageLookupByLibrary.simpleMessage("Tapahtumat"),
        "activity": MessageLookupByLibrary.simpleMessage("Aktiviteetti"),
        "activityCalendar":
            MessageLookupByLibrary.simpleMessage("Tapahtumakalenteri"),
        "activityLevel":
            MessageLookupByLibrary.simpleMessage("Aktiivisuustaso"),
        "activityRecorded":
            MessageLookupByLibrary.simpleMessage("Kirjaus tallennettu"),
        "activityRegistrationFailed": MessageLookupByLibrary.simpleMessage(
            "Aktiviteetin rekisteröinti epäonnistui"),
        "activityRegistrationSaved": MessageLookupByLibrary.simpleMessage(
            "Aktiviteetin rekisteröinti onnistui"),
        "addedToList": MessageLookupByLibrary.simpleMessage("Lisätty"),
        "addingRoutineFailed": MessageLookupByLibrary.simpleMessage(
            "Ohjelman lisääminen kalenteriin epäonnistui"),
        "address": MessageLookupByLibrary.simpleMessage("Osoite"),
        "ageOver13":
            MessageLookupByLibrary.simpleMessage("Oletko yli 13-vuotias?"),
        "alreadyDone": MessageLookupByLibrary.simpleMessage("Tehty"),
        "answerDate": MessageLookupByLibrary.simpleMessage("Vastauspäivä"),
        "answerSaved":
            MessageLookupByLibrary.simpleMessage("Vastaus tallennettu"),
        "appName": MessageLookupByLibrary.simpleMessage("Fiteens"),
        "authenticating":
            MessageLookupByLibrary.simpleMessage("Kirjautuminen käynnissä"),
        "btnAddToCalendar":
            MessageLookupByLibrary.simpleMessage("Lisää kalenteriin"),
        "btnConfirm": MessageLookupByLibrary.simpleMessage("Vahvista"),
        "btnContinue": MessageLookupByLibrary.simpleMessage("Jatka"),
        "btnDashboard": MessageLookupByLibrary.simpleMessage("Etusivu"),
        "btnLogin": MessageLookupByLibrary.simpleMessage("Kirjaudu"),
        "btnMarkAsDone":
            MessageLookupByLibrary.simpleMessage("Merkitse tehdyksi"),
        "btnReturn": MessageLookupByLibrary.simpleMessage("Takaisin"),
        "btnReturnBook":
            MessageLookupByLibrary.simpleMessage("Poista lukulistalta"),
        "btnSend": MessageLookupByLibrary.simpleMessage("Lähetä"),
        "btnSetNewPassword":
            MessageLookupByLibrary.simpleMessage("Aseta salasana"),
        "btnShow": MessageLookupByLibrary.simpleMessage("Näytä"),
        "btnSkip": MessageLookupByLibrary.simpleMessage("Ohita"),
        "btnTasks": MessageLookupByLibrary.simpleMessage("Tehtävät"),
        "btnUseEmail":
            MessageLookupByLibrary.simpleMessage("Käytä sähköpostiosoitetta"),
        "btnUsePhone":
            MessageLookupByLibrary.simpleMessage("Käytä puhelinnumeroa"),
        "btnValidateContact":
            MessageLookupByLibrary.simpleMessage("Vahvista yhteystieto nyt"),
        "btnValidateContactLater":
            MessageLookupByLibrary.simpleMessage("Myöhemmin"),
        "calendar": MessageLookupByLibrary.simpleMessage("Kalenteri"),
        "calendarUpdated":
            MessageLookupByLibrary.simpleMessage("Kalenteri päivitetty"),
        "cancel": MessageLookupByLibrary.simpleMessage("Peruuta"),
        "cannotSaveEmptyForm": MessageLookupByLibrary.simpleMessage(
            "Täytä lomake ennen lähettämistä"),
        "challenges": MessageLookupByLibrary.simpleMessage("Haasteet"),
        "choose": MessageLookupByLibrary.simpleMessage("Valitse"),
        "chooseFile": MessageLookupByLibrary.simpleMessage("Valitse tiedosto"),
        "clickPictureToChooseAvatar": MessageLookupByLibrary.simpleMessage(
            "Voit valita itsellesi avatar - kuvan"),
        "codeAccepted":
            MessageLookupByLibrary.simpleMessage("Koodi hyväksytty"),
        "codeScanned": MessageLookupByLibrary.simpleMessage("Koodi skannattu"),
        "collectedBadges": MessageLookupByLibrary.simpleMessage("Ansiomerkit"),
        "confirmDeletingAccount": MessageLookupByLibrary.simpleMessage(
            "Vahvista käyttäjätilin poistaminen"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("Vahvista salasana"),
        "confirmationKey":
            MessageLookupByLibrary.simpleMessage("Vahvistusavain"),
        "contactInformation":
            MessageLookupByLibrary.simpleMessage("Yhteystiedot"),
        "contactInformationValidated":
            MessageLookupByLibrary.simpleMessage("Yhteystieto vahvistettu"),
        "contactMethod": MessageLookupByLibrary.simpleMessage("Yhteystieto"),
        "contactMethods": MessageLookupByLibrary.simpleMessage("Yhteystiedot"),
        "contentNotFound":
            MessageLookupByLibrary.simpleMessage("Sisältöä ei voitu ladata"),
        "couldNotOpenLink":
            MessageLookupByLibrary.simpleMessage("Linkkiä ei voitu avata"),
        "createAccount":
            MessageLookupByLibrary.simpleMessage("Luo käyttäjätili"),
        "dateRange": MessageLookupByLibrary.simpleMessage("Aikaväli"),
        "deleteAccount": MessageLookupByLibrary.simpleMessage("Poista tili"),
        "deleteYourAccount":
            MessageLookupByLibrary.simpleMessage("Poista käyttäjätilisi"),
        "deletingAccountCannotUndone": MessageLookupByLibrary.simpleMessage(
            "Tilin poistetaan lopullisesti. Tätä toimintoa ei voi peruuttaa."),
        "deletingAccountFailed": MessageLookupByLibrary.simpleMessage(
            "Tilin poistaminen epäonnistui"),
        "discover": MessageLookupByLibrary.simpleMessage("Tapahtumat"),
        "downloadCertificate":
            MessageLookupByLibrary.simpleMessage("Lataa sertifikaatti"),
        "downloadOpenBadge":
            MessageLookupByLibrary.simpleMessage("Lataa Open Badge"),
        "edit": MessageLookupByLibrary.simpleMessage("Muokkaa"),
        "email": MessageLookupByLibrary.simpleMessage("Sähköpostiosoite"),
        "emailOrPhoneNumber": MessageLookupByLibrary.simpleMessage(
            "Puhelinnumero tai sähköpostiosoite"),
        "enterGroupCode":
            MessageLookupByLibrary.simpleMessage("Syötä ryhmäkoodi tähän"),
        "enterNewCode":
            MessageLookupByLibrary.simpleMessage("Lisää uusi koodi"),
        "enterPassword": MessageLookupByLibrary.simpleMessage("Anna salasana"),
        "error": MessageLookupByLibrary.simpleMessage("Virhe"),
        "errorsInForm": MessageLookupByLibrary.simpleMessage(
            "Lomakkeen sisällössä on virheitä"),
        "eventCannotBeMarkedBeforeDate": m0,
        "eventCannotBeSkippedBeforeDate": m1,
        "eventInFuture": MessageLookupByLibrary.simpleMessage(
            "Tapahtuma on tulevaisuudessa"),
        "eventLog": MessageLookupByLibrary.simpleMessage("Tapahtumaloki"),
        "failedToSaveAnswer": MessageLookupByLibrary.simpleMessage(
            "Vastausta ei voitu tallentaa"),
        "feedback": MessageLookupByLibrary.simpleMessage("Palaute"),
        "feedbackSent":
            MessageLookupByLibrary.simpleMessage("Palaute lähetetty"),
        "fieldCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("Kenttä ei voi olla tyhjä"),
        "firstName": MessageLookupByLibrary.simpleMessage("Etunimi"),
        "flashOff": MessageLookupByLibrary.simpleMessage("Valo pois"),
        "flashOn": MessageLookupByLibrary.simpleMessage("Valo päälle"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Unohditko salasanan?"),
        "formIsEmpty": MessageLookupByLibrary.simpleMessage("Lomake on tyhjä"),
        "forms": MessageLookupByLibrary.simpleMessage("Lomakkeet"),
        "getCode": MessageLookupByLibrary.simpleMessage("Pyydä koodi"),
        "great": MessageLookupByLibrary.simpleMessage("Hienoa!"),
        "groupCode": MessageLookupByLibrary.simpleMessage("Ryhmäkoodi"),
        "guardianInfo":
            MessageLookupByLibrary.simpleMessage("Huoltajan tiedot vaaditaan"),
        "guardianName": MessageLookupByLibrary.simpleMessage("Huoltajan nimi"),
        "guardianPhone":
            MessageLookupByLibrary.simpleMessage("Huoltajan puhelinnumero"),
        "healthyFood":
            MessageLookupByLibrary.simpleMessage("Terveellinen ruokavalio"),
        "healthyLifestyle":
            MessageLookupByLibrary.simpleMessage("Terveellinen elämäntapa"),
        "joinedToGroup": MessageLookupByLibrary.simpleMessage(
            "Liittyminen uuteen ryhmään onnistui"),
        "joiningGroupFailed": MessageLookupByLibrary.simpleMessage(
            "Annetulla koodilla ei löytynyt ryhmää"),
        "joiningToUserGroup":
            MessageLookupByLibrary.simpleMessage("Uuteen ryhmään liittyminen"),
        "lastName": MessageLookupByLibrary.simpleMessage("Sukunimi"),
        "library": MessageLookupByLibrary.simpleMessage("Resurssikirjasto"),
        "libraryIsEmpty":
            MessageLookupByLibrary.simpleMessage("Resurssikirjasto on tyhjä"),
        "loading": MessageLookupByLibrary.simpleMessage("ladataan"),
        "locations": MessageLookupByLibrary.simpleMessage("Sijainnit"),
        "login": MessageLookupByLibrary.simpleMessage("Kirjautuminen"),
        "loginFailed":
            MessageLookupByLibrary.simpleMessage("kirjautuminen epäonnistui"),
        "loginTitle": MessageLookupByLibrary.simpleMessage("Kirjaudu sisään"),
        "logout": MessageLookupByLibrary.simpleMessage("kirjaudu ulos"),
        "month": MessageLookupByLibrary.simpleMessage("Kuukausi"),
        "moreInformation": MessageLookupByLibrary.simpleMessage("lisätiedot"),
        "myActivities":
            MessageLookupByLibrary.simpleMessage("Omat harrastukset"),
        "myPoints": MessageLookupByLibrary.simpleMessage("Pisteesi"),
        "myScore": MessageLookupByLibrary.simpleMessage("Omat pisteet"),
        "navitem": m2,
        "next": MessageLookupByLibrary.simpleMessage("Seuraava"),
        "no": MessageLookupByLibrary.simpleMessage("ei"),
        "noActivitiesFound":
            MessageLookupByLibrary.simpleMessage("Ei aktiviteetteja"),
        "noContactMethodsFound":
            MessageLookupByLibrary.simpleMessage("Yhteystietoja ei löytynyt"),
        "noDescription": MessageLookupByLibrary.simpleMessage("Ei kuvausta"),
        "noEventsFound": MessageLookupByLibrary.simpleMessage("Ei tapahtumia"),
        "noFormsFound": MessageLookupByLibrary.simpleMessage("Ei lomakkeita"),
        "noResourcesFound":
            MessageLookupByLibrary.simpleMessage("Ei resursseja"),
        "noRoutinesFound":
            MessageLookupByLibrary.simpleMessage("Ei harjoitusohjelmia"),
        "noTasks": MessageLookupByLibrary.simpleMessage("Ei tehtäviä"),
        "noThankYou": MessageLookupByLibrary.simpleMessage("Ei kiitos"),
        "noUsersFound": MessageLookupByLibrary.simpleMessage("Ei käyttäjiä"),
        "noVisitsFound": MessageLookupByLibrary.simpleMessage("Ei vierailuja"),
        "notVerified": MessageLookupByLibrary.simpleMessage("Ei vahvistettu"),
        "notification": MessageLookupByLibrary.simpleMessage("Huomio"),
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "oops": MessageLookupByLibrary.simpleMessage("Hups!"),
        "otherItems": MessageLookupByLibrary.simpleMessage("Muut"),
        "pageContent": MessageLookupByLibrary.simpleMessage("Sivusisältö"),
        "pageCount": MessageLookupByLibrary.simpleMessage("Sivumäärä"),
        "participants": MessageLookupByLibrary.simpleMessage("Osallistujat"),
        "password": MessageLookupByLibrary.simpleMessage("Salasana"),
        "passwordChanged":
            MessageLookupByLibrary.simpleMessage("Salasana vaihdettu"),
        "passwordIsRequired":
            MessageLookupByLibrary.simpleMessage("Salasana on pakollinen"),
        "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
            "Salasana ja vahvistus eivät täsmää"),
        "pause": MessageLookupByLibrary.simpleMessage("Tauota"),
        "phone": MessageLookupByLibrary.simpleMessage("Puhelin"),
        "phoneOrEmail": MessageLookupByLibrary.simpleMessage(
            "Puhelin tai sähköpostiosoite"),
        "physicalActivities": MessageLookupByLibrary.simpleMessage("Liikunta"),
        "pleaseCompleteFormProperly": MessageLookupByLibrary.simpleMessage(
            "Täytäthän kaikki vaadittavat kohdat"),
        "pleaseEnterConfirmationKey":
            MessageLookupByLibrary.simpleMessage("Anna vahvistuskoodi"),
        "pleaseEnterPassword":
            MessageLookupByLibrary.simpleMessage("Anna salasana"),
        "pleaseEnterPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Anna puhelinnumero"),
        "pleaseEnterPhoneOrEmail": MessageLookupByLibrary.simpleMessage(
            "Anna puhelinnumero tai sähköpostiosoite"),
        "pleaseProvideValidEmail": MessageLookupByLibrary.simpleMessage(
            "Anna kelvollinen sähköpostiosoite"),
        "pleaseProvideValidPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Tarkista puhelinnumero"),
        "pleaseProvideValidPhoneOrEmail": MessageLookupByLibrary.simpleMessage(
            "Anna kelvollinen puhelinnumero tai sähköpostiosoite"),
        "pleaseProvideYourName":
            MessageLookupByLibrary.simpleMessage("Anna nimesi"),
        "pleaseWaitRegistering": MessageLookupByLibrary.simpleMessage(
            "Käyttäjätiliä rekisteröidään"),
        "pleaseWaitSendingCode":
            MessageLookupByLibrary.simpleMessage("Käsitellään koodia"),
        "previous": MessageLookupByLibrary.simpleMessage("Edellinen"),
        "privacyPolicy":
            MessageLookupByLibrary.simpleMessage("Tietosuojakäytäntö"),
        "processing": MessageLookupByLibrary.simpleMessage("Käsitellään"),
        "ratingSaved":
            MessageLookupByLibrary.simpleMessage("Arvio tallennettu"),
        "readMore": MessageLookupByLibrary.simpleMessage("Lue lisää"),
        "references": MessageLookupByLibrary.simpleMessage("Lähteet"),
        "refresh": MessageLookupByLibrary.simpleMessage("Lataa uudelleen"),
        "registrationFailed":
            MessageLookupByLibrary.simpleMessage("Tilin luonti epäonnistui"),
        "requestFailed":
            MessageLookupByLibrary.simpleMessage("Pyyntö epäonnistui"),
        "requestNewCode":
            MessageLookupByLibrary.simpleMessage("Pyydä uusi koodi"),
        "requestNewPasswordTitle":
            MessageLookupByLibrary.simpleMessage("Vaihda salasana"),
        "resources": MessageLookupByLibrary.simpleMessage("Resurssit"),
        "resume": MessageLookupByLibrary.simpleMessage("Jatka"),
        "retrievingCoordinates":
            MessageLookupByLibrary.simpleMessage("Haetaan sijaintia"),
        "routineAddedToCalendar": MessageLookupByLibrary.simpleMessage(
            "Harjoitus lisätty kalenteriin"),
        "routines": MessageLookupByLibrary.simpleMessage("Harjoitusohjelmat"),
        "routines_title": MessageLookupByLibrary.simpleMessage("Harjoitukset"),
        "saveAnswer": MessageLookupByLibrary.simpleMessage("Tallenna vastaus"),
        "saveData": MessageLookupByLibrary.simpleMessage("Tallenna tiedot"),
        "savingDataFailed":
            MessageLookupByLibrary.simpleMessage("Tallennus epäonnistui"),
        "scanCode": MessageLookupByLibrary.simpleMessage("Skannaa koodi"),
        "score": MessageLookupByLibrary.simpleMessage("Pisteet"),
        "scoreListIsEmpty":
            MessageLookupByLibrary.simpleMessage("Ei ansaittuja pisteitä"),
        "sendAnswer": MessageLookupByLibrary.simpleMessage("Lähetä vastaus"),
        "settings": MessageLookupByLibrary.simpleMessage("Asetukset"),
        "signUp": MessageLookupByLibrary.simpleMessage("Uusi tili"),
        "startAssessment":
            MessageLookupByLibrary.simpleMessage("Aloita arviointi"),
        "tasks": MessageLookupByLibrary.simpleMessage("Tehtävät"),
        "thankyouForFeedback":
            MessageLookupByLibrary.simpleMessage("Kiitos palautteestasi!"),
        "today": MessageLookupByLibrary.simpleMessage("Tänään"),
        "twoWeeks": MessageLookupByLibrary.simpleMessage("Kaksi viikkoa"),
        "unknownUser":
            MessageLookupByLibrary.simpleMessage("tuntematon käyttäjä"),
        "unnamed": MessageLookupByLibrary.simpleMessage("Nimetön"),
        "unnamedActivity":
            MessageLookupByLibrary.simpleMessage("Nimetön tapahtuma"),
        "unnamedLibraryItem":
            MessageLookupByLibrary.simpleMessage("Nimetön resurssi"),
        "unnamedRoutine":
            MessageLookupByLibrary.simpleMessage("Nimetön harjoitusohjelma"),
        "unnamedWebPage": MessageLookupByLibrary.simpleMessage("Nimetön sivu"),
        "untitled": MessageLookupByLibrary.simpleMessage("Nimetön"),
        "useCode": MessageLookupByLibrary.simpleMessage("Lähetä koodi"),
        "userInformation":
            MessageLookupByLibrary.simpleMessage("Käyttäjätiedot"),
        "userNotFound":
            MessageLookupByLibrary.simpleMessage("Käyttäjätiliä ei löytynyt"),
        "validateContactTitle":
            MessageLookupByLibrary.simpleMessage("Vahvista yhteystieto"),
        "valueIsRequired":
            MessageLookupByLibrary.simpleMessage("Tämä tieto on pakollinen"),
        "verified": MessageLookupByLibrary.simpleMessage("Vahvistettu"),
        "verify": MessageLookupByLibrary.simpleMessage("Vahvista"),
        "visitRemoved":
            MessageLookupByLibrary.simpleMessage("Vierailu poistettu"),
        "week": MessageLookupByLibrary.simpleMessage("Viikko"),
        "welcomeInfo":
            MessageLookupByLibrary.simpleMessage("Näytä aloitusinfo"),
        "writeAnswerHere": MessageLookupByLibrary.simpleMessage(
            "Kirjoita tähän vastauksesi kysymykseen "),
        "yes": MessageLookupByLibrary.simpleMessage("kyllä"),
        "youHaveThisBadge": MessageLookupByLibrary.simpleMessage(
            "Olet ansainnut tämän saavutuksen"),
        "yourAnswerHasBeenSaved": MessageLookupByLibrary.simpleMessage(
            "Vastauksen tallentaminen onnistui"),
        "yourLogDates":
            MessageLookupByLibrary.simpleMessage("Kirjaamasi päivämäärät"),
        "yourPassword": MessageLookupByLibrary.simpleMessage("Syötä salasanasi")
      };
}
