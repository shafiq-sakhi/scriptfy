import 'package:text_to_image/utils/data_cache.dart';

class AppLanguage {
  static bool isEnglish = DataCache.isEnglish();

  static get STARS=>isEnglish?"Stars":"Sterne";

  static get FREE_CREDIT_FINSHED=>isEnglish?"Here you can buy more stars.":"Hier kannst du weitere Sterne kaufen.";

  static get PURCHASE_DESCRIPTION => isEnglish
      ? "You can search and download 12 images in just. Buy and enjoy"
      : "Sie können 12 Bilder in Just suchen und herunterladen. Kaufen und genießen";

  static get CLICK_TO_BUY =>
      isEnglish ? "Click to buy" : "Klicken um zu kaufen";

  static get NOT_NOW => isEnglish ? "Not now" : "Nicht jetzt";

  static get TEXT_COPIED => isEnglish ? "Text copied" : "Text kopiert";

  static get VERIICATION_EMAIL_SENT_PLEASE_VERIFY_EMAIL => isEnglish
      ? "A verification email from Scriptfy has been sent. Please confirm the verification email"
      : "Eine Bestätigungs von Scriptfy wurde gesendet. Bitte bestätige die Verfifizierungs E-Mail";

  static get ONLINE => isEnglish ? "Online" : "Online";

  static get MENU => isEnglish ? "Menu" : "Menü";

  static get CONFIRM_PASSWORD =>
      isEnglish ? "Confirm password" : "Bestätige das Passwort";

  static get FULNAME => isEnglish ? "FirstName" : "Vorname";

  static get GET_STARTED_WITH_SCRIPTFY => isEnglish
      ? "Get started with Scriptfy"
      : "Beginnene mit Scriptfy";

  static get  PASSWORD=>isEnglish?"Password":"Passwort";

  static get HELO_AGAIN_YOU_HAVE_BEEN_MISSED=>isEnglish?"Hello again, you’ve been missed!":"Hallo nochmal, du wurdest vermisst!";

  static get HI_WELCOME_BACK=>isEnglish?"Hi, Wecome Back! 👋":"Hallo, Willkommen zurück! 👋";

  static get START_PURCHASED=>isEnglish?"Stars Purchased":"Sterne gekauft";

  static get PURCHASE_STAR=>isEnglish?"Purchase Star":"Sterne kaufen";

  static get YOUR_ACCOUNT_UPDATED_SUCCESSFULLY=>isEnglish?'Your account updated successfully!':"Dein Konto wurde erfolgreich aktualisiert!";

  static get ACCOUNT_CREATED_SUCCESSFULLY => isEnglish
      ? "Account created successfully. Please confirm the email we have sent."
      : "Konto erfolgreich erstellt. Bitte Bestätige die E-Mail, die wir gesendet haben.";

  static get PHONE_NUMBER => isEnglish ? "Phone number" : "Telefonnummer";

  static get EMAIL => isEnglish ? "Email" : "Email";

  static get NAME => isEnglish ? "Name" : "Name";

  static get DOWNLOAD_COMPLETED =>
      isEnglish ? "Download completed" : "Download abgeschlossen";

  static get YOU_REALLYWANT_TO_DOWNLOAD_ALL_IMAGES => isEnglish
      ? "Download all images"
      : "Alle Bilder herunterladen";

  static get STORAGE => isEnglish ? "Storage" : "Lagerung";

  static get DOWNLOAD_IMAGE =>
      isEnglish ? "Download image" : "Bild herunterladen";

  static get SEARC_AND_DOWNLOAD =>
      isEnglish ? "Search and download image" : "Bild suchen und herunterladen";

  static get CREATE => isEnglish ? 'Create' : 'Erstellen';

  static get DESCRIBE_THE_PICTURE_AS_BEST_AS_PISSIBLE => isEnglish
      ? "Describe the picture as best as possible."
      : 'Das Bild so gut als möglich beschreiben.';

  static get SCRIPTARTIFY => isEnglish ? 'Scriptfy' : "Scriptfy";

