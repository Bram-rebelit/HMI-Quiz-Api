
# Use the official .NET SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy everything and restore dependencies
COPY . .
RUN dotnet restore

# Build and publish the app
RUN dotnet publish -c Release -o /app/publish

# Use the official ASP.NET Core runtime image to run the app
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Set ASP.NET Core to listen on port 80 inside the container
ENV ASPNETCORE_URLS=http://+:80

# Copy published files from build stage
COPY --from=build /app/publish .

# Run the application
ENTRYPOINT ["dotnet", "HMI-Quiz Api.dll"]
