# CloudDeploymentDemo - Spring Boot Application

A beginner-friendly Spring Boot 3 microservice designed for college cloud deployment practicals using **Render** or **AWS EC2**.

---

## 📋 Table of Contents
1. [Project Overview](#project-overview)
2. [REST API Endpoints](#rest-api-endpoints)
3. [Project Directory Structure](#project-directory-structure)
4. [How to Run the Application Locally (Maven)](#how-to-run-the-application-locally-maven)
5. [How to Test the Endpoints (Browser / Postman / curl)](#how-to-test-the-endpoints-browser--postman--curl)
6. [How to Build the JAR File](#how-to-build-the-jar-file)
7. [How to Deploy on Render (Step-by-Step)](#how-to-deploy-on-render-step-by-step)
8. [How to Deploy on AWS EC2 (Step-by-Step)](#how-to-deploy-on-aws-ec2-step-by-step)

---

## 🌟 Project Overview
- **Language & Version:** Java 17
- **Framework:** Spring Boot 3.3.4
- **Build Tool:** Maven
- **Dependencies:** Spring Web (`spring-boot-starter-web`) with embedded Tomcat
- **Ports:** Listens on port `8080` locally, or dynamically binds to the `$PORT` environment variable provided by Render.

---

## 📡 REST API Endpoints

| Endpoint | HTTP Method | Expected Output / Response | Description |
|---|---|---|---|
| `/` | `GET` | `Welcome to Cloud Deployment Demo!` | Home welcome message |
| `/health` | `GET` | `Application is running successfully!` | Cloud health check endpoint |
| `/student` | `GET` | `{"id": 101, "name": "John", "course": "Computer Science", "status": "Active"}` | Student information JSON |

---

## 📁 Project Directory Structure

```text
CloudDeploymentDemo/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/example/demo/
│       │       ├── CloudDeploymentDemoApplication.java
│       │       └── StudentController.java
│       └── resources/
│           └── application.properties
├── pom.xml
├── Dockerfile
├── .gitignore
└── README.md
```

---

## 💻 How to Run the Application Locally (Maven)

### Step 1: Open a Terminal / Command Prompt
Navigate into the project directory:
```bash
cd CloudDeploymentDemo
```

### Step 2: Run with Maven
```bash
# If Maven is installed globally on your system:
mvn spring-boot:run

# Or if using Maven Wrapper:
# On Windows:
mvnw.cmd spring-boot:run

# On Linux / Mac:
./mvnw spring-boot:run
```

Once started, you will see output ending with:
```
Started CloudDeploymentDemoApplication in 1.8 seconds (process running for 2.1)
```

The application is now live on `http://localhost:8080`.

---

## 🔍 How to Test the Endpoints (Browser / Postman / curl)

### Option 1: Using a Web Browser
Open any web browser (Chrome, Edge, Firefox) and paste these URLs into the address bar:
1. **Home Endpoint:**
   `http://localhost:8080/`
   👉 **Output:** `Welcome to Cloud Deployment Demo!`

2. **Health Check Endpoint:**
   `http://localhost:8080/health`
   👉 **Output:** `Application is running successfully!`

3. **Student Information Endpoint:**
   `http://localhost:8080/student`
   👉 **Output:**
   ```json
   {
     "id": 101,
     "name": "John",
     "course": "Computer Science",
     "status": "Active"
   }
   ```

---

### Option 2: Using Postman
1. Open **Postman** and click **New Request**.
2. Select **GET** as the HTTP method.
3. Enter URL: `http://localhost:8080/student`
4. Click **Send**.
5. Check the response body:
   - Status: `200 OK`
   - Format: `JSON`
   - Content:
     ```json
     {
       "id": 101,
       "name": "John",
       "course": "Computer Science",
       "status": "Active"
     }
     ```

---

### Option 3: Using cURL in Terminal
```bash
# Test Home
curl http://localhost:8080/

# Test Health
curl http://localhost:8080/health

# Test Student
curl http://localhost:8080/student
```

---

## 📦 How to Build the JAR File

To create a standalone runnable `.jar` file:

```bash
# Clean and package project without running tests
mvn clean package -DskipTests
# Or on Windows wrapper:
mvnw.cmd clean package -DskipTests
```

This compiles your code and produces the executable JAR in the `target/` directory:
```
target/CloudDeploymentDemo-0.0.1-SNAPSHOT.jar
```

To run the built JAR directly:
```bash
java -jar target/CloudDeploymentDemo-0.0.1-SNAPSHOT.jar
```

---

## 🚀 How to Deploy on Render (Step-by-Step)

Render is a modern cloud platform that provides free hosting for web services with automatic TLS/HTTPS.

### Step 1: Push Code to GitHub
1. Create a new repository on [GitHub](https://github.com/new) named `CloudDeploymentDemo`.
2. In your local `CloudDeploymentDemo` folder, initialize and push git:
   ```bash
   git init
   git add .
   git commit -m "Initial commit of CloudDeploymentDemo"
   git branch -M main
   git remote add origin https://github.com/<your-username>/CloudDeploymentDemo.git
   git push -u origin main
   ```

### Step 2: Create a Web Service on Render
1. Go to [https://render.com](https://render.com) and sign in.
2. Click **New +** at the top right and select **Web Service**.
3. Choose **Build and deploy from a Git repository** and connect your GitHub account.
4. Select the `CloudDeploymentDemo` repository.

### Step 3: Configure Deployment Settings
Fill in the form:
- **Name:** `cloud-deployment-demo`
- **Region:** Any region (e.g., `Oregon (US West)` or `Singapore`)
- **Branch:** `main`
- **Runtime:** `Docker` *(Recommended - Render detects the Dockerfile automatically)*
  - *(Alternatively, choose `Java` runtime:*
    - **Build Command:** `mvn clean package -DskipTests`
    - **Start Command:** `java -Dserver.port=$PORT -jar target/CloudDeploymentDemo-0.0.1-SNAPSHOT.jar`
- **Instance Type:** `Free`

### Step 4: Deploy and Verify
1. Click **Create Web Service**.
2. Render will automatically pull the code, build the Docker container, and deploy it.
3. Once live, Render displays your public URL, such as:
   `https://cloud-deployment-demo.onrender.com`
4. Test the live endpoints in your browser:
   - `https://cloud-deployment-demo.onrender.com/`
   - `https://cloud-deployment-demo.onrender.com/health`
   - `https://cloud-deployment-demo.onrender.com/student`

---

## ☁️ How to Deploy on AWS EC2 (Step-by-Step)

### Step 1: Launch an EC2 Instance
1. Sign in to the **AWS Management Console** and navigate to **EC2**.
2. Click **Launch Instance**:
   - **Name:** `CloudDeploymentDemo-Server`
   - **AMI:** `Ubuntu Server 22.04 LTS` (Free Tier eligible)
   - **Instance Type:** `t2.micro`
   - **Key pair:** Create or select an existing `.pem` key pair.
3. **Security Group Inbound Rules:**
   - Allow **SSH** (Port 22) from `My IP`
   - Allow **Custom TCP** (Port 8080) from `0.0.0.0/0` (Anywhere)
4. Click **Launch Instance**.

### Step 2: Connect to EC2 and Install Java 17
Connect via SSH:
```bash
ssh -i "your-key.pem" ubuntu@<YOUR_EC2_PUBLIC_IP>
```
On the EC2 terminal, install Java 17:
```bash
sudo apt update
sudo apt install -y openjdk-17-jre-headless
java -version
```

### Step 3: Transfer and Run the JAR
1. From your local PC, copy the JAR to EC2 using `scp`:
   ```bash
   scp -i "your-key.pem" target/CloudDeploymentDemo-0.0.1-SNAPSHOT.jar ubuntu@<YOUR_EC2_PUBLIC_IP>:~/
   ```
2. On EC2, start the application in the background:
   ```bash
   nohup java -jar CloudDeploymentDemo-0.0.1-SNAPSHOT.jar > app.log 2>&1 &
   ```

### Step 4: Verify Deployment
Open your browser or terminal:
- `http://<YOUR_EC2_PUBLIC_IP>:8080/`
- `http://<YOUR_EC2_PUBLIC_IP>:8080/health`
- `http://<YOUR_EC2_PUBLIC_IP>:8080/student`