  static get OPEN_AI_WAITINGFOR_YOUR_QUERY => isEnglish
      ? "Scriptfy is looking forward to your chat"
      : "Scriptfy freut sich auf dein Chat";

  static get CHAT_GPT => isEnglish ? 'Scriptfy Code develop' : "Scriptfy Code entwickeln";

  static get ENTER_YOUR_PASSWORD_BEFORE_DELETING_ACCOUNT => isEnglish
      ? "Enter your password before deleting account?"
      : "Geben dein Passwort ein, bevor du dein Konto löscht?";

  static get DELETE_ACCOUNT => isEnglish ? "Delete account" : "Konto löschen";

  static String get WELCOME_TO_SCRIPTFY => isEnglish
      ? "Welcome to Scriptfy!"
      : "Herzlich Willkommen bei Scriptfy!";

  static String get ABOUT_APP => isEnglish
      ? "Visions can be brought to life through images"
      : "Visionen können durch Bilder zum Leben erweckt werden";

  static String get LETS_GO => isEnglish ? "Here we go!" : "Los geht\'s!";

  static String get WELCOME_DESCRITION => isEnglish
      ? "Dall-E2 Scriptfy, the first app based on artificial intelligence that turns text into stunning images. \nIt can also write codes and stories."
      : "Dall-E2 Scriptfy, der ersten App, die auf künstliche Intelligenz basiert und Texte in atemberaubende Bilder verwandelt. \nDazu noch Codes & Geschichten schreiben kann.";

  static String get ENTER_YOUR_EMAIL =>
      isEnglish ? 'Enter your email' : "E-Mail Adresse eingeben";

  static String get ENTER_YOU_PASSWORD =>
      isEnglish ? 'Enter your password' : "Passwort eingeben";

  static String get DONT_HAVE_ACCOUNT =>
      isEnglish ? "don't have account?" : "Du haben kein Konto?";

  static String get SIGNIN => isEnglish ? "Signin" : "Anmelden";

  static String get LOADING => isEnglish ? "Loading..." : "Wird geladen...";

  static String get ERROR => isEnglish ? "Unfortunately, you've run out of stars." : "Leider sind dir die Sterne ausgegangen.";

  static String get NAME_IS_EMPTY =>
      isEnglish ? 'Name field is empty' : "Namensfeld ist leer";

  static String get PHONE_IS_EMPTY =>
      isEnglish ? 'Phone field is empty' : "Telefonfeld ist leer";

  static String get EMAIL_IS_EMPTY =>
      isEnglish ? 'Email field is empty' : "E-Mail-Feld ist leer";

  static String get PASSWORD_IS_EMPTY =>
      isEnglish ? 'Password field is empty' : "Passwortfeld ist leer";

  static String get PASSWORD_LENGTH => isEnglish
      ? 'Password must be at least 8 characters'
      : "Das Passwort muss mindestens 8 Zeichen lang sein";

  static String get PASSWORD_DONOT_MATCHED =>
      isEnglish ? 'Passwords do not match' : "Passwörter stimmen nicht überein";

  static String get REGISTER => isEnglish ? 'Register' : "Registrieren";

  static String get ALREAD_HAVE_ACCOUNT =>
      isEnglish ? "Don't have an account" : "Du hast kein Konto";

  static String get ENTER_YOUR_NAME =>
      isEnglish ? 'Enter your Name' : "Gib deinen Namen ein";

  static String get ENTER_YOUR_PHONE =>
      isEnglish ? 'Enter your Phone' : "Telefon eingeben";

  static String get ENTER_OUR_CONFIRM_PASSWORD => isEnglish
      ? 'Enter your confirm password'
      : "Passwort bestätigen";

  static String get SELECT_YOUR_IMAGE =>
      isEnglish ? 'Select image profile' : "Profilbild auswählen";

  static String get HI => isEnglish ? "Hi" : "Hi";

  static String get WHAT_YOU_WANT_TO_DO => isEnglish
      ? 'What do you want to do today?'
      : "Was möchtest du heute machen?";

  static String get LOGOUT => isEnglish ? "Logout" : "Ausloggen";

