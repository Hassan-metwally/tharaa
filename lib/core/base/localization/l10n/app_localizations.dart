import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('ar'), Locale('en')];

  /// No description provided for @locale.
  ///
  /// In en, this message translates to:
  /// **'EN'**
  String get locale;

  /// No description provided for @languageName.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageName;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Tharaa'**
  String get appName;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again.'**
  String get unexpectedError;

  /// No description provided for @unAutherizedUserExeption.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized user. Please log in again.'**
  String get unAutherizedUserExeption;

  /// No description provided for @failToLoad.
  ///
  /// In en, this message translates to:
  /// **'Failed to load. Please try again.'**
  String get failToLoad;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get somethingWentWrong;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection available.'**
  String get noInternetConnection;

  /// No description provided for @connectionIssueTryLater.
  ///
  /// In en, this message translates to:
  /// **'There was a connection issue. Please try again later.'**
  String get connectionIssueTryLater;

  /// No description provided for @noInternetFound.
  ///
  /// In en, this message translates to:
  /// **'No internet found, check your connection'**
  String get noInternetFound;

  /// No description provided for @unAuthenticatedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired, please##log in##again.'**
  String get unAuthenticatedMessage;

  /// No description provided for @anErrorOccurredWhileLoading.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while loading,'**
  String get anErrorOccurredWhileLoading;

  /// No description provided for @tryAnotherTime.
  ///
  /// In en, this message translates to:
  /// **'Try another time'**
  String get tryAnotherTime;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @pickImageFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Photo gallery'**
  String get pickImageFromGallery;

  /// No description provided for @pickImageFromCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get pickImageFromCamera;

  /// No description provided for @pickVideoFromCamera.
  ///
  /// In en, this message translates to:
  /// **'Pick Video From Camera'**
  String get pickVideoFromCamera;

  /// No description provided for @pickVideoFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Pick Video From Gallery'**
  String get pickVideoFromGallery;

  /// No description provided for @deleteImage.
  ///
  /// In en, this message translates to:
  /// **'Delete image'**
  String get deleteImage;

  /// No description provided for @cantOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Cannot open link, make sure it\'s valid.'**
  String get cantOpenLink;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @changeLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the language you want to use in the app.'**
  String get changeLanguageSubtitle;

  /// No description provided for @arabicLanguage.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabicLanguage;

  /// No description provided for @englishLanguage.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get englishLanguage;

  /// No description provided for @guestHeaderMessage.
  ///
  /// In en, this message translates to:
  /// **'Please log in first'**
  String get guestHeaderMessage;

  /// No description provided for @guestSubHeaderMessage.
  ///
  /// In en, this message translates to:
  /// **'to enjoy all the features of the app'**
  String get guestSubHeaderMessage;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @selectCity.
  ///
  /// In en, this message translates to:
  /// **'Select City'**
  String get selectCity;

  /// No description provided for @bank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get bank;

  /// No description provided for @selectBank.
  ///
  /// In en, this message translates to:
  /// **'Select Bank'**
  String get selectBank;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @service.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get service;

  /// No description provided for @offers.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get offers;

  /// No description provided for @offer.
  ///
  /// In en, this message translates to:
  /// **'Offer'**
  String get offer;

  /// No description provided for @providers.
  ///
  /// In en, this message translates to:
  /// **'Providers'**
  String get providers;

  /// No description provided for @chooseService.
  ///
  /// In en, this message translates to:
  /// **'Choose a service'**
  String get chooseService;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResults;

  /// No description provided for @images.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get images;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @files.
  ///
  /// In en, this message translates to:
  /// **'Files'**
  String get files;

  /// No description provided for @requestSentSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Request sent successfully'**
  String get requestSentSuccessfully;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get readMore;

  /// No description provided for @readLess.
  ///
  /// In en, this message translates to:
  /// **'Read less'**
  String get readLess;

  /// No description provided for @searchByProductName.
  ///
  /// In en, this message translates to:
  /// **'Search by product name...'**
  String get searchByProductName;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'to'**
  String get to;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'لا يوجد إشعارات حالياً'**
  String get noNotifications;

  /// No description provided for @dayMonthYear.
  ///
  /// In en, this message translates to:
  /// **'Day/Month/Year'**
  String get dayMonthYear;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @sendRequest.
  ///
  /// In en, this message translates to:
  /// **'Send Request'**
  String get sendRequest;

  /// No description provided for @continue_.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @upload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get upload;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @startNow.
  ///
  /// In en, this message translates to:
  /// **'Start now'**
  String get startNow;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get goBack;

  /// No description provided for @agree.
  ///
  /// In en, this message translates to:
  /// **'Agree'**
  String get agree;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @editPhoto.
  ///
  /// In en, this message translates to:
  /// **'Edit photo'**
  String get editPhoto;

  /// No description provided for @editProfilePicture.
  ///
  /// In en, this message translates to:
  /// **'Edit profile picture'**
  String get editProfilePicture;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @disagree.
  ///
  /// In en, this message translates to:
  /// **'Disagree'**
  String get disagree;

  /// No description provided for @search_.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search_;

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @loadMore.
  ///
  /// In en, this message translates to:
  /// **'Load more'**
  String get loadMore;

  /// No description provided for @closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// No description provided for @closeChatPreviewMessage.
  ///
  /// In en, this message translates to:
  /// **'Chat closed'**
  String get closeChatPreviewMessage;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @agree2.
  ///
  /// In en, this message translates to:
  /// **'Agree'**
  String get agree2;

  /// No description provided for @saveEdites.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveEdites;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get fieldRequired;

  /// No description provided for @fieldMustNotHaveSpaces.
  ///
  /// In en, this message translates to:
  /// **'This field must not have spaces.'**
  String get fieldMustNotHaveSpaces;

  /// No description provided for @invalidIban.
  ///
  /// In en, this message translates to:
  /// **'The IBAN must start with SA and be exactly 24 characters long (SA + 22 alphanumeric characters).'**
  String get invalidIban;

  /// No description provided for @invalidAcountNumber.
  ///
  /// In en, this message translates to:
  /// **'The account number must be between 10 and 13 digits'**
  String get invalidAcountNumber;

  /// No description provided for @commercialRegistrationValidation.
  ///
  /// In en, this message translates to:
  /// **'Commercial registration number must consist of 10 digits'**
  String get commercialRegistrationValidation;

  /// No description provided for @invalidOperatingLicenseNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid operating license number'**
  String get invalidOperatingLicenseNumber;

  /// No description provided for @nameTooShort.
  ///
  /// In en, this message translates to:
  /// **'Name is too short.'**
  String get nameTooShort;

  /// No description provided for @invalidEmailFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address format.'**
  String get invalidEmailFormat;

  /// No description provided for @passwordRequirements.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long, include capital letters, at least one lowercase letter and special character.'**
  String get passwordRequirements;

  /// No description provided for @passwordConfirmValidation.
  ///
  /// In en, this message translates to:
  /// **'Password confirmation is not same'**
  String get passwordConfirmValidation;

  /// No description provided for @urlValidateMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid URL'**
  String get urlValidateMessage;

  /// No description provided for @invalidDateFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid Date Format'**
  String get invalidDateFormat;

  /// No description provided for @dateMustBeAfter.
  ///
  /// In en, this message translates to:
  /// **'Date Must Be After'**
  String get dateMustBeAfter;

  /// No description provided for @profileImageValidation.
  ///
  /// In en, this message translates to:
  /// **'Profile image is required'**
  String get profileImageValidation;

  /// No description provided for @invalidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number invalid format.'**
  String get invalidPhoneNumber;

  /// No description provided for @noResultFound.
  ///
  /// In en, this message translates to:
  /// **'No result found'**
  String get noResultFound;

  /// No description provided for @youMustAgreeTermsAndConditionsFirst.
  ///
  /// In en, this message translates to:
  /// **'You must agree to the terms and conditions first'**
  String get youMustAgreeTermsAndConditionsFirst;

  /// No description provided for @youCannotAddMoreThanTheAvailableQuantity.
  ///
  /// In en, this message translates to:
  /// **'You cannot add more than the available quantity'**
  String get youCannotAddMoreThanTheAvailableQuantity;

  /// No description provided for @invalidIdentityNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid identity number'**
  String get invalidIdentityNumber;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @bankName.
  ///
  /// In en, this message translates to:
  /// **'Bank name'**
  String get bankName;

  /// No description provided for @idImage.
  ///
  /// In en, this message translates to:
  /// **'ID Image'**
  String get idImage;

  /// No description provided for @enterBankName.
  ///
  /// In en, this message translates to:
  /// **'Enter bank name'**
  String get enterBankName;

  /// No description provided for @ibaneNumber.
  ///
  /// In en, this message translates to:
  /// **'Ibane number'**
  String get ibaneNumber;

  /// No description provided for @enterIbaneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter ibane number'**
  String get enterIbaneNumber;

  /// No description provided for @inCorrectPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password'**
  String get inCorrectPassword;

  /// No description provided for @pleaseWriteValidNumber.
  ///
  /// In en, this message translates to:
  /// **'Please write valid number'**
  String get pleaseWriteValidNumber;

  /// No description provided for @writeAMessage.
  ///
  /// In en, this message translates to:
  /// **'Write your message here...'**
  String get writeAMessage;

  /// No description provided for @failedToSendMessageTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Failed to send message, try again'**
  String get failedToSendMessageTryAgain;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copiedToClipboard;

  /// No description provided for @maxAllowedMediaCount.
  ///
  /// In en, this message translates to:
  /// **'Max allowed media count is 10'**
  String get maxAllowedMediaCount;

  /// No description provided for @searchForCountry.
  ///
  /// In en, this message translates to:
  /// **'Search for country'**
  String get searchForCountry;

  /// No description provided for @pleaseSelectProviderType.
  ///
  /// In en, this message translates to:
  /// **'Please select provider type'**
  String get pleaseSelectProviderType;

  /// No description provided for @clickToUploadImages.
  ///
  /// In en, this message translates to:
  /// **'Click to upload images'**
  String get clickToUploadImages;

  /// No description provided for @clickToUploadServiceImages.
  ///
  /// In en, this message translates to:
  /// **'Click to upload service images'**
  String get clickToUploadServiceImages;

  /// No description provided for @imageUploadConstraints.
  ///
  /// In en, this message translates to:
  /// **'The number of images must not exceed 5 images'**
  String get imageUploadConstraints;

  /// No description provided for @maps.
  ///
  /// In en, this message translates to:
  /// **'Maps'**
  String get maps;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @addressAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Address added successfully'**
  String get addressAddedSuccessfully;

  /// No description provided for @addressDetails.
  ///
  /// In en, this message translates to:
  /// **'Address details'**
  String get addressDetails;

  /// No description provided for @addAddress.
  ///
  /// In en, this message translates to:
  /// **'Add address'**
  String get addAddress;

  /// No description provided for @addAddressPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Add address'**
  String get addAddressPageTitle;

  /// No description provided for @editAddress.
  ///
  /// In en, this message translates to:
  /// **'Edit address'**
  String get editAddress;

  /// No description provided for @saveAddress.
  ///
  /// In en, this message translates to:
  /// **'Save address'**
  String get saveAddress;

  /// No description provided for @setAsDefaultAddress.
  ///
  /// In en, this message translates to:
  /// **'Set as default address'**
  String get setAsDefaultAddress;

  /// No description provided for @addressNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Home'**
  String get addressNameHint;

  /// No description provided for @addressDetailsHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 2nd floor, Apt 5, near the neighborhood mosque'**
  String get addressDetailsHint;

  /// No description provided for @defaultAddress.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultAddress;

  /// No description provided for @locationOnMap.
  ///
  /// In en, this message translates to:
  /// **'Location on map'**
  String get locationOnMap;

  /// No description provided for @district.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get district;

  /// No description provided for @searchForAddress.
  ///
  /// In en, this message translates to:
  /// **'Search for address'**
  String get searchForAddress;

  /// No description provided for @enterSearchText.
  ///
  /// In en, this message translates to:
  /// **'Enter search text'**
  String get enterSearchText;

  /// No description provided for @locationPermissionDeniedMessage.
  ///
  /// In en, this message translates to:
  /// **'Location permission denied , please enable it in your phone settings'**
  String get locationPermissionDeniedMessage;

  /// No description provided for @addressInformation.
  ///
  /// In en, this message translates to:
  /// **'Address information'**
  String get addressInformation;

  /// No description provided for @addressRemoved.
  ///
  /// In en, this message translates to:
  /// **'Address removed successfully'**
  String get addressRemoved;

  /// No description provided for @addressTitle.
  ///
  /// In en, this message translates to:
  /// **'Address title'**
  String get addressTitle;

  /// No description provided for @addressUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Address updated successfully'**
  String get addressUpdatedSuccessfully;

  /// No description provided for @addressesList.
  ///
  /// In en, this message translates to:
  /// **'Addresses list'**
  String get addressesList;

  /// No description provided for @noAddressesYet.
  ///
  /// In en, this message translates to:
  /// **'No addresses yet'**
  String get noAddressesYet;

  /// No description provided for @deleteAddressFromList.
  ///
  /// In en, this message translates to:
  /// **'Delete address from list'**
  String get deleteAddressFromList;

  /// No description provided for @areYouSureYouWantToDeleteThisAddress.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this address?'**
  String get areYouSureYouWantToDeleteThisAddress;

  /// No description provided for @failedToGetLocationDetails.
  ///
  /// In en, this message translates to:
  /// **'Failed to get location details ,please try again'**
  String get failedToGetLocationDetails;

  /// No description provided for @savedAddresses.
  ///
  /// In en, this message translates to:
  /// **'Saved addresses'**
  String get savedAddresses;

  /// No description provided for @enterAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter address'**
  String get enterAddress;

  /// No description provided for @selectDistrict.
  ///
  /// In en, this message translates to:
  /// **'Select district'**
  String get selectDistrict;

  /// No description provided for @pleaseSelectCity.
  ///
  /// In en, this message translates to:
  /// **'Please select city first'**
  String get pleaseSelectCity;

  /// No description provided for @pleaseSelectAddress.
  ///
  /// In en, this message translates to:
  /// **'Please select address'**
  String get pleaseSelectAddress;

  /// No description provided for @selectYourlocation.
  ///
  /// In en, this message translates to:
  /// **'Select your location'**
  String get selectYourlocation;

  /// No description provided for @locateYourself.
  ///
  /// In en, this message translates to:
  /// **'Locate yourself'**
  String get locateYourself;

  /// No description provided for @failedToGetCurrentLocationMessage.
  ///
  /// In en, this message translates to:
  /// **'Failed to get current location'**
  String get failedToGetCurrentLocationMessage;

  /// No description provided for @userLocationPermissionDescription.
  ///
  /// In en, this message translates to:
  /// **'You need to enable location access to access all services providers'**
  String get userLocationPermissionDescription;

  /// No description provided for @enableLocation.
  ///
  /// In en, this message translates to:
  /// **'Enable location'**
  String get enableLocation;

  /// No description provided for @pleaseSelectYourLocation.
  ///
  /// In en, this message translates to:
  /// **'Please select your location'**
  String get pleaseSelectYourLocation;

  /// No description provided for @pleaseEnableLocation.
  ///
  /// In en, this message translates to:
  /// **'Please enable location, so we can retrieve orders within your domain.'**
  String get pleaseEnableLocation;

  /// No description provided for @myAddresses.
  ///
  /// In en, this message translates to:
  /// **'My Addresses'**
  String get myAddresses;

  /// No description provided for @building.
  ///
  /// In en, this message translates to:
  /// **'Building'**
  String get building;

  /// No description provided for @pleaseEnterAddressDetails.
  ///
  /// In en, this message translates to:
  /// **'Please enter address details'**
  String get pleaseEnterAddressDetails;

  /// No description provided for @selectYourLocationOnMap.
  ///
  /// In en, this message translates to:
  /// **'Select your location on the map'**
  String get selectYourLocationOnMap;

  /// No description provided for @enterBuildingNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter building number or name'**
  String get enterBuildingNumber;

  /// No description provided for @enterDistrict.
  ///
  /// In en, this message translates to:
  /// **'Enter district'**
  String get enterDistrict;

  /// No description provided for @enterAddressLocationOnMap.
  ///
  /// In en, this message translates to:
  /// **'Enter address location on map'**
  String get enterAddressLocationOnMap;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @specifyYourLocation.
  ///
  /// In en, this message translates to:
  /// **'Specify your location'**
  String get specifyYourLocation;

  /// No description provided for @pleaseSelectLocationInsideTheCity.
  ///
  /// In en, this message translates to:
  /// **'Please select your location inside the city'**
  String get pleaseSelectLocationInsideTheCity;

  /// No description provided for @selectCityFirst.
  ///
  /// In en, this message translates to:
  /// **'Please select city first'**
  String get selectCityFirst;

  /// No description provided for @userType.
  ///
  /// In en, this message translates to:
  /// **'User Type'**
  String get userType;

  /// No description provided for @chooseUserType.
  ///
  /// In en, this message translates to:
  /// **'Choose User Type'**
  String get chooseUserType;

  /// No description provided for @selectRoleDescreption.
  ///
  /// In en, this message translates to:
  /// **'Select your account type as a provider or a provider.'**
  String get selectRoleDescreption;

  /// No description provided for @pleaseSelectRoleFirst.
  ///
  /// In en, this message translates to:
  /// **'Please select user type'**
  String get pleaseSelectRoleFirst;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @loginWelcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcom back in app'**
  String get loginWelcomeMessage;

  /// No description provided for @loginHeadline.
  ///
  /// In en, this message translates to:
  /// **'Ready to fill your cart? 🛒'**
  String get loginHeadline;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in and stay close to the finest fresh products, and everything you need delivered to your door.'**
  String get loginSubtitle;

  /// No description provided for @phoneNumberExampleHint.
  ///
  /// In en, this message translates to:
  /// **'Example: 0512345687'**
  String get phoneNumberExampleHint;

  /// No description provided for @phoneNumberHelperText.
  ///
  /// In en, this message translates to:
  /// **'Enter the 9-digit mobile number starting with 05'**
  String get phoneNumberHelperText;

  /// No description provided for @registerWelcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to'**
  String get registerWelcomeMessage;

  /// No description provided for @registerHeadline.
  ///
  /// In en, this message translates to:
  /// **'Let\'s get started! ✨'**
  String get registerHeadline;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create your account now and enjoy an easier and faster shopping experience, and discover featured products and offers.'**
  String get registerSubtitle;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @phoneNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get phoneNumberHint;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get passwordHint;

  /// No description provided for @doYouForgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Did you forget password?'**
  String get doYouForgetPassword;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Register Now'**
  String get createAccount;

  /// No description provided for @createNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Create new account'**
  String get createNewAccount;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'Example: Mohamed Ahmed Mohamed'**
  String get nameHint;

  /// No description provided for @accountType.
  ///
  /// In en, this message translates to:
  /// **'Account type'**
  String get accountType;

  /// No description provided for @individual.
  ///
  /// In en, this message translates to:
  /// **'Individual'**
  String get individual;

  /// No description provided for @institution.
  ///
  /// In en, this message translates to:
  /// **'Institution'**
  String get institution;

  /// No description provided for @idNumber.
  ///
  /// In en, this message translates to:
  /// **'ID Number'**
  String get idNumber;

  /// No description provided for @enterIdNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your ID number'**
  String get enterIdNumber;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @agreeFor.
  ///
  /// In en, this message translates to:
  /// **'Agree to'**
  String get agreeFor;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditions;

  /// No description provided for @otpHeadline.
  ///
  /// In en, this message translates to:
  /// **'We\'ve confirmed it\'s you! 🔐'**
  String get otpHeadline;

  /// No description provided for @otpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code sent to your mobile and we\'ll complete your login easily.'**
  String get otpSubtitle;

  /// No description provided for @otpHeaderMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter the activation code sent to the number'**
  String get otpHeaderMessage;

  /// No description provided for @yourPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Your phone number'**
  String get yourPhoneNumber;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resendCode;

  /// No description provided for @resendCodeMessage.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code?'**
  String get resendCodeMessage;

  /// No description provided for @resendVersionCodeOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend verification code'**
  String get resendVersionCodeOtp;

  /// No description provided for @verificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get verificationCode;

  /// No description provided for @enterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter verification code'**
  String get enterVerificationCode;

  /// No description provided for @otpSentSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'OTP sent successfully'**
  String get otpSentSuccessfully;

  /// No description provided for @verificationCodeLengthValidation.
  ///
  /// In en, this message translates to:
  /// **'Verification code must be 4 digits'**
  String get verificationCodeLengthValidation;

  /// No description provided for @verifyCodeSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your mobile number has been successfully verified'**
  String get verifyCodeSuccessMessage;

  /// No description provided for @phoneUpdateSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your phone number has been successfully updated'**
  String get phoneUpdateSuccessMessage;

  /// No description provided for @recoverYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Recover your password'**
  String get recoverYourPassword;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enterPassword;

  /// No description provided for @newWord.
  ///
  /// In en, this message translates to:
  /// **'new'**
  String get newWord;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @sendVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Send verification code'**
  String get sendVerificationCode;

  /// No description provided for @enterYourPhoneNumberToSend.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number to send'**
  String get enterYourPhoneNumberToSend;

  /// No description provided for @passwordResetSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your password has been successfully reset'**
  String get passwordResetSuccessMessage;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @yesLogOut.
  ///
  /// In en, this message translates to:
  /// **'Yes, log out'**
  String get yesLogOut;

  /// No description provided for @noGoBack.
  ///
  /// In en, this message translates to:
  /// **'No, go back'**
  String get noGoBack;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @yesDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Yes, delete account'**
  String get yesDeleteAccount;

  /// No description provided for @logoutMessage.
  ///
  /// In en, this message translates to:
  /// **'You will be logged out of your account, and you can log back in at any time.'**
  String get logoutMessage;

  /// No description provided for @deleteAccountMessage.
  ///
  /// In en, this message translates to:
  /// **'Your account and data will be deleted permanently, and you will not be able to recover them after completing the process.'**
  String get deleteAccountMessage;

  /// No description provided for @deleteAccountSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your account has been successfully deleted'**
  String get deleteAccountSuccessMessage;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress;

  /// No description provided for @enterEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter email address'**
  String get enterEmailAddress;

  /// No description provided for @emailExampleHint.
  ///
  /// In en, this message translates to:
  /// **'Example: mohamed@example.com'**
  String get emailExampleHint;

  /// No description provided for @enterYourPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your##phone number'**
  String get enterYourPhoneNumber;

  /// No description provided for @verifyCode.
  ///
  /// In en, this message translates to:
  /// **'Verify code'**
  String get verifyCode;

  /// No description provided for @continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Skip and continue as guest'**
  String get continueAsGuest;

  /// No description provided for @commercialRegistrationNumber.
  ///
  /// In en, this message translates to:
  /// **'Commercial Registration Number'**
  String get commercialRegistrationNumber;

  /// No description provided for @enterCommercialRegistrationNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your commercial registration number'**
  String get enterCommercialRegistrationNumber;

  /// No description provided for @operatingLicenseImage.
  ///
  /// In en, this message translates to:
  /// **'Operating license image'**
  String get operatingLicenseImage;

  /// No description provided for @uploadOperatingLicenseImage.
  ///
  /// In en, this message translates to:
  /// **'Upload operating license image'**
  String get uploadOperatingLicenseImage;

  /// No description provided for @commercialRegisterImage.
  ///
  /// In en, this message translates to:
  /// **'Commercial register image'**
  String get commercialRegisterImage;

  /// No description provided for @uploadCommercialRegisterImage.
  ///
  /// In en, this message translates to:
  /// **'Upload commercial register image'**
  String get uploadCommercialRegisterImage;

  /// No description provided for @operatingLicenseNumber.
  ///
  /// In en, this message translates to:
  /// **'Operating license number'**
  String get operatingLicenseNumber;

  /// No description provided for @enterOperatingLicenseNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter operating license number'**
  String get enterOperatingLicenseNumber;

  /// No description provided for @ibanNumber.
  ///
  /// In en, this message translates to:
  /// **'IBAN number'**
  String get ibanNumber;

  /// No description provided for @enterIbanNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter IBAN number'**
  String get enterIbanNumber;

  /// No description provided for @ibanCertificateImage.
  ///
  /// In en, this message translates to:
  /// **'IBAN certificate image'**
  String get ibanCertificateImage;

  /// No description provided for @uploadIbanCertificateImage.
  ///
  /// In en, this message translates to:
  /// **'Upload IBAN certificate image'**
  String get uploadIbanCertificateImage;

  /// No description provided for @enterProviderName.
  ///
  /// In en, this message translates to:
  /// **'Enter your provider name'**
  String get enterProviderName;

  /// No description provided for @deleteAccountWarrningMessage.
  ///
  /// In en, this message translates to:
  /// **'In case of deleting the account, the data will be permanently deleted from the application.'**
  String get deleteAccountWarrningMessage;

  /// No description provided for @sendContactUsMessageSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your message has been successfully sent'**
  String get sendContactUsMessageSuccess;

  /// No description provided for @contactHeader.
  ///
  /// In en, this message translates to:
  /// **'You can contact the management of##Tharaa##through:'**
  String get contactHeader;

  /// No description provided for @sendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send message'**
  String get sendMessage;

  /// No description provided for @sendTheMessage.
  ///
  /// In en, this message translates to:
  /// **'Send the message'**
  String get sendTheMessage;

  /// No description provided for @contactInformation.
  ///
  /// In en, this message translates to:
  /// **'Contact information'**
  String get contactInformation;

  /// No description provided for @contactNumbers.
  ///
  /// In en, this message translates to:
  /// **'Contact numbers'**
  String get contactNumbers;

  /// No description provided for @contactNumber.
  ///
  /// In en, this message translates to:
  /// **'Contact number'**
  String get contactNumber;

  /// No description provided for @callNow.
  ///
  /// In en, this message translates to:
  /// **'Call now'**
  String get callNow;

  /// No description provided for @emailNow.
  ///
  /// In en, this message translates to:
  /// **'Email now'**
  String get emailNow;

  /// No description provided for @writeYourMessage.
  ///
  /// In en, this message translates to:
  /// **'Write your message'**
  String get writeYourMessage;

  /// No description provided for @socialX.
  ///
  /// In en, this message translates to:
  /// **'X'**
  String get socialX;

  /// No description provided for @socialInstagram.
  ///
  /// In en, this message translates to:
  /// **'Instagram'**
  String get socialInstagram;

  /// No description provided for @socialFacebook.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get socialFacebook;

  /// No description provided for @socialWhatsApp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get socialWhatsApp;

  /// No description provided for @socialTikTok.
  ///
  /// In en, this message translates to:
  /// **'TikTok'**
  String get socialTikTok;

  /// No description provided for @socialSnapchat.
  ///
  /// In en, this message translates to:
  /// **'Snapchat'**
  String get socialSnapchat;

  /// No description provided for @socialYoutube.
  ///
  /// In en, this message translates to:
  /// **'YouTube'**
  String get socialYoutube;

  /// No description provided for @socialGooglePlay.
  ///
  /// In en, this message translates to:
  /// **'Google Play'**
  String get socialGooglePlay;

  /// No description provided for @socialAppStore.
  ///
  /// In en, this message translates to:
  /// **'App Store'**
  String get socialAppStore;

  /// No description provided for @messageType.
  ///
  /// In en, this message translates to:
  /// **'Message type'**
  String get messageType;

  /// No description provided for @selectMessageType.
  ///
  /// In en, this message translates to:
  /// **'Select message type'**
  String get selectMessageType;

  /// No description provided for @messageText.
  ///
  /// In en, this message translates to:
  /// **'Message text'**
  String get messageText;

  /// No description provided for @writeHere.
  ///
  /// In en, this message translates to:
  /// **'Write here...'**
  String get writeHere;

  /// No description provided for @contactData.
  ///
  /// In en, this message translates to:
  /// **'Contact data'**
  String get contactData;

  /// No description provided for @contactWays.
  ///
  /// In en, this message translates to:
  /// **'Contact ways'**
  String get contactWays;

  /// No description provided for @request.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get request;

  /// No description provided for @suggestion.
  ///
  /// In en, this message translates to:
  /// **'Suggestion'**
  String get suggestion;

  /// No description provided for @inquery.
  ///
  /// In en, this message translates to:
  /// **'Inquery'**
  String get inquery;

  /// No description provided for @complaint.
  ///
  /// In en, this message translates to:
  /// **'Complaint'**
  String get complaint;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @shareApp.
  ///
  /// In en, this message translates to:
  /// **'Share app'**
  String get shareApp;

  /// No description provided for @myAdds.
  ///
  /// In en, this message translates to:
  /// **'My Ads'**
  String get myAdds;

  /// No description provided for @packagesAndSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'Packages and Subscriptions'**
  String get packagesAndSubscriptions;

  /// No description provided for @staticPages.
  ///
  /// In en, this message translates to:
  /// **'Static Pages'**
  String get staticPages;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @ratingsAndComments.
  ///
  /// In en, this message translates to:
  /// **'Ratings and Comments'**
  String get ratingsAndComments;

  /// No description provided for @addRate.
  ///
  /// In en, this message translates to:
  /// **'Add rating'**
  String get addRate;

  /// No description provided for @chooseRate.
  ///
  /// In en, this message translates to:
  /// **'Choose your rating'**
  String get chooseRate;

  /// No description provided for @yourComment.
  ///
  /// In en, this message translates to:
  /// **'Your comment'**
  String get yourComment;

  /// No description provided for @successfullyRated.
  ///
  /// In en, this message translates to:
  /// **'Successfully rated'**
  String get successfullyRated;

  /// No description provided for @rateYourExperience.
  ///
  /// In en, this message translates to:
  /// **'Rate your experience'**
  String get rateYourExperience;

  /// No description provided for @addYourComment.
  ///
  /// In en, this message translates to:
  /// **'Add your comment'**
  String get addYourComment;

  /// No description provided for @writeYourComment.
  ///
  /// In en, this message translates to:
  /// **'Write your comment'**
  String get writeYourComment;

  /// No description provided for @sendRating.
  ///
  /// In en, this message translates to:
  /// **'Send rating'**
  String get sendRating;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @mangeNotifications.
  ///
  /// In en, this message translates to:
  /// **'Manage Notifications'**
  String get mangeNotifications;

  /// No description provided for @manageLanguage.
  ///
  /// In en, this message translates to:
  /// **'Manage Language'**
  String get manageLanguage;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'User name'**
  String get userName;

  /// No description provided for @personalProfile.
  ///
  /// In en, this message translates to:
  /// **'Personal profile'**
  String get personalProfile;

  /// No description provided for @personalProfileUpdateSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your personal profile has been successfully updated'**
  String get personalProfileUpdateSuccessMessage;

  /// No description provided for @changePhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Change phone number'**
  String get changePhoneNumber;

  /// No description provided for @newPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'New phone number'**
  String get newPhoneNumber;

  /// No description provided for @myAddress.
  ///
  /// In en, this message translates to:
  /// **'My address'**
  String get myAddress;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @supportAndInfo.
  ///
  /// In en, this message translates to:
  /// **'Support and information'**
  String get supportAndInfo;

  /// No description provided for @policies.
  ///
  /// In en, this message translates to:
  /// **'Policies'**
  String get policies;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @accountManagement.
  ///
  /// In en, this message translates to:
  /// **'Account management'**
  String get accountManagement;

  /// No description provided for @discountCoupons.
  ///
  /// In en, this message translates to:
  /// **'Discount coupons'**
  String get discountCoupons;

  /// No description provided for @couponUnused.
  ///
  /// In en, this message translates to:
  /// **'Unused'**
  String get couponUnused;

  /// No description provided for @couponUsed.
  ///
  /// In en, this message translates to:
  /// **'Used'**
  String get couponUsed;

  /// No description provided for @couponExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get couponExpired;

  /// No description provided for @couponValidFromTo.
  ///
  /// In en, this message translates to:
  /// **'Valid from {from} to {to}'**
  String couponValidFromTo(String from, String to);

  /// No description provided for @couponMinOrder.
  ///
  /// In en, this message translates to:
  /// **'Minimum order'**
  String get couponMinOrder;

  /// No description provided for @couponCopied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get couponCopied;

  /// No description provided for @discountCouponBanner.
  ///
  /// In en, this message translates to:
  /// **'Discount coupon'**
  String get discountCouponBanner;

  /// No description provided for @noCouponsFound.
  ///
  /// In en, this message translates to:
  /// **'No coupons yet'**
  String get noCouponsFound;

  /// No description provided for @noCouponsFoundSub.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any discount coupons at the moment. Coupons assigned to your account will appear here.'**
  String get noCouponsFoundSub;

  /// No description provided for @whoWeAre.
  ///
  /// In en, this message translates to:
  /// **'Who we are'**
  String get whoWeAre;

  /// No description provided for @newOrders.
  ///
  /// In en, this message translates to:
  /// **'New orders'**
  String get newOrders;

  /// No description provided for @ordersInProgress.
  ///
  /// In en, this message translates to:
  /// **'Orders in progress'**
  String get ordersInProgress;

  /// No description provided for @finishedOrders.
  ///
  /// In en, this message translates to:
  /// **'Finished orders'**
  String get finishedOrders;

  /// No description provided for @providerOnBoardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Your digital provider is your way to reach thousands of customers!'**
  String get providerOnBoardingTitle1;

  /// No description provided for @providerOnBoardingSubTitle1.
  ///
  /// In en, this message translates to:
  /// **'Register your services now and let your customers request you with the click of a button.'**
  String get providerOnBoardingSubTitle1;

  /// No description provided for @providerOnBoardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Display your services and products and let delivery providers deliver them to those who need them!'**
  String get providerOnBoardingTitle2;

  /// No description provided for @providerOnBoardingSubTitle2.
  ///
  /// In en, this message translates to:
  /// **'Easier management, clearer orders, and delivery providers ready for delivery.'**
  String get providerOnBoardingSubTitle2;

  /// No description provided for @providerOnBoardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'One app that combines selling, service, and delivery.'**
  String get providerOnBoardingTitle3;

  /// No description provided for @providerOnBoardingSubTitle3.
  ///
  /// In en, this message translates to:
  /// **'Guaranteed services at the best price, high quality, and fastest delivery.'**
  String get providerOnBoardingSubTitle3;

  /// No description provided for @userOnBoardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Food products at affordable prices for everyone'**
  String get userOnBoardingTitle1;

  /// No description provided for @userOnBoardingSubTitle1.
  ///
  /// In en, this message translates to:
  /// **'Get food products at affordable prices for everyone, every day.'**
  String get userOnBoardingSubTitle1;

  /// No description provided for @userOnBoardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'The tastiest fresh fruits in one place'**
  String get userOnBoardingTitle2;

  /// No description provided for @userOnBoardingSubTitle2.
  ///
  /// In en, this message translates to:
  /// **'Enjoy a diverse selection of fresh fruits, with high quality and an irresistible taste.'**
  String get userOnBoardingSubTitle2;

  /// No description provided for @userOnBoardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Fresh vegetables daily at affordable prices'**
  String get userOnBoardingTitle3;

  /// No description provided for @userOnBoardingSubTitle3.
  ///
  /// In en, this message translates to:
  /// **'Choose from a wide variety of fresh vegetables daily, with guaranteed quality.'**
  String get userOnBoardingSubTitle3;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @currentBalance.
  ///
  /// In en, this message translates to:
  /// **'Current balance'**
  String get currentBalance;

  /// No description provided for @transactionHistory.
  ///
  /// In en, this message translates to:
  /// **'Transaction history'**
  String get transactionHistory;

  /// No description provided for @saudiRiyal.
  ///
  /// In en, this message translates to:
  /// **'Saudi Riyal'**
  String get saudiRiyal;

  /// No description provided for @withdrawalRequest.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal request'**
  String get withdrawalRequest;

  /// No description provided for @pleaseEnterBankAccountDetails.
  ///
  /// In en, this message translates to:
  /// **'Please enter bank account details'**
  String get pleaseEnterBankAccountDetails;

  /// No description provided for @withdrawalAmount.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal amount'**
  String get withdrawalAmount;

  /// No description provided for @accountNumber.
  ///
  /// In en, this message translates to:
  /// **'Account number'**
  String get accountNumber;

  /// No description provided for @enterAccountNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter account number'**
  String get enterAccountNumber;

  /// No description provided for @accountName.
  ///
  /// In en, this message translates to:
  /// **'Account name'**
  String get accountName;

  /// No description provided for @enterAccountName.
  ///
  /// In en, this message translates to:
  /// **'Enter account name'**
  String get enterAccountName;

  /// No description provided for @settlementAmount.
  ///
  /// In en, this message translates to:
  /// **'Settlement amount'**
  String get settlementAmount;

  /// No description provided for @enterSettlementAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter settlement amount'**
  String get enterSettlementAmount;

  /// No description provided for @enterAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter amount'**
  String get enterAmount;

  /// No description provided for @amountExceedsBalance.
  ///
  /// In en, this message translates to:
  /// **'Amount exceeds available balance'**
  String get amountExceedsBalance;

  /// No description provided for @bankAccountDetails.
  ///
  /// In en, this message translates to:
  /// **'Bank account details'**
  String get bankAccountDetails;

  /// No description provided for @accountWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Account withdraw'**
  String get accountWithdraw;

  /// No description provided for @areYouSureYouWantToWithdrawTheAccount.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to withdraw the account?'**
  String get areYouSureYouWantToWithdrawTheAccount;

  /// No description provided for @totalProfitServiceProvider.
  ///
  /// In en, this message translates to:
  /// **'provider Total profit'**
  String get totalProfitServiceProvider;

  /// No description provided for @hideHistory.
  ///
  /// In en, this message translates to:
  /// **'Hide history'**
  String get hideHistory;

  /// No description provided for @walletHistory.
  ///
  /// In en, this message translates to:
  /// **'Wallet history'**
  String get walletHistory;

  /// No description provided for @noWalletHistory.
  ///
  /// In en, this message translates to:
  /// **'No wallet history yet'**
  String get noWalletHistory;

  /// No description provided for @withdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get withdraw;

  /// No description provided for @withdrawSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your withdrawal request has been successfully sent to the administration.'**
  String get withdrawSuccessMessage;

  /// No description provided for @addNewOnlineLecture.
  ///
  /// In en, this message translates to:
  /// **'Add new online lecture'**
  String get addNewOnlineLecture;

  /// No description provided for @walletChargedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Wallet charged successfully!'**
  String get walletChargedSuccess;

  /// No description provided for @walletTopUp.
  ///
  /// In en, this message translates to:
  /// **'Wallet Top-Up'**
  String get walletTopUp;

  /// No description provided for @enterTopUpAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter the amount to top up'**
  String get enterTopUpAmount;

  /// No description provided for @amountValue.
  ///
  /// In en, this message translates to:
  /// **'Amount value'**
  String get amountValue;

  /// No description provided for @enterBankDetails.
  ///
  /// In en, this message translates to:
  /// **'Please enter your bank account details'**
  String get enterBankDetails;

  /// No description provided for @aviableBalance.
  ///
  /// In en, this message translates to:
  /// **'Aviable balance'**
  String get aviableBalance;

  /// No description provided for @myWallet.
  ///
  /// In en, this message translates to:
  /// **'My wallet'**
  String get myWallet;

  /// No description provided for @paymentFailMessage.
  ///
  /// In en, this message translates to:
  /// **'Payment failed, please try again'**
  String get paymentFailMessage;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @providerName.
  ///
  /// In en, this message translates to:
  /// **'Provider name'**
  String get providerName;

  /// No description provided for @todayTasks.
  ///
  /// In en, this message translates to:
  /// **'Today Tasks'**
  String get todayTasks;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @number.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get number;

  /// No description provided for @classesNumber.
  ///
  /// In en, this message translates to:
  /// **'Classes number'**
  String get classesNumber;

  /// No description provided for @packagePrice.
  ///
  /// In en, this message translates to:
  /// **'Package price'**
  String get packagePrice;

  /// No description provided for @ryal.
  ///
  /// In en, this message translates to:
  /// **'ryal'**
  String get ryal;

  /// No description provided for @priceAnnotation.
  ///
  /// In en, this message translates to:
  /// **'prices doesnt include taxes'**
  String get priceAnnotation;

  /// No description provided for @book.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get book;

  /// No description provided for @choosePackage.
  ///
  /// In en, this message translates to:
  /// **'Choose Package'**
  String get choosePackage;

  /// No description provided for @rewards.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get rewards;

  /// No description provided for @cashback.
  ///
  /// In en, this message translates to:
  /// **'Cashback'**
  String get cashback;

  /// No description provided for @confirmPayment.
  ///
  /// In en, this message translates to:
  /// **'Confirm Payment'**
  String get confirmPayment;

  /// No description provided for @onlinePayment.
  ///
  /// In en, this message translates to:
  /// **'Online Payment'**
  String get onlinePayment;

  /// No description provided for @pleaseSelectPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Please select payment method'**
  String get pleaseSelectPaymentMethod;

  /// No description provided for @subscripePackageSuccess.
  ///
  /// In en, this message translates to:
  /// **'Subscripe package success'**
  String get subscripePackageSuccess;

  /// No description provided for @packages.
  ///
  /// In en, this message translates to:
  /// **'Packages'**
  String get packages;

  /// No description provided for @availableCredit.
  ///
  /// In en, this message translates to:
  /// **'Available Credit'**
  String get availableCredit;

  /// No description provided for @payOrder.
  ///
  /// In en, this message translates to:
  /// **'Pay Order'**
  String get payOrder;

  /// No description provided for @deposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get deposit;

  /// No description provided for @provider.
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get provider;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrders;

  /// No description provided for @storManagement.
  ///
  /// In en, this message translates to:
  /// **'Provider Management'**
  String get storManagement;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcome;

  /// No description provided for @welomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome ! in Tharaa app'**
  String get welomeMessage;

  /// No description provided for @welomeSubMessage.
  ///
  /// In en, this message translates to:
  /// **'You can enjoy and discover app features on login'**
  String get welomeSubMessage;

  /// No description provided for @homeSearchBarHint.
  ///
  /// In en, this message translates to:
  /// **'Yellow camels, prepared for fodder...'**
  String get homeSearchBarHint;

  /// No description provided for @mainCategories.
  ///
  /// In en, this message translates to:
  /// **'Main categories'**
  String get mainCategories;

  /// No description provided for @advertisments.
  ///
  /// In en, this message translates to:
  /// **'Advertisments'**
  String get advertisments;

  /// No description provided for @providerDiscription.
  ///
  /// In en, this message translates to:
  /// **'Provider Description'**
  String get providerDiscription;

  /// No description provided for @providerDetails.
  ///
  /// In en, this message translates to:
  /// **'Provider Details'**
  String get providerDetails;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @totalNumberOfProviders.
  ///
  /// In en, this message translates to:
  /// **'Providers'**
  String get totalNumberOfProviders;

  /// No description provided for @totalNumberOfProducts.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get totalNumberOfProducts;

  /// No description provided for @totalNumberOfOngoingOrders.
  ///
  /// In en, this message translates to:
  /// **'Ongoing Orders'**
  String get totalNumberOfOngoingOrders;

  /// No description provided for @totalNumberOfCompletedOrders.
  ///
  /// In en, this message translates to:
  /// **'Completed Orders'**
  String get totalNumberOfCompletedOrders;

  /// No description provided for @totalProviderProfit.
  ///
  /// In en, this message translates to:
  /// **'Total Provider Profit'**
  String get totalProviderProfit;

  /// No description provided for @newServiceRequests.
  ///
  /// In en, this message translates to:
  /// **'New Service Requests'**
  String get newServiceRequests;

  /// No description provided for @orderDate.
  ///
  /// In en, this message translates to:
  /// **'Order Date'**
  String get orderDate;

  /// No description provided for @orderNumber.
  ///
  /// In en, this message translates to:
  /// **'Order Number'**
  String get orderNumber;

  /// No description provided for @newProductOrders.
  ///
  /// In en, this message translates to:
  /// **'New Product Orders'**
  String get newProductOrders;

  /// No description provided for @orderStatus.
  ///
  /// In en, this message translates to:
  /// **'Order Status'**
  String get orderStatus;

  /// No description provided for @totalPrice.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get totalPrice;

  /// No description provided for @noNewServiceRequests.
  ///
  /// In en, this message translates to:
  /// **'No new service requests'**
  String get noNewServiceRequests;

  /// No description provided for @noNewProductsRequests.
  ///
  /// In en, this message translates to:
  /// **'No new products requests'**
  String get noNewProductsRequests;

  /// No description provided for @noProductsFound.
  ///
  /// In en, this message translates to:
  /// **'No products found'**
  String get noProductsFound;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @requestService.
  ///
  /// In en, this message translates to:
  /// **'Request a service'**
  String get requestService;

  /// No description provided for @createService.
  ///
  /// In en, this message translates to:
  /// **'Create service request'**
  String get createService;

  /// No description provided for @mostRequestedServices.
  ///
  /// In en, this message translates to:
  /// **'Most requested services'**
  String get mostRequestedServices;

  /// No description provided for @mostRequestedProducts.
  ///
  /// In en, this message translates to:
  /// **'Most requested products'**
  String get mostRequestedProducts;

  /// No description provided for @offersList.
  ///
  /// In en, this message translates to:
  /// **'Offers list'**
  String get offersList;

  /// No description provided for @discountPercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}% off'**
  String discountPercent(int percent);

  /// No description provided for @viewMore.
  ///
  /// In en, this message translates to:
  /// **'View more'**
  String get viewMore;

  /// No description provided for @topRatedProviders.
  ///
  /// In en, this message translates to:
  /// **'Top-rated providers'**
  String get topRatedProviders;

  /// No description provided for @pleaseSelectServiceFirstToViewAvailableProviders.
  ///
  /// In en, this message translates to:
  /// **'Please select a service first, to view available providers'**
  String get pleaseSelectServiceFirstToViewAvailableProviders;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'welcome to Tharaa'**
  String get welcomeMessage;

  /// No description provided for @welcomeSubMessage.
  ///
  /// In en, this message translates to:
  /// **'You can enjoy and discover app features on login'**
  String get welcomeSubMessage;

  /// No description provided for @homeAppBarSlogan.
  ///
  /// In en, this message translates to:
  /// **'Fresh, delicious, and delivered to your door! 🍎'**
  String get homeAppBarSlogan;

  /// No description provided for @highestRated.
  ///
  /// In en, this message translates to:
  /// **'Highest Rated'**
  String get highestRated;

  /// No description provided for @selectProviderStatus.
  ///
  /// In en, this message translates to:
  /// **'Select Provider Status'**
  String get selectProviderStatus;

  /// No description provided for @providerStatus.
  ///
  /// In en, this message translates to:
  /// **'Provider Status'**
  String get providerStatus;

  /// No description provided for @filterProviders.
  ///
  /// In en, this message translates to:
  /// **'Filter Providers'**
  String get filterProviders;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @cartIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Cart is empty'**
  String get cartIsEmpty;

  /// No description provided for @successfullyAddedToCart.
  ///
  /// In en, this message translates to:
  /// **'Successfully added to cart'**
  String get successfullyAddedToCart;

  /// No description provided for @cartIsEmptySubMessage.
  ///
  /// In en, this message translates to:
  /// **'Please add some items to the cart'**
  String get cartIsEmptySubMessage;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get addToCart;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get items;

  /// No description provided for @item.
  ///
  /// In en, this message translates to:
  /// **'Item'**
  String get item;

  /// No description provided for @noItemsInCartCurrently.
  ///
  /// In en, this message translates to:
  /// **'No items in cart currently'**
  String get noItemsInCartCurrently;

  /// No description provided for @pleaseComeBackLater.
  ///
  /// In en, this message translates to:
  /// **'Please come back later'**
  String get pleaseComeBackLater;

  /// No description provided for @itemsCount.
  ///
  /// In en, this message translates to:
  /// **'Items Count'**
  String get itemsCount;

  /// No description provided for @productsFrom.
  ///
  /// In en, this message translates to:
  /// **'Products from'**
  String get productsFrom;

  /// No description provided for @totalIncludingTax.
  ///
  /// In en, this message translates to:
  /// **'Total (Price including tax)'**
  String get totalIncludingTax;

  /// No description provided for @productsPrice.
  ///
  /// In en, this message translates to:
  /// **'Products Price'**
  String get productsPrice;

  /// No description provided for @deliveryPrice.
  ///
  /// In en, this message translates to:
  /// **'Delivery Price'**
  String get deliveryPrice;

  /// No description provided for @totalOrderPriceIncludingTax.
  ///
  /// In en, this message translates to:
  /// **'Total Order Price (Price including tax)'**
  String get totalOrderPriceIncludingTax;

  /// No description provided for @totalOrderPrice.
  ///
  /// In en, this message translates to:
  /// **'Total Order Price'**
  String get totalOrderPrice;

  /// No description provided for @priceIncludingTax.
  ///
  /// In en, this message translates to:
  /// **'Price including tax'**
  String get priceIncludingTax;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @vatAmount.
  ///
  /// In en, this message translates to:
  /// **'VAT Amount'**
  String get vatAmount;

  /// No description provided for @completeOrder.
  ///
  /// In en, this message translates to:
  /// **'Complete Order'**
  String get completeOrder;

  /// No description provided for @addProducts.
  ///
  /// In en, this message translates to:
  /// **'Add products'**
  String get addProducts;

  /// No description provided for @emptyCartTitle.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty 🛒'**
  String get emptyCartTitle;

  /// No description provided for @emptyCartSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t chosen what you like yet! Browse our products, add everything you need to your cart, and start shopping.'**
  String get emptyCartSubtitle;

  /// No description provided for @paymentSummary.
  ///
  /// In en, this message translates to:
  /// **'Payment summary'**
  String get paymentSummary;

  /// No description provided for @cartTotal.
  ///
  /// In en, this message translates to:
  /// **'Cart total'**
  String get cartTotal;

  /// No description provided for @savings.
  ///
  /// In en, this message translates to:
  /// **'Savings'**
  String get savings;

  /// No description provided for @grandTotal.
  ///
  /// In en, this message translates to:
  /// **'Grand total'**
  String get grandTotal;

  /// No description provided for @productNoLongerAvailable.
  ///
  /// In en, this message translates to:
  /// **'Sorry, this product is no longer available and cannot be purchased'**
  String get productNoLongerAvailable;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @paymentDetails.
  ///
  /// In en, this message translates to:
  /// **'Payment Details'**
  String get paymentDetails;

  /// No description provided for @applePay.
  ///
  /// In en, this message translates to:
  /// **'Apple Pay'**
  String get applePay;

  /// No description provided for @electronicPayment.
  ///
  /// In en, this message translates to:
  /// **'Electronic payment'**
  String get electronicPayment;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @offersOnly.
  ///
  /// In en, this message translates to:
  /// **'Offers only'**
  String get offersOnly;

  /// No description provided for @sort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// No description provided for @mostRequested.
  ///
  /// In en, this message translates to:
  /// **'Most requested'**
  String get mostRequested;

  /// No description provided for @priceHighToLow.
  ///
  /// In en, this message translates to:
  /// **'Price: high to low'**
  String get priceHighToLow;

  /// No description provided for @priceLowToHigh.
  ///
  /// In en, this message translates to:
  /// **'Price: low to high'**
  String get priceLowToHigh;

  /// No description provided for @fromHighToLow.
  ///
  /// In en, this message translates to:
  /// **'High to low'**
  String get fromHighToLow;

  /// No description provided for @fromLowToHigh.
  ///
  /// In en, this message translates to:
  /// **'Low to high'**
  String get fromLowToHigh;

  /// No description provided for @offersTitle.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get offersTitle;

  /// No description provided for @mostRequestedTitle.
  ///
  /// In en, this message translates to:
  /// **'Most requested'**
  String get mostRequestedTitle;

  /// No description provided for @searchProductByName.
  ///
  /// In en, this message translates to:
  /// **'Search by product name'**
  String get searchProductByName;

  /// No description provided for @searchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchTitle;

  /// No description provided for @whatAreYouLookingFor.
  ///
  /// In en, this message translates to:
  /// **'What are you looking for? 🔍'**
  String get whatAreYouLookingFor;

  /// No description provided for @searchIdleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Search for your favorite products and discover a variety that suits your needs.'**
  String get searchIdleSubtitle;

  /// No description provided for @noSearchResults.
  ///
  /// In en, this message translates to:
  /// **'No results found 🔍'**
  String get noSearchResults;

  /// No description provided for @noSearchResultsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Try searching with another word or make sure the product name is spelled correctly.'**
  String get noSearchResultsSubtitle;

  /// No description provided for @searchResults.
  ///
  /// In en, this message translates to:
  /// **'Search results'**
  String get searchResults;

  /// No description provided for @productDetails.
  ///
  /// In en, this message translates to:
  /// **'Product details'**
  String get productDetails;

  /// No description provided for @offerEndsIn.
  ///
  /// In en, this message translates to:
  /// **'Offer ends in:'**
  String get offerEndsIn;

  /// No description provided for @productPrice.
  ///
  /// In en, this message translates to:
  /// **'Product price'**
  String get productPrice;

  /// No description provided for @noProductsInThisSection.
  ///
  /// In en, this message translates to:
  /// **'No products in this section 🥕'**
  String get noProductsInThisSection;

  /// No description provided for @noProductsInThisSubsection.
  ///
  /// In en, this message translates to:
  /// **'There are currently no products in this subsection. Try choosing another section.'**
  String get noProductsInThisSubsection;

  /// No description provided for @searchByOrderNumber.
  ///
  /// In en, this message translates to:
  /// **'Search by order number'**
  String get searchByOrderNumber;

  /// No description provided for @orderCreationDate.
  ///
  /// In en, this message translates to:
  /// **'Created: {date}'**
  String orderCreationDate(String date);

  /// No description provided for @orderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order details'**
  String get orderDetails;

  /// No description provided for @orderStatusNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get orderStatusNew;

  /// No description provided for @orderStatusInPreparation.
  ///
  /// In en, this message translates to:
  /// **'In preparation'**
  String get orderStatusInPreparation;

  /// No description provided for @orderStatusReadyForDelivery.
  ///
  /// In en, this message translates to:
  /// **'Ready for delivery'**
  String get orderStatusReadyForDelivery;

  /// No description provided for @orderStatusOnTheWay.
  ///
  /// In en, this message translates to:
  /// **'On the way'**
  String get orderStatusOnTheWay;

  /// No description provided for @orderStatusDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get orderStatusDelivered;

  /// No description provided for @orderStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get orderStatusCancelled;

  /// No description provided for @noOrdersFound.
  ///
  /// In en, this message translates to:
  /// **'No orders found'**
  String get noOrdersFound;

  /// No description provided for @noOrdersFoundSub.
  ///
  /// In en, this message translates to:
  /// **'There are currently no orders. Try changing the filter or searching by another order number.'**
  String get noOrdersFoundSub;

  /// No description provided for @deliveryAddress.
  ///
  /// In en, this message translates to:
  /// **'Delivery address'**
  String get deliveryAddress;

  /// No description provided for @orderedProducts.
  ///
  /// In en, this message translates to:
  /// **'Ordered products'**
  String get orderedProducts;

  /// No description provided for @priceDetails.
  ///
  /// In en, this message translates to:
  /// **'Price details'**
  String get priceDetails;

  /// No description provided for @productsPriceExcludingTax.
  ///
  /// In en, this message translates to:
  /// **'Products total excluding tax'**
  String get productsPriceExcludingTax;

  /// No description provided for @cancelOrder.
  ///
  /// In en, this message translates to:
  /// **'Cancel order'**
  String get cancelOrder;

  /// No description provided for @trackOrder.
  ///
  /// In en, this message translates to:
  /// **'Track order'**
  String get trackOrder;

  /// No description provided for @reorder.
  ///
  /// In en, this message translates to:
  /// **'Reorder'**
  String get reorder;

  /// No description provided for @cancellationReason.
  ///
  /// In en, this message translates to:
  /// **'Cancellation reason'**
  String get cancellationReason;

  /// No description provided for @taxInvoice.
  ///
  /// In en, this message translates to:
  /// **'Tax invoice'**
  String get taxInvoice;

  /// No description provided for @rateOrder.
  ///
  /// In en, this message translates to:
  /// **'Rate order'**
  String get rateOrder;

  /// No description provided for @quantityCount.
  ///
  /// In en, this message translates to:
  /// **'Quantity: {count}'**
  String quantityCount(int count);

  /// No description provided for @deliveryMethod.
  ///
  /// In en, this message translates to:
  /// **'Delivery method'**
  String get deliveryMethod;

  /// No description provided for @homeDelivery.
  ///
  /// In en, this message translates to:
  /// **'Home delivery'**
  String get homeDelivery;

  /// No description provided for @storePickup.
  ///
  /// In en, this message translates to:
  /// **'Store pickup'**
  String get storePickup;

  /// No description provided for @addNewAddress.
  ///
  /// In en, this message translates to:
  /// **'Add new address'**
  String get addNewAddress;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// No description provided for @electronicShort.
  ///
  /// In en, this message translates to:
  /// **'Electronic'**
  String get electronicShort;

  /// No description provided for @discountCoupon.
  ///
  /// In en, this message translates to:
  /// **'Discount coupon'**
  String get discountCoupon;

  /// No description provided for @enterDiscountCoupon.
  ///
  /// In en, this message translates to:
  /// **'Enter discount coupon'**
  String get enterDiscountCoupon;

  /// No description provided for @invoiceDetails.
  ///
  /// In en, this message translates to:
  /// **'Invoice details'**
  String get invoiceDetails;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @placeOrder.
  ///
  /// In en, this message translates to:
  /// **'Place order'**
  String get placeOrder;

  /// No description provided for @selectDeliveryAddress.
  ///
  /// In en, this message translates to:
  /// **'Please select a delivery address'**
  String get selectDeliveryAddress;

  /// No description provided for @orderPlacedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Order placed successfully'**
  String get orderPlacedSuccessfully;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
