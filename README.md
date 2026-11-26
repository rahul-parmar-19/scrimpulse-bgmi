# 🎯 ScrimPulse — Real-Time BGMI Esports Companion App

ScrimPulse is a production-grade, real-time BGMI (Battlegrounds Mobile India) Esports Companion mobile app built with **Flutter**, **Firebase Cloud Firestore**, and **Firebase Cloud Messaging (FCM)**.

Tracks official tournaments such as **BGIS**, **BMPS**, and **BMIC**, complete with live point tables, dynamic 10-point scoring calculations, match schedules with map filtering, 4-player team rosters, and embedded floating YouTube streams.

---

## ⚡ Tech Stack & Architecture

- **State Management**: `flutter_bloc` 8.x (reactive event-state streams)
- **Live Database**: Firebase Cloud Firestore with real-time reactive streams (`.snapshots()`)
- **Push Alerts**: Firebase Cloud Messaging (`firebase_messaging`) & `flutter_local_notifications`
- **Embedded Stream**: `youtube_player_flutter` (Supports docked top banner & floating draggable PiP card)
- **Offline Caching**: `isar` / in-memory resilient caching layer
- **Styling**: High-contrast dark esports theme (Neon Yellow `#DFFF00` & Cyan `#00F5D4` on Deep Charcoal `#090B0E`)
- **Typography**: `google_fonts` (`Rajdhani` for esports headers, `Inter` for data tables)

---

## 🗄️ Firestore Database Schema

### 1. `tournaments`
```json
{
  "id": "bgis_2026_grand_finals",
  "name": "BGIS 2026: GRAND FINALS - DAY 3",
  "status": "LIVE", // ["LIVE", "UPCOMING", "COMPLETED"]
  "live_stream_url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
  "total_prize": "₹2,00,00,000 INR",
  "banner_url": "https://..."
}
```

### 2. `matches`
```json
{
  "match_id": "match_13",
  "tournament_id": "bgis_2026_grand_finals",
  "match_number": 13,
  "map_name": "Erangel", // ["Erangel", "Miramar", "Sanhok", "Rondo"]
  "group_info": "Grand Finals - Match 13",
  "start_time": "Timestamp",
  "is_live": true,
  "winner_team": "Team SouL"
}
```

### 3. `standings`
```json
{
  "id": "std_1",
  "tournament_id": "bgis_2026_grand_finals",
  "rank": 1,
  "team_id": "team_soul",
  "team_name": "Team SouL (iQOO SouL)",
  "team_logo_url": "https://...",
  "matches_played": 12,
  "wwcd_count": 3,
  "placement_points": 54,
  "kill_points": 78,
  "total_points": 132
}
```

### 4. `teams`
```json
{
  "team_id": "team_soul",
  "team_name": "Team SouL",
  "tag": "SouL",
  "logo_url": "https://...",
  "roster": [
    { "player_name": "Manya", "role": "IGL", "total_kills": 22, "kd_ratio": 1.83 },
    { "player_name": "Spower", "role": "Assaulter", "total_kills": 28, "kd_ratio": 2.33 },
    { "player_name": "Rony", "role": "Support", "total_kills": 14, "kd_ratio": 1.16 },
    { "player_name": "Nakul", "role": "Assaulter", "total_kills": 14, "kd_ratio": 1.16 }
  ]
}
```

---

## 🏆 Official 10-Point System Implementation

Placement Points breakdown:
- 1st (WWCD): **10 Points**
- 2nd: **6 Points**
- 3rd: **5 Points**
- 4th: **4 Points**
- 5th: **3 Points**
- 6th: **2 Points**
- 7th & 8th: **1 Point**
- 9th to 16th: **0 Points**
- Plus: **+1 Point per Kill**

**Tie-Breaking Priority** handled by `ScoringCalculator.sortAndComputeRanks()`:
1. Highest Total Points (Placement + Kill Points)
2. Total WWCDs
3. Highest Total Placement Points
4. Highest Total Kill Points

---

## 🚀 Getting Started

1. **Install dependencies**:
   ```bash
   flutter pub get
   ```

2. **Generate Isar schemas** (optional for local DB generation):
   ```bash
   flutter pub run build_runner build
   ```

3. **Add Firebase Credentials**:
   - Android: Place `google-services.json` into `android/app/`
   - iOS: Place `GoogleService-Info.plist` into `ios/Runner/`

4. **Run the App**:
   ```bash
   flutter run
   ```
   *(The app includes full offline mock fallbacks and automatic seeding, allowing instant testing even before connecting live Firebase credentials!)*

