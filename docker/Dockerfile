# Build runtime image using the redhat UBI .NET image
FROM registry.access.redhat.com/ubi8/dotnet-50-runtime
WORKDIR /app
COPY .  /app
ENTRYPOINT ["dotnet", "app.dll"]