  static String get DO_YOU_REALLY_WANT_TO_LOGOUT => isEnglish
      ? "Do you really want to logout?"
      : "Möchtest du dich wirklich abmelden?";

  static String get DO_YOU_REALLY_WANT_TO_DELETE => isEnglish
      ? "Do you really want to delete?"
      : "Account wirklich löschen?";

  static String get YES => isEnglish ? "Yes" : "Ja";

  static String get NO => isEnglish ? "No" : "Nein";

  static String get TEXT_COMPLETION =>
      isEnglish ? "Text & Stories" : "Text & Geschichten";

  static String get IMAGE_GENERATION =>
      isEnglish ? "Convert text to images" : "Text in Bilder umwandeln";

  static String get CODE_COMPLETION =>
      isEnglish ? "Web & App" : "Web & App";

  static String get EMBEDDING => isEnglish ? "Coming soon" : "Demnächst verfügbar";

  static String get COMMING_SOON => isEnglish ? "Coming soon!" : "Kommt bald!";

  static String get HOME => isEnglish ? 'Home' : "Home";

  static String get INFO => isEnglish ? 'Profile' : "Profil";

  static String get PROFILE => isEnglish ? 'Profile' : "Profil";

  static String get ACCOUNT => isEnglish ? "Account" : "Konto";

  static String get UPDATE_PROFILE =>
      isEnglish ? "Update Profile" : "Profil aktualisieren";

  static String get REVIEWS => isEnglish ? "Reviews" : "Bewertungen";

  static String get GOTO_REVIEWS =>
      isEnglish ? "Goto reviews" : "Gehe zu Bewertungen";

  static String get LANGUAGE => isEnglish ? "Language" : "Sprache";

  static String get UPDATE_LANGUAGE =>
      isEnglish ? "Update \nlanguage" : "Sprache \naktualisieren";

  static String get SUPPORT => isEnglish ? "Support" : "Support";

  static String get SELECT_LANGUAGE =>
      isEnglish ? "Select Language" : "Sprache auswählen";

  static String get ENGLISH => isEnglish ? "English" : "Englisch";

  static String get GERMAN => isEnglish ? "German" : "Deutsch";

  static String get SIGN_IN_WITH_FACEBOOK => isEnglish ? "Sign in with Facebook" : "Mit Facebook anmelden";

  static String get  CONTINUE_WITH_GOOGLE => isEnglish ? "Continue with Google" : "Weiter mit Google";

  static String get  SELECT_FROM => isEnglish ? "Select From" : "Wählen aus";

  static String get  CAMERA => isEnglish ? "Camera" : "Kamera";

  static String get  GALLERY => isEnglish ? "Gallery" : "Galerie";

  static String get  PRIVACY_POLICY => isEnglish ? "Privacy policy" : "Datenschutz";

  static String get  TERM_OF_USE => isEnglish ? "Term of use" : "Nutzungs-\nbedinung";

  static String get  CODE_COMPLETION_CHATS => isEnglish ? "Develop something creative" : "Etwas kreatives entwickeln";

  static String get  DELETE => isEnglish ? "deleted" : "gelöscht";

  static String get  DELETE_CHATROOM => isEnglish ? "Delete Chatroom" : "Chatroom Löschen";

  static String get  NEW_CHAT => isEnglish ? "New Chat" : "Neuer Chat";

  static String get  TITLE => isEnglish ? "title" : "titel";

  static String get  ADD => isEnglish ? "add" : "hinzufügen";

  static String get  DOWNLOADING => isEnglish ? "Image has been downloaded..." : "Bild wurde heruntergeladen...";

  static String get  THE_EMAIL_OR_PASSWORD_IS_WRONG => isEnglish ? "The email is wrong!" : "Die E-Mail ist falsch!";

  static String get  PLEASE_AGREE_ON_POLICY_AND_USE_TERM => isEnglish ? "Please agree on policy and terms" : "Ga akkoord met het beleid en de voorwaarden";

  static String get  AGREE_ON_POLICY_AND_USE_TERM => isEnglish ? "Agree on policy and terms" : "het eens worden over het \nbeleid en de voorwaarden";
}

