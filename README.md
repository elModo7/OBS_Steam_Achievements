# OBS_Steam_Achievements
Show custom Steam Achievements on your Live Stream

Muestra Logros de Steam Personalizables para tus directos.


|*Configurables*|

Parámetros configurables desde el menú de Configuración:
- Intervalo entre Logros
- Retardo del Texto "Descripción"
- Texto a Voz
- Idioma/Tipo de Voz


|*Guía de uso*|

#1: Las imágenes van en la carpeta "res"
#2: En el archivo "Logros.conf" guardamos los datos:

▼ Logros.conf ▼ [Ejemplo de contenidos #1]

Titulo1|Titulo2|Titulo3
Descripción1|Descripción2|Descripción3
.\res\1.png|.\res\2.png|.\res\3.jpg

El archivo tiene 3 líneas, cada una guarda información de ("Titulo", "Descripción", "RutaImagen")
Cada sección de logro se delimita con el símbolo "|", ejemplo: 
▼ Logros.conf ▼ [Ejemplo de contenidos #2]

TituloA|TituloB
DescriA|DescriB
.\res\imagenA.png|.\res\imagenB.png


|*Texto A Voz*|

Dependiendo de tu sistema Operativo y/o tus idiomas instalados, puedes hacer que los logros que lean nada más aparecer con la voz de Loquendo o similar.
