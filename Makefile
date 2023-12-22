DATE_NOW:=`date +%Y%m%d.%H%M`
VERSION:=`cider version`
APP_NAME:=Hora
PATH_IPA:=`PWD`/build/ios/ipa/Hora.ipa
PATH_APK:=`PWD`/build/app/outputs/flutter-apk
PATH_APK_GOOGLE:=$(GOOGLE_DRIVE2)/Hora/APK

ifeq ($(OS),Windows_NT)
	PATH_APP_BUNDLE:=.\build\app\outputs\bundle
else
	PATH_APP_BUNDLE:=`PWD`/build/app/outputs/bundle
endif
ifeq ($(OS),Windows_NT)
	SPLIT_DEBUG_INFO:=.\build\split-debug-info-logs
else
	SPLIT_DEBUG_INFO:=`PWD`/build/split-debug-info-logs
endif

generate:
	flutter pub run build_runner build --delete-conflicting-outputs
apk:
	flutter build apk \
		--split-debug-info=$(SPLIT_DEBUG_INFO) \
		--split-per-abi \
		--target-platform=android-arm \
		--release \
		-v
apk-open: apk
ifeq ($(OS),Windows_NT)
	.\upload-apk-to-google-drive.bat
else
	mv $(PATH_APK)/app-armeabi-v7a-release.apk $(PATH_APK_GOOGLE)/$(APP_NAME)-v$(VERSION)-$(DATE_NOW).apk
	open $(PATH_APK_GOOGLE)/
endif
app-bundle:
	flutter build appbundle \
		--release \
		-v
ifeq ($(OS),Windows_NT)
	.\upload-aab-to-google-drive.bat
else
	mv $(PATH_APP_BUNDLE)/release/app-release.aab $(PATH_APK_GOOGLE)/$(APP_NAME)-v$(VERSION).aab
	open $(PATH_APK_GOOGLE)/
endif
ipa:
	flutter build ipa \
		--release \
		-v
	open build/ios/ipa
ipa-validation:
	xcrun altool --validate-app \
		--file $(PATH_IPA) \
		--type ios \
		--username "$(APP_STORE_USERNAME)" \
		--password "$(APP_STORE_PASSWORD)"
ipa-publish:
	xcrun altool --upload-app \
		--file $(PATH_IPA) \
		--type ios \
		--username "$(APP_STORE_USERNAME)" \
		--password "$(APP_STORE_PASSWORD)"
ipa-validation: ipa ipa-validation
ipa-publish: ipa ipa-publish