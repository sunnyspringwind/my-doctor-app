# MyDoctorApp

MyDoctorApp is a Java web application designed to manage doctor and patient interactions. It leverages modern Java EE technologies, including Servlets and JSP, with JSTL support for dynamic web pages, and integrates with a MySQL database.

## Features

- User authentication and security (with bcrypt hashing)
- Doctor and patient management
- Database connectivity with connection pooling
- Email notifications (Jakarta Mail)
- RESTful (JSON) API support (via Gson)
- Modular Maven project structure

## Project Structure

```
my-doctor-app/
├── pom.xml
├── src/
│   └── main/
│       ├── java/         # Java source code (servlets, models, utilities)
│       ├── resources/    # Application resources (properties, configs)
│       └── webapp/       # Web application (JSPs, static assets, WEB-INF)
├── .gitignore
└── .idea/                # IDE configuration (optional)
```

## Dependencies

Key dependencies (see `pom.xml` for details):

- Jakarta Servlet API 6.0
- JSTL 3.0
- MySQL Connector/J 8.0
- jBCrypt 0.4
- Jakarta Mail 2.0

## Getting Started

### Prerequisites

- Java 16 or higher
- Maven 3.x
- MySQL database

### Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/sunnyspringwind/my-doctor-app.git
   cd my-doctor-app
   ```

2. **Configure the database:**
   - Edit the resource files with your MySQL configuration (see `src/main/resources`).

3. **Build the project:**
   ```bash
   mvn clean package
   ```
   This produces a WAR file in the `target/` directory.

4. **Deploy to a servlet container:**
   - Deploy the WAR file to Apache Tomcat or another compatible servlet container.

### Running

- Access the application in your browser after deployment (typically `http://localhost:8080/MyDoctorApp`).

