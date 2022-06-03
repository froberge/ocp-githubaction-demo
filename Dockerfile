# Get image from microsoft
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env
WORKDIR /app 

# # Copy csproj and restore as distinct layers
# COPY *.csproj .
# RUN dotnet restore

# Copy eveything
COPY . ./
# Restore as distinct layers
RUN dotnet restore

# build and publish a release 
COPY . .
RUN dotnet publish -c Release -o out

# Build runtime image using the redhat UBI .NET image
FROM registry.access.redhat.com/ubi8/dotnet-50-runtime
WORKDIR /app
COPY --from=build-env /app/out  .
#ENTRYPOINT ["dotnet", "app.dll"]
ENTRYPOINT ["dotnet", "DotNet.Docker.dll"]
LABEL maintainer="froberge@redhat.com"