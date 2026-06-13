# Futsal IQ

MVP iOS en SwiftUI para jugadores de futsal. Incluye onboarding local, seguimiento semanal, tips personalizados, biblioteca de aprendizaje y tablero táctico.

## Tecnología

- SwiftUI
- iOS 16 o superior
- Datos locales con `@AppStorage`
- Sin backend ni dependencias externas

## Estructura

- `FutsalIQ/App`: entrada y navegación principal
- `FutsalIQ/Features`: pantallas por funcionalidad
- `FutsalIQ/Components`: componentes visuales reutilizables
- `FutsalIQ/Models`: modelos y opciones
- `FutsalIQ/Data`: contenido local
- `FutsalIQ/Theme`: tema y claves de almacenamiento

## Compilar en Codemagic

1. Subir este proyecto completo a un repositorio de GitHub.
2. En Codemagic, elegir **Add application** y conectar el repositorio.
3. Seleccionar **Codemagic YAML** como tipo de configuración.
4. Iniciar el workflow `Futsal IQ - iOS Simulator`.

El workflow compila para el simulador sin firma y entrega un archivo `.app` como artefacto. Para publicar en TestFlight/App Store será necesario configurar Apple Developer, App Store Connect y firma automática en Codemagic.

## Subir a GitHub desde Windows

El conector de GitHub debe tener acceso al repositorio para poder operarlo desde herramientas externas. Si el repositorio ya existe, la ruta más directa es instalar Git para Windows y asociar esta carpeta:

```bash
git init
git add .
git commit -m "Initial Futsal IQ MVP"
git branch -M main
git remote add origin https://github.com/TU-USUARIO/futsal-IQ.git
git push -u origin main
```

Reemplazar la URL por la URL exacta del repositorio creado. Si el repositorio remoto contiene un README u otro commit inicial, conviene clonarlo primero y mover estos archivos dentro de esa copia antes de hacer `git add .`.

Alternativa sin terminal:

1. Instalar GitHub Desktop e iniciar sesión.
2. Clonar el repositorio vacío `futsal IQ`.
3. Mover todo el contenido de esta carpeta dentro de la carpeta clonada.
4. Confirmar que aparecen los 22 archivos del proyecto.
5. Crear el commit `Initial Futsal IQ MVP` y presionar **Push origin**.
