# Get image from microsoft
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /app 

# Copy csproj and restore as distinct layers
COPY *.csproj .
RUN dotnet restore

# Copy and publish the apps 
COPY . .
RUN dotnet publish -c release -o /app --no-restore

# Build runtime image using the redhat UBI .NET image
FROM registry.access.redhat.com/ubi8/dotnet-50-runtime
WORKDIR /app
COPY --from=build /app  /app
ENTRYPOINT ["dotnet", "app.dll"]

LABEL maintainer="froberge@redhat.com"