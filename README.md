# 📝️ Tier List Maker

Tier List Maker is a sleek and modern Flutter app designed to empower users to create and edit tier lists effortlessly. With its rich feature set and intuitive interface, users can customize tier lists with images or text, manage their collections, and even share their creations.

## 📋 Features

![screenshots](https://github.com/user-attachments/assets/35fea87c-bc5f-4d49-bd5a-9697f03a737e)

1. **Menu Screen**:
   - Create a new tier list.
   - View personal tier lists.
   - Explore built-in popular lists.

2. **Editor Screen**:
   - Create or edit tier lists.
   - Drag and drop items across tiers.
   - Edit tier names and add or remove tiers.
   - Add text items or image items (with cropping functionality).
   - Download the tier list as an image.

3. **My Lists Screen**:
   - View saved tier lists.
   - Edit list names.
   - Delete tier lists.

4. **Popular Lists Screen**:
   - See predefined popular tier lists.
   - Add popular lists to personal collections.

5. **Settings Dialog**:
   - Reset the app to default settings.
   - Access the privacy policy.
   - Share the app.
   - Rate the app.
   - Provide feedback via email.

## 🛠️ Tech Stack
- **Development**: Flutter, Dart
- **State Management**: Provider
- **Dependency Injection**: Get_it, Injectable
- **Database**: Hive
- **Image Handling**: Image_picker, Crop_your_image, Image_gallery_saver
- **Testing**: Device_preview

## 🏢 Architecture

![diagram](https://github.com/user-attachments/assets/f9716b90-5231-4410-b6bb-81d393a1dd4a)

### Presentation Layer
- **Editor Provider**:
  - Manages the state of the **Editor Screen**.
  - The **Editor Provider** communicates with the **Tier Lists Provider** to update the overall state of tier lists when a user saves a list.
- **Tier Lists Provider**:
  - Manages the state of all tier lists within the app.
  - Has Repository as a dependency

### Data Layer
- **Tier Lists Repository**:
  - Serves as the central data access point for the app.
  - Dependencies:
    1. **Database Helper**: Interfaces with the Hive database for storing and retrieving tier lists.
    2. **Popular Tier Lists**: A predefined list of popular tier lists, stored in a separate class.

### Application Layer
- **Components**:
  - **App Theme**: Defines the overall styling and themes of the app.
  - **Router**: Manages navigation between screens.
  - **Material App**: Provides the app's foundational structure.
  - **App Module**: Utilizes the Injectable package for dependency injection.
  - **Utils**: Contains utility functions and settings.
  - **Dependency Injection File**: Configures dependencies and service bindings using Get_it and Injectable.

## 📄 License
GNU General Public License v3.0

