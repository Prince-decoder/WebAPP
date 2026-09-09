

https://github.com/user-attachments/assets/7a99b581-176c-4164-8e14-569a0c07f65d


# 💼 WebApplication — Spring Boot Job Portal

A full-stack **Job Portal Web Application** built with **Spring Boot 4.1**, backed by **PostgreSQL**, and powered by **Google Gemini AI** for intelligent job discovery. Users can register, log in securely (via form login **or Google OAuth2**), post jobs, search listings, and use AI to find top hiring companies — all rendered via JSP views. The entire application is **containerized with Docker** for zero-friction deployment.

---

## 📋 Table of Contents

1. [Project Overview](#-project-overview)
2. [Tech Stack](#-tech-stack)
3. [Project Structure](#-project-structure)
4. [Application Entry Point](#-application-entry-point-webapplicationjava)
5. [DataModel (Entity Layer)](#-datamodel-entity-layer)
6. [Repository Layer](#-repository-layer)
7. [Service Layer](#-service-layer)
8. [Security](#-security)
9. [OAuth2 — Google Login](#-oauth2--google-login)
10. [ViewControl (MVC Controllers)](#-viewcontrol-mvc-controllers)
11. [Views (JSP Pages)](#-views-jsp-pages)
12. [Application Properties](#-application-properties)
13. [PostgreSQL Setup](#-postgresql-setup)
14. [JPA & Hibernate](#-jpa--hibernate)
15. [Lombok](#-lombok)
16. [Spring AI (Google Gemini)](#-spring-ai-google-gemini)
17. [Docker](#-docker)
18. [Running the Application](#-running-the-application)
19. [API Endpoints Reference](#-api-endpoints-reference)

---

## 🌐 Project Overview

This application is a **Job Portal** where:

- **Visitors** can register and log in — with a **username/password form** or via **"Sign in with Google"** (OAuth2).
- **Authenticated users** can post new job listings, browse all jobs, delete postings, and search by keyword.
- An **AI-powered job finder** (`/findjob`) uses Google Gemini to suggest the top 5 companies currently hiring for a given role.
- The entire stack (app + PostgreSQL) can be launched with a **single `docker compose up` command**.

The app follows a classic **Spring MVC layered architecture**:

```
Browser ──► ViewControl (Controller) ──► Service ──► Repository ──► PostgreSQL DB
                 │
                 ├──► Spring Security (Form Login / OAuth2 Google)
                 │
                 └──► Spring AI (Gemini) ──► AI Response
```

---

## 🛠 Tech Stack

| Technology               | Version      | Purpose                              |
|--------------------------|--------------|--------------------------------------|
| Java                     | 21           | Core language                        |
| Spring Boot              | 4.1.0        | Application framework                |
| Spring MVC               | (via Boot)   | Web layer / routing                  |
| Spring Security          | (via Boot)   | Authentication & authorization       |
| Spring OAuth2 Client     | (via Boot)   | Google OAuth2 / OpenID Connect login |
| Spring Data JPA          | 4.1.0        | ORM / database abstraction           |
| Hibernate ORM            | 7.4.0.Final  | JPA implementation                   |
| PostgreSQL               | 42.7.11      | Relational database                  |
| Spring AI (Google GenAI) | 2.0.0        | AI job recommendations via Gemini    |
| Lombok                   | (via Boot)   | Boilerplate code reduction           |
| Apache Tomcat (Embed)    | (via Boot)   | Embedded servlet container           |
| JSP + JSTL               | Jakarta      | Server-side HTML view rendering      |
| Docker & Docker Compose  | Latest       | Containerized deployment             |
| Maven                    | Wrapper      | Build & dependency management        |

---

## 📁 Project Structure

```
WebApplication/
│
├── src/
│   ├── main/
│   │   ├── java/com/ashu/WebApplication/
│   │   │   │
│   │   │   ├── WebApplication.java              # ← Entry point (@SpringBootApplication)
│   │   │   │
│   │   │   ├── DataModel/
│   │   │   │   └── JobPost.java                 # ← JPA Entity for job postings
│   │   │   │
│   │   │   ├── Repository/
│   │   │   │   └── UserRepository.java          # ← JPA Repository for JobPost
│   │   │   │
│   │   │   ├── Service/
│   │   │   │   └── UserService.java             # ← Business logic for jobs
│   │   │   │
│   │   │   ├── Security/
│   │   │   │   ├── Security_Config.java         # ← Spring Security + OAuth2 configuration
│   │   │   │   ├── Model/
│   │   │   │   │   ├── User.java                # ← User entity (authentication)
│   │   │   │   │   └── UserDetailImplementation.java  # ← UserDetails adapter
│   │   │   │   ├── Repository/
│   │   │   │   │   └── ClientRepository.java    # ← JPA Repository for User
│   │   │   │   └── Service/
│   │   │   │       └── UserDetailService.java   # ← UserDetailsService impl
│   │   │   │
│   │   │   └── ViewControl/
│   │   │       └── PageController.java          # ← MVC Controller (all routes)
│   │   │
│   │   ├── resources/
│   │   │   └── application.properties           # ← All configuration (incl. OAuth2)
│   │   │
│   │   └── webapp/
│   │       ├── style.css / style1.css           # ← Stylesheets
│   │       └── views/
│   │           ├── home.jsp
│   │           ├── addjob.jsp
│   │           ├── findjob.jsp
│   │           ├── viewalljobs.jsp
│   │           ├── searched.jsp
│   │           ├── success.jsp
│   │           └── Contact.jsp
│   │
│   └── test/                                    # ← Test sources
│
├── Dockerfile                                   # ← Docker image definition
├── docker-compose.yaml                          # ← Multi-container orchestration (app + DB)
├── .env                                         # ← Secret keys for Docker (not committed)
├── pom.xml                                      # ← Maven build configuration
└── README.md
```

---

## 🚀 Application Entry Point — `WebApplication.java`

```java
@SpringBootApplication(scanBasePackages = {
    "com.ashu.WebApplication",
    "com.ashu.WebApplication.ViewControl",
    "com.ashu.WebApplication.DataModel"
})
public class WebApplication {
    public static void main(String[] args) {
        SpringApplication.run(WebApplication.class, args);
    }
}
```

**What it does:**
- `@SpringBootApplication` is a meta-annotation that combines:
  - `@Configuration` — marks the class as a source of bean definitions.
  - `@EnableAutoConfiguration` — lets Spring Boot automatically configure beans based on classpath.
  - `@ComponentScan` — scans the listed packages for Spring-managed components.
- `scanBasePackages` explicitly tells Spring to scan three packages, ensuring all `@Controller`, `@Service`, `@Repository`, and `@Component` classes are discovered.
- `SpringApplication.run(...)` bootstraps the embedded Tomcat server, sets up the Spring application context, and starts the application.

---

## 🗂 DataModel (Entity Layer)

### `DataModel/JobPost.java`

```java
@Data
@NoArgsConstructor
@AllArgsConstructor
@Component
@Entity
public class JobPost {
    @Id
    private int postId;
    private String postProfile;
    private String postDesc;
    private int reqExperience;
    private List<String> postTechStack;
}
```

**What it does:**
- `@Entity` — marks this class as a JPA-managed table. Hibernate automatically maps it to a `job_post` table in PostgreSQL.
- `@Id` — designates `postId` as the primary key of the table.
- `postProfile` — the job title / role name (e.g., "Java Developer").
- `postDesc` — a short description of what the role requires.
- `reqExperience` — minimum years of experience required (stored as an integer).
- `postTechStack` — a `List<String>` of relevant technologies. Hibernate stores this as a separate element collection table by default.
- Lombok annotations auto-generate getters, setters, constructors, `equals`, `hashCode`, and `toString` at compile time — see the [Lombok section](#-lombok).

---

## 🗃 Repository Layer

### `Repository/UserRepository.java`

```java
@Repository
public interface UserRepository extends JpaRepository<JobPost, Integer> {
    List<JobPost> findByPostProfileContainingOrPostDescContaining(String key, String keyd);
}
```

**What it does:**
- Extends `JpaRepository<JobPost, Integer>` — inherits a full suite of CRUD operations (`save`, `findAll`, `findById`, `delete`, etc.) with **zero boilerplate SQL**.
- `findByPostProfileContainingOrPostDescContaining` is a **derived query method**. Spring Data JPA reads the method name and automatically generates SQL at runtime:
  ```sql
  SELECT * FROM job_post
  WHERE post_profile LIKE '%key%'
     OR post_desc    LIKE '%keyd%';
  ```
- `@Repository` registers the interface as a Spring bean and enables exception translation.

### `Security/Repository/ClientRepository.java`

```java
@Repository
public interface ClientRepository extends JpaRepository<User, Integer> {
    User findByUsername(String username);
}
```

**What it does:**
- Manages `User` entities (the authentication table).
- `findByUsername(String username)` — derived query that fetches a user by username during login.

---

## ⚙️ Service Layer

### `Service/UserService.java`

```java
@Service
public class UserService {
    @Autowired
    private UserRepository ur;

    public void addJob(JobPost p)       { ur.save(p); }
    public List<JobPost> getAlljobs()   { return ur.findAll(); }
    public void delete(JobPost jobPost) { ur.delete(jobPost); }
    public List<JobPost> jobsearch(String keyword) {
        return ur.findByPostProfileContainingOrPostDescContaining(keyword, keyword);
    }
    public void load() { ur.saveAll(/* predefined sample jobs */); }
}
```

**What it does:**
- `@Service` — Spring-managed service bean that sits between the controller and repository layers.
- Acts as the **business logic layer** — all controller interactions with the database go through here, keeping controllers thin.
- `addJob(JobPost)` — persists a new job posting via `ur.save(...)`.
- `getAlljobs()` — fetches every job record from the `job_post` table.
- `delete(JobPost)` — removes a specific job record.
- `jobsearch(String keyword)` — delegates to the repository's derived query for keyword search.
- `load()` — bulk-inserts 5 sample job postings for quick demo/testing via `/load` endpoint.

---

## 🔐 Security

The security system is composed of four classes that work together to authenticate users against the database, plus **Google OAuth2** for social login.

### `Security/Security_Config.java`

```java
@Configuration
@EnableWebSecurity
public class Security_Config {

    @Bean
    public AuthenticationProvider authProvider() {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider(userDetailsService);
        provider.setPasswordEncoder(new BCryptPasswordEncoder(12));
        return provider;
    }

    @Bean
    public SecurityFilterChain setFilterChain(HttpSecurity httpSecurity) throws Exception {
        httpSecurity
            .csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(request -> request
                .requestMatchers("/register", "/login", "/goLogin", "/error", "/views/**").permitAll()
                .anyRequest().authenticated())
            .oauth2Login(oauth2 -> oauth2
                .loginPage("/login")
                .defaultSuccessUrl("/home", true)
            )
            .formLogin(form -> form
                .loginPage("/login")
                .loginProcessingUrl("/login")
                .defaultSuccessUrl("/home", true)
                .failureUrl("/login?error")
                .permitAll()
            );
        return httpSecurity.build();
    }
}
```

**What it does:**
- `@EnableWebSecurity` — activates Spring Security's web security support.
- **`AuthenticationProvider` bean** — configures `DaoAuthenticationProvider`:
  - Wires in our custom `UserDetailsService` to load users from PostgreSQL.
  - Uses `BCryptPasswordEncoder` with strength **12** (2¹² = 4096 hashing rounds).
- **`SecurityFilterChain` bean** — defines HTTP security rules:
  - `/register`, `/login`, `/goLogin`, `/error`, `/views/**` — publicly accessible (no login required).
  - `anyRequest().authenticated()` — every other URL requires login.
  - **`oauth2Login(...)`** — enables Google OAuth2 login, pointing to the custom `/login` page and redirecting to `/home` on success.
  - **`formLogin(...)`** — enables the custom form-based login at `/login` with a redirect to `/home` on success and `/login?error` on failure.

### `Security/Model/User.java`

```java
@Data @Entity @NoArgsConstructor @AllArgsConstructor
@Table(name = "Users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "name")
    private String username;
    private String password;
}
```

**What it does:**
- JPA entity mapped to the `Users` table (`@Table` avoids the reserved keyword `user` in PostgreSQL).
- `@GeneratedValue(IDENTITY)` — auto-increments `id` in the database.
- Stores the BCrypt-hashed password; plain-text is **never** persisted.

### `Security/Model/UserDetailImplementation.java`

```java
public class UserDetailImplementation implements UserDetails {
    User user;
    public Collection<? extends GrantedAuthority> getAuthorities() { return List.of(); }
    public String getPassword() { return user.getPassword(); }
    public String getUsername() { return user.getUsername(); }
}
```

**What it does:**
- Implements `UserDetails` — the contract Spring Security uses during authentication.
- Acts as an **adapter** wrapping our `User` JPA entity in a form Spring Security understands.

### `Security/Service/UserDetailService.java`

```java
@Service
public class UserDetailService implements UserDetailsService {

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = clientRepository.findByUsername(username);
        if (user == null) throw new UsernameNotFoundException(username);
        return new UserDetailImplementation(user);
    }

    public void saveUser(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        clientRepository.save(user);
    }
}
```

**What it does:**
- Implements `UserDetailsService` — called by Spring Security during form login to look up a user.
- `loadUserByUsername` — queries the DB; throws `UsernameNotFoundException` if not found.
- `saveUser` — encodes the plain-text password with BCrypt **before** persisting.

---

## 🔑 OAuth2 — Google Login

The application supports **"Sign in with Google"** via Spring Security's OAuth2 Client integration. Users can authenticate with their Google account without needing to register manually.

### How it works

```
User clicks "Sign in with Google"
         ↓
Spring Security redirects to Google's OAuth2 Authorization endpoint
         ↓
User grants permission on Google's consent screen
         ↓
Google redirects back with an authorization code
         ↓
Spring Security exchanges the code for an access token + ID token (OpenID Connect)
         ↓
User is authenticated and redirected to /home
```

### Dependency

Added to `pom.xml`:

```xml
<!-- OAuth2 Login -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-oauth2-client</artifactId>
</dependency>
```

### Configuration in `application.properties`

```properties
# Google OAuth2 credentials (loaded from .env in Docker, or ~/keys.properties locally)
spring.security.oauth2.client.registration.google.client-id=${GOOGLE_OAUTH_CLIENT_ID}
spring.security.oauth2.client.registration.google.client-secret=${GOOGLE_OAUTH_CLIENT_SECRET}
```

Spring Boot's auto-configuration picks up `google` as a well-known provider and automatically configures the authorization URI, token URI, and user-info endpoint — **no extra provider configuration is needed**.

### Security Config

`oauth2Login(...)` is chained in the `SecurityFilterChain`:

```java
.oauth2Login(oauth2 -> oauth2
    .loginPage("/login")               // use our custom login page
    .defaultSuccessUrl("/home", true)  // redirect to /home after Google login
)
```

### Setting Up Google OAuth2 Credentials

1. Go to [Google Cloud Console](https://console.cloud.google.com/) → **APIs & Services → Credentials**.
2. Create an **OAuth 2.0 Client ID** (Application type: **Web application**).
3. Add an **Authorized Redirect URI**:
   - Local: `http://localhost:8080/login/oauth2/code/google`
   - Docker: `http://localhost:8090/login/oauth2/code/google`
4. Copy the **Client ID** and **Client Secret** into your `.env` file (Docker) or `~/keys.properties` (local).

### Environment Variables

| Variable                     | Description                              |
|------------------------------|------------------------------------------|
| `GOOGLE_OAUTH_CLIENT_ID`     | OAuth2 Client ID from Google Console     |
| `GOOGLE_OAUTH_CLIENT_SECRET` | OAuth2 Client Secret from Google Console |

---

## 🖥 ViewControl (MVC Controllers)

### `ViewControl/PageController.java`

The single controller that handles **all HTTP routes** in the application.

**Route Handlers:**

| Method   | URL                            | Description                                           |
|----------|--------------------------------|-------------------------------------------------------|
| `GET`    | `/` or `/home`                 | Renders `home.jsp`                                    |
| `GET`    | `/addjob`                      | Renders the add job form (`addjob.jsp`)               |
| `POST`   | `/handleForm`                  | Saves a new job and redirects to `success.jsp`        |
| `GET`    | `/viewalljobs`                 | Fetches all jobs and renders list view                |
| `POST`   | `/viewalljobs`                 | Deletes a job post and redirects to the list          |
| `GET`    | `/jobPosts/Keyword/{keyword}`  | Keyword search, renders `searched.jsp`                |
| `GET`    | `/load`                        | Bulk-loads sample jobs, redirects to job list         |
| `GET`    | `/findjob` _(no params)_       | Renders the AI job finder page (`findjob.jsp`)        |
| `GET`    | `/findjob?type=...`            | Calls Gemini AI and returns `List<JobPost>` as JSON   |
| `POST`   | `/register`                    | Registers a new user and redirects home               |
| `GET`    | `/contact`                     | Renders `Contact.jsp`                                 |

> **AI Endpoint:** `GET /findjob?type=<role>` uses `BeanOutputConverter` to instruct Gemini to return structured JSON. Spring AI handles the prompt templating, API call, and JSON-to-bean conversion automatically.

---

## 🌐 Views (JSP Pages)

Located at `src/main/webapp/views/`. Spring MVC resolves view names using prefix `/views/` and suffix `.jsp`.

| File               | Purpose                                                            |
|--------------------|--------------------------------------------------------------------|
| `home.jsp`         | Landing page — navigation hub for the portal                       |
| `addjob.jsp`       | Form to submit a new job posting                                   |
| `findjob.jsp`      | AI-powered job finder — sends requests to `/findjob?type=...`      |
| `viewalljobs.jsp`  | Displays all job postings with a delete option                     |
| `searched.jsp`     | Shows keyword search results                                       |
| `success.jsp`      | Confirmation page shown after a job is successfully posted         |
| `Contact.jsp`      | Contact information page                                           |

---

## ⚙️ Application Properties

**File:** `src/main/resources/application.properties`

```properties
# Application name
spring.application.name=WebApplication

# Import sensitive keys from an external file (keeps secrets out of source control)
spring.config.import=optional:file:${user.home}/keys.properties

# JSP View Resolver — maps view names to actual .jsp files
spring.mvc.view.prefix=/views/
spring.mvc.view.suffix=.jsp

# Google Gemini AI (Spring AI)
spring.ai.google.genai.api-key=${GOOGLE_GENAI_API_KEY}
spring.ai.google.genai.chat.options.model=gemini-flash-latest
spring.ai.google.genai.embedding.enabled=true
spring.ai.google.genai.embedding.options.model=text-embedding-004
spring.ai.google.genai.project-id=dummy-project
spring.ai.google.genai.embedding.api-key=${spring.ai.google.genai.api-key}

# PostgreSQL Datasource (uses 'postgres' hostname inside Docker network)
spring.datasource.url=jdbc:postgresql://postgres:5432/Jobs
spring.datasource.username=ashu
spring.datasource.password=ashu@123
spring.datasource.driver-class-name=org.postgresql.Driver

# Google OAuth2 credentials
spring.security.oauth2.client.registration.google.client-id=${GOOGLE_OAUTH_CLIENT_ID}
spring.security.oauth2.client.registration.google.client-secret=${GOOGLE_OAUTH_CLIENT_SECRET}

# JPA / Hibernate
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
```

**Key Properties Explained:**

| Property | Explanation |
|---|---|
| `spring.config.import` | Loads `~/keys.properties` for secrets. `optional:` means the app won't fail if it doesn't exist. |
| `spring.mvc.view.prefix/suffix` | Tells MVC to resolve view names like `"home"` → `/views/home.jsp`. |
| `spring.ai.google.genai.api-key` | References `GOOGLE_GENAI_API_KEY` from env variable or `keys.properties`. |
| `spring.datasource.url` | Uses the `postgres` Docker service hostname inside the shared Docker network. For local dev, change `postgres` to `localhost`. |
| `spring.security.oauth2.client.registration.google.*` | Wires in Google OAuth2 credentials for social login. Spring Boot auto-configures Google as a provider. |
| `spring.jpa.hibernate.ddl-auto=update` | Hibernate auto-creates/updates DB tables to match entities on startup. **Avoid in production.** |
| `spring.jpa.show-sql=true` | Prints every generated SQL statement to the console — useful for debugging. |

---

## 🐘 PostgreSQL Setup

Hibernate's `ddl-auto=update` **automatically creates the required tables** on first run.

**Prerequisites:** PostgreSQL installed and running on `localhost:5432`.

**Quick Setup:**
```sql
-- Connect to PostgreSQL as superuser
psql -U postgres

-- Create the database
CREATE DATABASE "Jobs";
```

**Tables created automatically by Hibernate:**

| Table                        | Managed By         | Description                           |
|------------------------------|--------------------|---------------------------------------|
| `job_post`                   | `JobPost` entity   | Stores all job postings               |
| `job_post_post_tech_stack`   | JPA collection     | Stores the tech stack list items      |
| `users`                      | `User` entity      | Stores registered user credentials    |

> **Note:** When running with Docker Compose, PostgreSQL is provisioned automatically — no manual `CREATE DATABASE` step is needed. The `POSTGRES_DB: Jobs` environment variable in `docker-compose.yaml` handles this.

---

## 🗄 JPA & Hibernate

**Spring Data JPA** sits on top of **Hibernate ORM** and provides a high-level abstraction for database access.

### How it works in this project:

```
Your Code (Repository Interface)
         ↓
Spring Data JPA (generates implementations at runtime)
         ↓
Hibernate ORM (translates objects ↔ SQL)
         ↓
JDBC Driver (org.postgresql.Driver)
         ↓
PostgreSQL Database
```

### Key Concepts Used:

| Concept | Where Used | What It Does |
|---|---|---|
| `@Entity` | `JobPost`, `User` | Marks a class as a database table |
| `@Id` | `JobPost.postId`, `User.id` | Designates the primary key column |
| `@GeneratedValue` | `User.id` | Auto-increments the ID in the DB |
| `@Table(name=...)` | `User` | Maps to a specific table name |
| `@Column(name=...)` | `User.username` | Maps a field to a specific column name |
| `JpaRepository` | Both repositories | Provides CRUD + derived query methods |
| Derived Queries | `findByPostProfileContaining...` | Auto-generates SQL from method name |
| `ddl-auto=update` | `application.properties` | Syncs schema with entities on startup |

---

## 🔧 Lombok

Lombok is an annotation processor that **generates boilerplate Java code at compile time**.

### Annotations Used:

| Annotation | What It Generates | Used In |
|---|---|---|
| `@Data` | Getters, setters, `equals()`, `hashCode()`, `toString()` | `JobPost`, `User` |
| `@NoArgsConstructor` | No-argument constructor — `new JobPost()` | `JobPost`, `User` |
| `@AllArgsConstructor` | Constructor with all fields as parameters | `JobPost`, `User` |

Lombok is declared as an `annotationProcessorPath` in the `maven-compiler-plugin` and excluded from the final packaged WAR (not needed at runtime). Without Lombok, each model class would require ~60 extra lines of boilerplate.

---

## 🤖 Spring AI (Google Gemini)

The project uses **Spring AI** (`spring-ai-starter-model-google-genai` v2.0.0) to integrate Google's **Gemini Flash** model for AI-powered job recommendations.

### How it's used in `PageController.java`:

```java
// 1. Build a ChatClient from the auto-configured ChatModel
private ChatClient chatClient;
public PageController(ChatModel model) {
    this.chatClient = ChatClient.create(model);
}

// 2. AI endpoint handler
@GetMapping(value = "/findjob", params = "type")
@ResponseBody
public List<JobPost> getJobs(@RequestParam String type) {
    // 3. Output converter that maps AI JSON response → List<JobPost>
    BeanOutputConverter<List<JobPost>> BC =
        new BeanOutputConverter<>(new ParameterizedTypeReference<List<JobPost>>() {});

    // 4. Build prompt with role type and format instructions
    String prompt = "find top 5 companies that are currently recruiting {type}\n{format}";
    Prompt prompt1 = new PromptTemplate(prompt)
        .create(Map.of("type", type, "format", BC.getFormat()));

    // 5. Call Gemini and convert response to Java objects
    return BC.convert(chatClient.prompt(prompt1).call().content());
}
```

**Flow:**
1. User visits `/findjob` and types a job role (e.g., "Data Scientist").
2. Frontend calls `/findjob?type=Data+Scientist`.
3. Spring AI formats a structured prompt asking Gemini for top 5 companies.
4. `BeanOutputConverter` appends JSON schema instructions so Gemini returns valid JSON.
5. The JSON is parsed back into `List<JobPost>` and returned to the browser.

> **Setup:** Set `GOOGLE_GENAI_API_KEY` as an environment variable or in `~/keys.properties`:
> ```properties
> GOOGLE_GENAI_API_KEY=your_api_key_here
> ```

---

## 🐳 Docker

The application is fully containerized. A single `docker compose up` command spins up both the **Spring Boot app** and **PostgreSQL** in isolated containers connected via a private network.

### Files

#### `Dockerfile`

```dockerfile
FROM openjdk:28-ea-trixie

WORKDIR /app

# Copy the executable WAR file
COPY target/MyJobPortal.war jobPortal.war

ENTRYPOINT ["java", "-jar", "/app/jobPortal.war"]
```

| Instruction | Purpose |
|---|---|
| `FROM openjdk:28-ea-trixie` | Base image with Java 28 early-access build on Debian Trixie |
| `WORKDIR /app` | Sets `/app` as the working directory inside the container |
| `COPY target/MyJobPortal.war jobPortal.war` | Copies the built WAR artifact into the container |
| `ENTRYPOINT [...]` | Runs the Spring Boot application on container start |

> **Note:** You must run `./mvnw package -DskipTests` to produce `target/MyJobPortal.war` before building the Docker image.

#### `docker-compose.yaml`

```yaml
services:
  app:
    container_name: job-app
    build: .
    ports:
      - "8090:8080"
    env_file:
      - .env
    networks:
      - my-net

  postgres:
    image: postgres:latest
    container_name: shop-postgres
    environment:
      POSTGRES_DB: Jobs
      POSTGRES_USER: ashu
      POSTGRES_PASSWORD: ashu@123
    ports:
      - "5433:5432"
    networks:
      - my-net

networks:
  my-net:
    driver: bridge
```

| Setting | Details |
|---|---|
| `app.build: .` | Builds the image from the local `Dockerfile` |
| `app.ports: 8090:8080` | Maps host port **8090** → container port **8080** (Tomcat) |
| `app.env_file: .env` | Injects all secrets from `.env` into the container's environment |
| `postgres.image` | Uses the official latest PostgreSQL image |
| `POSTGRES_DB: Jobs` | Auto-creates the `Jobs` database on first start |
| `POSTGRES_USER/PASSWORD` | Match the credentials in `application.properties` |
| `postgres.ports: 5433:5432` | Exposes PostgreSQL on host port **5433** for local DB tools |
| `my-net` (bridge network) | Both containers share this network so the app reaches `postgres` by hostname |

#### `.env` (not committed to source control)

```properties
# Docker environment variables — fill in your real values
GOOGLE_GENAI_API_KEY=your_gemini_api_key
GOOGLE_OAUTH_CLIENT_ID=your_google_oauth_client_id
GOOGLE_OAUTH_CLIENT_SECRET=your_google_oauth_client_secret
```

The `app` service loads this file via `env_file: - .env`, making all variables available as environment variables inside the container — where `application.properties` picks them up via `${VAR_NAME}` placeholders.

### Container Architecture

```
Host Machine
├── localhost:8090  ──►  job-app container (Spring Boot :8080)
│                              │
│                              └── my-net (bridge network)
│                                      │
└── localhost:5433  ──►  shop-postgres container (PostgreSQL :5432)
                               └── Database: Jobs
```

### Docker Workflow

```bash
# 1. Build the WAR artifact
./mvnw package -DskipTests

# 2. Build the Docker image and start all services
docker compose up --build

# 3. Access the application
open http://localhost:8090

# 4. Stop all services
docker compose down
```

> **Tip:** After the first build, use `docker compose up` (without `--build`) for faster restarts if the source code has not changed.

---

## ▶️ Running the Application

### Option A — Local (without Docker)

**Prerequisites:**
- Java 21+
- Maven (or use the included `./mvnw` wrapper)
- PostgreSQL running with a `Jobs` database
- Google Gemini API key + Google OAuth2 credentials

**Steps:**

**1. Clone the repository:**
```bash
git clone <your-repo-url>
cd WebApplication
```

**2. Add your credentials to `~/keys.properties`:**
```properties
GOOGLE_GENAI_API_KEY=your_gemini_api_key_here
GOOGLE_OAUTH_CLIENT_ID=your_google_client_id_here
GOOGLE_OAUTH_CLIENT_SECRET=your_google_client_secret_here
```

**3. Update the datasource URL for local PostgreSQL:**

In `application.properties`, change `postgres` to `localhost`:
```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/Jobs
```

**4. Create the PostgreSQL database:**
```sql
CREATE DATABASE "Jobs";
```

**5. Run the application:**
```bash
./mvnw spring-boot:run
```

**6. Open in browser:**
```
http://localhost:8080
```

---

### Option B — Docker Compose (recommended)

**Prerequisites:**
- Docker & Docker Compose installed
- Google Gemini API key + Google OAuth2 credentials

**Steps:**

**1. Clone the repository:**
```bash
git clone <your-repo-url>
cd WebApplication
```

**2. Create the `.env` file in the project root:**
```properties
GOOGLE_GENAI_API_KEY=your_gemini_api_key_here
GOOGLE_OAUTH_CLIENT_ID=your_google_client_id_here
GOOGLE_OAUTH_CLIENT_SECRET=your_google_client_secret_here
```

**3. Build the WAR and start all containers:**
```bash
./mvnw package -DskipTests
docker compose up --build
```

**4. Open in browser:**
```
http://localhost:8090
```

**5. (Optional) Load sample jobs:**
```
http://localhost:8090/load
```

---

## 📡 API Endpoints Reference

| Method | URL | Auth Required | Description |
|--------|-----|---------------|-------------|
| `GET`  | `/` or `/home` | No | Landing page |
| `POST` | `/register` | No | Register new user |
| `GET`  | `/login` | No | Login page (form + Google OAuth2 button) |
| `GET`  | `/addjob` | Yes | Show add job form |
| `POST` | `/handleForm` | Yes | Submit new job posting |
| `GET`  | `/viewalljobs` | Yes | View all job listings |
| `POST` | `/viewalljobs` | Yes | Delete a job posting |
| `GET`  | `/jobPosts/Keyword/{keyword}` | Yes | Search jobs by keyword |
| `GET`  | `/load` | Yes | Bulk-load sample jobs |
| `GET`  | `/findjob` | Yes | AI-powered job finder page |
| `GET`  | `/findjob?type={role}` | Yes | Returns AI job results as JSON |
| `GET`  | `/contact` | Yes | Contact page |

---

## 📌 Production Readiness Checklist

> ⚠️ The following are development-only settings. Change before going to production:

- [ ] Move `spring.datasource.password` and all secrets to a secrets manager (e.g., AWS Secrets Manager, HashiCorp Vault).
- [ ] Change `ddl-auto` from `update` to `validate`; use **Flyway** or **Liquibase** for migrations.
- [ ] Set `spring.jpa.show-sql=false` in production.
- [ ] Re-enable CSRF protection in `Security_Config.java`.
- [ ] Implement role-based access control by populating `getAuthorities()` in `UserDetailImplementation`.
- [ ] Add a Docker health check for the `postgres` service and a `depends_on: condition: service_healthy` for the `app` service to prevent startup race conditions.
- [ ] Use a fixed PostgreSQL image tag (e.g., `postgres:16`) instead of `postgres:latest` for reproducibility.
- [ ] Use HTTPS in production; configure a reverse proxy (e.g., Nginx) in front of the Docker container.
- [ ] Add the production redirect URI to your Google OAuth2 client in Google Cloud Console.

---

*Built with Spring Boot, PostgreSQL, Google Gemini AI, Spring OAuth2, and Docker.*
