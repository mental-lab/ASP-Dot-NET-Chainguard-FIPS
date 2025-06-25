## Introduction

This is a simple ASP.NET Core application configured to run with Chainguard FIPS-compliant Docker images. It demonstrates how to run both an ASP.NET Core application and PostgreSQL database in a secure, containerized environment.

# Reference links

- [GitLab CI Documentation](https://docs.gitlab.com/ee/ci/)
- [.NET Hello World tutorial](https://dotnet.microsoft.com/learn/dotnet/hello-world-tutorial/)

If you're new to .NET you'll want to check out the tutorial, but if you're
already a seasoned developer considering building your own .NET app with GitLab,
this should all look very familiar.

## What's contained in this project

The root of the repository contains ASP.net MVC application with GitLab Tanuki logo and a form. 
It's a simple example, but great for demonstrating how easy GitLab CI is to
use with .NET. Check out the `Program.cs` and `dotnetcore.csproj` files to
see how these work.

In addition to the .NET Core content, there is a ready-to-go `Dockerfile` file
that will build a docker image for this app

Finally, the `.gitlab-ci.yml` contains the configuration needed for GitLab
to build your code. Let's take a look, section by section.

First, we note that we want to use the official Microsoft .NET SDK image
to build our project.

```
image: microsoft/dotnet:latest
```

We're defining two stages here: `build`, and `test`. As your project grows
in complexity you can add more of these.

```
stages:
    - build
    - test
```

Next, we define our build job which simply runs the `dotnet build` command and
identifies the `bin` folder as the output directory. Anything in the `bin` folder
will be automatically handed off to future stages, and is also downloadable through
the web UI.

```
build:
    stage: build
    script:
        - "dotnet build"
    artifacts:
      paths:
        - bin/
```

Similar to the build step, we get our test output simply by running `dotnet test`.

```
test:
    stage: test
    script: 
        - "dotnet test"
```

This should be enough to get you started. There are many, many powerful options 
for your `.gitlab-ci.yml`. You can read about them in our documentation 
[here](https://docs.gitlab.com/ee/ci/yaml/).

## Running with Chainguard FIPS-compliant Images

This project has been configured to run using Chainguard FIPS-compliant Docker images for both the ASP.NET Core application and PostgreSQL database.

### Prerequisites

- Docker and Docker Compose installed
- .NET SDK 8.0 or later (for local development)

### Running the Application

1. Build the application:
   ```bash
   dotnet publish -c Release -o ./publish
   ```

2. Start the containers:
   ```bash
   docker-compose up
   ```

3. Access the application at http://localhost:5000

### Configuration

The docker-compose.yml file is configured to:

- Use Chainguard FIPS-compliant images for ASP.NET Core and PostgreSQL
- Run containers as non-root users for enhanced security
- Set up a PostgreSQL database with proper health checks
- Mount the published application files into the container

### Security Features

- FIPS-compliant cryptographic modules via Chainguard images
- Non-root container execution
- Health checks to ensure services are ready
- Proper volume permissions
