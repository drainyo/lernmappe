   # Lernmappe als private Website (Cloudflare Pages + Access)

Stand: 2026-10-13. Ziel: Die Lernmappe ist im Internet erreichbar, aber nur für
freigegebene E-Mail-Adressen (Familie). Kosten: 0 €.

## Wie es funktioniert
- **Cloudflare Pages** hostet die Dateien aus dem Ordner `website\`.
- **Cloudflare Access** steht davor: Wer die Seite öffnet, gibt seine E-Mail ein,
  bekommt einen 6-stelligen Code und ist dann drin. Nur Adressen auf der Liste
  bekommen einen Code.
- `website\` wird **nie von Hand bearbeitet**, sondern mit
  `website-aktualisieren.ps1` aus den Arbeitsblättern erzeugt.

## Einmalige Einrichtung (ca. 30 min)
Die Menünamen bei Cloudflare ändern sich gelegentlich ein wenig.

### 1. Konto
- cloudflare.com → Sign up → E-Mail bestätigen.

### 2. Website hochladen (Pages)
1. Links **Workers & Pages** → **Create** → Reiter **Pages** →
   **Upload assets** (Direct Upload).
2. Projektname: z. B. `lernmappe-ml26` (wird Teil der Adresse; **kein
   Nachname**, nichts Erratbares).
3. Den Ordner `08 Lernen mit Kindern\website` hineinziehen → **Deploy**.
4. Adresse notieren: `https://<projektname>.pages.dev`

⚠️ Ab hier ist die Seite **öffentlich**, bis Schritt 3 erledigt ist. Schritt 3
also gleich anschließend machen.

### 3. Zugang beschränken (Access)
1. Links **Zero Trust** öffnen. Beim ersten Mal: Teamname wählen (beliebig),
   **Free**-Plan wählen. Cloudflare fragt dabei eventuell nach einer
   Zahlungsmethode, obwohl der Plan gratis ist.
2. **Access** → **Applications** → **Add an application** → **Self-hosted**.
3. Name: `Lernmappe`. Session Duration: **1 month** (damit Omas/Opas nicht
   ständig neue Codes brauchen).
4. Domains hinzufügen, **beide**:
   - `<projektname>.pages.dev`
   - `*.<projektname>.pages.dev` (Vorschau-Adressen jeder Version)
5. Policy anlegen: Name `Familie`, Action **Allow**, Include → **Emails** →
   alle Adressen eintragen (Benjamin, Bianca, ihr Freund, Clara, Omas, Opas,
   Kinder, falls eigene Mail).
6. Login-Methode: **One-time PIN** (ist Standard). Speichern.

### 4. Testen
- Seite in einem **privaten Browserfenster** öffnen → muss nach E-Mail fragen.
- Mit einer Adresse, die **nicht** auf der Liste ist, probieren → darf keinen
  Zugang bekommen.
- Erst dann den Link an die Familie schicken.

## Bei jeder Änderung an den Blättern (seit 2026-10-13 über GitHub)
Claude sagen: „Website aktualisieren“. Oder selbst in PowerShell in diesem Ordner:
1. `.\website-aktualisieren.ps1`
2. `git add -A`
3. `git commit -m "Update worksheets"`
4. `git push`

Cloudflare baut nach jedem Push automatisch neu (1–2 min).

- Repository: https://github.com/drainyo/lernmappe (privat)
- Nicht im Repository (`.gitignore`): `PROJEKT.md`, alle Bilder, `Lernmappe PDF/`.
- Cloudflare-Pages-Projekt `lernmappe-m-l` ist mit GitHub verbunden:
  Production branch `main`, kein Build-Befehl, Build output directory `website`.

## Person hinzufügen / entfernen
Zero Trust → Access → Applications → Lernmappe → Policy `Familie` → E-Mail
ergänzen oder löschen.

## Später (optional)
Statt Hochladen per Hand: Git + GitHub-Repository mit Cloudflare verbinden, dann
geht jede Änderung automatisch online. Guter erster Schritt zum Programmieren-Lernen.
