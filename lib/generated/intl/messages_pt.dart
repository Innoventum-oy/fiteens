// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
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
  String get localeName => 'pt';

  static String m0(startdate) =>
      "Você não pode marcar esta atividade como concluída antes de ${startdate}";

  static String m1(startdate) => "O evento não pode ser pulado antes da data";

  static String m2(item) =>
      "${Intl.select(item, {'home': 'Início', 'calendar': 'Calendário', 'routines': 'Rotinas', 'mywellbeing': 'Meu Bem-estar', 'library': 'Biblioteca/Recursos', 'dashboard': 'Painel', 'other': 'Menu:${item}'})}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("Sobre"),
    "accountCreated": MessageLookupByLibrary.simpleMessage("Conta criada"),
    "accountDeleted": MessageLookupByLibrary.simpleMessage(
      "Conta de usuário excluída",
    ),
    "accountDeletion": MessageLookupByLibrary.simpleMessage(
      "Exclusão de conta",
    ),
    "achievements": MessageLookupByLibrary.simpleMessage("Conquistas"),
    "activities": MessageLookupByLibrary.simpleMessage("Atividades"),
    "activity": MessageLookupByLibrary.simpleMessage("Atividade"),
    "activityCalendar": MessageLookupByLibrary.simpleMessage(
      "Calendário de atividades",
    ),
    "activityLevel": MessageLookupByLibrary.simpleMessage("Nível de atividade"),
    "activityRecorded": MessageLookupByLibrary.simpleMessage(
      "Atividade registrada",
    ),
    "activityRegistrationFailed": MessageLookupByLibrary.simpleMessage(
      "Falha ao atualizar o status da atividade",
    ),
    "activityRegistrationSaved": MessageLookupByLibrary.simpleMessage(
      "Atividade marcada como concluída",
    ),
    "addedToList": MessageLookupByLibrary.simpleMessage("Adicionado à lista"),
    "addingRoutineFailed": MessageLookupByLibrary.simpleMessage(
      "Falha ao adicionar rotina ao calendário",
    ),
    "address": MessageLookupByLibrary.simpleMessage("Endereço"),
    "ageOver13": MessageLookupByLibrary.simpleMessage(
      "Você tem mais de 13 anos?",
    ),
    "alreadyDone": MessageLookupByLibrary.simpleMessage("Já feito"),
    "answerDate": MessageLookupByLibrary.simpleMessage("Data da resposta"),
    "answerSaved": MessageLookupByLibrary.simpleMessage("Resposta salva"),
    "appName": MessageLookupByLibrary.simpleMessage("FiTeens"),
    "authenticating": MessageLookupByLibrary.simpleMessage(
      "Autenticando... Por favor, aguarde",
    ),
    "btnAddToCalendar": MessageLookupByLibrary.simpleMessage(
      "Adicionar ao calendário",
    ),
    "btnConfirm": MessageLookupByLibrary.simpleMessage("Confirmar"),
    "btnContinue": MessageLookupByLibrary.simpleMessage("Continuar"),
    "btnDashboard": MessageLookupByLibrary.simpleMessage("Abrir Painel"),
    "btnLogin": MessageLookupByLibrary.simpleMessage("Login"),
    "btnMarkAsDone": MessageLookupByLibrary.simpleMessage(
      "Marcar como concluído",
    ),
    "btnReturn": MessageLookupByLibrary.simpleMessage("Voltar"),
    "btnReturnBook": MessageLookupByLibrary.simpleMessage("Devolver livro"),
    "btnSend": MessageLookupByLibrary.simpleMessage("Enviar"),
    "btnSetNewPassword": MessageLookupByLibrary.simpleMessage("Definir Senha"),
    "btnShow": MessageLookupByLibrary.simpleMessage("Mostrar"),
    "btnSkip": MessageLookupByLibrary.simpleMessage("Pular"),
    "btnTasks": MessageLookupByLibrary.simpleMessage("Tarefas"),
    "btnUseEmail": MessageLookupByLibrary.simpleMessage("Usar E-mail"),
    "btnUsePhone": MessageLookupByLibrary.simpleMessage(
      "Usar Número de Telefone",
    ),
    "btnValidateContact": MessageLookupByLibrary.simpleMessage(
      "Validar informações de contato agora",
    ),
    "btnValidateContactLater": MessageLookupByLibrary.simpleMessage(
      "Mais tarde",
    ),
    "calendar": MessageLookupByLibrary.simpleMessage("Calendário"),
    "calendarUpdated": MessageLookupByLibrary.simpleMessage(
      "Calendário atualizado",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
    "cannotSaveEmptyForm": MessageLookupByLibrary.simpleMessage(
      "Não é possível salvar um formulário vazio",
    ),
    "challenges": MessageLookupByLibrary.simpleMessage("Desafios"),
    "choose": MessageLookupByLibrary.simpleMessage("Escolher"),
    "chooseFile": MessageLookupByLibrary.simpleMessage("Escolher arquivo"),
    "clickPictureToChooseAvatar": MessageLookupByLibrary.simpleMessage(
      "Clique na imagem para escolher um avatar",
    ),
    "codeAccepted": MessageLookupByLibrary.simpleMessage("Código aceito"),
    "codeScanned": MessageLookupByLibrary.simpleMessage("Código escaneado"),
    "collectedBadges": MessageLookupByLibrary.simpleMessage(
      "Conquistas obtidas",
    ),
    "confirmDeletingAccount": MessageLookupByLibrary.simpleMessage(
      "Confirmar exclusão da conta de usuário",
    ),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("Confirmar senha"),
    "confirmationKey": MessageLookupByLibrary.simpleMessage(
      "Chave de confirmação",
    ),
    "contactInformation": MessageLookupByLibrary.simpleMessage(
      "Informações de contato",
    ),
    "contactInformationValidated": MessageLookupByLibrary.simpleMessage(
      "Contato validado",
    ),
    "contactMethod": MessageLookupByLibrary.simpleMessage("Método de contato"),
    "contactMethods": MessageLookupByLibrary.simpleMessage(
      "Métodos de contato",
    ),
    "contentNotFound": MessageLookupByLibrary.simpleMessage(
      "Conteúdo não encontrado",
    ),
    "couldNotOpenLink": MessageLookupByLibrary.simpleMessage(
      "Não foi possível abrir o link",
    ),
    "createAccount": MessageLookupByLibrary.simpleMessage("Criar conta"),
    "dateRange": MessageLookupByLibrary.simpleMessage("Intervalo de datas"),
    "deleteAccount": MessageLookupByLibrary.simpleMessage("Excluir conta"),
    "deleteYourAccount": MessageLookupByLibrary.simpleMessage(
      "Excluir sua conta",
    ),
    "deletingAccountCannotUndone": MessageLookupByLibrary.simpleMessage(
      "A conta de usuário é removida imediatamente. Essa ação não pode ser desfeita.",
    ),
    "deletingAccountFailed": MessageLookupByLibrary.simpleMessage(
      "Falha ao excluir conta",
    ),
    "discover": MessageLookupByLibrary.simpleMessage("Descobrir"),
    "downloadCertificate": MessageLookupByLibrary.simpleMessage(
      "Baixar Certificado",
    ),
    "downloadOpenBadge": MessageLookupByLibrary.simpleMessage(
      "Baixar Open Badge",
    ),
    "edit": MessageLookupByLibrary.simpleMessage("Editar"),
    "email": MessageLookupByLibrary.simpleMessage("E-mail"),
    "emailOrPhoneNumber": MessageLookupByLibrary.simpleMessage(
      "E-mail ou Número de Telefone",
    ),
    "enterGroupCode": MessageLookupByLibrary.simpleMessage(
      "Digite o código do grupo aqui",
    ),
    "enterNewCode": MessageLookupByLibrary.simpleMessage(
      "Digite um novo código",
    ),
    "enterPassword": MessageLookupByLibrary.simpleMessage("Digite a senha"),
    "error": MessageLookupByLibrary.simpleMessage("Erro"),
    "errorsInForm": MessageLookupByLibrary.simpleMessage(
      "Erros no conteúdo do formulário",
    ),
    "eventCannotBeMarkedBeforeDate": m0,
    "eventCannotBeSkippedBeforeDate": m1,
    "eventInFuture": MessageLookupByLibrary.simpleMessage(
      "A atividade está planejada para o futuro",
    ),
    "eventLog": MessageLookupByLibrary.simpleMessage("Registro de eventos"),
    "failedToSaveAnswer": MessageLookupByLibrary.simpleMessage(
      "Não foi possível salvar sua resposta",
    ),
    "feedback": MessageLookupByLibrary.simpleMessage("Feedback"),
    "feedbackSent": MessageLookupByLibrary.simpleMessage("Feedback enviado"),
    "fieldCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
      "Campo não pode ficar vazio",
    ),
    "firstName": MessageLookupByLibrary.simpleMessage("Nome"),
    "flashOff": MessageLookupByLibrary.simpleMessage("Flash Desligado"),
    "flashOn": MessageLookupByLibrary.simpleMessage("Flash Ligado"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Esqueceu a senha?"),
    "formIsEmpty": MessageLookupByLibrary.simpleMessage(
      "O formulário está vazio",
    ),
    "forms": MessageLookupByLibrary.simpleMessage("Formulários"),
    "getCode": MessageLookupByLibrary.simpleMessage("Obter código"),
    "great": MessageLookupByLibrary.simpleMessage("Ótimo!"),
    "groupCode": MessageLookupByLibrary.simpleMessage("Código do grupo"),
    "guardianInfo": MessageLookupByLibrary.simpleMessage(
      "Informações do responsável",
    ),
    "guardianName": MessageLookupByLibrary.simpleMessage("Nome do responsável"),
    "guardianPhone": MessageLookupByLibrary.simpleMessage(
      "Telefone do responsável",
    ),
    "healthyFood": MessageLookupByLibrary.simpleMessage("Alimentação saudável"),
    "healthyLifestyle": MessageLookupByLibrary.simpleMessage(
      "Estilo de vida saudável",
    ),
    "joinedToGroup": MessageLookupByLibrary.simpleMessage(
      "Você ingressou em um novo grupo",
    ),
    "joiningGroupFailed": MessageLookupByLibrary.simpleMessage(
      "Falha ao ingressar no grupo com o código fornecido",
    ),
    "joiningToUserGroup": MessageLookupByLibrary.simpleMessage(
      "Ingressando em um novo Grupo",
    ),
    "lastName": MessageLookupByLibrary.simpleMessage("Sobrenome"),
    "library": MessageLookupByLibrary.simpleMessage("Biblioteca"),
    "libraryIsEmpty": MessageLookupByLibrary.simpleMessage(
      "Não há conteúdo disponível no momento",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Carregando"),
    "locations": MessageLookupByLibrary.simpleMessage("Locais"),
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "loginFailed": MessageLookupByLibrary.simpleMessage("Falha no login"),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Login"),
    "logout": MessageLookupByLibrary.simpleMessage("Sair"),
    "month": MessageLookupByLibrary.simpleMessage("Mês"),
    "moreInformation": MessageLookupByLibrary.simpleMessage("Mais informações"),
    "myActivities": MessageLookupByLibrary.simpleMessage("Minhas atividades"),
    "myPoints": MessageLookupByLibrary.simpleMessage("Meus pontos"),
    "myScore": MessageLookupByLibrary.simpleMessage("Minha pontuação"),
    "navitem": m2,
    "next": MessageLookupByLibrary.simpleMessage("Próximo"),
    "no": MessageLookupByLibrary.simpleMessage("não"),
    "noActivitiesFound": MessageLookupByLibrary.simpleMessage(
      "Não foi possível encontrar atividades",
    ),
    "noContactMethodsFound": MessageLookupByLibrary.simpleMessage(
      "Nenhum método de contato encontrado",
    ),
    "noDescription": MessageLookupByLibrary.simpleMessage("Sem descrição"),
    "noEventsFound": MessageLookupByLibrary.simpleMessage(
      "Nenhum evento encontrado",
    ),
    "noFormsFound": MessageLookupByLibrary.simpleMessage(
      "Nenhum formulário encontrado",
    ),
    "noResourcesFound": MessageLookupByLibrary.simpleMessage(
      "Nenhum recurso disponível no momento",
    ),
    "noRoutinesFound": MessageLookupByLibrary.simpleMessage(
      "Nenhuma rotina encontrada",
    ),
    "noTasks": MessageLookupByLibrary.simpleMessage("Nenhuma tarefa"),
    "noThankYou": MessageLookupByLibrary.simpleMessage("Não, obrigado"),
    "noUsersFound": MessageLookupByLibrary.simpleMessage(
      "Nenhum usuário encontrado",
    ),
    "noVisitsFound": MessageLookupByLibrary.simpleMessage(
      "Nenhuma visita encontrada",
    ),
    "notVerified": MessageLookupByLibrary.simpleMessage("Não verificado"),
    "notification": MessageLookupByLibrary.simpleMessage("Notificação"),
    "ok": MessageLookupByLibrary.simpleMessage("Ok"),
    "oops": MessageLookupByLibrary.simpleMessage("Ops!"),
    "otherItems": MessageLookupByLibrary.simpleMessage("Outros"),
    "pageContent": MessageLookupByLibrary.simpleMessage("Conteúdo da página"),
    "pageCount": MessageLookupByLibrary.simpleMessage("Número de páginas:"),
    "participants": MessageLookupByLibrary.simpleMessage("Participantes"),
    "password": MessageLookupByLibrary.simpleMessage("Senha"),
    "passwordChanged": MessageLookupByLibrary.simpleMessage("Senha alterada"),
    "passwordIsRequired": MessageLookupByLibrary.simpleMessage(
      "Senha é obrigatória",
    ),
    "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
      "Senha e confirmação não correspondem",
    ),
    "pause": MessageLookupByLibrary.simpleMessage("Pausar"),
    "phone": MessageLookupByLibrary.simpleMessage("Telefone"),
    "phoneOrEmail": MessageLookupByLibrary.simpleMessage("Telefone ou E-mail"),
    "physicalActivities": MessageLookupByLibrary.simpleMessage(
      "Atividades físicas",
    ),
    "pleaseCompleteFormProperly": MessageLookupByLibrary.simpleMessage(
      "Por favor, preencha o formulário corretamente",
    ),
    "pleaseEnterConfirmationKey": MessageLookupByLibrary.simpleMessage(
      "Por favor, digite a chave de confirmação",
    ),
    "pleaseEnterPassword": MessageLookupByLibrary.simpleMessage(
      "Por favor, digite a senha",
    ),
    "pleaseEnterPhoneNumber": MessageLookupByLibrary.simpleMessage(
      "Por favor, digite o número de telefone",
    ),
    "pleaseEnterPhoneOrEmail": MessageLookupByLibrary.simpleMessage(
      "Por favor, digite o número de telefone ou endereço de e-mail",
    ),
    "pleaseProvideValidEmail": MessageLookupByLibrary.simpleMessage(
      "Por favor, forneça um endereço de e-mail válido",
    ),
    "pleaseProvideValidPhoneNumber": MessageLookupByLibrary.simpleMessage(
      "Por favor, forneça um número de telefone válido",
    ),
    "pleaseProvideValidPhoneOrEmail": MessageLookupByLibrary.simpleMessage(
      "Por favor, forneça um número de telefone ou endereço de e-mail válido",
    ),
    "pleaseProvideYourName": MessageLookupByLibrary.simpleMessage(
      "Por favor, forneça seu nome",
    ),
    "pleaseWaitRegistering": MessageLookupByLibrary.simpleMessage(
      "Registrando conta, por favor, aguarde",
    ),
    "pleaseWaitSendingCode": MessageLookupByLibrary.simpleMessage(
      "Por favor, aguarde, enviando código",
    ),
    "previous": MessageLookupByLibrary.simpleMessage("Anterior"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Política de Privacidade",
    ),
    "processing": MessageLookupByLibrary.simpleMessage("Processando"),
    "ratingSaved": MessageLookupByLibrary.simpleMessage("Avaliação salva"),
    "readMore": MessageLookupByLibrary.simpleMessage("Leia mais"),
    "references": MessageLookupByLibrary.simpleMessage("Referências"),
    "refresh": MessageLookupByLibrary.simpleMessage("Atualizar"),
    "registrationFailed": MessageLookupByLibrary.simpleMessage(
      "Falha no registro",
    ),
    "requestFailed": MessageLookupByLibrary.simpleMessage(
      "Falha na solicitação",
    ),
    "requestNewCode": MessageLookupByLibrary.simpleMessage("Obter novo código"),
    "requestNewPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Obter nova senha",
    ),
    "resources": MessageLookupByLibrary.simpleMessage("Recursos"),
    "resume": MessageLookupByLibrary.simpleMessage("Continuar"),
    "retrievingCoordinates": MessageLookupByLibrary.simpleMessage(
      "Obtendo coordenadas",
    ),
    "routineAddedToCalendar": MessageLookupByLibrary.simpleMessage(
      "Rotina adicionada ao calendário",
    ),
    "routines": MessageLookupByLibrary.simpleMessage("Rotinas"),
    "routines_title": MessageLookupByLibrary.simpleMessage("Rotinas"),
    "saveAnswer": MessageLookupByLibrary.simpleMessage("Salvar resposta"),
    "saveData": MessageLookupByLibrary.simpleMessage("Salvar dados"),
    "savingDataFailed": MessageLookupByLibrary.simpleMessage(
      "Falha ao salvar dados",
    ),
    "scanCode": MessageLookupByLibrary.simpleMessage("Escanear Código"),
    "score": MessageLookupByLibrary.simpleMessage("Pontuação"),
    "scoreListIsEmpty": MessageLookupByLibrary.simpleMessage(
      "Nenhuma pontuação obtida ainda",
    ),
    "sendAnswer": MessageLookupByLibrary.simpleMessage("Enviar resposta"),
    "settings": MessageLookupByLibrary.simpleMessage("Configurações"),
    "signUp": MessageLookupByLibrary.simpleMessage("Inscrever-se"),
    "startAssessment": MessageLookupByLibrary.simpleMessage(
      "Iniciar nova avaliação",
    ),
    "tasks": MessageLookupByLibrary.simpleMessage("Tarefas"),
    "thankyouForFeedback": MessageLookupByLibrary.simpleMessage(
      "Obrigado pelo seu feedback!",
    ),
    "today": MessageLookupByLibrary.simpleMessage("Hoje"),
    "twoWeeks": MessageLookupByLibrary.simpleMessage("Duas semanas"),
    "unknownUser": MessageLookupByLibrary.simpleMessage("usuário desconhecido"),
    "unnamed": MessageLookupByLibrary.simpleMessage("Sem nome"),
    "unnamedActivity": MessageLookupByLibrary.simpleMessage(
      "Atividade sem nome",
    ),
    "unnamedLibraryItem": MessageLookupByLibrary.simpleMessage("Item sem nome"),
    "unnamedRoutine": MessageLookupByLibrary.simpleMessage("Rotina sem título"),
    "unnamedWebPage": MessageLookupByLibrary.simpleMessage("Página sem título"),
    "untitled": MessageLookupByLibrary.simpleMessage("Sem título"),
    "useCode": MessageLookupByLibrary.simpleMessage("Usar código"),
    "userInformation": MessageLookupByLibrary.simpleMessage(
      "Informações do usuário",
    ),
    "userNotFound": MessageLookupByLibrary.simpleMessage(
      "Usuário não encontrado",
    ),
    "validateContactTitle": MessageLookupByLibrary.simpleMessage(
      "Validar informações de contato",
    ),
    "valueIsRequired": MessageLookupByLibrary.simpleMessage(
      "Este campo é obrigatório",
    ),
    "verified": MessageLookupByLibrary.simpleMessage("Verificado"),
    "verify": MessageLookupByLibrary.simpleMessage("verificar"),
    "visitRemoved": MessageLookupByLibrary.simpleMessage("Visita removida"),
    "week": MessageLookupByLibrary.simpleMessage("Semana"),
    "welcomeInfo": MessageLookupByLibrary.simpleMessage(
      "Mostrar informações de boas-vindas",
    ),
    "writeAnswerHere": MessageLookupByLibrary.simpleMessage(
      "Escreva sua resposta aqui para ",
    ),
    "yes": MessageLookupByLibrary.simpleMessage("Sim"),
    "youHaveThisBadge": MessageLookupByLibrary.simpleMessage(
      "Você possui esta conquista",
    ),
    "yourAnswerHasBeenSaved": MessageLookupByLibrary.simpleMessage(
      "Sua resposta foi salva",
    ),
    "yourLogDates": MessageLookupByLibrary.simpleMessage("Datas de registro"),
    "yourPassword": MessageLookupByLibrary.simpleMessage("Sua senha"),
  };
}
