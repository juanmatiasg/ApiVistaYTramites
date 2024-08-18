# Usa una imagen base de .NET SDK
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Establece el directorio de trabajo
WORKDIR /app

# Copia la solución y los archivos de proyecto
COPY EstadoDeVistasYTramites.sln ./
COPY EstadoDeVistasYTramitesAPI/EstadoDeVistasYTramitesAPI.csproj EstadoDeVistasYTramitesAPI/
COPY EstadoDeVistasYTramites.Model/EstadoDeVistasYTramites.Model.csproj EstadoDeVistasYTramites.Model/
COPY TramiteVista.Service/TramiteVista.Service.csproj TramiteVista.Service/

# Restaura las dependencias
RUN dotnet restore

# Copia el resto de los archivos y compila la aplicación
COPY . .
RUN dotnet publish -c Release -o out

# Usa una imagen base de .NET Runtime para ejecutar la aplicación
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos publicados desde la etapa de construcción
COPY --from=build /app/out .

# Expone el puerto en el que la aplicación escuchará
EXPOSE 80

# Ejecuta la aplicación
ENTRYPOINT ["dotnet", "EstadoDeVistasYTramitesAPI.dll"]
