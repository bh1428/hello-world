; INNO Setup script for hello-world
; Copyright (C) 2025 Ben Hattem (benghattem@gmail.com) - All Rights Reserved
#include "version.iss"
#define MyAppName "hello-world"
#define MyCompany "benhattem.nl"
#define MyAppExe "hello-world.exe"

[Setup]
AppId={{6EAAFAD8-23AD-47DD-BE23-E74C5B75A40B}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher="{#MyCompany}"
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
DisableProgramGroupPage=true
LicenseFile="LICENSE"
OutputDir=dist
OutputBaseFilename="{#MyAppName} setup {#MyAppVersion}"
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
SetupIconFile="images\python.ico"
UninstallDisplayIcon="{app}\{#MyAppExe}"
Compression=lzma2
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: desktopicon; Description: "Create a &desktop icon"; GroupDescription: "Additional icons:";
Name: desktopicon\common; Description: "For all users"; GroupDescription: "Additional icons:"; Flags: exclusive unchecked
Name: desktopicon\user; Description: "For the current user only"; GroupDescription: "Additional icons:"; Flags: exclusive
Name: quicklaunchicon; Description: "Create a &Quick Launch icon"; GroupDescription: "Additional icons:"; Flags: unchecked

[Files]
Source: "dist\build_info.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\{#MyAppName}\{#MyAppExe}"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\{#MyAppName}\lib\*"; DestDir: "{app}\lib"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\Hello-World"; Filename: "{app}\{#MyAppExe}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\Hello-World"; Filename: "{app}\{#MyAppExe}"; Tasks: desktopicon

[InstallDelete]
Type: filesandordirs; Name: "{app}\lib"
