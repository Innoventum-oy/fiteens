// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static String m0(startdate) =>
      "No puedes marcar esta actividad como completada antes de ${startdate}";

  static String m1(startdate) =>
      "El evento no se puede saltar antes de la fecha";

  static String m2(item) =>
      "${Intl.select(item, {'home': 'Inicio', 'calendar': 'Calendario', 'routines': 'Rutinas', 'mywellbeing': 'Mi bienestar', 'library': 'Biblioteca/Recursos', 'dashboard': 'Panel', 'other': 'Menú:${item}'})}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("Acerca de"),
    "accountCreated": MessageLookupByLibrary.simpleMessage("Cuenta creada"),
    "accountDeleted": MessageLookupByLibrary.simpleMessage(
      "Cuenta de usuario eliminada",
    ),
    "accountDeletion": MessageLookupByLibrary.simpleMessage(
      "Eliminación de cuenta",
    ),
    "achievements": MessageLookupByLibrary.simpleMessage("Logros"),
    "activities": MessageLookupByLibrary.simpleMessage("Actividades"),
    "activity": MessageLookupByLibrary.simpleMessage("Actividad"),
    "activityCalendar": MessageLookupByLibrary.simpleMessage(
      "Calendario de actividades",
    ),
    "activityLevel": MessageLookupByLibrary.simpleMessage("Nivel de actividad"),
    "activityRecorded": MessageLookupByLibrary.simpleMessage(
      "Actividad registrada",
    ),
    "activityRegistrationFailed": MessageLookupByLibrary.simpleMessage(
      "Error al actualizar el estado de la actividad",
    ),
    "activityRegistrationSaved": MessageLookupByLibrary.simpleMessage(
      "Actividad marcada como completada",
    ),
    "addedToList": MessageLookupByLibrary.simpleMessage("Agregado a la lista"),
    "addingRoutineFailed": MessageLookupByLibrary.simpleMessage(
      "Error al agregar la rutina al calendario",
    ),
    "address": MessageLookupByLibrary.simpleMessage("Dirección"),
    "ageOver13": MessageLookupByLibrary.simpleMessage(
      "¿Tienes más de 13 años?",
    ),
    "answerDate": MessageLookupByLibrary.simpleMessage("Fecha de respuesta"),
    "answerSaved": MessageLookupByLibrary.simpleMessage("Respuesta guardada"),
    "appName": MessageLookupByLibrary.simpleMessage("FiTeens"),
    "authenticating": MessageLookupByLibrary.simpleMessage(
      "Autenticando... Por favor espera",
    ),
    "btnAddToCalendar": MessageLookupByLibrary.simpleMessage(
      "Agregar al calendario",
    ),
    "btnConfirm": MessageLookupByLibrary.simpleMessage("Confirmar"),
    "btnContinue": MessageLookupByLibrary.simpleMessage("Continuar"),
    "btnDashboard": MessageLookupByLibrary.simpleMessage("Abrir panel"),
    "btnLogin": MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
    "btnMarkAsDone": MessageLookupByLibrary.simpleMessage(
      "Marcar como completado",
    ),
    "btnReturn": MessageLookupByLibrary.simpleMessage("Volver"),
    "btnReturnBook": MessageLookupByLibrary.simpleMessage("Devolver libro"),
    "btnSend": MessageLookupByLibrary.simpleMessage("Enviar"),
    "btnSetNewPassword": MessageLookupByLibrary.simpleMessage(
      "Establecer contraseña",
    ),
    "btnShow": MessageLookupByLibrary.simpleMessage("Mostrar"),
    "btnSkip": MessageLookupByLibrary.simpleMessage("Saltar"),
    "btnTasks": MessageLookupByLibrary.simpleMessage("Tareas"),
    "btnUseEmail": MessageLookupByLibrary.simpleMessage(
      "Usar correo electrónico",
    ),
    "btnUsePhone": MessageLookupByLibrary.simpleMessage(
      "Usar número de teléfono",
    ),
    "btnValidateContact": MessageLookupByLibrary.simpleMessage(
      "Validar información de contacto ahora",
    ),
    "btnValidateContactLater": MessageLookupByLibrary.simpleMessage(
      "Más tarde",
    ),
    "calendar": MessageLookupByLibrary.simpleMessage("Calendario"),
    "calendarUpdated": MessageLookupByLibrary.simpleMessage(
      "Calendario actualizado",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
    "cannotSaveEmptyForm": MessageLookupByLibrary.simpleMessage(
      "No se puede guardar un formulario vacío",
    ),
    "challenges": MessageLookupByLibrary.simpleMessage("Desafíos"),
    "choose": MessageLookupByLibrary.simpleMessage("Elegir"),
    "chooseFile": MessageLookupByLibrary.simpleMessage("Elegir archivo"),
    "clickPictureToChooseAvatar": MessageLookupByLibrary.simpleMessage(
      "Haz clic en la imagen para elegir un avatar",
    ),
    "codeAccepted": MessageLookupByLibrary.simpleMessage("Código aceptado"),
    "codeScanned": MessageLookupByLibrary.simpleMessage("Código escaneado"),
    "collectedBadges": MessageLookupByLibrary.simpleMessage(
      "Insignias obtenidas",
    ),
    "confirmDeletingAccount": MessageLookupByLibrary.simpleMessage(
      "Confirmar eliminación de cuenta de usuario",
    ),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "Confirmar contraseña",
    ),
    "confirmationKey": MessageLookupByLibrary.simpleMessage(
      "Clave de confirmación",
    ),
    "contactInformation": MessageLookupByLibrary.simpleMessage(
      "Información de contacto",
    ),
    "contactInformationValidated": MessageLookupByLibrary.simpleMessage(
      "Contacto validado",
    ),
    "contactMethod": MessageLookupByLibrary.simpleMessage("Método de contacto"),
    "contactMethods": MessageLookupByLibrary.simpleMessage(
      "Métodos de contacto",
    ),
    "contentNotFound": MessageLookupByLibrary.simpleMessage(
      "Contenido no encontrado",
    ),
    "couldNotOpenLink": MessageLookupByLibrary.simpleMessage(
      "No se pudo abrir el enlace",
    ),
    "createAccount": MessageLookupByLibrary.simpleMessage("Crear cuenta"),
    "dateRange": MessageLookupByLibrary.simpleMessage("Rango de fechas"),
    "deleteAccount": MessageLookupByLibrary.simpleMessage("Eliminar cuenta"),
    "deleteYourAccount": MessageLookupByLibrary.simpleMessage(
      "Eliminar tu cuenta",
    ),
    "deletingAccountCannotUndone": MessageLookupByLibrary.simpleMessage(
      "La cuenta de usuario se elimina de inmediato. Esta acción no se puede deshacer.",
    ),
    "deletingAccountFailed": MessageLookupByLibrary.simpleMessage(
      "Error al eliminar la cuenta",
    ),
    "discover": MessageLookupByLibrary.simpleMessage("Descubrir"),
    "downloadCertificate": MessageLookupByLibrary.simpleMessage(
      "Descargar certificado",
    ),
    "downloadOpenBadge": MessageLookupByLibrary.simpleMessage(
      "Descargar insignia abierta",
    ),
    "edit": MessageLookupByLibrary.simpleMessage("Editar"),
    "email": MessageLookupByLibrary.simpleMessage("Correo electrónico"),
    "emailOrPhoneNumber": MessageLookupByLibrary.simpleMessage(
      "Correo electrónico o número de teléfono",
    ),
    "enterGroupCode": MessageLookupByLibrary.simpleMessage(
      "Ingresa tu código de grupo aquí",
    ),
    "enterNewCode": MessageLookupByLibrary.simpleMessage(
      "Ingresar nuevo código",
    ),
    "enterPassword": MessageLookupByLibrary.simpleMessage(
      "Ingresar contraseña",
    ),
    "error": MessageLookupByLibrary.simpleMessage("Error"),
    "errorsInForm": MessageLookupByLibrary.simpleMessage(
      "Errores en el contenido del formulario",
    ),
    "eventCannotBeMarkedBeforeDate": m0,
    "eventCannotBeSkippedBeforeDate": m1,
    "eventInFuture": MessageLookupByLibrary.simpleMessage(
      "La actividad está planeada para el futuro",
    ),
    "eventLog": MessageLookupByLibrary.simpleMessage("Registro de eventos"),
    "failedToSaveAnswer": MessageLookupByLibrary.simpleMessage(
      "No se pudo guardar tu respuesta",
    ),
    "feedback": MessageLookupByLibrary.simpleMessage("Comentarios"),
    "feedbackSent": MessageLookupByLibrary.simpleMessage(
      "Comentarios enviados",
    ),
    "fieldCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
      "El campo no puede estar vacío",
    ),
    "firstName": MessageLookupByLibrary.simpleMessage("Nombre"),
    "flashOff": MessageLookupByLibrary.simpleMessage("Flash apagado"),
    "flashOn": MessageLookupByLibrary.simpleMessage("Flash encendido"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "¿Olvidaste tu contraseña?",
    ),
    "formIsEmpty": MessageLookupByLibrary.simpleMessage(
      "El formulario está vacío",
    ),
    "forms": MessageLookupByLibrary.simpleMessage("Formularios"),
    "getCode": MessageLookupByLibrary.simpleMessage("Obtener código"),
    "great": MessageLookupByLibrary.simpleMessage("¡Genial!"),
    "groupCode": MessageLookupByLibrary.simpleMessage("Código de grupo"),
    "guardianInfo": MessageLookupByLibrary.simpleMessage(
      "Información del tutor",
    ),
    "guardianName": MessageLookupByLibrary.simpleMessage("Nombre del tutor"),
    "guardianPhone": MessageLookupByLibrary.simpleMessage("Teléfono del tutor"),
    "healthyFood": MessageLookupByLibrary.simpleMessage("Comida saludable"),
    "healthyLifestyle": MessageLookupByLibrary.simpleMessage(
      "Estilo de vida saludable",
    ),
    "joinedToGroup": MessageLookupByLibrary.simpleMessage(
      "Te has unido a un nuevo grupo",
    ),
    "joiningGroupFailed": MessageLookupByLibrary.simpleMessage(
      "Error al unirse al grupo con el código proporcionado",
    ),
    "joiningToUserGroup": MessageLookupByLibrary.simpleMessage(
      "Unirse a un nuevo grupo",
    ),
    "lastName": MessageLookupByLibrary.simpleMessage("Apellido"),
    "library": MessageLookupByLibrary.simpleMessage("Biblioteca"),
    "libraryIsEmpty": MessageLookupByLibrary.simpleMessage(
      "La biblioteca está vacía",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Cargando"),
    "locations": MessageLookupByLibrary.simpleMessage("Ubicaciones"),
    "login": MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
    "loginFailed": MessageLookupByLibrary.simpleMessage(
      "Error al iniciar sesión",
    ),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
    "logout": MessageLookupByLibrary.simpleMessage("Cerrar sesión"),
    "month": MessageLookupByLibrary.simpleMessage("Mes"),
    "moreInformation": MessageLookupByLibrary.simpleMessage("Más información"),
    "myActivities": MessageLookupByLibrary.simpleMessage("Mis actividades"),
    "myPoints": MessageLookupByLibrary.simpleMessage("Mis puntos"),
    "myScore": MessageLookupByLibrary.simpleMessage("Mi puntuación"),
    "navitem": m2,
    "next": MessageLookupByLibrary.simpleMessage("Siguiente"),
    "no": MessageLookupByLibrary.simpleMessage("no"),
    "noActivitiesFound": MessageLookupByLibrary.simpleMessage(
      "No se encontraron actividades",
    ),
    "noContactMethodsFound": MessageLookupByLibrary.simpleMessage(
      "No se encontraron métodos de contacto",
    ),
    "noDescription": MessageLookupByLibrary.simpleMessage("Sin descripción"),
    "noEventsFound": MessageLookupByLibrary.simpleMessage(
      "No se encontraron eventos",
    ),
    "noFormsFound": MessageLookupByLibrary.simpleMessage(
      "No se encontraron formularios",
    ),
    "noResourcesFound": MessageLookupByLibrary.simpleMessage(
      "No hay recursos disponibles actualmente",
    ),
    "noRoutinesFound": MessageLookupByLibrary.simpleMessage(
      "No se encontraron rutinas",
    ),
    "noTasks": MessageLookupByLibrary.simpleMessage("No hay tareas"),
    "noThankYou": MessageLookupByLibrary.simpleMessage("No, gracias"),
    "noUsersFound": MessageLookupByLibrary.simpleMessage(
      "No se encontraron usuarios",
    ),
    "noVisitsFound": MessageLookupByLibrary.simpleMessage(
      "No se encontraron visitas",
    ),
    "notVerified": MessageLookupByLibrary.simpleMessage("No verificado"),
    "notification": MessageLookupByLibrary.simpleMessage("Notificación"),
    "ok": MessageLookupByLibrary.simpleMessage("Aceptar"),
    "oops": MessageLookupByLibrary.simpleMessage("¡Ups!"),
    "otherItems": MessageLookupByLibrary.simpleMessage("Otros"),
    "pageContent": MessageLookupByLibrary.simpleMessage(
      "Contenido de la página",
    ),
    "pageCount": MessageLookupByLibrary.simpleMessage("Cantidad de páginas:"),
    "participants": MessageLookupByLibrary.simpleMessage("Participantes"),
    "password": MessageLookupByLibrary.simpleMessage("Contraseña"),
    "passwordChanged": MessageLookupByLibrary.simpleMessage(
      "Contraseña cambiada",
    ),
    "passwordIsRequired": MessageLookupByLibrary.simpleMessage(
      "Se requiere contraseña",
    ),
    "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
      "La contraseña y la confirmación no coinciden",
    ),
    "pause": MessageLookupByLibrary.simpleMessage("Pausa"),
    "phone": MessageLookupByLibrary.simpleMessage("Teléfono"),
    "phoneOrEmail": MessageLookupByLibrary.simpleMessage(
      "Teléfono o correo electrónico",
    ),
    "physicalActivities": MessageLookupByLibrary.simpleMessage(
      "Actividades físicas",
    ),
    "pleaseCompleteFormProperly": MessageLookupByLibrary.simpleMessage(
      "Por favor completa el formulario correctamente",
    ),
    "pleaseEnterConfirmationKey": MessageLookupByLibrary.simpleMessage(
      "Por favor ingresa la clave de confirmación",
    ),
    "pleaseEnterPassword": MessageLookupByLibrary.simpleMessage(
      "Por favor ingresa la contraseña",
    ),
    "pleaseEnterPhoneNumber": MessageLookupByLibrary.simpleMessage(
      "Por favor ingresa el número de teléfono",
    ),
    "pleaseEnterPhoneOrEmail": MessageLookupByLibrary.simpleMessage(
      "Por favor ingresa el número de teléfono o la dirección de correo electrónico",
    ),
    "pleaseProvideValidEmail": MessageLookupByLibrary.simpleMessage(
      "Por favor proporciona una dirección de correo electrónico válida",
    ),
    "pleaseProvideValidPhoneNumber": MessageLookupByLibrary.simpleMessage(
      "Por favor proporciona un número de teléfono válido",
    ),
    "pleaseProvideValidPhoneOrEmail": MessageLookupByLibrary.simpleMessage(
      "Por favor proporciona un número de teléfono o una dirección de correo electrónico válidos",
    ),
    "pleaseProvideYourName": MessageLookupByLibrary.simpleMessage(
      "Por favor proporciona tu nombre",
    ),
    "pleaseWaitRegistering": MessageLookupByLibrary.simpleMessage(
      "Registrando cuenta, por favor espera",
    ),
    "pleaseWaitSendingCode": MessageLookupByLibrary.simpleMessage(
      "Por favor espera, enviando código",
    ),
    "previous": MessageLookupByLibrary.simpleMessage("Anterior"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Política de privacidad",
    ),
    "processing": MessageLookupByLibrary.simpleMessage("Procesando"),
    "ratingSaved": MessageLookupByLibrary.simpleMessage(
      "Calificación guardada",
    ),
    "readMore": MessageLookupByLibrary.simpleMessage("Leer más"),
    "references": MessageLookupByLibrary.simpleMessage("Referencias"),
    "refresh": MessageLookupByLibrary.simpleMessage("Actualizar"),
    "registrationFailed": MessageLookupByLibrary.simpleMessage(
      "Error de registro",
    ),
    "requestFailed": MessageLookupByLibrary.simpleMessage("Error de solicitud"),
    "requestNewCode": MessageLookupByLibrary.simpleMessage(
      "Obtener nuevo código",
    ),
    "requestNewPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Obtener nueva contraseña",
    ),
    "resources": MessageLookupByLibrary.simpleMessage("Recursos"),
    "resume": MessageLookupByLibrary.simpleMessage("Reanudar"),
    "retrievingCoordinates": MessageLookupByLibrary.simpleMessage(
      "Obteniendo coordenadas",
    ),
    "routineAddedToCalendar": MessageLookupByLibrary.simpleMessage(
      "Rutina agregada al calendario",
    ),
    "routines": MessageLookupByLibrary.simpleMessage("Rutinas"),
    "routines_title": MessageLookupByLibrary.simpleMessage("Rutinas"),
    "saveAnswer": MessageLookupByLibrary.simpleMessage("Guardar respuesta"),
    "saveData": MessageLookupByLibrary.simpleMessage("Guardar datos"),
    "savingDataFailed": MessageLookupByLibrary.simpleMessage(
      "Error al guardar los datos",
    ),
    "scanCode": MessageLookupByLibrary.simpleMessage("Escanear código"),
    "score": MessageLookupByLibrary.simpleMessage("Puntuación"),
    "scoreListIsEmpty": MessageLookupByLibrary.simpleMessage(
      "Aún no se ha obtenido ninguna puntuación",
    ),
    "sendAnswer": MessageLookupByLibrary.simpleMessage("Enviar respuesta"),
    "settings": MessageLookupByLibrary.simpleMessage("Configuración"),
    "signUp": MessageLookupByLibrary.simpleMessage("Registrarse"),
    "startAssessment": MessageLookupByLibrary.simpleMessage(
      "Iniciar nueva evaluación",
    ),
    "tasks": MessageLookupByLibrary.simpleMessage("Tareas"),
    "thankyouForFeedback": MessageLookupByLibrary.simpleMessage(
      "¡Gracias por tu opinión!",
    ),
    "today": MessageLookupByLibrary.simpleMessage("Hoy"),
    "twoWeeks": MessageLookupByLibrary.simpleMessage("Dos semanas"),
    "unknownUser": MessageLookupByLibrary.simpleMessage("usuario desconocido"),
    "unnamed": MessageLookupByLibrary.simpleMessage("Sin nombre"),
    "unnamedActivity": MessageLookupByLibrary.simpleMessage(
      "Actividad sin nombre",
    ),
    "unnamedLibraryItem": MessageLookupByLibrary.simpleMessage(
      "Elemento sin nombre",
    ),
    "unnamedRoutine": MessageLookupByLibrary.simpleMessage("Rutina sin título"),
    "unnamedWebPage": MessageLookupByLibrary.simpleMessage("Página sin título"),
    "untitled": MessageLookupByLibrary.simpleMessage("Sin título"),
    "useCode": MessageLookupByLibrary.simpleMessage("Usar código"),
    "userInformation": MessageLookupByLibrary.simpleMessage(
      "Información del usuario",
    ),
    "userNotFound": MessageLookupByLibrary.simpleMessage(
      "Usuario no encontrado",
    ),
    "validateContactTitle": MessageLookupByLibrary.simpleMessage(
      "Validar información de contacto",
    ),
    "valueIsRequired": MessageLookupByLibrary.simpleMessage(
      "Este campo es obligatorio",
    ),
    "verified": MessageLookupByLibrary.simpleMessage("Verificado"),
    "verify": MessageLookupByLibrary.simpleMessage("verificar"),
    "visitRemoved": MessageLookupByLibrary.simpleMessage("Visita eliminada"),
    "week": MessageLookupByLibrary.simpleMessage("Semana"),
    "welcomeInfo": MessageLookupByLibrary.simpleMessage(
      "Mostrar información de bienvenida",
    ),
    "writeAnswerHere": MessageLookupByLibrary.simpleMessage(
      "Escribe tu respuesta aquí para ",
    ),
    "yes": MessageLookupByLibrary.simpleMessage("Sí"),
    "youHaveThisBadge": MessageLookupByLibrary.simpleMessage(
      "Tienes este logro",
    ),
    "yourAnswerHasBeenSaved": MessageLookupByLibrary.simpleMessage(
      "Tu respuesta ha sido guardada",
    ),
    "yourLogDates": MessageLookupByLibrary.simpleMessage("Fechas de registro"),
    "yourPassword": MessageLookupByLibrary.simpleMessage("Tu contraseña"),
  };
}
