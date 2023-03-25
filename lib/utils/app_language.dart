import 'package:text_to_image/utils/data_cache.dart';

class AppLanguage {
  static bool isEnglish = DataCache.isEnglish();

  static get STARS=>isEnglish?"Stars":"Sterne";

  static get FREE_CREDIT_FINSHED=>isEnglish?"Free credit finished":"Gratisguthaben beendet";

  static get PURCHASE_DESCRIPTION => isEnglish
      ? "You can search and download 12 images in just.Buy and enjoy"
      : "Sie können 12 Bilder in Just suchen und herunterladen. Kaufen und genießen";

  static get CLICK_TO_BUY =>
      isEnglish ? "Click to buy" : "Klicken um zu kaufen";

  static get NOT_NOW => isEnglish ? "Not now" : "Nicht jetzt";

  static get TEXT_COPIED => isEnglish ? "Text copied" : "Texte kopiert";

  static get VERIICATION_EMAIL_SENT_PLEASE_VERIFY_EMAIL => isEnglish
      ? "A verification email was sent. Please verify your email"
      : "Eine Bestätigungs-E-Mail wurde gesendet. Bitte bestätigen Sie Ihre E-Mail";

  static get ONLINE => isEnglish ? "Online" : "Online";

  static get MENU => isEnglish ? "Menu" : "Speisekarte";

  static get CONFIRM_PASSWORD =>
      isEnglish ? "Confirm password" : "Bestätige das Passwort";

  static get FULNAME => isEnglish ? "FirstName" : "Vorname";

  static get GET_STARTED_WITH_SCRIPTFY => isEnglish
      ? "Get started with ScriptArtify"
      : "Beginnen Sie mit ScriptArtify";

  static get  PASSWORD=>isEnglish?"Password":"Passwort";

  static get HELO_AGAIN_YOU_HAVE_BEEN_MISSED=>isEnglish?"Hello again, you’ve been missed!":"Hallo nochmal, du wurdest vermisst!";

  static get HI_WELCOME_BACK=>isEnglish?"Hi, Wecome Back! 👋":"Hallo, Willkommen zurück! 👋";

  static get START_PURCHASED=>isEnglish?"Stars Purchased":"Sterne gekauft";

  static get PURCHASE_STAR=>isEnglish?"Purchase Star":"Stern kaufen";

  static get YOUR_ACCOUNT_UPDATED_SUCCESSFULLY=>isEnglish?'Your account updated successfully!':"Ihr Konto wurde erfolgreich aktualisiert!";

  static get ACCOUNT_CREATED_SUCCESSFULLY => isEnglish
      ? "Account created successfully.Please check your email"
      : "Konto erfolgreich erstellt. Bitte überprüfen Sie Ihre E-Mail";

  static get PHONE_NUMBER => isEnglish ? "Phone number" : "Telefonnummer";

  static get EMAIL => isEnglish ? "Email" : "Email";

  static get NAME => isEnglish ? "Name" : "Name";

  static get DOWNLOAD_COMPLETED =>
      isEnglish ? "Download completed" : "Download abgeschlossen";

  static get YOU_REALLYWANT_TO_DOWNLOAD_ALL_IMAGES => isEnglish
      ? "You really want to download all images?"
      : "Sie möchten wirklich alle Bilder herunterladen?";

  static get STORAGE => isEnglish ? "Storage" : "Lagerung";

  static get DOWNLOAD_IMAGE =>
      isEnglish ? "Download image" : "Bild herunterladen";

  static get SEARC_AND_DOWNLOAD =>
      isEnglish ? "Search and download image" : "Bild suchen und herunterladen";

  static get CREATE => isEnglish ? 'Create' : 'Erstellen';

  static get DESCRIBE_THE_PICTURE_AS_BEST_AS_PISSIBLE => isEnglish
      ? "Describe the picture as best as possible."
      : 'Das Bild so gut als möglich beschreiben.';

  static get SCRIPTARTIFY => isEnglish ? 'ScriptArtify' : "ScriptArtify";

  static get OPEN_AI_WAITINGFOR_YOUR_QUERY => isEnglish
      ? "Open AI Waiting for your query..."
      : "KI öffnen Warten auf Ihre Anfrage...";

  static get CHAT_GPT => isEnglish ? 'Chat GPT Text' : "Chat GPT tekst";

  static get ENTER_YOUR_PASSWORD_BEFORE_DELETING_ACCOUNT => isEnglish
      ? "Enter your password before deleting account?"
      : "Geben Sie Ihr Passwort ein, bevor Sie das Konto löschen?";

  static get DELETE_ACCOUNT => isEnglish ? "Delete account" : "Konto löschen";

  static String get WELCOME_TO_SCRIPTFY => isEnglish
      ? "Welcome to ScriptArtify!"
      : "Herzlich Willkommen bei ScriptArtify!";

  static String get ABOUT_APP => isEnglish
      ? "Our app allows you to convert text to images and then share them with friends and family"
      : "Unsere App ermöglicht es Ihnen, Text in Bilder umzuwandeln und diese dann mit Freunden und Familie zu teilen";

  static String get LETS_GO => isEnglish ? "Here we go!" : "Los geht\'s!";

  static String get WELCOME_DESCRITION => isEnglish
      ? "Featuring ScriptArtify, the app based on Dall-E 2 that converts text into stunning images."
      : "Mit ScriptArtify, der  App, die auf Dall-E 2 basiert und Text in atemberaubende Bilder umwandelt.";

