# Hydroponics Management Systems

## Overview
Hydroponics Management Systems is a comprehensive Spring Boot application designed to manage and monitor hydroponics farming operations. It provides robust features for user management, environment monitoring, notifications, transactions, PDF generation, and more, making it ideal for administrators and users involved in hydroponic agriculture.

---

## Table of Contents
- [Features](#features)
- [Technology Stack](#technology-stack)
- [Project Structure](#project-structure)
- [Configuration](#configuration)
- [Getting Started](#getting-started)
- [Default Admin User](#default-admin-user)
- [Testing](#testing)
- [Contributing](#contributing)
- [Author](#author)

---

## Features
- **User Management:** Registration, authentication, role-based access (admin/user), profile management
- **Environment Monitoring:** CRUD operations for environment data, real-time updates via WebSocket
- **Notifications:** Real-time and persistent notifications for system events
- **Transactions & Payments:** Management of transactions, invoices, and payments
- **PDF Generation:** Exporting data and reports to PDF
- **Location Management:** CRUD for locations within the hydroponics system
- **Data Generation:** Tools for generating test/sample data
- **File Uploads:** Multipart file handling with configurable limits

---

## Technology Stack
- **Backend:** Java 17, Spring Boot 3.2.0 (Web, Data JPA, Validation, WebSocket, Scheduling)
- **Database:** MySQL (configured in `application.properties`)
- **ORM:** Hibernate (JPA)
- **Security:** BCrypt for password hashing
- **PDF Generation:** Apache PDFBox, iText (kernel, html2pdf)
- **Object Mapping:** ModelMapper
- **Lombok:** For reducing boilerplate code
- **Web Frontend:** JSP (configured as view technology), static assets (JS, CSS, plugins)
- **Testing:** JUnit 5 (Spring Boot Test)
- **Build Tool:** Maven (with wrapper scripts for cross-platform compatibility)

---

## Project Structure
```
HydroponicsManagementSystems/
├── src/
│   ├── main/
│   │   ├── java/com/hydroponics/management/system/
│   │   │   ├── controllers/      # REST and WebSocket controllers
│   │   │   ├── entities/         # JPA entities
│   │   │   ├── services/         # Service interfaces
│   │   │   ├── servicesImple/    # Service implementations
│   │   │   ├── reopository/      # Spring Data JPA repositories
│   │   │   ├── DTO/, payloads/   # Data Transfer Objects and payloads
│   │   │   ├── configs/, enums/, exception/, annotation/
│   │   │   └── HydroponicsManagementSystemsApplication.java # Main entry point
│   │   ├── resources/
│   │   │   ├── application.properties # Main configuration
│   │   │   ├── banner.txt            # Custom startup banner
│   │   │   ├── static/, templates/   # Static assets and view templates
│   ├── test/
│   │   └── java/com/hydroponics/management/system/
│   │       └── HydroponicsManagementSystemsApplicationTests.java
├── templates/                        # Sample PDF files
├── pom.xml                           # Maven build file
├── mvnw, mvnw.cmd                    # Maven wrapper scripts
└── ...
```

---

## Configuration
- **Database:** MySQL, configured in `src/main/resources/application.properties`
- **Port:** Default server port is 8080
- **File Uploads:** Max file size and request size are configurable

Example `application.properties`:
```properties
server.port=8080
spring.datasource.url=jdbc:mysql://localhost:3306/hydroponics_management_system
spring.datasource.username=root
spring.datasource.password=
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL8Dialect
spring.jpa.hibernate.ddl-auto=update
spring.servlet.multipart.max-request-size=200MB
spring.servlet.multipart.max-file-size=100MB
```

---

## Getting Started

### Prerequisites
- Java 17+
- Maven
- MySQL

### Steps
1. **Clone the repository**
   ```sh
   git clone <repository-url>
   cd HydroponicsManagementSystems
   ```
2. **Configure MySQL**
   - Create a database named `hydroponics_management_system`.
   - Update the username and password in `src/main/resources/application.properties` if needed.
3. **Build the project**
   ```sh
   ./mvnw clean install
   ```
4. **Run the application**
   ```sh
   ./mvnw spring-boot:run
   ```
5. **Access the app**
   - Open [http://localhost:8080](http://localhost:8080) in your browser.

---

## Default Admin User
On first run, an admin user is created automatically:
- **Email:** admin@gmail.com
- **Password:** 1111

---

## Testing
- Basic context load test is present in `HydroponicsManagementSystemsApplicationTests.java`.
- To run tests:
  ```sh
  ./mvnw test
  ```

---

## Contributing
1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Open a pull request

---

## Author
Developed by **Shubrato Debnath**

---

## License
(Add your license here, if any) 