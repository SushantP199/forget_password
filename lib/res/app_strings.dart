// ignore_for_file: constant_identifier_names

class AppStr {
  /*
    Font
  */
  static const fontFamily = "Kanit";

  /*
    View titles
  */
  static const appTitleName = "forget password";

  // View substitles 
  static const guide = "Guide";
  static const setTicket = "set ticket";
  static const changeTicket = "change ticket";
  static const addAccount = "add account";
  static const editAccount = "edit account";

  /*
    Splash view
  */
  static const getStarted = "GET STARTED";

  /*
    User guide view
  */
  static const read_with_care_text = "Read Concernfully";
  static const aggrement_text = "If you agree with above statements then GET STARTED, why to wait. Else do not use this app, as app never ever want to play with your ethics.";

  static const app_guide_lines = """
To keep your accounts safe T I C K E T concept is used in this app.

T I C K E T must be exact same for all the accounts you store.

After 6 consitent wrong entries for T I C K E T, access to your accounts will be denied for next 6 hours.

If you forget the T I C K E T itself, then there is no way to get it back. And eventually you will lost all you passwords stored forever.

Not to worry 😌.

You just have to remember one single T I C K E T 😇 of eight characters throughout entire app.

(By the way it is way more easier than remembering different usernames and passwords 😖 for all the accounts like before)
""";

  /*
    Home view
  */
  static const homeViewTitle = "Passwords";
  static const searchTextFieldHintText = "Search";
  static const messageForEmptyAccounts = "No Accounts Found";

  /*
    Account form view (add and edit)
  */
  static const accountTextFieldHintText = "enter acccount eg. twitter, instagram";
  static const usernameTextFieldHintText = "enter you email or user id";
  static const passwordTextFieldHintText = "enter your password";
  static const accountTextFieldErrorWarningText = "Account name cannot be empty";
  static const usernameTextFieldHErrorWarningText = "Email or user id cannot be empty";
  static const passwordTextFieldErrorWarningText = "Password cannot be empty";
  static const submitAcccountButtonText = "SAVE";

  /*
    Account detail view
  */
  static const copyToClipboardHintText = "Click to copy";
  static const removeButtonText = "DELETE";
  static const updateButtonText = "EDIT";
  static const deleteAccountWarningText = "Are you sure you want delete this account ?";
  static const editButtonErrorText = "Error occured while moving to edit account page";

  /*
    Tikcet form view (set and change)
  */
  static const enterOldTicketHintText = "old T I C K E T";
  static const enterTicketHintText = "T I C K E T";
  static const enterTicketConfirmHintText = "confirm T I C K E T";
  static const enterTicketConfirmAgainHintText = "confirm again T I C K E T";
  static const enternewTicketHintText = "new T I C K E T";
  static const enternewTicketConfirmHintText = "confirm new T I C K E T";
  static const enternewTicketConfirmAgainHintText = "confirm again new T I C K E T";
  static const submitTicketButtonText = "SET";
  static const submitTicketButtonErrorText = "Ticket cannot be set, something wrong happened, try again.";
  static const submitTicketButtonSuccessText = "Tikcet saved successfully";
  static const emptyOldTicketErrorText = "Old ticket cannot be empty";
  static const emptyTicketErrorText = "Ticket cannot be empty";
  static const lesserLengthTicketErrorText = "Please enter 8 character T I C K E T";
  static const ticketAndTicketConfirmsUnmatchErrorText =  "Ticket, confirm ticket & confirm again ticket are not matched to each other equally. PLEASE do the correction.";
  static const wrongTicketAttemptsCountNotifierText = "Attempts Available: ";
  static const wrongTicketAttemptsErrorText = "Your wrong ticket attempts are over, please try again after ";
  
  static const ticketCompliantUnsatisfiedErrorText = """
Ticket should follow below compliants:
Excatly 8 characters
At least one uppercase
At least one lowercase
At least one digit
At least one specialcase out of 
! @ # \$ % ^ & * ( ) , . ? ' " : ; { }  | < > ~ ` - _ + = [ ] \\ /
Avoid <space(s)>
""";

  /*
    Protection view
  */
  static const protectionWallTitle = "Protection Wall";
  static const submitTicketProtectionWallText = "ENTER";
  static const encryptingLoadingText = "Encrypting...";
  static const decryptingLoadingText = "Decrypting...";

  /*
    Alerts
  */
  static const dataSavedSuccessfullyAlertText = "Saved sucessfully";
  static const dataCopiedSuccessfullyAlertText = "Copied sucessfully";
  static const dataCopiedErrorAlertText = "Copied to clipboard Failed";
  static const dataRemovedSuccessfullyAlertText = "Deleted sucessfully";
  static const alertButtonText = "OKAY";
  static const alertCancelButtonText = "CANCEL";
  static const alertErrorTitleText = "ERROR";
  static const alertWarningTitleText = "WARNING";
  static const alertSucessTitleText = "SUCCESS";

  /*
    Error view
  */
  static const exitButtonText = "EXIT APP";
  static const homeButtonText = "GO TO HOME";
  static const homeButtonAlterText = "RELOAD HOME";
  static const copyButtonErrorText = "Error occuried while copying data";
  static const navigatedToUnknownRouteErrorText = "You are moved yo unknown page";
  static const hiveDbSaveErrorText = "Failed to save user account";
  static const contextMountingErrorText = "Page failed to load";

  static const homeErrorButtonsGuideText = """\n
Press OKAY, to refresh the home.
Press CANCEL, to exit the app.""";  
}
