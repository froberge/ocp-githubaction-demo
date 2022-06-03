# # Get image from microsoft
# FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env
# WORKDIR /source

# # Copy csproj and restore as distinct layers
# COPY *.csproj ./
# RUN dotnet restore

# # copy and publish app and libraries
# COPY . .
# RUN dotnet publish -c release -o out --no-restore

# # final stage/image using the redhat UBI .NET image
# FROM registry.access.redhat.com/ubi8/dotnet-50-runtime
# WORKDIR /app
# COPY --from=build-env /app/out .
# ENTRYPOINT ["dotnet", "dotnetapp.dll"]

# LABEL maintainer="froberge@redhat.com"


FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM registry.access.redhat.com/ubi8/dotnet-60-runtime
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "webapp.dll"]