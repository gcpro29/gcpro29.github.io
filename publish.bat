@echo off
title Publication du portfolio + CV
echo.
echo === Etape 1/3 : Regeneration du CV PDF ===
echo.

set CHROME="C:\Program Files\Google\Chrome\Application\chrome.exe"
set OUTPUT=%~dp0CV-Gauthier-Chauvet.pdf
set INPUT=file:///%~dp0cv.html

if not exist %CHROME% (
    echo [ERREUR] Chrome n'est pas trouve. Edite ce .bat si Chrome est ailleurs.
    pause
    exit /b 1
)

%CHROME% --headless --disable-gpu --no-pdf-header-footer --print-to-pdf="%OUTPUT%" "%INPUT%"

if not exist "%OUTPUT%" (
    echo [ERREUR] La generation PDF a echoue.
    pause
    exit /b 1
)

echo [OK] PDF regenere.
echo.
echo === Etape 2/3 : Verification des changements ===
echo.

cd /d "%~dp0"

git status --short
echo.

REM Verifier s'il y a des changements a publier
git diff --quiet HEAD -- 2>nul
if errorlevel 1 goto HAS_CHANGES
git diff --cached --quiet 2>nul
if errorlevel 1 goto HAS_CHANGES

echo [INFO] Rien a publier. Le site en ligne est deja a jour.
echo.
pause
exit /b 0

:HAS_CHANGES
echo === Etape 3/3 : Publication ===
echo.
set /p MSG=Decris en une phrase ce que tu as change (puis Entree) :

if "%MSG%"=="" set MSG=Mise a jour du portfolio

echo.
echo Publication en cours...
git add .
git commit -m "%MSG%"
if errorlevel 1 (
    echo [ERREUR] Echec du commit.
    pause
    exit /b 1
)

git push
if errorlevel 1 (
    echo [ERREUR] Echec du push. Verifie ta connexion ou ton authentification GitHub.
    pause
    exit /b 1
)

echo.
echo ================================================
echo  [OK] Tout est en ligne sur https://gcpro29.github.io/
echo  Le site sera mis a jour dans 1-2 minutes.
echo ================================================
echo.
pause
