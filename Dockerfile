# Get image from microsoft
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env
WORKDIR /app 

# Copy csproj and restore as distinct layers
COPY *.csproj .
RUN dotnet restore

# copy and publish app and libraries
COPY . .
RUN dotnet publish -c release -o /app --no-restore

# final stage/image using the redhat UBI .NET image
FROM registry.access.redhat.com/ubi8/dotnet-50-runtime
WORKDIR /app
COPY --from=build-env /app .
ENTRYPOINT ["dotnet", "dotnetapp.dll"]

LABEL maintainer="froberge@redhat.com"