# Aarogya Saathi 🏥📱

An AI-powered rural health assistant designed for India's healthcare challenges, providing accessible medical guidance through multiple channels including IVR systems for feature phones and a lightweight offline Android app.

## 🌟 Overview

Aarogya Saathi bridges the healthcare gap in rural India by leveraging artificial intelligence to provide essential health services in local languages. The platform is specifically designed to work with limited connectivity and basic mobile devices, ensuring healthcare accessibility for underserved populations.

## 🚀 Key Features

### 📞 Multi-Channel Access
- **IVR (Interactive Voice Response)** system for feature phones
- **Lightweight Android app** with offline capabilities
- **Voice-based interactions** in local Indian languages

### 🤖 AI-Powered Health Assistant
- **Pregnancy risk assessment** and monitoring
- **General health information** and guidance
- **Symptom checker** with preliminary diagnosis
- **Medication reminders** and health tips

### 🏥 ASHA Worker Dashboard
- Dedicated interface for Accredited Social Health Activists
- **Patient tracking** and case management
- **Health data collection** and reporting
- **Community health monitoring** tools

### 🌐 Technology Stack
- **On-device AI** for offline functionality
- **AWS cloud synchronization** when connectivity is available
- **Flutter framework** for cross-platform mobile development
- **Multi-language support** for regional languages

## 📱 Installation & Setup

### Prerequisites
- Flutter SDK (>=3.0.0)
- Android Studio / VS Code
- Android device or emulator (API level 21+)

### Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/erpranjalmishra/Aarogya-Saathi.git
   cd Aarogya-Saathi
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

### Configuration

1. **AWS Setup** (Optional - for cloud sync)
   - Configure AWS credentials in `lib/config/aws_config.dart`
   - Set up your AWS services (S3, Lambda, etc.)

2. **Language Configuration**
   - Add language files in `assets/languages/`
   - Configure supported languages in `lib/config/language_config.dart`

## 🏗️ Project Structure

```
lib/
├── config/          # Configuration files
├── models/          # Data models
├── services/        # API and business logic
├── screens/         # UI screens
├── widgets/         # Reusable UI components
├── utils/           # Utility functions
└── main.dart        # Application entry point

assets/
├── images/          # Image assets
├── languages/       # Localization files
└── audio/           # Audio files for IVR
```

## 🎯 Use Cases

### For Rural Communities
- Access health information without internet connectivity
- Get preliminary health assessments in local languages
- Receive pregnancy and maternal health guidance
- Connect with nearest healthcare facilities

### For ASHA Workers
- Digital tools for community health monitoring
- Patient data collection and management
- Health education resource distribution
- Performance tracking and reporting

### For Healthcare Systems
- Extend reach to remote areas
- Collect health data from underserved populations
- Monitor public health trends
- Reduce burden on primary healthcare centers

## 🌍 Language Support

Currently supports:
- Hindi
- Bengali
- Tamil
- Telugu
- Marathi
- Gujarati
- Kannada
- Malayalam
- Punjabi
- Odia

## 🤝 Contributing

We welcome contributions to improve Aarogya Saathi! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Development Guidelines
- Follow Flutter best practices
- Write comprehensive tests
- Ensure accessibility compliance
- Test on low-end Android devices
- Validate offline functionality

## 📊 Impact & Goals

### Current Impact
- Serving rural communities across multiple Indian states
- Supporting ASHA workers with digital tools
- Providing health information in 10+ regional languages

### Future Goals
- Expand to 20+ Indian languages
- Integrate with government health systems
- Add telemedicine capabilities
- Implement AI-driven health predictions

## 🔒 Privacy & Security

- All personal health data is encrypted
- On-device processing ensures data privacy
- AWS cloud sync follows healthcare data compliance
- User consent required for all data collection

## 📞 Support & Contact

- **Issues**: [GitHub Issues](https://github.com/erpranjalmishra/Aarogya-Saathi/issues)
- **Developer**: [Pranjal Mishra](https://github.com/erpranjalmishra)
- **Email**: [Contact via GitHub]

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Ministry of Health & Family Welfare, India
- ASHA workers and rural communities for feedback
- Open source contributors
- Flutter and AWS communities

---

**Aarogya Saathi** - Empowering rural India with accessible healthcare through technology 🚀