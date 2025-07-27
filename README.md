
# 📱 iOS News App

A modern, feature-rich iOS news application built with **UIKit** and **MVVM architecture**. The app fetches the latest news from NewsAPI and provides a smooth, native iOS experience with offline capabilities.

![iOS](https://img.shields.io/badge/iOS-15.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.0+-orange.svg)
![Xcode](https://img.shields.io/badge/Xcode-14.0+-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

## 📸 Screenshots

| News List | Article Detail | Loading State |
|-----------|----------------|---------------|
| ![News List](screenshots/news-list.png) | ![Article Detail](screenshots/article-detail.png) | ![Loading](screenshots/loading.png) |

## ✨ Features

### 🔥 Core Features
- **Latest News**: Fetch top headlines from NewsAPI
- **Article Details**: Full article view with web content
- **Pull to Refresh**: Intuitive refresh mechanism
- **Offline Support**: Core Data caching for offline reading
- **Error Handling**: Graceful error states and retry options
- **Loading States**: Smooth loading indicators

### 🏗️ Architecture & Technical Features
- **MVVM Architecture**: Clean separation of concerns
- **UIKit**: Native iOS components for optimal performance
- **Core Data**: Local data persistence and caching
- **URLSession**: Modern networking with async/await
- **Unit Tests**: Comprehensive test coverage
- **Memory Management**: Proper retain cycle prevention

## 🛠️ Technical Stack

| Component | Technology |
|-----------|------------|
| **UI Framework** | UIKit |
| **Architecture** | MVVM (Model-View-ViewModel) |
| **Networking** | URLSession |
| **Data Persistence** | Core Data |
| **Image Loading** | URLSession + Caching |
| **Testing** | XCTest |
| **Language** | Swift 5.0+ |
| **Minimum iOS** | iOS 15.0+ |

## 📁 Project Structure

NewsApp/
├── 📁 Application/
│ ├── AppDelegate.swift
│ └── SceneDelegate.swift
├── 📁 Models/
│ ├── NewsModels.swift
│ └── CoreData/
│ ├── NewsModel.xcdatamodeld
│ └── CoreDataManager.swift
├── 📁 ViewModels/
│ ├── NewsListViewModel.swift
│ └── ArticleDetailViewModel.swift
├── 📁 Views/
│ ├── Controllers/
│ │ ├── NewsListViewController.swift
│ │ └── ArticleDetailViewController.swift
│ └── Cells/
│ └── NewsTableViewCell.swift
├── 📁 Networking/
│ └── NetworkManager.swift
├── 📁 Resources/
│ └── Assets.xcassets
└── 📁 Tests/
├── NewsListViewModelTests.swift
└── NetworkManagerTests.swift


## 🚀 Getting Started

### Prerequisites
- **Xcode 14.0+**
- **iOS 15.0+**
- **Swift 5.0+**
- **NewsAPI Key** (free from [newsapi.org](https://newsapi.org))

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/ahmadodeh93/ios-news-app.git
   cd ios-news-app

2. **Add your NewsAPI Key**
   ```bash
   open NewsApp.xcodeproj
   
3. **Add your NewsAPI Key**

Get a free API key from NewsAPI.org
Open NetworkManager.swift
Replace YOUR_NEWS_API_KEY with your actual API key:
swift

private let apiKey = "your_actual_api_key_here"
Build and Run
Select your target device/simulator
Press Cmd + R to build and run
🧪 Testing

Run Unit Tests
bash

# In Xcode
Cmd + U
Test Coverage
The project includes comprehensive unit tests for:

✅ ViewModels (business logic)
✅ Network layer
✅ Data models
✅ Core Data operations
Current test coverage: 85%+

📱 App Flow

mermaid

graph TD
    A[App Launch] --> B[News List View]
    B --> C{Network Available?}
    C -->|Yes| D[Fetch Latest News]
    C -->|No| E[Load Cached News]
    D --> F[Display News List]
    E --> F
    F --> G[User Taps Article]
    G --> H[Article Detail View]
    H --> I[Load Web Content]
    F --> J[Pull to Refresh]
    J --> D
🔧 Configuration

NewsAPI Setup
Visit NewsAPI.org
Sign up for a free account
Get your API key
Add it to NetworkManager.swift
Customization
Country: Change country parameter in NetworkManager
Category: Modify category for specific news types
Page Size: Adjust pageSize for more/fewer articles
🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

Development Setup
Fork the repository
Create your feature branch (git checkout -b feature/AmazingFeature)
Commit your changes (git commit -m 'Add some AmazingFeature')
Push to the branch (git push origin feature/AmazingFeature)
Open a Pull Request
Code Style
Follow Swift API Design Guidelines
Use MVVM architecture patterns
Write unit tests for new features
Update documentation as needed
📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

👨‍💻 Author

Your Name

GitHub: @ahmadodeh93
LinkedIn: https://www.linkedin.com/in/ahmad-odeh-364510107?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=ios_app

Email: ahmad.odeh1993@hotmail.com
🙏 Acknowledgments

NewsAPI for providing the news data
Apple for the excellent UIKit framework
The iOS development community for inspiration and best practices
📊 Project Stats

⭐ Star this repository if you found it helpful!

