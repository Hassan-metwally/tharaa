#######################################################
#######           Build Runner Command          #######
#######################################################
 
 # flutter pub run build_runner build --delete-conflicting-outputs

 # flutter clean cache; flutter clean; flutter pub get       


#######################################################
#######             Build Flavors               #######
#######################################################

### Video [Marcus]                       : https://www.youtube.com/watch?v=Vhm1Cv2uPko
### Offical documentation                : https://docs.flutter.dev/deployment/flavors
## Add various mainifist for each flavor : https://developer.android.com/build/manage-manifests#merge_rule_markers

#######################################################
#######                App Info                 #######
#######################################################

## App Bundles :
                        ## IOS ##                 |          ## Android ##
                ------------------------------------------------------------------
                    com.moltaqa.tharaa           |        com.moltaqa.tharaa


## BUILD APK && IPA: 
 - For IOS :
    flutter build ipa

 - For Android :
    flutter build apk --release

 - For Android [Build App Bundle] :
    flutter build appbundle


#######################################################
#######              SHA1 & SHA256              #######
#######################################################

- open android folder in terminal
- write command [./gradlew signingReport]   Mac/Linux
- write command [.\gradlew signingReport]     Windows

- for release 
  write command [./gradlew app:signingReport --console=plain]
   


#######################################################
#######             Flutter Fire                #######
#######################################################

## Flutter Fire Config Path [export PATH="$PATH":"$HOME/.pub-cache/bin"]
## Flutter Fire Apps Configs:
    firebase login
    dart pub global activate flutterfire_cli
    export PATH="$PATH":"$HOME/.pub-cache/bin"
    flutterfire config --project=azhamani-d5ed8

## Flutter Fire Flavour Apps Configs:
    flutterfire config \
    --project=azhamani-d5ed8 \
    --out=lib/src/_client_app/client_firebase_options.dart \
    --android-package-name=com.moltaqa.tharaa.client \
    --ios-bundle-id=com.moltaqa.tharaa.client

    flutterfire config \
    --project=azhamani-d5ed8 \
    --out=lib/src/_provider_app/provider_firebase_options.dart \
    --android-package-name=com.moltaqa.tharaa.provider \
    --ios-bundle-id=com.moltaqa.tharaa.provider
    