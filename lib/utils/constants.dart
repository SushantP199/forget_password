// ignore_for_file: constant_identifier_names

class KPrefs {
  static const KAuthVerifier = "AuthVerifier";
  static const KIsSplashSeen = "IsSplashSeen";
  static const KIncorrectTickets = "IncorrectTickets";
  static const KLastTimeTicketEntryFailed = "LastTimeTicketEntryFailed";
}

class KGlobal {
  static const KAllowedIncorrectTickets = 6;
  static const KTicketEntryDeniedHours = 6;
  static const KLastTimeTicketEntryFailed = "";
  static const KCodingTimeInMilliSec = 750;
  static const KSplashTimeInMilliSec = 1500;
  static const KMaxPassLen = 100;
  static const KPassRegEx =
      r'''[a-zA-Z0-9!@#$%^&*(),.?'":;{}|<>~`\-_+=\[\]\\/ ]''';
  static const VOID = "void";
  static const ERROR = "error";
  static const SUCCESS = "success";
  static const EMPTY = "";
}

class KError {
  static const STORERROR = "Internal memory error occured";
  static const TECHERROR = "Technical error occured";
  static const CODEERROR = "Application error occured";
}
