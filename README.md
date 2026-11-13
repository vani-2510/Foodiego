
# 🍔 Foodiego – Online Food Delivery System

A Java-based web application designed to provide an online food ordering experience. Foodiego uses Java, JSP, Servlets, and MySQL to manage application functionality and database operations.

## 📌 Project Overview

Foodiego is an Online Food Delivery Web Application developed using Java Enterprise Web Technologies. The project follows a layered structure to organize database operations, business logic, application models, and request handling.

The application uses MySQL for storing and managing food delivery-related information.

## 🚀 Technologies Used

| Technology | Purpose |
|---|---|
| Java | Backend development |
| JSP | Dynamic web pages |
| Java Servlets | Request handling |
| JDBC | Database connectivity |
| MySQL | Database management |
| HTML5 | Web page structure |
| CSS3 | Styling |
| JavaScript | Client-side functionality |
| Apache Tomcat | Web application server |
| Eclipse IDE | Development environment |
| Git & GitHub | Version control |

## ✨ Project Modules

The project is organized into the following Java packages:

- DAO: Data Access Object layer for database operations.
- DAO Implementation: Implementation of database access functionality.
- Model: Java classes representing application entities.
- Servlets: Handles application requests and responses.
- Utility: Database connection and utility classes.

## 🗄️ Database Details

**Database:** MySQL

**Database Name:** `online_food`

The database contains the following tables:

| Table Name | Description |
|---|---|
| user | User-related information |
| restaurant | Restaurant information |
| menu | Food menu information |
| order | Order information |
| orderitem | Individual order item information |

### Database File

The MySQL database export is included in the repository:

`database/foodiego.sql`

## 📂 Project Structure

```text
Foodiego/
│
├── src/
│   └── main/
│       ├── java/
│       │   └── com/vani/
│       │       ├── dao/
│       │       ├── daoimplementation/
│       │       ├── model/
│       │       ├── servlets/
│       │       └── utility/
│       │
│       └── webapp/
│
├── database/
│   └── foodiego.sql
│
├── build/
├── .classpath
├── .project
├── .gitignore
└── README.md
```

## ⚙️ Installation and Setup

Follow these steps to run the project locally.

### 1. Prerequisites

Install the following software:

- Java JDK
- Eclipse IDE
- Apache Tomcat Server
- MySQL Server
- MySQL Workbench

### 2. Clone the Repository

```bash
git clone https://github.com/vani-2510/Foodiego.git
```

### 3. Import the Project into Eclipse

1. Open Eclipse IDE.
2. Select File → Import.
3. Choose Existing Projects into Workspace.
4. Browse to the cloned project folder.
5. Select the Foodiego project and click Finish.

### 4. Configure the MySQL Database

1. Open MySQL Workbench.
2. Connect to your local MySQL instance.
3. Create the database:

```sql
CREATE DATABASE online_food;
```

4. Import the SQL file located at:

`database/foodiego.sql`

5. Execute the SQL script to create and populate the database.

### 5. Configure Database Connectivity

Open:

`src/main/java/com/vani/utility/DBConnection.java`

Update the database connection details according to your local MySQL configuration.

Make sure the MySQL JDBC driver is available in the project libraries.

**Important:** Do not upload actual database passwords or credentials to GitHub.

### 6. Run the Application

1. Configure Apache Tomcat in Eclipse.
2. Right-click the project.
3. Select Run As → Run on Server.
4. Select your configured Tomcat server.
5. Finish the configuration and start the application.

## 🛠️ Development Tools

- Eclipse IDE
- MySQL Workbench
- Apache Tomcat
- Git Bash
- GitHub

## 📌 Future Enhancements

- Improve user interface and responsiveness.
- Enhance user authentication and security.
- Add online payment integration.
- Introduce order tracking functionality.
- Improve restaurant and menu management.

## 👨‍💻 Author

**Vani**

GitHub: [@vani-2510](https://github.com/vani-2510)

## 📄 License

This project is developed for educational and learning purposes. A formal open-source license has not yet been specified.
