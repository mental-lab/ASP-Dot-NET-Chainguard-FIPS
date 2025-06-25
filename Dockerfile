# Build stage
FROM cgr.dev/chainguard-private/dotnet-sdk-fips:8-dev AS build
WORKDIR /src

# Copy csproj and restore as distinct layers
COPY ["AspMVC.csproj", "./"]
RUN dotnet restore "AspMVC.csproj"

# Copy everything else and build
COPY . .
RUN dotnet publish "AspMVC.csproj" -c Release -o /app/publish

# Runtime stage
FROM cgr.dev/chainguard-private/aspnet-runtime-fips:8-dev
WORKDIR /app

# Copy the published app from the build stage
COPY --from=build /app/publish .

# Set the entry point
ENTRYPOINT ["/usr/bin/dotnet", "AspMVC.dll"]