  static String get ENTER_YOUR_EMAIL =>
      isEnglish ? 'Enter your email' : "Geben sie ihre E-Mail Adresse ein";

  static String get ENTER_YOU_PASSWORD =>
      isEnglish ? 'Enter your password' : "Geben Sie Ihr Passwort ein";

  static String get DONT_HAVE_ACCOUNT =>
      isEnglish ? "don't have account?" : "Sie haben kein Konto?";

  static String get SIGNIN => isEnglish ? "Signin" : "Anmelden";

  static String get LOADING => isEnglish ? "Loading..." : "Wird geladen...";

  static String get ERROR => isEnglish ? "Error" : "Fehler";

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
      isEnglish ? "Don't have an account" : "Don't have an account";

  static String get ENTER_YOUR_NAME =>
      isEnglish ? 'Enter your Name' : "Gib deinen Namen ein";

  static String get ENTER_YOUR_PHONE =>
      isEnglish ? 'Enter your Phone' : "Geben Sie Ihr Telefon ein";

  static String get ENTER_OUR_CONFIRM_PASSWORD => isEnglish
      ? 'Enter your confirm password'
      : "Geben Sie Ihr Bestätigungspasswort ein";

  static String get SELECT_YOUR_IMAGE =>
      isEnglish ? 'Select image profile' : "Bildprofil auswählen";

  static String get HI => isEnglish ? "Hi" : "Hi";

  static String get WHAT_YOU_WANT_TO_DO => isEnglish
      ? 'What do you want to do today?'
      : "Was willst Du heute machen?";

  static String get LOGOUT => isEnglish ? "Logout" : "Ausloggen";

  static String get DO_YOU_REALLY_WANT_TO_LOGOUT => isEnglish
      ? "Do you really want to logout?"
      : "Möchten Sie sich wirklich abmelden?";

  static String get DO_YOU_REALLY_WANT_TO_DELETE => isEnglish
      ? "Do you really want to delete?"
      : "Möchten Sie wirklich löschen?";

  static String get YES => isEnglish ? "Yes" : "Ja";

  static String get NO => isEnglish ? "No" : "Nein";

  static String get TEXT_COMPLETION =>
      isEnglish ? "Text completion" : "Textvervollständigung";

  static String get IMAGE_GENERATION =>
      isEnglish ? "Image generation" : "Bilderzeugung";

  static String get CODE_COMPLETION =>
      isEnglish ? "Code completion" : "Code-Vervollständigung";

  static String get EMBEDDING => isEnglish ? "Embeddings" : "Einbettungen";

  static String get COMMING_SOON => isEnglish ? "Coming soon!" : "Kommt bald!";

  static String get HOME => isEnglish ? 'Home' : "Heim";

  static String get INFO => isEnglish ? 'Info' : "Die Info";

  static String get PROFILE => isEnglish ? 'Profile' : "Profil";

  static String get ACCOUNT => isEnglish ? "Account" : "Konto";

  static String get UPDATE_PROFILE =>
      isEnglish ? "Update Profile" : "Profil aktualisieren";

  static String get REVIEWS => isEnglish ? "Reviews" : "Bewertungen";

  static String get GOTO_REVIEWS =>
      isEnglish ? "Goto reviews" : "Gehe zu Bewertungen";

  static String get LANGUAGE => isEnglish ? "Language" : "Sprache";

  static String get UPDATE_LANGUAGE =>
      isEnglish ? "Update language" : "Sprache aktualisieren";

  static String get SUPPORT => isEnglish ? "Support" : "Die Unterstützung";

  static String get SELECT_LANGUAGE =>
      isEnglish ? "Select Language" : "Sprache auswählen";

  static String get ENGLISH => isEnglish ? "English" : "Englisch";

  static String get GERMAN => isEnglish ? "German" : "Deutsch";

  static String get SIGN_IN_WITH_FACEBOOK => isEnglish ? "Sign in with Facebook" : "Mit Facebook anmelden";

  static String get  CONTINUE_WITH_GOOGLE => isEnglish ? "Continue with Google" : "Weiter mit Google";

  static String get  SELECT_FROM => isEnglish ? "Select From" : "Wählen aus";

  static String get  CAMERA => isEnglish ? "Camera" : "Kamera";

  static String get  GALLERY => isEnglish ? "Gallery" : "Galerie";

  static String get  PRIVACY_POLICY => isEnglish ? "Privacy policy" : "Datenschutz-Bestimmungen";

  static String get  TERM_OF_USE => isEnglish ? "Term of use" : "Nutzungsbedinungen";

  static String get  CODE_COMPLETION_CHATS => isEnglish ? "Code completion chats" : "Code Vervollständigungs Chats";

  static String get  DELETE => isEnglish ? "deleted" : "gelöscht";

  static String get  DELETE_CHATROOM => isEnglish ? "Delete Chatroom" : "Chatroom Löschen";

  static String get  NEW_CHAT => isEnglish ? "New Chat" : "Neuer Chat";

  static String get  TITLE => isEnglish ? "title" : "titel";

  static String get  ADD => isEnglish ? "add" : "hinzufügen";

  static String get  DOWNLOADING => isEnglish ? "DOWNLOADING....." : "WIRD HERUNTERGELADEN.....";

  static String get  THE_EMAIL_OR_PASSWORD_IS_WRONG => isEnglish ? "The email or password is wrong!" : "Het e-mailadres of wachtwoord is verkeerd!";
}

