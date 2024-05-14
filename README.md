# LuxeVue Hotel Booking

Welcome to LuxeVue Hotel! This project is a web and mobile application built using React for the web frontend, Spring Boot for the backend, and Flutter for the mobile app.

## Getting Started

To run the LuxeVue Hotel application, follow these steps:

### Prerequisites

- Node.js installed on your machine
- npm package manager
- Java Development Kit (JDK) installed
- MySQL database server installed and running
- Flutter SDK installed

### Running the Backend

1. Clone the repository to your local machine.
2. Navigate to the backend directory:
   ```bash
   cd LuxeVue-hotel-backend
3.Open the application.properties file and update the database information to match your MySQL configuration. Modify the following line:
spring.datasource.url=jdbc:mysql://localhost:3306/luxevuehotel
4.Run the Spring Boot application using Maven:
mvn spring-boot:run

### Running the Frontend


1.Navigate to the frontend directory:
cd LuxeVue-hotel
2.Install the dependencies:
npm install
3.Start the development server:
 ```bash
npm run dev

### Running the Mobile App


1.Ensure you have the Flutter SDK installed on your system.
2.Navigate to the mobile directory:
cd LuxeVue-hotel-mobile
3.Run the command to build and run the Flutter app on your preferred device or simulator:
flutter run
4.If you want to run the app on a specific device, use the command:
flutter run -d Pixel_3_XL_API_31
Replace Pixel_3_XL_API_31 with the ID of your target device.

***Once the backend, frontend, and mobile app servers are running, you can access the LuxeVue Hotel application in your web browser at http://localhost:3000 and on your mobile device or emulator.***

Cela devrait vous aider à mieux organiser votre projet et à fournir des instructions claires pour l'équipe et les utilisateurs. N'hésitez pas à personnaliser davantage le fichier README.md selon vos besoins spécifiques. Si vous avez d'autres questions ou avez besoin d'aide supplémentaire, n'hésitez pas à demander !

