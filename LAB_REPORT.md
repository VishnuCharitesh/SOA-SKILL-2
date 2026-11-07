# LAB EXPERIMENT 9: Infrastructure Provisioning & Deployment using Render / AWS

**Course:** Service-Oriented Architecture & Cloud Computing Lab  
**Experiment Number:** 09  
**Application Name:** `CloudDeploymentDemo`  
**Platform Used:** Render (PaaS) / AWS EC2 (IaaS)  

---

## 1. Aim
To automate and demonstrate the infrastructure provisioning and deployment of a Spring Boot microservice application using cloud platforms (Render or AWS EC2), configure the required runtime environment, build commands, start commands, environment variables, and verify the live endpoints.

---

## 2. Software & Runtime Requirements
- **JDK:** Java 17 (Eclipse Temurin / OpenJDK)
- **Framework:** Spring Boot 3.3.4
- **Build Tool:** Apache Maven
- **Server:** Embedded Apache Tomcat (Port 8080 / Dynamic `$PORT`)
- **Container Engine:** Docker (Multi-stage build)
- **Cloud Platform:** Render Web Services / AWS EC2 (Ubuntu 22.04 LTS)

---

## 3. Architecture & Deployment Workflow

```
+-------------------------------------------------------------------------------+
|                       Developer Workstation (Local PC)                        |
|                                                                               |
|   1. Write Spring Boot Code (CloudDeploymentDemo)                             |
|   2. Commit & Push to GitHub Repository                                       |
+---------------------------------------+---------------------------------------+
                                        |
                                        v
+---------------------------------------+---------------------------------------+
|                    Cloud Infrastructure Provisioning                          |
+-------------------------------------------------------------------------------+
|                                                                               |
|   OPTION A: Render (Cloud PaaS)           OPTION B: AWS EC2 (Cloud IaaS)      |
|   - Auto-provision Web Service            - Launch t2.micro VM Instance       |
|   - Multi-stage Dockerfile build          - Open Security Group Port 8080     |
|   - Free Tier container hosting           - SSH access via .pem Key Pair      |
|   - Dynamic $PORT injection               - Install OpenJDK 17 on Linux       |
|   - Free automated SSL (HTTPS)            - Background Execution (nohup)      |
|                                                                               |
+---------------------------------------+---------------------------------------+
                                        |
                                        v
+---------------------------------------+---------------------------------------+
|                      Live Application Verification                            |
|                                                                               |
|   1. GET /         --> "Welcome to Cloud Deployment Demo!"                    |
|   2. GET /health   --> "Application is running successfully!"                 |
|   3. GET /student  --> {"id":101,"name":"John","course":"CS","status":"Active"}|
+-------------------------------------------------------------------------------+
```

---

## 4. Execution Steps

### STEP 1: Configure Cloud Infrastructure

#### On Render:
1. Register/Login on [https://render.com](https://render.com) using a GitHub account.
2. Select **New +** → **Web Service**.
3. Link the GitHub repository containing `CloudDeploymentDemo`.
4. Configure infrastructure settings:
   - **Service Name:** `cloud-deployment-demo`
   - **Region:** `Oregon (US West)` or `Singapore`
   - **Branch:** `main`
   - **Runtime:** `Docker` (or `Java`)
   - **Instance Plan:** `Free` (0.1 CPU, 512 MB RAM)

#### On AWS EC2:
1. Sign in to AWS Management Console → **EC2 Dashboard** → **Launch Instance**.
2. **AMI:** Ubuntu Server 22.04 LTS.
3. **Instance Type:** `t2.micro` (Free tier eligible).
4. **Security Group Inbound Rules:**
   - **Port 8080 (Custom TCP):** Source `0.0.0.0/0` (Spring Boot microservice traffic)
   - **Port 22 (SSH):** Source `My IP` (Administrative access)

---

### STEP 2: Deploy the Application

#### On Render:
1. Render detects the `Dockerfile` automatically.
2. **Build Stage:** Maven packages the application inside a temporary container:
   ```bash
   mvn clean package -DskipTests
   ```
3. **Run Stage:** Lightweight JRE 17 container starts the Spring Boot JAR:
   ```bash
   java -Dserver.port=$PORT -jar app.jar
   ```
4. Click **Create Web Service**. Monitor the deployment logs until `Service is live` appears.

#### On AWS EC2:
1. Connect via SSH:
   ```bash
   ssh -i "your-key.pem" ubuntu@<EC2_PUBLIC_IP>
   ```
2. Install Java 17:
   ```bash
   sudo apt update && sudo apt install -y openjdk-17-jre-headless
   ```
3. Transfer `CloudDeploymentDemo-0.0.1-SNAPSHOT.jar` and launch in background:
   ```bash
   nohup java -jar CloudDeploymentDemo-0.0.1-SNAPSHOT.jar > app.log 2>&1 &
   ```

---

### STEP 3: Apply & Verify

Access the deployed microservice using the assigned **Public IP address** (for AWS EC2) or **Public URL** (for Render):

#### Test 1: Home Endpoint
- **URL:** `https://cloud-deployment-demo.onrender.com/` (or `http://<EC2_PUBLIC_IP>:8080/`)
- **Method:** `GET`
- **Output:**
  ```text
  Welcome to Cloud Deployment Demo!
  ```

#### Test 2: Health Check Endpoint
- **URL:** `https://cloud-deployment-demo.onrender.com/health` (or `http://<EC2_PUBLIC_IP>:8080/health`)
- **Method:** `GET`
- **Output:**
  ```text
  Application is running successfully!
  ```

#### Test 3: Student Information Endpoint
- **URL:** `https://cloud-deployment-demo.onrender.com/student` (or `http://<EC2_PUBLIC_IP>:8080/student`)
- **Method:** `GET`
- **Output (JSON):**
  ```json
  {
    "id": 101,
    "name": "John",
    "course": "Computer Science",
    "status": "Active"
  }
  ```

---

## 5. Result & Conclusion
The Spring Boot application **CloudDeploymentDemo** was successfully developed, containerized, provisioned, and deployed on cloud infrastructure (Render / AWS EC2). All three endpoints (`/`, `/health`, and `/student`) were tested and verified via web browser and cURL, confirming high availability and successful cloud deployment.

