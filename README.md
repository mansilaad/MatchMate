# MatchMate - Matrimonial Card Interface (iOS)

## Project Description
MatchMate is an iOS application that simulates a matrimonial app. The app fetches user data from an API, allows users to accept or decline matches, and persists their choices using Core Data. It is designed to work seamlessly in both online and offline modes while following best-in-class design patterns and utilizing modern iOS libraries.

## Features
- Fetches user data from an API and displays match cards.
- Users can accept or decline matches.
- Uses Core Data for offline persistence.
- Syncs offline actions when the internet connection is restored.
- Implements MVVM architecture for maintainability.
- Uses URLSession for API calls, SDWebImage for image loading, Combine for data flow management, and Core Data for local storage.
- Ensures robust error handling for API calls, database operations, and network connectivity.
- Provides a clean, intuitive, and visually appealing UI following iOS design guidelines.

## Tech Stack
- **Language:** Swift
- **Frameworks:** SwiftUI, Combine
- **Networking:** URLSession
- **Image Loading:** SDWebImage
- **Local Storage:** Core Data
- **Architecture:** MVVM

## Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/mansilaad/MatchMate.git
   ```
2. Navigate to the project directory:
   ```sh
   cd MatchMate
   ```
3. Open the project in Xcode:
   ```sh
   open MatchMate.xcodeproj
   ```
4. Build and run the project using an iOS Simulator or a physical device.
   

## Requirements

Xcode 16.2
iOS 17+

## API Integration
MatchMate fetches user data from the [Random User API](https://randomuser.me/api/?results=10). 
The API response provides details such as name, age, location, and profile picture, which are displayed on the match cards.

## Data Persistence
- **Core Data** is used to store user profiles and their acceptance/decline status.
- Data remains accessible in offline mode and syncs with the server when the connection is restored.

## Error Handling
- Implements structured error handling for:
  - API failures (e.g., no internet connection, server errors)
  - Database operations (e.g., failed fetch, save errors)
  - UI issues (e.g., missing data, image loading errors)

## Usage
1. Launch the app.
2. Browse through match cards.
3. Accept or decline a match.
4. The status updates and is stored persistently.
5. If offline, actions are saved and synced once back online.


---
Developed by MANSI LAAD.



