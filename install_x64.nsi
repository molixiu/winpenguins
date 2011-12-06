; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME       "WinPenguins"
!define VERSION_MAJOR      "0"
!define VERSION_MINOR      "6"
!define VERSION            "${VERSION_MAJOR}.${VERSION_MINOR}"
!define VERSION_FULL       "${VERSION_MAJOR}.${VERSION_MINOR}.0.0"
!define PRODUCT_WEB_SITE   "http://WinPenguins.sourceforge.net"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}64"
!define PUBLISHER          "Michael Vines"

!include "MUI2.nsh"

; MUI Settings
!define MUI_ABORTWARNING
SetCompressor /SOLID lzma

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page
!insertmacro MUI_PAGE_LICENSE "README.txt"
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\WinPenguins.exe"
;!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\README.txt"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; MUI end ------

;--------------------------------
;Installer's VersionInfo

VIProductVersion                   "${VERSION_FULL}"
VIAddVersionKey "CompanyName"      "${PUBLISHER}"
VIAddVersionKey "ProductName"      "${PRODUCT_NAME}"
VIAddVersionKey "ProductVersion"   "${VERSION}"
VIAddVersionKey "FileDescription"  "${PRODUCT_NAME}"
VIAddVersionKey "FileVersion"      "${VERSION}"
VIAddVersionKey "LegalCopyright"   "${PUBLISHER}"
VIAddVersionKey "OriginalFilename" "${PRODUCT_NAME}_${VERSION}_setup.exe"

Name "${PRODUCT_NAME} ${VERSION}"
OutFile "${PRODUCT_NAME}_${VERSION}_x64_setup.exe"
InstallDir "$PROGRAMFILES64\WinPenguins"
ShowInstDetails show
ShowUnInstDetails show

RequestExecutionLevel admin

Section "MainSection" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite on
  File "Release\x64\WinPenguins.exe"
  File "Winmon\Release\x64\Winmon.dll"
  File "CHANGES.txt"
  File "COPYING.txt"
  File "README.txt"
  File "res\boom.wav"
  File "res\quack.wav"
  File "res\eep.wav"
SectionEnd

Section -AdditionalIcons
  CreateDirectory "$SMPROGRAMS\WinPenguins"
  CreateShortCut "$SMPROGRAMS\WinPenguins\WinPenguins.lnk" "$INSTDIR\WinPenguins.exe"
  CreateShortCut "$SMPROGRAMS\WinPenguins\README.lnk" "$INSTDIR\README.txt"
  CreateShortCut "$SMPROGRAMS\WinPenguins\COPYING.lnk" "$INSTDIR\COPYING.txt"
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\WinPenguins\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\WinPenguins\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "DisplayName"      "${PRODUCT_NAME} ${VERSION} (64bit)"
  WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "UninstallString"  "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "DisplayIcon"      "$INSTDIR\WinPenguins.exe"
  WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "DisplayVersion"   "${VERSION}"
  WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "URLInfoAbout"     "${PRODUCT_WEB_SITE}"
  WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "URLUpdateInfo"    "${PRODUCT_WEB_SITE}"
  WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "HelpLink"         "${PRODUCT_WEB_SITE}"
  WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "Publisher"        "${PUBLISHER}"
  WriteRegStr HKLM "${PRODUCT_UNINST_KEY}" "InstallLocation"  "$INSTDIR"
  WriteRegDWORD HKLM "${PRODUCT_UNINST_KEY}" "VersionMajor"   "${VERSION_MAJOR}"
  WriteRegDWORD HKLM "${PRODUCT_UNINST_KEY}" "VersionMinor"   "${VERSION_MINOR}"
  WriteRegDWORD HKLM "${PRODUCT_UNINST_KEY}" "NoModify"       "1"
  WriteRegDWORD HKLM "${PRODUCT_UNINST_KEY}" "NoRepair"       "1"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\Source.zip"
  Delete "$INSTDIR\eep.wav"
  Delete "$INSTDIR\quack.wav"
  Delete "$INSTDIR\boom.wav"
  Delete "$INSTDIR\README.txt"
  Delete "$INSTDIR\CHANGES.txt"
  Delete "$INSTDIR\COPYING.txt"
  Delete "$INSTDIR\Winmon.dll"
  Delete "$INSTDIR\WinPenguins.exe"

  Delete "$SMPROGRAMS\WinPenguins\Uninstall.lnk"
  Delete "$SMPROGRAMS\WinPenguins\Website.lnk"
  Delete "$DESKTOP\WinPenguins.lnk"
  Delete "$SMPROGRAMS\WinPenguins\WinPenguins.lnk"
  Delete "$SMPROGRAMS\WinPenguins\README.lnk"
  Delete "$SMPROGRAMS\WinPenguins\COPYING.lnk"

  RMDir "$SMPROGRAMS\WinPenguins"
  RMDir "$INSTDIR"

  DeleteRegKey HKLM "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKCU "SOFTWARE\${PRODUCT_NAME}"
  DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\WinPenguins.exe"
  SetAutoClose true
SectionEnd