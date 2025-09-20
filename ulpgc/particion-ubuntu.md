# Crear una partición para Ubuntu

En Kaizten Analytics trabajamos con Ubuntu como sistema operativo. Este sistema operativo es conocido por su estabilidad, seguridad y flexibilidad, lo que lo hace ideal para entornos de desarrollo y análisis.

Por ello, si necesitas usar Ubuntu para tus prácticas y tienes Windows en tu equipo, una buena opción es instalarlo junto con Windows en el mismo equipo. Esto se llama *dual-boot*. De esta forma al arrancar el ordenador podrás elegir si quieres usar Windows o Ubuntu.

> **Warning**: A partir de este punto, necesitarás un USB disponible para crear un medio de arranque. Asegúrate de tener uno a mano antes de continuar.

**Pasos a realizar:**

1. Hacer copia de seguridad. 

   Antes de empezar, haz una copia de seguridad de todos tus datos importantes de Windows. Las particiones pueden moverse/cambiar y siempre existe riesgo de error.

2. Desactivar temporalmente BitLocker / cifrado (si aplica)

   Si tu Windows usa BitLocker o algún cifrado del disco, conviene desactivarlo temporalmente para evitar problemas durante la instalación.
   
3. Liberar espacio en Windows

   * En Windows, abre “Administración de discos” (Disk Management).
   * Selecciona la partición principal (habitualmente C:).
   * Usa la opción “Disminuir volumen” (“Shrink Volume”) para reducirla, dejando un espacio libre (unallocated) donde colocarás Ubuntu. Al menos 60-80 GB es recomendable, pero dependerá del uso que le darás. 

4. Descargar Ubuntu 24.04 y preparar USB de arranque

   * Ve a la página oficial de Ubuntu y descarga la ISO de [Ubuntu 24.04 LTS](https://releases.ubuntu.com/noble/).

   * Verifica la integridad del archivo descargado (por ejemplo comparando suma SHA256) para asegurarte de que no está corrupto. 

   * Usar una herramienta como Rufus, balenaEtcher o similar para escribir la ISO en un USB y hacer que éste sea booteable. 

5. Configurar BIOS/UEFI para arrancar desde USB

   * Reinicia el PC y entra al menú de BIOS/UEFI (normalmente pulsando F2, F12, Esc, Del al arrancar).

   * Asegúrate de que el arranque seguro (Secure Boot) esté desactivado o compatible, según los casos.

6. Configura el USB booteable como primera opción de arranque, al menos temporalmente.

   * Iniciar desde el USB y lanzar instalador
   * Inserta el USB y arranca desde él.
   * En el menú que aparecerá, selecciona “Instalar Ubuntu”. Puedes elegir “Probar Ubuntu” primero si quieres ver que todo funciona (gráficos, hardware, etc.). 

7. Elección del tipo de instalación
   * Cuando el instalador te pregunte, elige la opción “Instalar Ubuntu junto con Windows” (“Install Ubuntu alongside Windows Boot Manager”). El instalador debería reconocer Windows e indicar el espacio libre disponible. 
   * Si prefieres más control, usa la opción de particionado manual (Manual) para asignar qué partición será root (/), si quieres también /home separada, o swap. 

8. Asignar particiones (si vas manual)

   * Selecciona el espacio libre que dejaste antes y crea al menos:
     * una partición para `/` (`root`), formato `ext4`,
     * posiblemente una partición para intercambio swap (aunque Ubuntu puede usar swap file por defecto),
     * opcionalmente `/home` si quieres separar tus datos personales.
   * Asegúrate de no tocar las particiones de Windows si no quieres perder tus datos.

9. Instalar el cargador de arranque (GRUB)

   * Durante la instalación, Ubuntu instalará GRUB como gestor de arranque. Este te permitirá elegir al inicio entre Ubuntu y Windows.

   * Verifica que GRUB lo instala en el disco correcto (normalmente el mismo disco donde está Windows, en modo UEFI si Windows lo está).

10. Finalizar instalación y reiniciar

    * Completa la instalación: selecciona zona horaria, usuario, contraseña, etc.
    * Cuando termine, reinicia el equipo, quita el USB.
    * Verifica que al inicio aparece el menú de GRUB, con opciones para Ubuntu y Windows.

11. Después de arrancar Ubuntu

    * Actualiza Ubuntu (`sudo apt update && sudo apt upgrade`).
    * Si apagaste BitLocker, puedes volver a activarlo si lo deseas, teniendo cuidado de no cifrar mientras algo del bootloader esté en preparado.