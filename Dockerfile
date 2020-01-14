FROM microsoft/dotnet:sdk@sha256:d2f919654e100154e62cb2ccf023a6bfda5b8364b390c88101add859841c45fd AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM microsoft/dotnet:aspnetcore-runtime@sha256:3372d9791da05212be80f9f642c9dc5f098abf88889d32d196ceb81a36f23a3a
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "AspMVC.dll", "--urls", "http://*:5000"]
