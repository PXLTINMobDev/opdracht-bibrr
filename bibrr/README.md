## Team

Aantal studenten: 2

Student 1: Rune Indestege

Student 2: Richelle Lippens

## Titel app

bibrr

## Programmeertaal

Flutter

## Link naar filmpje

https://hogeschoolpxl-my.sharepoint.com/personal/12001536_student_pxl_be/_layouts/15/stream.aspx?id=%2Fpersonal%2F12001536_student_pxl_be%2FDocuments%2FOpnamen%2FCall%20with%20Niek%20and%201%20other-20241108_112710-Meeting%20Recording%2Emp4&referrer=StreamWebApp%2EWeb&referrerScenario=AddressBarCopied%2Eview%2E980c6903-2a21-4caa-a2be-8508544f6190&ga=1

## Github link en branch
### Link

[Github link](https://github.com/PXLTINMobDev/opdracht-bibrr)

### Branch

Branch: **main**

## Korte beschrijving

Onze app is gericht op mensen die graag lezen en informatie willen over verschillende soorten boeken.

Inloggen kan via Google of op de gebruikelijke manier. Na inloggen zijn er drie hoofdfuncties beschikbaar. Een boekenlijst is te bekijken, en met de zoekbalk kan specifieke informatie over titels worden gevonden. Wanneer een boek is geselecteerd, kan de detailpagina worden bezocht voor meer informatie over dat boek. Daarnaast is er een instellingenpagina om de gebruikersnaam en profielfoto aan te passen. Tot slot is het mogelijk om uit te loggen en de taal van de app te wijzigen naar Nederlands of Engels.

## Minimale eisen

## Schermen

## Aantal schermen

Het aantal schermen in onze app bedraagt **4**

### Lijst van schermen

* Login (BookDetailPageScreen)
* Master (Booklistpagescreen)
* Detail (LoginPageScreen)
* Settings (Settingpagescreen)

## Lokale opslag / Shared Preferences


Voor de lokale opslag, gebruikten we het flutter package shared_preferences.
Hiermee kunnen we eenvoudige gegevens opslaan en ophalen in een persistent opslag.
In de LanguageService wordt de taalvoorkeur opgeslagen.
In de Settingpagescreen wordt de gebruikersnaam en de image path opgeslagen(image wordt op device zelf opgeslagen) opgeslagen en deze worden ook gekeyed met een userid afkomstig uit FirebaseAuth.instance.

## lijst/tabel

In de applicatie is een ListView.builder geïmplementeerd om een lijst met gegevens uit de database op te halen en weer te geven.

## event handling/navigatie

**Meerdere Schermen**: Booklistpagescreen, LoginPageScreen, en Settingpagescreen, beheerd met een MaterialApp en benoemde routes voor eenvoudige navigatie.

**Navigatie** is ingesteld in MyApp met benoemde routes (bijv. /book-list, /login, /settings-page)

**Event Handlers** worden gebruikt, zoals in de IconButton op de app bar (voor navigatie naar instellingen) en in LoginPageScreen voor Google-login.

## resources
Er is een assets-map aanwezig in de applicatie, waarin JSON-bestanden zoals strings.json en animation.json (voor Lottie-animaties) zijn opgeslagen. Daarnaast bevat deze map afbeeldingen, zoals het Google-logo en het app_logo.

## asynchrone verwerking en/of threading

Door het gebruik van async en await in combinatie met de Future API van Dart/Flutter blijft de UI responsief tijdens het uitvoeren van langdurig/asynchrone taken en ook om te voorkomen dat de hoofdthread geblokkeerd wordt. Bij het inloggen en registreren van gebruikers (met Firebase Authenticatie) wordt gebruik gemaakt van asynchrone Futures om netwerkcalls naar Firebase te doen. Het opslaan en ophalen met SharedPreferences gebeurt asynchroon. Het ophalen van de boekgegevens gebeurt met een externe asynchrone API call(fetch request). FutureBuilder wordt gebruikt om de vertaalde beschrijving van een boek asynchroon op te halen en weer te geven. Bij het initialiseren van de widget, laadt initState de vertaalde beschrijving in een Future (_translatedDescription), FutureBuilder bouwt vervolgens de UI op basis van de status van deze Future.

## Extra's

### Beschrijving extra 1

**Animatie**: In de applicatie is een animatie toegevoegd met een Lottie-afbeelding, die als bewegende afbeelding op het scherm wordt weergegeven. Daarnaast verandert de achtergrondkleur telkens voor één seconde wanneer een andere gebruikersnaam of profielfoto wordt ingesteld.

### Beschrijving extra 2
**Authenticatie**: De applicatie valideert invoer tijdens het inloggen en toont een melding bij foutieve gegevens. Inloggen kan met een gebruikers-e-mailadres en wachtwoord hierbij wordt Firebase aangesproken en het daarin geconfigureerde project.

### Beschrijving extra 3
**Translate**: voor de taalfunctionaliteit maken we gebruik van json string files (strings.json, string_dutch.json) die in LanguageService wordt geladen. LanguageService wordt in de screens geladen en met getString geeft die de samenhangende variabele mee (een string string array waar eerste string (die met getString meegegeven wordt) de key is in de language json) mee geeft en correcte taal variant meegeeft, afhankelijk van welke language preference is geselecteerd. Language preference wordt in SettingsPageScreen geselecteerd en verandert in LanguageService, waar dan een andere json wordt geladen. Ook wordt voor de boeken api (enkel description) een translator (GoogleTranslator, flutter package) gebruikt. In BookDetailPageScreen wordt bij initialisatie getTranslatedDescription aangeroepen en wordt een language code meegeven verkregen van LanguageService, wanneer de book description wordt opgehaald later in de screen zal de beschrijving in de juiste taal zijn.

### Beschrijving extra 4

**Afbeelding lokaal opslaan en selecteren**: De applicatie biedt de mogelijkheid om een afbeelding lokaal op het apparaat op te slaan. Hierdoor kan een foto direct vanuit de galerij worden gekozen.

**Camera gebruiken**: De applicatie kan de camera van het device openen om een foto te maken en op te slaan. 

### Beschrijving extra 5
**Inloggen via google**: We hebben Google Federated Identity geïmplementeerd via Firebase, waardoor Google gebruikers via hun Google-account kan laten inloggen om toegang te krijgen tot de applicatie.



## Ondersteuning landscape en portrait / correct gebruik van Fragments

In landscape-modus wordt een flexbox gebruikt om het scherm in tweeën te splitsen: links de lijst met items en rechts de details van een geselecteerd item. Door op het kruisje te drukken, wordt de detailweergave gesloten en keert het scherm terug naar een volledige lijstweergave. Widgets zijn geïmplementeerd om herhaling van code te voorkomen.

## Web service / API

https://api.algobook.info/v1/ebooks/

We hebben bovenstaande API gebruikt, was publiek beschikbaar en geen nood voor een API-key. Verder hebben we query parameters gebruikt om de api te queryen.

De webservice Firebase wordt ook gebruikt. Hierin wordt een project aangemaakt en de inlog met emailadress en wachtwoord geconfigureerd. Ook google federated identity wordt hierlangs geauthenticeerd.

## Extra informatie

Het is mogelijk dat een melding verschijnt met het verzoek om de ontwikkelaarsmodus in te schakelen op Windows. Zonder deze instelling kan de applicatie bij ons niet worden gestart.
