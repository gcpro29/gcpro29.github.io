@echo off
title Generation du CV PDF
echo.
echo === Generation du CV PDF a partir de cv.html ===
echo.

set CHROME="C:\Program Files\Google\Chrome\Application\chrome.exe"
set OUTPUT=%~dp0CV-Gauthier-Chauvet.pdf
set INPUT=file:///%~dp0cv.html

if not exist %CHROME% (
    echo [ERREUR] Chrome n'est pas trouve a l'emplacement attendu.
    echo Verifie l'installation de Chrome ou edite ce fichier .bat.
    pause
    exit /b 1
)

%CHROME% --headless --disable-gpu --no-pdf-header-footer --print-to-pdf="%OUTPUT%" "%INPUT%"

if exist "%OUTPUT%" (
    echo [OK] PDF genere : %OUTPUT%
    echo.
    echo Tu peux fermer cette fenetre.
) else (
    echo [ERREUR] La generation a echoue.
)

echo.
pause
