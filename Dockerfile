# Usa una imagen base de .NET SDK
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia todo el contenido del proyecto al contenedor
COPY . .



# Compila y publica la aplicación
RUN dotnet publish EstadoDeVistasYTramites.sln -c Release -o out

# Usa una imagen base de .NET Runtime para ejecutar la aplicación
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia los archivos publicados desde la etapa de construcción
COPY --from=build /app/out .

# Expone el puerto en el que la aplicación escuchará
EXPOSE 80

# Define el punto de entrada para ejecutar la aplicación
ENTRYPOINT ["dotnet", "EstadoDeVistasYTramites.API.dll"]
