# MODULO 4: Python y VSCode

## Requisitos de software

* python3: Lenguaje de programación
* vscode: IDE (entorno de desarrollo integrado)
* uv: Manejador de paquetes

## Crear entorno virtual e instalación de dependencias

Los entornos virtuales nos permiten aislar un proyecto python, para que no entre en conflicto con otras versiones instaladas en el mismo sistema operativo.

Existen muchas alternativas, pero usaremos uv por ser rápida y fácil de usar.

El comando para crear un nuevo entorno virtual es: `uv venv /path/to/venv`

```sh
# crear entorno virtual en el directorio actual, llamado .venv
uv venv .venv
```

En los sistemas Unix (Linux, Mac, ...), los archivos cuyo nombre comienza por un punto (.) se ocultan por defecto. Eso significa que no los puedes ver en el explorador de archivo o con un `ls` ó `ls -l`. Para poder verlos habría que decir: `ls -a`.

El nuevo entorno virtual debe ser activado para poder usarlo:
```sh
source .venv/bin/activate
```

Para desactivarlo usamos simplemente:
```sh
deactivate
```

En general, veremos las dependencias de un proyecto en archivos llamados: `requeriments.txt` o similar. Es simplemente un archivo en texto plano con la lista de paquetes que deben ser instalados y las versiones correctas.

Entre los manejadores de paquetes python se encuentra uno llamado pip, pero es lento y cada vez que lo llamas demora un rato en descargar todo desde cero. Por eso usaremos uv para instalar las dependencias usando:

```sh
# activar el entorno virtual si estuviera desactivado porque de lo contrario se instala en el sistema
source .venv/bin/activate

# instalar dependencias usando uv
uv pip install -r requirements.txt

```

## Jupyter Notebooks (archivos .ipynb)

Los notebooks son una forma de documentar y probar código python pensado para humanos. Incluye bloques de código que se pueden ejecutar y bloques de texto para los comentarios estáticos. Similar a lo que veíamos en R con los .Rmd

Hay alternativas nuevas que van ganando fuerza, pero esta es una de las variantes más difundidas y por eso la usaremos en el curso.

VSCode ya incluye plugins para trabajar con archivos .ipynb, y si estos no estuvieran instalados te recomendará hacerlo cuando abras uno.

En esta carpeta encontrarás un ejemplo didáctico: .ipynb

