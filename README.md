# 📰 Smart Headlines

A modern, eye-catching **Flutter News Application** built with **Provider**, **REST API integration**, and **clean modular architecture**.  
**Smart Headlines** delivers real-time news from Google News API — allowing users to explore the world’s top stories by **category, country, language, or keyword**, all in one beautifully designed app. 🌍📱

---

## 🚀 Features

- 🌎 Browse news by **country**, **language**, and **category**
- 🔍 Search for specific topics or news sources (e.g., “Bitcoin”, “BBC News”)
- ⚙️ User preferences saved locally using **SharedPreferences**
- 🧭 Pagination support for seamless scrolling of multiple articles
- 💬 Clean, intuitive, and **responsive UI**
- 🧱 Modular project structure for scalability
- 📰 Article details screen with “Read Full Article” option (opens in Chrome)
- ✨ Animated splash screen for a premium feel
- 🔐 Secure API key storage using **flutter_dotenv**
- 💾 Efficient image caching via **cached_network_image**

---

## 🔑 Setup Instructions

### 1️⃣ Clone the Repository

git clone https://github.com/YOUR_USERNAME/smart_headlines.git

### 2️⃣ Navigate to the Project

cd smart_headlines

### 3️⃣ Create a .env File

In the project root directory, create a .env file and add your API key:

NEWS_API_KEY=your_api_key_here

⚠️ Important: Never commit this .env file — it’s already excluded in .gitignore.

### 4️⃣ Install Dependencies

flutter pub get

### 5️⃣ Run the App

flutter run

🧩 Tech Stack & Dependencies

| Package                    | Purpose                             |
| -------------------------- | ----------------------------------- |
| **flutter_dotenv**         | Manage environment variables safely |
| **provider**               | Lightweight state management        |
| **cached_network_image**   | Efficient image loading and caching |
| **shared_preferences**     | Store user-selected filters         |
| **url_launcher**           | Open full news articles in browser  |
| **animated_splash_screen** | Beautiful intro animation           |

## 🧠 API Information

### Source: Google News API

Features used:

- Top headlines by country, language, and category
- Keyword-based search
- Pagination for smooth feed loading

## 💅 Design Highlights

- Elegant AppBar with search field and filter popup
- Smooth animated splash screen
- Consistent color palette defined in color_constants.dart
- Modular widget design (easily extendable for more features)
- Responsive layout for both Android & iOS

## 📸 Screenshots

| Splash Screen                      | Home Screen                    | Article Details                     | Filter Popup                       |
|------------------------------------|--------------------------------|-------------------------------------|------------------------------------|
| ![Splash](screenshots/splash.jpeg) | ![Home](screenshots/home.jpeg) | ![Details](screenshots/detail.jpeg) | ![Filter](screenshots/filter.jpeg) |


## 📘 Example .env.example
Add this file to help other developers set up their keys easily:

Rename this file to .env and insert your API key below
NEWS_API_KEY=your_api_key_here

🧹 .gitignore Setup
Your .gitignore ensures clean commits and private keys stay hidden:

Env and keys
.env.example


## 🧭 How It Works

- Fetches news data from the API based on filters (country, language, category)
- Displays articles in a card list with thumbnail, title, and date
- Saves user filters with SharedPreferences for auto-restore on app relaunch
- Allows keyword/source search dynamically
- Launches browser for full article view

## 🛠️ Future Enhancements

🌙 Add Dark Mode support
🔖 Implement “Save for Later” bookmark feature
🗞️ Support multiple API sources
🌐 Offline reading mode

## 📄 License

This project is licensed under the MIT License — feel free to use, modify, or extend it for your own portfolio or learning.

👨‍💻 Developer
Bhavik Pithadiya
Mobile Application Developer | Flutter Developer
📧 bpithadiya8@gmail.com

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
