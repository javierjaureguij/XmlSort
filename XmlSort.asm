.MODEL small, STDCALL
.STACK 100h

.DATA

    ; --> Constantes

    COLOR_BLACK                 EQU         0
    COLOR_BLUE                  EQU         1
    COLOR_GREEN                 EQU         2
    COLOR_CYAN                  EQU         3
    COLOR_RED                   EQU         4
    COLOR_MAGENTA               EQU         5
    COLOR_BROWN                 EQU         6
    COLOR_LIGHTGRAY             EQU         7
    COLOR_DARKGRAY              EQU         8
    COLOR_LIGHTBLUE             EQU         9
    COLOR_LIGHTGREEN            EQU         10
    COLOR_LIGHTCYAN             EQU         11
    COLOR_LIGHTRED              EQU         12
    COLOR_LIGHTMAGENTA          EQU         13
    COLOR_YELLOW                EQU         14
    COLOR_WHITE                 EQU         15   


    ; --> Estados

    ESTADO_INICIO_ENCABEZADO        EQU         0
    ESTADO_ENCABEZADO               EQU         1
    ESTADO_FIN_ENCABEZADO           EQU         2

    ESTADO_INICIO_ETQ_NUMERO        EQU         3
    ESTADO_ETQ_NUMERO               EQU         4
    ESTADO_FINAL_ETQ_NUMERO         EQU         5

    ESTADO_CONTENIDO_NUMERO         EQU         6

    ESTADO_INICIO_ETQ_NUMERO_FINAL  EQU         7
    ESTADO_ETQ_NUMERO_FINAL         EQU         8
    ESTADO_FIN_ETQ_NUMERO_FINAL     EQU         9

    ESTADO_HAY_SIGUIENTE_NUMERO     EQU         10
     
    ESTADO_FINAL_ARCHIVO            EQU         11
    ESTADO_FIN_FINAL_ARCHIVO        EQU         12


    ESTADO_INICIO_NUMERO            EQU         13
    ESTADO_SIGUIENTE_DIGITO         EQU         14
    ESTADO_FINAL_NUMERO             EQU         15

    ; ---> Ordenamientos

    ORDENAMIENTO_BURBUJA            EQU         0
    ORDENAMIENTO_QUICK              EQU         1
    ORDENAMIENTO_SHELL              EQU         2

    ORDEN_ASCENDENTE                EQU         0
    ORDEN_DESCENDENTE               EQU         1

    ; --> Menú Inicio

    strMenuInicio               BYTE        0ah, 0ah, 0ah, 0dh, "  ============================================================"
                                BYTE                  0ah, 0dh, "  == UNIVERSIDAD DE SAN CARLOS DE GUATEMALA                 =="
                                BYTE                  0ah, 0dh, "  == FACULTAD DE INGENIERIA                                 =="
                                BYTE                  0ah, 0dh, "  == CIENCIAS Y SISTEMAS                                    =="
                                BYTE                  0ah, 0dh, "  == CURSO: ARQUITECTURA DE COMPUTADORAS Y ENSAMBLADORES 1  =="
                                BYTE                  0ah, 0dh, "  == SECCION: A                                             =="
                                BYTE                  0ah, 0dh, "  == NOMBRE: JAVIER ORLANDO JAUREGUI JUAREZ                 =="
                                BYTE                  0ah, 0dh, "  == CARNET: 201503748                                      =="
                                BYTE                  0ah, 0dh, "  ============================================================"
                                BYTE                  0ah, 0dh, "  == 1.) CARGAR ARCHIVO                                     =="
                                BYTE                  0ah, 0dh, "  == 2.) ORDENAR                                            =="
                                BYTE                  0ah, 0dh, "  == 3.) GENERAR REPORTE                                    =="
                                BYTE                  0ah, 0dh, "  == 4.) SALIR                                              =="
                                BYTE                  0ah, 0dh, "  ============================================================", 0ah, 0dh
                                BYTE                  0ah, 0dh, "  Escoja una opcion: "                                         , "$"

    strCargarArchivo            BYTE        0ah, 0dh, 0ah, 0dh, "  ============================================================"
                                BYTE                  0ah, 0dh, "  INGRESE RUTA DEL ARCHIVO .xml: "                             , "$"


    strSelecOrdenamiento        BYTE        0ah, 0ah, 0ah, 0dh, "  ============================================================"
                                BYTE                  0ah, 0dh, "  == 1.) BUBBLESORT                                         =="
                                BYTE                  0ah, 0dh, "  == 2.) QUICKSORT                                          =="
                                BYTE                  0ah, 0dh, "  == 3.) SHELLSORT                                          =="
                                BYTE                  0ah, 0dh, "  ============================================================", 0ah, 0dh
                                BYTE                  0ah, 0dh, "  Escoja un ordenamiento: "                                    , "$"

    strSelecVelocidad           BYTE        0ah, 0ah, 0ah, 0dh, "  ============================================================"
                                BYTE                  0ah, 0dh, "  == Ingrese una velocidad (0-9): "                            , "$"

    strSelecOrden               BYTE        0ah, 0dh, 0ah, 0dh, "  ============================================================"
                                BYTE                  0ah, 0dh, "  == 1.) Ascendente                                         =="
                                BYTE                  0ah, 0dh, "  == 2.) Descendente                                        =="
                                BYTE                  0ah, 0dh, "  ============================================================", 0ah, 0dh
                                BYTE                  0ah, 0dh, "  Escoja un orden: "                                           , "$"
                                

    strMsgArchivoCargado        BYTE                  0ah, 0dh, "El archivo ha sido cargado con exito"                          , 0ah, 0dh, "$"

    ; --> Variables

    strBufferEntrada            BYTE                   31 dup(00h)
    strCadenaAuxiliar           BYTE                   31 dup(00h)

    strContenidoArchivo         BYTE                   20481 dup(00h)

    arregloValoresCargados      WORD                   25 dup(0)
    arregloValoresOrdenados     WORD                   25 dup(0)
    cantidadValoresCargados     WORD                   0

    ordenamientoActual          BYTE                   0
    velocidadActual             BYTE                   0
    ordenActual                 WORD                   0

    minutosDesdeInicio          WORD                   0
    segundosDesdeInicio         WORD                   0
    milisegundosDesdeInicio     WORD                   0

    ; --> Cadenas

    strOrdenamiento             BYTE                  "ORDENAMIENTO:"

    strBurbuja                  BYTE                  "BUBBLESORT"
    strQuickSort                BYTE                  "QUICKSORT"
    strShellSort                BYTE                  "SHELLSORT"
    
    strTiempo                   BYTE                  "TIEMPO:"
    strMinSegundos              BYTE                  "00:00"

    strVelocidad                BYTE                  "VELOCIDAD:"


    ; --> Variables para reporte

    velocidadBubbleSort         BYTE                  0
    velocidadQuickSort          BYTE                  0
    velocidadShellSort          BYTE                  0

    minutosBubbleSort           WORD                  0
    segundosBubbleSort          WORD                  0
    milisegundosBubbleSort      WORD                  0

    minutosQuickSort            WORD                  0
    segundosQuickSort           WORD                  0
    milisegundosQuickSort       WORD                  0
    

    minutosShellSort            WORD                  0
    segundosShellSort           WORD                  0
    milisegundosShellSort       WORD                  0
    
    ordenBubbleSort             WORD                  0
    ordenQuickSort              WORD                  0
    ordenShellSort              WORD                  0

    arregloValoresBubbleSort    WORD                  25 dup(0)
    arregloValoresQuickSort     WORD                  25 dup(0)
    arregloValoresShellSort     WORD                  25 dup(0)

    strFechaReporte             BYTE                  "00/00/0000", 0ah, 0dh, "$"
    strTiempoReporte            BYTE                  "00:00:00", 0ah, 0dh, "$"

    strNombreArchivoReporte     BYTE                  "reporte", 00h

    ; --> Cadenas para reporte

    strTabulacion               BYTE                  09h
    strSaltoLinea               BYTE                  0ah, 0dh

    strComa                     BYTE                  ","
    
    strEtqAbreArqui             BYTE                  "<Arqui>" 
    strEtqCierraArqui           BYTE                  "</Arqui>"

    strEtqAbreEncabezado        BYTE                  "<Encabezado>"
    strEtqCierraEncabezado      BYTE                  "</Encabezado>"
    
    strEtqUniversidad           BYTE                  "<Universidad>Universidad San Carlos De Guatemala</Universidad>"
    strEtqFacultad              BYTE                  "<Facultad>Facultad de Ingenieria</Facultad>"
    strEtqEscuela               BYTE                  "<Escuela>Ciencias Y Sistemas</Escuela>"

    strEtqAbreCurso             BYTE                  "<Curso>"
    strEtqCierraCurso           BYTE                  "</Curso>"

    strEtqNombreCurso           BYTE                  "<Nombre>Arquitectura de Computadores y Ensambladores 1</Nombre>"
    strEtqSeccionCurso          BYTE                  "<Seccion>Seccion A</Seccion>"

    strEtqCiclo                 BYTE                  "<Ciclo>Primer Semestre 2019</Ciclo>"

    strEtqAbreFecha             BYTE                  "<Fecha>"
    strEtqCierraFecha           BYTE                  "</Fecha>"
    
    strEtqDia                   BYTE                  "<Dia>00</Dia>"
    strEtqMes                   BYTE                  "<Mes>00</Mes>"
    strEtqAnio                  BYTE                  "<Anio>0000</Anio>"

    strEtqAbreHora              BYTE                  "<Hora>"
    strEtqCierraHora            BYTE                  "</Hora>"
    
    strEtqHora                  BYTE                  "<Hora>00</Hora>"
    strEtqMinutos               BYTE                  "<Minutos>00</Minutos>"
    strEtqSegundos              BYTE                  "<Segundos>00</Segundos>"
    
    strEtqAbreAlumno            BYTE                  "<Alumno>"
    strEtqCierraAlumno          BYTE                  "</Alumno>"

    strEtqNombreAlumno          BYTE                  "<Nombre>Javier Orlando Jauregui Juarez</Nombre>"
    strEtqCarnet                BYTE                  "<Carnet>201503748</Carnet>"

    strEtqAbreResultados        BYTE                  "<Resultados>"
    strEtqCierraResultados      BYTE                  "</Resultados>"

    strEtqAbreListaEntrada      BYTE                  "<Lista_Entrada>"
    strEtqCierraListaEntrada    BYTE                  "</Lista_Entrada>"

    strEtqAbreListaOrdenada     BYTE                  "<Lista_Ordenada>"
    strEtqCierraListaOrdenada   BYTE                  "</Lista_Ordenada>"

    strEtqAbreBubbleSort        BYTE                  "<Ordenamiento_BubbleSort>"
    strEtqCierraBubbleSort      BYTE                  "</Ordenamiento_BubbleSort>"

    strEtqAbreQuickSort         BYTE                  "<Ordenamiento_QuickSort>"
    strEtqCierraQuickSort       BYTE                  "</Ordenamiento_QuickSort>"
    
    strEtqAbreShellSort         BYTE                  "<Ordenamiento_ShellSort>"
    strEtqCierraShellSort       BYTE                  "</Ordenamiento_ShellSort>"
    
    strEtqTipoAscendente        BYTE                  "<Tipo>Ascendente</Tipo>"
    strEtqTipoDescendente       BYTE                  "<Tipo>Descendente</Tipo>"

    strEtqAbreVelocidad         BYTE                  "<Velocidad>"
    strEtqCierraVelocidad       BYTE                  "</Velocidad>"

    strEtqAbreTiempo            BYTE                  "<Tiempo>"
    strEtqCierraTiempo          BYTE                  "</Tiempo>"

    strEtqAbreMinutos           BYTE                  "<Minutos>"
    strEtqCierraMinutos         BYTE                  "</Minutos>"

    strEtqAbreSegundos          BYTE                  "<Segundos>"
    strEtqCierraSegundos        BYTE                  "</Segundos>"

    strEtqAbreMilisegundos      BYTE                  "<Milisegundos>"
    strEtqCierraMilisegundos    BYTE                  "</Milisegundos>"


    ; --> Errores:

    strErrorOpInvalida          BYTE                  0ah, 0dh, "Error: La opcion ingresada es invalida."                       , 0ah, 0dh, "$"

    strErrorAperturaRuta        BYTE                  0ah, 0dh, "Error: Falta el simbolo % al inicio de la ruta."               , 0ah, 0dh, "$"
    strErrorCierreRuta          BYTE                  0ah, 0dh, "Error: Falta el simbolo % al final de la ruta."                , 0ah, 0dh, "$"
    strErrorExtensionInvalida   BYTE                  0ah, 0dh, "Error: La extension del archivo debe ser .xml."                   , 0ah, 0dh, "$"
    strErrorRuta                BYTE                  0ah, 0dh, "Error: Ruta invalida."                                         , 0ah, 0dh, "$"

    strErrorCrearArchivo        BYTE                  0ah, 0dh, "Error: No fue posible crear el archivo."                       , 0ah, 0dh, "$"
    strErrorEscribirArchivo     BYTE                  0ah, 0dh, "Error: No fue posible escribir en el archivo."                 , 0ah, 0dh, "$"
    strErrorAbrirArchivo        BYTE                  0ah, 0dh, "Error: No fue posible abrir el archivo."                       , 0ah, 0dh, "$"     
    strErrorLeerArchivo         BYTE                  0ah, 0dh, "Error: No fue posible leer el archivo."                        , 0ah, 0dh, "$"
    strErrorFinArchivo          BYTE                  0ah, 0dh, "Error: No fue posible posicinarse en el final del archivo"     , 0ah, 0dh, "$"
    strErrorCerrarArchivo       BYTE                  0ah, 0dh, "Error: No fue posible cerrar el archivo."                      , 0ah, 0dh, "$"
    
    strErrorAnalizarArchivo     BYTE                  0ah, 0dh, "Error: Ocurrio un error al parsear el archivo."                , 0ah, 0dh, "$"

    strErrorValoresNoCargados   BYTE                  0ah, 0dh, "Error: No se ha cargado ningun valor."                         , 0ah, 0dh, "$"

    strErrorMenosDelRango       BYTE                  0ah, 0dh, "Error: Se deben cargar al menos 10 numeros."                   , 0ah, 0dh, "$"
    strErrorMasDelRango         BYTE                  0ah, 0dh, "Error: Unicamente se pueden cargar hasta 25 numeros."          , 0ah, 0dh, "$"
    
.CODE

; ------------------------------------------------
; ---------           MACROS            ----------                 
; ------------------------------------------------

;------------------------------------------------
ImprimirEnConsola MACRO cadena
;
; Descripción : Imprime en consola una cadena.
; Recibe      : Cadena terminada en '$'
; Devuelve    : NADA
;------------------------------------------------

    push ax
    push cx
    push dx

    mov ah, 09h
    mov dx, OFFSET cadena
    int 21h

    pop dx
    pop cx
    pop ax
    
ENDM

;------------------------------------------------
LeerCaracterConsola MACRO
;
; Descripción : Lee una caracter ingresado por el usuario en consola.
; Recibe      : NADA
; Devuelve    : AL = Código ASCII en Hexadecimal del caracter ingresado
;------------------------------------------------

    mov ah, 01h
    int 21h

ENDM

;------------------------------------------------
EliminarCaracterConsola MACRO
;
; Descripción : Elimina un caracter de la consola cuando el usuario ingresa un 'backspace'
; Recibe      : NADA
; Devuelve    : NADA
;------------------------------------------------

    push ax
    push dx

    mov ah, 02h
    mov dl, 20h
    int 21h
    mov dl, 08h
    int 21h

    pop dx
    pop ax

ENDM

;------------------------------------------------
TerminarPrograma MACRO
;
; Descripción : Termina la ejecución de programa.
; Recibe      : NADA
; Devuelve    : NADA
;------------------------------------------------

    mov ah, 4CH
    mov al, 01
    int 21h

ENDM


CrearArchivo MACRO strNombre, handle
;
; Descripción : Crea un archivo..
; Recibe      : strNombre = Cadena donde está almacenado el nombre del archivo.
;             : handle = Variable donde se almacenará el Handle del archivo
; Devuelve    : handle = Handle del archivo creado.
;------------------------------------------------
LOCAL ErrorArchivo, Salir

    push cx
    push dx

    mov ah, 3ch
    mov cx, 00h
    lea dx, strNombre

    int 21h
    jc ErrorArchivo

    mov handle, ax
    jmp Salir

    ErrorArchivo:
        ImprimirEnConsola strErrorCrearArchivo

    Salir:
        pop dx
        pop cx

ENDM

;------------------------------------------------
EscribirEnArchivo MACRO handle, strContenido, tamanioContenido
;
; Descripción : Abre un archivo y escribe dentro de él.
; Recibe      : strContenido = Cadena que se escribirá en el archivo.
;             : handle = Variable donde se almacena el Handle del archivo
;             : tamanioContenido = Tamaño del contenido a escribir.
; Devuelve    : Nada
;------------------------------------------------
LOCAL ErrorArchivo, Salir

    push ax
    push bx
    push cx
    push dx

    mov ah, 40h
    mov bx, handle
    mov cx, tamanioContenido
    lea dx, strContenido
    
    int 21h
    jc ErrorArchivo
    jmp Salir

    ErrorArchivo:
        ImprimirEnConsola strErrorEscribirArchivo

    Salir:
        pop dx
        pop cx
        pop bx
        pop ax

ENDM

;------------------------------------------------
PosicionarEnFinalDeArchivo MACRO handle
;
; Descripción : Posiciona cursor de lectura y escritura del archivo en el final.
; Recibe      : handle = Variable donde se almacena el Handle del archivo
; Devuelve    : Nada
;------------------------------------------------
LOCAL ErrorArchivo, Salir

    push ax
    push bx
    push cx
    push dx

    mov ah, 42h
    mov al, 02h 
    mov bx, handle

    xor cx, cx
    xor dx, dx
    int 21h

    jc ErrorArchivo
    jmp Salir

    ErrorArchivo:
        ImprimirEnConsola strErrorFinArchivo

    Salir:
        pop dx
        pop cx
        pop bx
        pop ax

ENDM

;------------------------------------------------
AbrirArchivo MACRO nombreArchivo, handle
;
; Descripción : Abre un archivo y devuelve su Handle.
; Recibe      : nombreArchivo = Cadena donde está almacenado el nombre del archivo.
;             : handle = Variable donde se almacenará el Handle devuelto
; Devuelve    : handle = Handle del archivo abierto.
;------------------------------------------------
LOCAL ErrorArchivo, Salir

    push ax
    push dx

    mov ah, 3Dh
    mov al, 02h
    lea dx, nombreArchivo
    int 21h
    jc ErrorArchivo
    mov handle, ax
    jmp Salir

    ErrorArchivo:
        ImprimirEnConsola strErrorAbrirArchivo
        mov handle, 0h
    
    Salir:
        pop dx
        pop ax

ENDM

;------------------------------------------------
LeerArchivo MACRO handle, bufferContenidoArchivo, tamanioContenido
;
; Descripción : Lee un archivo y guarda su contenido en una cadena.
; Recibe      : handle = handle del archivo
;             : bufferContenidoArchivo = Cadena donde se almacenará el contenido del archivo.
;             : tamanioContenido = tamaño del contenido a leer del archivo.
; Devuelve    : NADa.
;------------------------------------------------

LOCAL ErrorArchivo, Salir

    cmp handle, 0
        je ErrorArchivo

    push ax
    push bx
    push cx
    push dx

    mov ah, 3FH
    mov bx, handle
    mov cx, tamanioContenido
    lea dx, bufferContenidoArchivo
    int 21h
    jc ErrorArchivo
    jmp Salir

    ErrorArchivo:
        ImprimirEnConsola strErrorLeerArchivo

    Salir:
        pop dx
        pop cx
        pop bx
        pop ax

ENDM

;------------------------------------------------
CerrarArchivo MACRO handle
;
; Descripción : Cierra un archivo.
; Recibe      : handle = Handle del archivo a cerrar.
; Devuelve    : NADA.
;------------------------------------------------
LOCAL ErrorArchivo, Salir

    cmp handle, 0
        je ErrorArchivo

    push ax
    push bx

    mov ah, 3EH
    mov bx, handle
    int 21h
    jc ErrorArchivo
    jmp Salir

    ErrorArchivo:
        ImprimirEnConsola strErrorCerrarArchivo
    
    Salir:
        pop bx
        pop ax

ENDM


;------------------------------------------------
UpperLetra MACRO
;
; Descripción : Convierte una letra de minúscula a mayúscula.
; Recibe      : AL = valor ascii en hexadecimal de la letra.
; Devuelve    : AL = valor ascii en hexadecimal de la letra en mayúsucla, si el registro AL no contenía
;               una letra minúscula, el valor de éste no cambia.
;------------------------------------------------
LOCAL PosibleMinuscula, Convertir, Salir

    cmp al, "a"
        jae PosibleMinuscula
    jmp Salir

    PosibleMinuscula:
        cmp al, "z"
            jbe Convertir
        jmp Salir

    Convertir:
        sub al, 20h
        jmp Salir
    
    Salir:

ENDM

;------------------------------------------------
EsDigitoAscii MACRO
;
; Descripción : Determina si un valor ascii en hexadecimal corresponde al de un digito.
; Recibe      : AL = valor ascii en hexadecimal a evaluar.
; Devuelve    : CF = 1 es dígito, CF = 0 No es dígito.
;------------------------------------------------
LOCAL PosibleDigito, EsDigito, NoEsDigito, Salir

    cmp al, "0"
        jae PosibleDigito

    jmp NoEsDigito
    
    PosibleDigito:
        cmp al, "9"
            jbe EsDigito
        
        jmp NoEsDigito

    EsDigito:
        STC                 ; CF = 1
        jmp Salir
    
    NoEsDigito:
        CLC                 ; CF = 0
        jmp Salir

    Salir:

ENDM

;------------------------------------------------
DigitoAsciiToNumero MACRO
;
; Descripción : Convierte un dígito de ascii a su valor numérico.
; Recibe      : Al = valor ascii en hexadecimal del dígito.
; Devuelve    : Al = valor numérico del dígito. Si Al no contenía un dígito, el valor de éste no cambia.
;------------------------------------------------
LOCAL PosibleDigito, Convertir, Salir

    EsDigitoAscii
    jc Convertir
    jmp Salir

    Convertir:
        sub al, "0"
        jmp Salir

    Salir:

ENDM

;------------------------------------------------
EmitirSonido MACRO hz, cantidadDelay
;
; Descripción : Emite un sonido a cierta frecuencia en hz por una cantidad de tiempo pasada por parámetro.
; Recibe      : hz = frecuencia a la que se emitirá el sonido.
;               cantidadDelay = duración del sonido.
; Devuelve    : NADA
;------------------------------------------------

LOCAL Inicializacion, ApagarBocina, Sonido, Salir


    Inicializacion:

        push ax
        push cx

        xor ax, ax
        xor cx, cx

    Sonido:

        mov al, 86h
        out 43h, al
        mov ax, (1193180 / hz)
        out 42h, al
        mov al, ah
        out 42h, al 
        in  al, 61h
        or  al, 00000011b
        out 61h, al
        
        INVOKE Delay, cantidadDelay

    ApagarBocina:

        in al, 61h
        and al, 11111100b
        out 61h, al

    Salir:

        pop cx
        pop ax

ENDM


; ------------------------------------------------
; ---------       PROCEDIMIENTOS        ----------                 
; ------------------------------------------------


Put_BCD2 PROC

    push    ax

    shr     ax, 1
    shr     ax, 1
    shr     ax, 1
    shr     ax, 1

    and     ax, 0fh
    add     ax, '0'
    mov     [bx], al
    inc     bx
    pop     ax

    and     ax, 0fh
    add     ax, '0'
    mov     [bx], al

    inc     bx
    ret

Put_BCD2 ENDP

;------------------------------------------------
GetTiempo PROC USES ax bx
;
; Descripción : Obtiene el tiempo del BIOS y lo convierte a una cadena.
; Recibe      : NADA
; Devuelve    : La variable global strTiempoReporte guarda la cadena con el tiempo actual
; Fuente      : https://stackoverflow.com/questions/28609924/assembly-a86-get-and-display-time
;------------------------------------------------

    mov     ah, 02h              ; Obtener tiempo del BIOS.
    int     1ah

    mov     bx, OFFSET strTiempoReporte ; Horas
    mov     al, ch
    call    Put_BCD2

    inc     bx                   ; Minutos
    mov     al, cl
    call    Put_BCD2 

    inc     bx                   ; Segundos
    mov     al, dh
    call    Put_BCD2 

    ret

GetTiempo ENDP

;------------------------------------------------
GetFecha PROC USES ax bx
;
; Descripción : Obtiene la fecha del BIOS y lo convierte a una cadena.
; Recibe      : NADA
; Devuelve    : La variable global strFechaReporte guarda la cadena con la fecha actual
; Fuente      : https://stackoverflow.com/questions/28609924/assembly-a86-get-and-display-time
;------------------------------------------------

    mov     ah, 04h             ; Obtener fecha del BIOS.
    int     1ah

    mov     bx, OFFSET strFechaReporte ; Día
    mov     al, dl
    call    Put_BCD2

    inc     bx                  ; Mes
    mov     al, dh
    call    Put_BCD2

    inc     bx                  ; Año
    mov     al, ch
    call    Put_BCD2
    mov     al, cl
    call    Put_BCD2

    ret

GetFecha ENDP


;------------------------------------------------
Delay PROC USES si di tiempo : WORD
;
; Descripción : Suspende el programa por la cantidad de tiempo pasada por parámetro.
; Recibe      : tiempo = cantidad de tiempo que se suspenderá el programa.
; Devuelve    : NADA
;------------------------------------------------

    Inicializacion:

        xor di, di
        xor si, si
        mov si, tiempo

    Ciclo1:
        dec si
        jz Salir
        mov di, tiempo
    Ciclo2:
        dec di
        jnz Ciclo2
        jmp Ciclo1

    Salir:
        ret

Delay ENDP

;------------------------------------------------
LimpiarBuffer PROC USES bx cx si, buffer: PTR BYTE, tamanioBuffer: WORD
;
; Descripción : Rellena con "00h" el contenido del buffer.
; Recibe      : Dirección de memoria del buffer a ser limpiado.
; Devuelve    : NADA
;------------------------------------------------

    xor bx, bx
    xor cx, cx
    xor si, si

    mov cx, tamanioBuffer
    mov bx, buffer

    EtqCiclo:
        mov BYTE PTR [bx + si], 00h
        inc si
        Loop EtqCiclo

    ret

LimpiarBuffer ENDP

LimpiarArreglo PROC USES bx cx si, pArreglo : PTR BYTE, tamanio : WORD
;
; Descripción : Rellena con 0's el contenido del arreglo.
; Recibe      : pArreglo = Dirección de memoria del arreglo a limpiar.
;               tamanio = tamaño del arreglo.
; Devuelve    : NADA
;------------------------------------------------

    Inicializacion:
    
        xor bx, bx
        xor cx, cx
        xor si, si

        mov cx, tamanio
        mov bx, pArreglo

    Ciclo:

        mov BYTE PTR[bx + si], 0
        inc si
        Loop Ciclo

    Salir:
        ret

LimpiarArreglo ENDP

;------------------------------------------------
LeerCadenaConsola PROC USES ax bx cx si, pCadenaLeida: PTR BYTE, tamanioCadena: BYTE
;
; Descripción : Lee una cadena ingresada por el usuario en consola.
; Recibe      : pCadenaLeida = dirección de memoria donde se guardará la cadena ingresada por el usuario.
;             : tamanioCadena = Tamaño máximo de la cadena donde se guardará lo ingresado por el usuario.
; Devuelve    : Guarda en la dirección a donde apunta pCadenaLeida la cadena ingresada por el usuario.
;------------------------------------------------
    
    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor si, si

    INVOKE LimpiarBuffer, pCadenaLeida, tamanioCadena

    mov si, 0
    mov cl, tamanioCadena
    mov bx, pCadenaLeida

    EtqCiclo:

        LeerCaracterConsola
        cmp al, 08h
            je EtqEliminarCaracter
        cmp al, 0dh
            jne EtqVerificarCaracter
        jmp EtqTerminarLectura
    
    EtqVerificarCaracter:
        
        cmp si, cx
            jb EtqGuardarCaracter
        jmp EtqCiclo

    EtqGuardarCaracter:
    
        mov BYTE PTR [bx + si], al
        inc si
        jmp EtqCiclo

    EtqEliminarCaracter:

        cmp si, 0
            je EtqCiclo
        EliminarCaracterConsola
        dec si
        mov BYTE PTR [bx + si], 00h
        jmp EtqCiclo
        
    EtqTerminarLectura:

        mov BYTE PTR [bx + si], 00h
        ret

LeerCadenaConsola ENDP

;------------------------------------------------
ConvertirNumeroToCadena PROC USES ax cx dx bx si di Numero: WORD, pCadenaDestino: PTR BYTE, tamanioDestino : WORD
;
; Descripción : Convierte un número a cadena.
; Recibe      : Numero = Valor numérico que se desa convertir
;             : pCadenaDestino = dirección de memoria donde se guardará el número convertido.
;             : tamanioDestino = cantidad de caracteres a copiar.
; Devuelve    : Guarda en la dirección a donde apunta pCadenaDestino el número convertido.
;------------------------------------------------


    Inicializacion:
    
        INVOKE LimpiarBuffer, pCadenaDestino, tamanioDestino
    
        mov ax, Numero
        mov cx, 10
        mov bx, pCadenaDestino         
        mov si, 0
        mov di, 0

        test ax, ax
        jns Convertir
        
        mov BYTE PTR[bx + 0], "-"
        inc di
        mov cx, -1 
        mul cx
        mov cx, 10

    Convertir:

        mov dx, 0            
        div cx              
        add dx, "0"         
        
        inc si
        push dx

        cmp ax,0            
            je CrearCadena            
        jmp Convertir 

    CrearCadena:

        pop dx
        mov BYTE PTR[bx + di], dl
        
        inc di
        dec si

        cmp si, 0
            je Salir
        jmp CrearCadena
       
    Salir:
        ret

ConvertirNumeroToCadena ENDP

;------------------------------------------------
GetTamanioCadena PROC USES bx cx si pCadena : PTR BYTE
;
; Descripción : Obtiene el tamaño de una cadena.
; Recibe      : pCadena = cadena a obtener su tamaño.
; Devuelve    : Registro AL = tamaño de la cadena.
;------------------------------------------------

    Inicializacion:

        xor ax, ax
        xor bx, bx
        xor cx, cx
        xor si, si

        mov bx, pCadena

    Ciclo:
        
        mov cl, BYTE PTR[bx + si]
        cmp cl, 00h
            je Salir
        inc al
        inc si
        jmp Ciclo

    Salir:
        ret 

GetTamanioCadena ENDP

;------------------------------------------------
VaciarArregloValores PROC USES cx si
;
; Descripción : Vacía el arreglo global 'arregloValoresCargados'.
; Recibe      : NADA.
; Devuelve    : NADA.
;------------------------------------------------

    Inicializacion: 

        xor cx, cx
        xor si, si

        mov cx, 25

    Ciclo:

        mov arregloValoresCargados[si], 0
        add si, TYPE WORD
        Loop Ciclo

    Salir:
        ret


VaciarArregloValores ENDP

;------------------------------------------------
GetColorByValor PROC valor : WORD
;
; Descripción : Obtiene el color en base al rango en el que se encuentra el valor pasado por parámetro.
; Recibe      : valor = valor numérico a obtener su color.
; Devuelve    : AL = Color del valor.
;------------------------------------------------

    Inicializacion:

        xor ax, ax
    
    EvaluarRango:

        cmp valor, 20
            jbe Rojo
        
        cmp valor, 40
            jbe Azul
        
        cmp valor, 60
            jbe Amarillo
        
        cmp valor, 80
            jbe Verde
        
        cmp valor, 99
            jbe Blanco

        Rojo:
            mov al, COLOR_LIGHTRED
            jmp Salir
        Azul:
            mov al, COLOR_LIGHTBLUE
            jmp Salir
        Amarillo:
            mov al, COLOR_YELLOW
            jmp Salir
        Verde:
            mov al, COLOR_LIGHTGREEN
            jmp Salir
        Blanco:
            mov al, COLOR_WHITE
            jmp Salir

    Salir:
        ret

GetColorByValor ENDP

;------------------------------------------------
IncrementarTiempo PROC USES ax milisegundos
;
; Descripción : Incrementa el tiempo de la variable global 'milisegundosDesdeInicio'.
;               Si milisegundosDesdeInicio es mayor o igual a 1000, se aumenta en 1 la variable segundosDesdeInicio.
;               Si segundosDesdeInicio es mayor o igual a 60, se aumenta en 1 el valor de la variable minutosDesdeInicio.
; Recibe      : milisegundos = cantidad de milisegundos a incrementar.
; Devuelve    : NADA.
;------------------------------------------------

    Inicializacion:

        xor ax, ax

    IncrementarMilisegundos:

        mov ax, milisegundos
        add milisegundosDesdeInicio, ax

    CompararTiempo:
    
        cmp milisegundosDesdeInicio, 1000
            jb Salir
        
        add segundosDesdeInicio, 1
        mov milisegundosDesdeInicio, 0

        cmp segundosDesdeInicio, 60
            jb Salir
        
        add minutosDesdeInicio, 1
        mov segundosDesdeInicio, 0
        mov milisegundosDesdeInicio, 0

    Salir:
        ret

IncrementarTiempo ENDP

;------------------------------------------------
TiempoToCadena PROC
;
; Descripción : Convierte los valores de las variables globales minutosDesdeInicio y segundosDesdeInicio
;               a cadena y lo guarda en la variable global strMinSegundos.
; Recibe      : NADA
; Devuelve    : strMinSegundos = tiempo convertido.
;------------------------------------------------

    Inicializacion:

        mov strMinSegundos[0], "0"
        mov strMinSegundos[1], "0"
        mov strMinSegundos[3], "0"
        mov strMinSegundos[4], "0"

    EvaluarDigitosMinutos:

        cmp minutosDesdeInicio, 10
            jb MinutosUnDigito
        
        jmp MinutosDosDigitos

    MinutosUnDigito:
    
        INVOKE ConvertirNumeroToCadena, minutosDesdeInicio, ADDR strMinSegundos[1], 1
        jmp EvaluarDigitosSegundos
    
    MinutosDosDigitos:

        INVOKE ConvertirNumeroToCadena, minutosDesdeInicio, ADDR strMinSegundos[0], 2
        jmp EvaluarDigitosSegundos

    EvaluarDigitosSegundos:

        cmp segundosDesdeInicio, 10
            jb SegundosUnDigito
        
        jmp SegundosDosDigitos

    SegundosUnDigito:

        INVOKE ConvertirNumeroToCadena, segundosDesdeInicio, ADDR strMinSegundos[4], 1
        jmp Salir

    SegundosDosDigitos:

        INVOKE ConvertirNumeroToCadena, segundosDesdeInicio, ADDR strMinSegundos[3], 2
        jmp Salir

    Salir:
        ret

TiempoToCadena ENDP

;------------------------------------------------
CompararCadenas PROC USES ax bx cx si, pCadena1 : PTR BYTE, pCadena2 : PTR BYTE
;
; Descripción : Determina si 2 cadenas son iguales.
; Recibe      : pCadena1 = posición de memoria de la primera cadena.
;               pCadena2 = posición de memoria del a segunda cadena.
; Devuelve    : Bandera CF = 1 si son iguales, CF = 0 si no lo son.
;------------------------------------------------

    Inicializacion:

        xor ax, ax
        xor bx, bx
        xor cx, cx
        xor si, si

    CompararTamanios:

        INVOKE GetTamanioCadena, pCadena1
        mov cl, al
        INVOKE GetTamanioCadena, pCadena2

        cmp al, cl
            jne NoIguales
        
        xor ax, ax
        xor cx, cx
    
    CompararCaracteres:

        mov bx, pCadena1
        mov al, BYTE PTR[bx + si]
        
        UpperLetra
        mov cl, al

        mov bx, pCadena2
        mov al, BYTE PTR[bx + si]
        UpperLetra

        cmp al, cl
            jne NoIguales
        inc si
        cmp al, 00h
            jne CompararCaracteres

    Iguales:
        STC
        jmp Salir

    NoIguales:
        CLC
        jmp Salir
        
    Salir:
        ret

CompararCadenas ENDP

;------------------------------------------------
CopiarCadena PROC USES ax bx si, pCadenaOrigen: PTR BYTE, pCadenaDestino: PTR BYTE, tamanioDestino : WORD
;
; Descripción : Copia el contenido de una cadena a otra.
; Recibe      : pCadenaOrigen = dirección de memoria donde se almacena la cadena original.
;             : pCadenaDestino = dirección de memoria donde se guardará la copia de la cadena.
;             : tamanioDestino = cantidad de caracteres a copiar.
; Devuelve    : Guarda en la dirección a donde apunta pCadenaDestino la cadena copiada.
;------------------------------------------------

    Inicializacion:

        xor ax, ax
        xor bx, bx
        xor si, si

        INVOKE LimpiarBuffer, pCadenaDestino, tamanioDestino

    Ciclo:
        mov bx, pCadenaOrigen
        mov al, BYTE PTR[bx + si]
        cmp al, 00h
            je Salir 
        mov bx, pCadenaDestino
        mov BYTE PTR[bx + si], al
        inc si
        dec tamanioDestino
        cmp tamanioDestino, 0
            jne Ciclo
        
    Salir:
        ret

CopiarCadena ENDP

;------------------------------------------------
EstablecerModoTexto PROC USES ax
;
; Descripción : Establece el Modo de Texto.
; Recibe      : NADA.
; Devuelve    : NADA.
;------------------------------------------------

    Inicializar:
    
        mov ah, 00h
        mov al, 03h
        int 10h

    Salir:
        ret

EstablecerModoTexto ENDP

;------------------------------------------------
EstablecerModoVideo PROC USES ax
;
; Descripción : Establece el Modo de Video.
; Recibe      : NADA.
; Devuelve    : NADA.
;------------------------------------------------

    Inicializar:
    
        mov ah, 00h
        mov al, 18
        int 10h
    
    Salir:
        ret

EstablecerModoVideo ENDP

;------------------------------------------------
PosicionarCursor PROC USES ax bx dx cx, columna : BYTE, fila : BYTE
;
; Descripción : Posiciona el cursor en la fila y columna especificada
; Recibe      : fila = valor de 0 a 79.
;               columna = valor de 0 a 24
; Devuelve    : NADA.
;------------------------------------------------

    Inicializacion:

        xor ax, ax
        xor bx, bx
        xor dx, dx
    
    Posicionar:

        mov ah, 2
        mov bh, 0
        mov dh, fila
        mov dl, columna
        int 10h

    Salir:
        ret

PosicionarCursor ENDP

;------------------------------------------------
DibujarBarra PROC USES ax bx cx dx, posX : WORD, posY : WORD, ancho : WORD, altura : WORD, color : BYTE
;
; Descripción : Dibuja una barra en la consola en la posición, color y del ancho y altura especificados.
; Recibe      : posX = columna del modo de video actual donde iniciará a a dibujar.
;             : posY = fila del modo de video actual donde iniciará a a dibujar.
;             : color = vallor de 0 a 15 que representa el color de la barra.
;             : ancho = ancho de la barra.
;             : altura = altura de la barra a partir de la columna actual.
; Devuelve    : NADA
;------------------------------------------------

LOCAL posInicialX : WORD

    Inicializacion:

        xor ax, ax
        xor bx, bx
        xor cx, cx
        xor dx, dx

        mov ax, posX
        mov posInicialX, ax
        
        mov dx, posY
        mov cx, altura

    CicloAltura:

        push cx
        mov  cx, ancho

        CicloAncho:
            
            push cx
            mov  ah, 0Ch
            mov  al, color
            mov  bh, 0
            mov  cx, posX
            mov  dx, posY
            int  10h
            inc  posX
            pop  cx
            Loop CicloAncho

        pop cx
        dec posY

        mov ax, posInicialX
        mov posX, ax
        Loop CicloAltura

    Salir:
        ret

DibujarBarra ENDP

;------------------------------------------------
AvanzarCursor PROC USES ax bx cx dx, numColumnas : WORD
;
; Descripción : Avanza el cursor una cantidad de posiciones de columna.
; Recibe      : numColumnas = cantidad de columnas a avanzar el cursor.
; Devuelve    : NADA.
;------------------------------------------------

    Inicializacion:

        xor ax, ax
        xor bx, bx
        xor cx, cx
        xor dx, dx

        mov cx, numColumnas

    CicloMoverCursor:

        push cx
        mov  ah, 3
        mov  bh, 0
        int  10h
        inc  dl
        mov  ah, 2
        int  10h
        pop  cx
        Loop CicloMoverCursor

    Salir:
        ret


AvanzarCursor ENDP

;------------------------------------------------
DibujarCadena PROC USES ax bx cx si pCadena : PTR BYTE, tamanioCadena : WORD, columna : BYTE, fila : BYTE, color : BYTE
;
; Descripción : Dibuja una cadena en la fila y columna especificada
; Recibe      : pCadena = dirección de memoria donde se encuentra la cadena a dibujar.
;               tamanioCadena = tamaño de la cadena a dibujar
;               columna = valor de 0 a 79
;               fila = valor de 0 a 29.
;               color = valor de 0 a 15 que representa el color de la cadena.
; Devuelve    : NADA.
;------------------------------------------------

    Inicializacion:

        xor ax, ax
        xor bx, bx
        xor cx, cx
        xor si, si

        mov cx, tamanioCadena
        mov si, pCadena

        INVOKE PosicionarCursor, columna, fila

    CicloDibujar:

        push cx
        mov  ah, 9
        mov  al, [si]
        mov  bh, 0
        mov  bl, color
        mov  cx, 1
        int  10h
        INVOKE AvanzarCursor, 1
        inc  si
        pop  cx
        Loop CicloDibujar

    Salir:
        ret


DibujarCadena ENDP

;------------------------------------------------
DibujarNumero PROC USES ax valorNumerico : WORD, columna : BYTE, fila : BYTE, color : BYTE
;
; Descripción : Dibuja un número en pantalla
; Recibe      : valorNumerico = valor numérico a dibujar.
;               columna = valor de 0 a 79
;               fila = valor de 0 a 29.
;               color = valor de 0 a 15 que representa el color de la cadena.
; Devuelve    : NADA.
;------------------------------------------------
LOCAL tamanioNumero : WORD

    Inicializacion:

        xor ax, ax

    ObtenerCadena:

        INVOKE ConvertirNumeroToCadena, valorNumerico, ADDR strCadenaAuxiliar, SIZEOF strCadenaAuxiliar

    TamanioCadena:
    
        INVOKE GetTamanioCadena, ADDR strCadenaAuxiliar
        mov tamanioNumero, ax

        cmp tamanioNumero, 2
            jb AgregarEspacio

        jmp Dibujar

    AgregarEspacio:

        mov al, strCadenaAuxiliar[0]
        mov strCadenaAuxiliar[0], "0"
        mov strCadenaAuxiliar[1], al

    Dibujar:

        INVOKE DibujarCadena, ADDR strCadenaAuxiliar, SIZEOF tamanioNumero, columna, fila, color

    Salir:
        ret

DibujarNumero ENDP

;------------------------------------------------
DibujarArregloBarraValor PROC USES ax bx cx dx si di, arreglo : PTR WORD
;
; Descripción : Dibuja las barras junto a su valor acorde al contenido del arreglo pasado por parámetro.
; Recibe      : arreglo = dirección de memoria donde se encuentra el arreglo con los valores numéricos a dibujar.
; Devuelve    : NADA.
;------------------------------------------------

    Inicializacion:

        xor ax, ax
        xor bx, bx
        xor cx, cx
        xor dx, dx
        xor si, si
        xor di, di
        
        mov cx, 25
        mov si, arreglo

        cmp cantidadValoresCargados, 10
            je DiezElementos

        cmp cantidadValoresCargados, 15
            jbe QuinceElementos

        cmp cantidadValoresCargados, 20  
            jbe VeinteElementos

        cmp cantidadValoresCargados, 25
            jbe VeinticincoElementos

    DiezElementos:

        mov bl, 10
        mov dx, 67
        jmp CicloDibujar

    QuinceElementos:

        mov bl, 5
        mov dx, 30
        jmp CicloDibujar

    VeinteElementos:

        mov bl, 10
        mov dx, 77
        jmp CicloDibujar

    VeinticincoElementos:

        mov bl, 3
        mov dx, 21
        jmp CicloDibujar

    CicloDibujar:

        mov ax, [si]
        cmp ax, 0
            ja Dibujar

        jmp AumentarIndice

        Dibujar:

            INVOKE GetColorByValor, [si]
            
            mov di, [si]
            add di, [si]

            cmp cantidadValoresCargados, 10
                je DiezElementosCiclo

            cmp cantidadValoresCargados, 15
                jbe QuinceElementosCiclo

            cmp cantidadValoresCargados, 20
                jbe VeinteElementosCiclo

            cmp cantidadValoresCargados, 25
                jbe VeinticincoElementosCiclo

            DiezElementosCiclo:

                INVOKE DibujarBarra, dx, 330, 40, di, al
                INVOKE DibujarNumero, [si], bl, 21, COLOR_WHITE
                add dx, 48
                add bl, 6
                jmp AumentarIndice

            QuinceElementosCiclo:

                INVOKE DibujarBarra, dx, 330, 33, di, al
                INVOKE DibujarNumero, [si], bl, 21, COLOR_WHITE
                add dx, 40
                add bl, 5
                jmp AumentarIndice

            VeinteElementosCiclo:

                INVOKE DibujarBarra, dx, 330, 23, di, al
                INVOKE DibujarNumero, [si], bl, 21, COLOR_WHITE
                add dx, 24
                add bl, 3
                jmp AumentarIndice

            VeinticincoElementosCiclo:

                INVOKE DibujarBarra, dx, 330, 20, di, al
                INVOKE DibujarNumero, [si], bl, 21, COLOR_WHITE
                add dx, 24
                add bl, 3
                jmp AumentarIndice

        AumentarIndice:

            add si, TYPE WORD
            dec cx
            cmp cx, 0
                jne CicloDibujar

    Salir:
        ret

DibujarArregloBarraValor ENDP

;------------------------------------------------
DibujarEncabezado PROC USES ax
;
; Descripción : Dibuja el encabezado con información del tipo de ordenamiento, tiempo y velocidad.
; Recibe      : NADA.
; Devuelve    : NADA.
;------------------------------------------------
    Inicializacion:

        xor ax, ax

    DibujarOrdenamiento:

        INVOKE DibujarCadena, ADDR strOrdenamiento, SIZEOF strOrdenamiento, 2, 1, COLOR_YELLOW

        cmp ordenamientoActual, ORDENAMIENTO_BURBUJA
            je DibujarBurbuja
        
        cmp ordenamientoActual, ORDENAMIENTO_QUICK
            je DibujarQuicksort

        cmp ordenamientoActual, ORDENAMIENTO_SHELL
            je DibujarShellsort

    DibujarBurbuja:

        INVOKE DibujarCadena, ADDR strBurbuja, SIZEOF strBurbuja, 16, 1, COLOR_YELLOW
        jmp DibujarTiempo
    
    DibujarQuicksort:

        INVOKE DibujarCadena, ADDR strQuickSort, SIZEOF strQuickSort, 16, 1, COLOR_YELLOW
        jmp DibujarTiempo
    
    DibujarShellsort:

        INVOKE DibujarCadena, ADDR strShellSort, SIZEOF strShellSort, 16, 1, COLOR_YELLOW
        jmp DibujarTiempo
    
    DibujarTiempo:
        
        INVOKE TiempoToCadena
        INVOKE DibujarCadena, ADDR strTiempo, SIZEOF strTiempo, 37, 1, COLOR_YELLOW
        INVOKE DibujarCadena, ADDR strMinSegundos, SIZEOF strMinSegundos, 45, 1, COLOR_YELLOW

    DibujarVelocidad:

        INVOKE DibujarCadena, ADDR strVelocidad, SIZEOF strVelocidad, 64, 1, COLOR_YELLOW
        INVOKE DibujarNumero, velocidadActual, 76, 1, COLOR_YELLOW

    DibujarSeparador:

        INVOKE DibujarBarra, 0, 45, 640, 4, COLOR_LIGHTBLUE

    Salir:
        ret

DibujarEncabezado ENDP

;------------------------------------------------
AnalizarNumero PROC USES bx cx dx
LOCAL Estado : BYTE, Negativo : BYTE
;
; Descripción : Extrae un número de strContenidoArchivo en base al índice actual en SI y lo
;               guarda en el registro AX
; Recibe      : SI = posición de strContenidoArchivo donde comienza a buscar el número a extraer.
; Devuelve    : Guarda en el registro AX el número extraído.
;------------------------------------------------

    Inicializacion:

        xor ax, ax
        xor cx, cx
        xor bx, bx
        xor dx, dx
        mov Negativo, 0
        mov Estado, ESTADO_INICIO_NUMERO
        

    EvaluarEstado:

        cmp Estado, ESTADO_INICIO_NUMERO
            je EstadoInicial
        cmp Estado, ESTADO_SIGUIENTE_DIGITO
            je EvaluarSiguienteDigito
        cmp Estado, ESTADO_FINAL_NUMERO
            je VerificarNegativo
    
    EstadoInicial:

        mov al, strContenidoArchivo[si]
        EsDigitoAscii
            jc PrimerDigito
    
        cmp ax, "-" 
            jne IncrementarIndice

        mov Negativo, 1
        jmp IncrementarIndice

    PrimerDigito:
        
        DigitoAsciiToNumero
        mov Estado, ESTADO_SIGUIENTE_DIGITO
        jmp IncrementarIndice

    EvaluarSiguienteDigito:
        
        xor bx, bx
        mov bx, ax

        xor ax, ax
        mov al, strContenidoArchivo[si]

        EsDigitoAscii
            jc EstadoSiguienteDigito

        xor ax, ax
        mov ax, bx

        mov Estado, ESTADO_FINAL_NUMERO
        jmp EvaluarEstado

    EstadoSiguienteDigito:

        DigitoAsciiToNumero

        xchg ax, bx
        mov cx, 10
        mul cx
        add ax, bx

        mov Estado, ESTADO_SIGUIENTE_DIGITO
        jmp IncrementarIndice

    IncrementarIndice:
        inc si
        jmp EvaluarEstado

    VerificarNegativo:

        cmp Negativo, 0
            je Salir

        mov cx, -1
        mul cx

    Salir:
        ret

AnalizarNumero ENDP

;------------------------------------------------
AnalizarContenidoArchivo PROC USES ax si di
;
; Descripción : Analiza el contenido del archivo y guarda los números encontrados en el arreglo global 'arregloValoresCargados'
; Recibe      : NADA
; Devuelve    : arregloValoresCargados  = valores leídos del archivo
;               cantidadValoresCargados = cantidad de valores cargados
;------------------------------------------------

LOCAL EstadoActual : BYTE

    Inicializacion:

        xor ax, ax
        xor si, si
        xor di, di
        
        INVOKE LimpiarArreglo, ADDR arregloValoresCargados, SIZEOF arregloValoresCargados

        mov cantidadValoresCargados, 0
        mov EstadoActual, ESTADO_INICIO_ENCABEZADO

    EvaluarEstado:

        cmp EstadoActual, ESTADO_INICIO_ENCABEZADO
            je InicioEncabezado

        cmp EstadoActual, ESTADO_ENCABEZADO
            je Encabezado

        cmp EstadoActual, ESTADO_FIN_ENCABEZADO
            je FinEncabezado

        cmp EstadoActual, ESTADO_INICIO_ETQ_NUMERO
            je InicioEtqNumero
        
        cmp EstadoActual, ESTADO_ETQ_NUMERO
            je EtqNumero

        cmp EstadoActual, ESTADO_FINAL_ETQ_NUMERO
            je FinalEtqNumero
    
        cmp EstadoActual, ESTADO_CONTENIDO_NUMERO
            je ContenidoNumero

        cmp EstadoActual, ESTADO_INICIO_ETQ_NUMERO_FINAL
            je InicioEtqNumeroFinal

        cmp EstadoActual, ESTADO_ETQ_NUMERO_FINAL
            je EtqNumeroFinal

        cmp EstadoActual, ESTADO_FIN_ETQ_NUMERO_FINAL
            je FinEtqNumeroFinal

        cmp EstadoActual, ESTADO_HAY_SIGUIENTE_NUMERO
            je HaySiguienteNumero

        cmp EstadoActual, ESTADO_FINAL_ARCHIVO
            je FinArchivo

        cmp EstadoActual, ESTADO_FIN_FINAL_ARCHIVO
            je FinFinalArchivo

    InicioEncabezado:

        cmp strContenidoArchivo[si], "<"
            jne AvanzarIndice

        mov EstadoActual, ESTADO_ENCABEZADO
        jmp AvanzarIndice

    Encabezado:

        mov al, strContenidoArchivo[si]
        UpperLetra
        cmp al, "N"
            jne AvanzarIndice
        
        inc si
        mov al, strContenidoArchivo[si]
        UpperLetra
        cmp al, "U"
            jne ErrorAnalisis
        
        inc si
        mov al, strContenidoArchivo[si]
        UpperLetra
        cmp al, "M"
            jne ErrorAnalisis

        inc si
        mov al, strContenidoArchivo[si]
        UpperLetra
        cmp al, "E"
            jne ErrorAnalisis

        inc si
        mov al, strContenidoArchivo[si]
        UpperLetra
        cmp al, "R"
            jne ErrorAnalisis

        inc si
        mov al, strContenidoArchivo[si]
        UpperLetra
        cmp al, "O"
            jne ErrorAnalisis

        inc si
        mov al, strContenidoArchivo[si]
        UpperLetra
        cmp al, "S"
            jne ErrorAnalisis

        mov EstadoActual, ESTADO_FIN_ENCABEZADO
        jmp AvanzarIndice

    FinEncabezado:

        cmp strContenidoArchivo[si], ">"
            jne AvanzarIndice

        mov EstadoActual, ESTADO_INICIO_ETQ_NUMERO
        jmp AvanzarIndice

    InicioEtqNumero:

        cmp strContenidoArchivo[si], "<"
            jne AvanzarIndice
        
        mov EstadoActual, ESTADO_ETQ_NUMERO
        jmp AvanzarIndice

    EtqNumero:

        mov al, strContenidoArchivo[si]
        UpperLetra
        cmp al, "N"
            jne AvanzarIndice
        
        inc si
        mov al, strContenidoArchivo[si]
        UpperLetra
        cmp al, "U"
            jne ErrorAnalisis
        
        inc si
        mov al, strContenidoArchivo[si]
        UpperLetra
        cmp al, "M"
            jne ErrorAnalisis

        inc si
        mov al, strContenidoArchivo[si]
        UpperLetra
        cmp al, "E"
            jne ErrorAnalisis

        inc si
        mov al, strContenidoArchivo[si]
        UpperLetra
        cmp al, "R"
            jne ErrorAnalisis

        inc si
        mov al, strContenidoArchivo[si]
        UpperLetra
        cmp al, "O"
            jne ErrorAnalisis 

        mov EstadoActual, ESTADO_FINAL_ETQ_NUMERO
        jmp AvanzarIndice

    FinalEtqNumero:

        cmp strContenidoArchivo[si], ">"
            jne AvanzarIndice

        mov EstadoActual, ESTADO_CONTENIDO_NUMERO
        jmp AvanzarIndice

    ContenidoNumero:
        
        mov ax, TYPE WORD
        mul cantidadValoresCargados
        mov di, ax

        INVOKE AnalizarNumero
        mov arregloValoresCargados[di], ax

        inc cantidadValoresCargados
        mov EstadoActual, ESTADO_INICIO_ETQ_NUMERO_FINAL
        jmp EvaluarEstado
    
    InicioEtqNumeroFinal:

        cmp strContenidoArchivo[si], "<"
            jne AvanzarIndice
        
        inc si
        cmp strContenidoArchivo[si], "/"
            jne ErrorAnalisis
        
        mov EstadoActual, ESTADO_ETQ_NUMERO_FINAL
        jmp AvanzarIndice

    EtqNumeroFinal:

        mov al, strContenidoArchivo[si]
        UpperLetra
        cmp al, "N"
            jne AvanzarIndice
        
        inc si
        mov al, strContenidoArchivo[si]
        UpperLetra
        cmp al, "U"
            jne ErrorAnalisis
        
        inc si
        mov al, strContenidoArchivo[si]
        UpperLetra
        cmp al, "M"
            jne ErrorAnalisis

        inc si
        mov al, strContenidoArchivo[si]
        UpperLetra
        cmp al, "E"
            jne ErrorAnalisis

        inc si
        mov al, strContenidoArchivo[si]
        UpperLetra
        cmp al, "R"
            jne ErrorAnalisis

        inc si
        mov al, strContenidoArchivo[si]
        UpperLetra
        cmp al, "O"
            jne ErrorAnalisis 

        mov EstadoActual, ESTADO_FIN_ETQ_NUMERO_FINAL
        jmp AvanzarIndice

    FinEtqNumeroFinal:
        
        cmp strContenidoArchivo[si], ">"
            jne AvanzarIndice

        mov EstadoActual, ESTADO_HAY_SIGUIENTE_NUMERO
        jmp AvanzarIndice


    HaySiguienteNumero:

        cmp strContenidoArchivo[si], "<"
            jne AvanzarIndice
        
        inc si
        cmp strContenidoArchivo[si], "/"
            je NoHaySiguienteNumero

        mov EstadoActual, ESTADO_ETQ_NUMERO
        jmp EvaluarEstado
        
    NoHaySiguienteNumero:

        mov EstadoActual, ESTADO_FINAL_ARCHIVO
        jmp AvanzarIndice
    
    FinArchivo:

        mov al, strContenidoArchivo[si]
        UpperLetra
        cmp al, "N"
            jne AvanzarIndice
        
        inc si
        mov al, strContenidoArchivo[si]
        UpperLetra
        cmp al, "U"
            jne ErrorAnalisis
        
        inc si
        mov al, strContenidoArchivo[si]
        UpperLetra
        cmp al, "M"
            jne ErrorAnalisis

        inc si
        mov al, strContenidoArchivo[si]
        UpperLetra
        cmp al, "E"
            jne ErrorAnalisis

        inc si
        mov al, strContenidoArchivo[si]
        UpperLetra
        cmp al, "R"
            jne ErrorAnalisis

        inc si
        mov al, strContenidoArchivo[si]
        UpperLetra
        cmp al, "O"
            jne ErrorAnalisis

        inc si
        mov al, strContenidoArchivo[si]
        UpperLetra
        cmp al, "S"
            jne ErrorAnalisis

        mov EstadoActual, ESTADO_FIN_FINAL_ARCHIVO
        jmp AvanzarIndice

    FinFinalArchivo:

        cmp strContenidoArchivo[si], ">"
            jne AvanzarIndice

        jmp ArchivoCorrecto

    AvanzarIndice:

        inc si

        cmp si, SIZEOF strContenidoArchivo
            jae ErrorAnalisis

        jmp EvaluarEstado

    ErrorAnalisis:

        ImprimirEnConsola strErrorAnalizarArchivo
        jmp Salir

    ArchivoCorrecto:

        ImprimirEnConsola strMsgArchivoCargado
        jmp Salir

    Salir:
        ret

AnalizarContenidoArchivo ENDP

;------------------------------------------------
EmitirSonidoByValor PROC valor : WORD, duracion : WORD
;
; Descripción : Emite un sonido en base al valor pasado por parámetro y con la duración pasada.
; Recibe      : valor = valor que determinará el sonido a emitir.
;               duracion = cantidad de milisegundos que durará la emisión del sonido.
; Devuelve    : NADA.
;------------------------------------------------

    EvaluarRango:

        cmp valor, 20
            jbe Rojo
        
        cmp valor, 40
            jbe Azul
        
        cmp valor, 60
            jbe Amarillo
        
        cmp valor, 80
            jbe Verde
        
        cmp valor, 99
            jbe Blanco

        Rojo:
            EmitirSonido 100, duracion
            jmp Salir
        Azul:
            EmitirSonido 300, duracion
            jmp Salir
        Amarillo:
            EmitirSonido 500, duracion
            jmp Salir
        Verde:
            EmitirSonido 700, duracion
            jmp Salir
        Blanco:
            EmitirSonido 900, duracion
            jmp Salir

    Salir:
        ret

EmitirSonidoByValor ENDP


;------------------------------------------------
CargarArchivo PROC USES ax bx si, pCadenaRuta : PTR BYTE
;
; Descripción : Carga el contenido de un archivo .xml en la variable global 'strContenidoArchivo'
; Recibe      : pCadenaRuta = dirección de memoria donde se encuentra la ruta del archivo.
; Devuelve    : NADA.
;------------------------------------------------

LOCAL handle : WORD

    Inicializacion:

        xor ax, ax
        xor si, si

        INVOKE LimpiarBuffer, ADDR strContenidoArchivo, SIZEOF strContenidoArchivo
        
        mov bx, pCadenaRuta

    EvaluarSimbolosRuta:

        cmp BYTE PTR[bx], "%"
            jne ErrorAperturaRuta

        INVOKE GetTamanioCadena, ADDR [bx + 1]
        mov si, ax

        cmp BYTE PTR[bx + si], "%"
            jne ErrorCierreRuta

        mov BYTE PTR[bx + si], 00h

    EvaluarExtension:

        INVOKE CopiarCadena, ADDR [bx + 1], ADDR strCadenaAuxiliar, si

        cmp strCadenaAuxiliar[si - 5], "."
            jne ErrorExtension
        cmp strCadenaAuxiliar[si - 4], "x"
            jne ErrorExtension
        cmp strCadenaAuxiliar[si - 3], "m"
            jne ErrorExtension
        cmp strCadenaAuxiliar[si - 2], "l"
            jne ErrorExtension

    Abrir:

        AbrirArchivo strCadenaAuxiliar, handle

        cmp handle, 0
            je ErrorRuta

    Leer:

        LeerArchivo handle, strContenidoArchivo, SIZEOF strContenidoArchivo

    Cerrar:

        CerrarArchivo handle
        jmp ArchivoCargado

    ErrorAperturaRuta:

        ImprimirEnConsola strErrorAperturaRuta
        jmp Salir
    
    ErrorCierreRuta:

        ImprimirEnConsola strErrorCierreRuta
        jmp Salir

    ErrorExtension:

        ImprimirEnConsola strErrorExtensionInvalida
        jmp Salir

    ErrorRuta:
        
        ImprimirEnConsola strErrorRuta
        jmp Salir

    ArchivoCargado:

        INVOKE AnalizarContenidoArchivo
        jmp Salir

    Salir:
        ret


CargarArchivo ENDP

;------------------------------------------------
SeleccionarOrdenamiento PROC
;
; Descripción : Muestra un menú para seleccionar el ordenamiento.
; Recibe      : NADA.
; Devuelve    : NADA.
;------------------------------------------------

    Mostrar:

        INVOKE LimpiarBuffer, ADDR strBufferEntrada, SIZEOF strBufferEntrada
        ImprimirEnConsola strSelecOrdenamiento
        INVOKE LeerCadenaConsola, ADDR strBufferEntrada, SIZEOF strBufferEntrada

        cmp strBufferEntrada[0], "1"
            je OrdemientoBurbuja
        
        cmp strBufferEntrada[0], "2"
            je OrdenamientoQuick

        cmp strBufferEntrada[0], "3"
            je OrdenamientoShell

        jmp Mostrar

    OrdemientoBurbuja:

        mov ordenamientoActual, ORDENAMIENTO_BURBUJA
        jmp Salir

    OrdenamientoQuick:

        mov ordenamientoActual, ORDENAMIENTO_QUICK
        jmp Salir

    OrdenamientoShell:

        mov ordenamientoActual, ORDENAMIENTO_SHELL
        jmp Salir

    Salir:
        ret

SeleccionarOrdenamiento ENDP

;------------------------------------------------
SeleccionarVelocidad PROC
;
; Descripción : Muestra un menú para seleccionar la velocidad.
; Recibe      : NADA.
; Devuelve    : NADA.
;------------------------------------------------

    Mostrar:

        INVOKE LimpiarBuffer, ADDR strBufferEntrada, SIZEOF strBufferEntrada
        ImprimirEnConsola strSelecVelocidad
        INVOKE LeerCadenaConsola, ADDR strBufferEntrada, SIZEOF strBufferEntrada

        mov al, strBufferEntrada[0]
        DigitoAsciiToNumero

        cmp al, 0
            jb Mostrar
        
        cmp al, 9
            ja Mostrar

        mov velocidadActual, al
    
    Salir:
        ret

SeleccionarVelocidad ENDP

;------------------------------------------------
SeleccionarOrden PROC
;
; Descripción : Muestra un menú para seleccionar el orden.
; Recibe      : NADA.
; Devuelve    : NADA.
;------------------------------------------------

    Mostrar:
        
        INVOKE LimpiarBuffer, ADDR strBufferEntrada, SIZEOF strBufferEntrada
        ImprimirEnConsola strSelecOrden
        INVOKE LeerCadenaConsola, ADDR strBufferEntrada, SIZEOF strBufferEntrada

        cmp strBufferEntrada[0], "1"
            je OrdenAscendente
        
        cmp strBufferEntrada[0], "2"
            je OrdenDescendente

        jmp Mostrar

    OrdenAscendente:

        mov ordenActual, ORDEN_ASCENDENTE
        jmp Salir
    
    OrdenDescendente:

        mov ordenActual, ORDEN_DESCENDENTE
        jmp Salir

    Salir:
        ret

SeleccionarOrden ENDP

;------------------------------------------------
DibujarValoresEnPantalla PROC pArreglo : PTR BYTE
;
; Descripción : Dibuja el encabezado y el arreglo enviado por parámetro.
; Recibe      : pArreglo = dirección del arreglo con los datos a dibujar.
; Devuelve    : NADA
;------------------------------------------------

    Dibujar:
        
        INVOKE EstablecerModoVideo
        INVOKE DibujarEncabezado
        INVOKE DibujarArregloBarraValor, pArreglo

    Salir:
        ret

DibujarValoresEnPantalla ENDP

;------------------------------------------------
GetValorDelay PROC USES cx
;
; Descripción : Obtiene el valor del delay dependiendo del nivel de velocidad guardado en la variable global 'velocidadActual'.
; Recibe      : NADA
; Devuelve    : ax = valor del delay
;------------------------------------------------

    Inicializacion:

        xor ax, ax
        xor cx, cx

        mov cx, 100

    EvaluarVelocidad:

        mov al, velocidadActual
        mul cl

        mov cx, 1200
        sub cx, ax
        mov ax, cx
        
    Salir:
        ret


GetValorDelay ENDP

;------------------------------------------------
RellenarArregloValoresOrdenados PROC USES ax bx si di cx pArregloDestino
;
; Descripción : Copia los valores del arreglo global 'arregloValoresCargados' al arreglo ubicado en la dirección de pArregloDestino
; Recibe      : NADA
; Devuelve    : arregloValoresOrdenados = copia de los valores de 'arregloValoresCargados'.
;------------------------------------------------

    Inicializacion:

        xor ax, ax
        xor si, si
        xor di, di
        xor cx, cx

        mov bx, pArregloDestino
    
    CicloRellenarValoresOrdenados:

        mov ax, arregloValoresCargados[si]
        mov WORD PTR[bx + di], ax

        add si, TYPE WORD
        add di, TYPE WORD
        inc cx

        cmp cx, cantidadValoresCargados
            jne CicloRellenarValoresOrdenados

    Salir:
        ret

RellenarArregloValoresOrdenados ENDP


;------------------------------------------------
OrdenarConMetodoBurbuja PROC USES ax bx cx dx si di pArreglo : PTR WORD, tamanioArreglo : WORD
;
; Descripción : Ordena los valores del arreglo pasado por parámetro utilizando el método BubbleSort
; Recibe      : pArreglo = dirección de memoria del arreglo a ordenar.
;               tamanioArreglo = tamaño del arreglo a ordenar.
; Devuelve    : NADA.
;------------------------------------------------

    Inicializacion:
        
        xor ax, ax
        xor bx, bx
        xor cx, cx
        xor dx, dx
        xor si, si
        xor di, di

        mov bx, pArreglo

    CicloExterior:
        
        xor cx, cx
        xor dx, dx
        xor di, di

        CicloInterior:

            push dx

            mov ax, WORD PTR[bx + di + TYPE WORD]
            mov dx, WORD PTR[bx + di]

            cmp ordenActual, ORDEN_ASCENDENTE
                je CompAscendente
            
            cmp ordenActual, ORDEN_DESCENDENTE
                je CompDescendente

            CompDescendente:

                cmp ax, dx
                    jg Swap

                jmp EvaluarCicloInterior

            CompAscendente:

                cmp ax, dx
                    jl Swap

                jmp EvaluarCicloInterior

            Swap:

                mov WORD PTR[bx + di + TYPE WORD], dx
                mov WORD PTR[bx + di], ax
            
                INVOKE GetValorDelay
                mov dx, ax

                INVOKE IncrementarTiempo, dx
                INVOKE DibujarValoresEnPantalla, bx
                INVOKE EmitirSonidoByValor, WORD PTR[bx + di], dx

            EvaluarCicloInterior:
                
                pop dx
                add di, TYPE WORD
                inc dx
                mov cx, tamanioArreglo
                sub cx, si
                sub cx, 1
                cmp dx, cx
                    jb CicloInterior
                
        inc si
        cmp si, tamanioArreglo
            jb CicloExterior

    Salir:
        ret

OrdenarConMetodoBurbuja ENDP

;------------------------------------------------
GetParticionQuickSort PROC USES bx cx dx si di pArreglo : PTR WORD, indiceMenor : WORD, indiceMayor : WORD
;
; Descripción : Procedimiento auxiliar del Ordenamiento QuickSort que obtiene el índice de particionamiento.
; Recibe      : pArreglo = dirección de memoria donde se encuentra el arreglo a ordenar.
;               indiceMenor = indice menor del arreglo donde se comenzará a evaluar.
;               indiceMayor = indice mayor del arreglo donde se terminará de evaluar.
; Devuelve    : ax = indice de partición.
;------------------------------------------------

LOCAL pivote : WORD, indiceResultante : WORD

    Inicializacion:
        
        xor ax, ax
        xor bx, bx
        xor cx, cx
        xor dx, dx
        xor si, si
        xor di, di
        
        mov bx, pArreglo
    
    GuardarPivote:

        mov ax, TYPE WORD
        mul indiceMayor
        mov si, ax
        mov ax, WORD PTR[bx + si]
        mov pivote, ax

    InicializarIndiceResultante:

        mov ax, indiceMenor
        sub ax, 1
        mov indiceResultante, ax 
    
    InicializarCiclo:

        mov cx, indiceMayor
        sub cx, 1

        mov ax, TYPE WORD
        mul indiceMenor
        mov si, ax

    Ciclo:

        mov ax, WORD PTR[bx + si]

        cmp ordenActual, ORDEN_ASCENDENTE
            je CompAscendente
            
        cmp ordenActual, ORDEN_DESCENDENTE
            je CompDescendente

        CompDescendente:

            cmp ax, pivote
                jg Swap1

            jmp EvaluarCiclo

        CompAscendente:

            cmp ax, pivote
                jl Swap1

            jmp EvaluarCiclo

        Swap1:

            inc indiceResultante

            mov ax, TYPE WORD
            mul indiceResultante
            mov di, ax

            mov ax, WORD PTR[bx + di] 
            mov dx, WORD PTR[bx + si]
        
            mov WORD PTR[bx + si], ax
            mov WORD PTR[bx + di], dx

            INVOKE GetValorDelay
            mov dx, ax    
            INVOKE IncrementarTiempo, dx
            INVOKE DibujarValoresEnPantalla, pArreglo
            INVOKE EmitirSonidoByValor, WORD PTR[bx + di], dx


        EvaluarCiclo:

           add si, TYPE WORD
           sub cx, 1

           cmp cx, indiceMenor
                jge Ciclo

    Swap2:

        inc indiceResultante

        mov ax, TYPE WORD
        mul indiceResultante
        mov di, ax

        mov ax, TYPE WORD
        mul indiceMayor
        mov si, ax

        mov ax, WORD PTR[bx + di]
        mov dx, WORD PTR[bx + si]

        mov WORD PTR[bx + si], ax
        mov WORD PTR[bx + di], dx

        mov ax, indiceResultante

    Salir:
        ret


GetParticionQuickSort ENDP

;------------------------------------------------
OrdenarConMetodoQuickSort PROC USES ax bx cx si di pArreglo : PTR WORD, indiceMenor : WORD, indiceMayor : WORD
;
; Descripción : Ordena los valores del arreglo pasado por parámetro utilizando el método Quicksort
; Recibe      : pArreglo = dirección de memoria del arreglo a ordenar.
;               indiceMenor = indice menor del arreglo donde se comenzará a evaluar.
;               indiceMayor = indice mayor del arreglo donde se terminará de evaluar.
; Devuelve    : NADA.
;------------------------------------------------

LOCAL indiceParticion : WORD

    Inicializacion:

        xor ax, ax
        xor bx, bx
        xor cx, cx 
        xor si, si
        xor di, di

    CompararIndices:

        mov si, indiceMenor
        mov di, indiceMayor

        cmp si, di
            jl Ordenar

        jmp Salir

    Ordenar:
            
        INVOKE GetParticionQuickSort, pArreglo, indiceMenor, indiceMayor
        mov indiceParticion, ax

        sub indiceParticion, 1
        INVOKE OrdenarConMetodoQuickSort, pArreglo, indiceMenor, indiceParticion

        add indiceParticion, 2
        INVOKE OrdenarConMetodoQuickSort, pArreglo, indiceParticion, indiceMayor

    Salir:
        ret

OrdenarConMetodoQuickSort ENDP

;------------------------------------------------
OrdenarConMetodoShellSort PROC USES ax bx cx dx si di pArreglo : PTR WORD, tamanioArreglo : WORD
;
; Descripción : Ordena los valores del arreglo pasado por parámetro utilizando el método ShellSort
; Recibe      : pArreglo = dirección de memoria del arreglo a ordenar.
;               tamanioArreglo = tamaño del arreglo a ordenar.
; Devuelve    : NADA.
;------------------------------------------------

LOCAL i : WORD, j : WORD, k : WORD 

    Inicializacion:
        
        xor ax, ax
        xor bx, bx
        xor cx, cx
        xor dx, dx
        xor si, si
        xor di, di
        
        mov bx, pArreglo

    InicializarCiclo1:

        mov ax, tamanioArreglo
        mov dh, 0
        mov dl, 2
        div dl
        mov ah, 0
        mov i, ax

        cmp i, 0
            jg Ciclo1
        
        jmp Salir

    Ciclo1:

        InicializarCiclo2:

            mov ax, i
            mov j, ax

            mov ax, tamanioArreglo
            cmp j, ax
                jl Ciclo2
            
            jmp EvaluarCiclo1
        
        Ciclo2:

            InicializarCiclo3:

                mov ax, j
                mov k, ax
                mov ax, i
                sub k, ax

                cmp k, 0
                    jge Ciclo3

                jmp EvaluarCiclo2

            Ciclo3:

                mov ax, k
                add ax, i
                mov si, TYPE WORD
                mul si
                mov si, ax
                mov cx, WORD PTR[bx + si]

                mov ax, k
                mov di, TYPE WORD
                mul di
                mov di, ax
                mov dx, WORD PTR[bx + di]

                cmp ordenActual, ORDEN_ASCENDENTE
                    je CompAscendente
                    
                cmp ordenActual, ORDEN_DESCENDENTE
                    je CompDescendente

                CompDescendente:

                    cmp cx, dx
                        jg Swap

                    jmp EvaluarCiclo2

                CompAscendente:

                    cmp cx, dx
                        jl Swap

                    jmp EvaluarCiclo2
                
                Swap:

                    mov cx, WORD PTR[bx + di] 
                    mov dx, WORD PTR[bx + si]
        
                    mov WORD PTR[bx + si], cx
                    mov WORD PTR[bx + di], dx

                    INVOKE GetValorDelay
                    mov dx, ax    
                    INVOKE IncrementarTiempo, dx
                    INVOKE DibujarValoresEnPantalla, pArreglo
                    INVOKE EmitirSonidoByValor, WORD PTR[bx + di], dx

            EvaluarCiclo3:

                mov ax, i
                sub k, ax
                cmp k, 0
                    jge Ciclo3

        EvaluarCiclo2:

            add j, 1
            mov ax, tamanioArreglo

            cmp j, ax
                jl Ciclo2

    EvaluarCiclo1:

        mov ax, i
        mov dh, 0
        mov dl, 2
        div dl
        mov ah, 0
        mov i, ax

        cmp i, 0
            jg Ciclo1

    Salir:
        ret


OrdenarConMetodoShellSort ENDP

;------------------------------------------------
EscribirEnReporte PROC handle : WORD, pCadena : PTR BYTE, tamanioCadena : WORD, saltoLinea : BYTE
;
; Descripción : Escribe una cadena en el reporte y posiciona el cursor al final del archivo.
; Recibe      : handle = handle del reporte.
;             : pCadena = dirección de memoria de la cadena a escribir.
;             : tamanioCadena = Tamaño de la cadena a escribir.
;             : saltoLinea = 1; Inserta salto de línea, saltoLinea = 0; No inserta salto de linea.
; Devuelve    : NADA.
;------------------------------------------------

    INVOKE CopiarCadena, pCadena, ADDR strCadenaAuxiliar, tamanioCadena
    EscribirEnArchivo handle, strCadenaAuxiliar, tamanioCadena

    cmp saltoLinea, 1
        jne Salir

    InsertarSalto:
        PosicionarEnFinalDeArchivo handle
        INVOKE CopiarCadena, ADDR strSaltoLinea, ADDR strCadenaAuxiliar, SIZEOF strSaltoLinea
        EscribirEnArchivo handle, strCadenaAuxiliar, SIZEOF strSaltoLinea

    Salir:
        PosicionarEnFinalDeArchivo handle
        ret

EscribirEnReporte ENDP


;------------------------------------------------
EscribirNumeroEnReporte PROC USES ax dx handle : WORD, numero : WORD, saltoLinea : BYTE
;
; Descripción : Escribe un número en el reporte y posiciona el cursor al final del archivo.
; Recibe      : handle = handle del reporte.
;             : numero = numero a escribir
;             : saltoLinea = 1; Inserta salto de línea, saltoLinea = 0; No inserta salto de linea.
; Devuelve    : NADA.
;------------------------------------------------
    Inicializacion:

        xor ax, ax
        xor dx, dx

    Convertir:

        INVOKE ConvertirNumeroToCadena, numero, ADDR strCadenaAuxiliar, SIZEOF strCadenaAuxiliar
        INVOKE GetTamanioCadena, ADDR strCadenaAuxiliar
        mov dx, ax

    Escribir:

        EscribirEnArchivo handle, strCadenaAuxiliar, dx
        cmp saltoLinea, 1
            jne Salir

    InsertarSalto:
        PosicionarEnFinalDeArchivo handle
        INVOKE CopiarCadena, ADDR strSaltoLinea, ADDR strCadenaAuxiliar, SIZEOF strSaltoLinea
        EscribirEnArchivo handle, strCadenaAuxiliar, SIZEOF strSaltoLinea

    Salir:
        PosicionarEnFinalDeArchivo handle
        ret

EscribirNumeroEnReporte ENDP

;------------------------------------------------
EscribirTabulacionEnReporte PROC USES cx handleReporte : WORD, cantidadTabulacion : WORD
;
; Descripción : Inserta tabulaciones al reporte.
; Recibe      : handle = handle del reporte.
;             : cantidadTabulacion = numreo de tabulaciones a insertar.
; Devuelve    : NADA.
;------------------------------------------------

    Inicializacion:
        
        xor cx, cx
        mov cx, cantidadTabulacion
    
    Ciclo:

        INVOKE EscribirEnReporte, handleReporte, ADDR strTabulacion, 1, 0
        Loop Ciclo

    Salir:
        ret

EscribirTabulacionEnReporte ENDP

;------------------------------------------------
CrearReporte PROC USES ax bx cx dx di si, pNombreReporte : PTR BYTE
;
; Descripción : Crea el reporte de ordenamientos en formato xml.
; Recibe      : pNombreReporte = dirección de memoria del nombre con el que se guardará el reporte.
; Devuelve    : NADA.
;------------------------------------------------

LOCAL handleReporte : WORD

    Inicializacion:

        xor ax, ax
        xor bx, bx
        xor cx, cx
        xor si, si
        xor di, di
    
        INVOKE GetTiempo
        INVOKE GetFecha

    Creacion:

        INVOKE CopiarCadena, pNombreReporte, ADDR strCadenaAuxiliar, SIZEOF strCadenaAuxiliar
        
        INVOKE GetTamanioCadena, ADDR strCadenaAuxiliar
        mov si, ax

        mov strCadenaAuxiliar[si], "."
        mov strCadenaAuxiliar[si + 1], "x"
        mov strCadenaAuxiliar[si + 2], "m"
        mov strCadenaAuxiliar[si + 3], "l"

        CrearArchivo strCadenaAuxiliar, handleReporte

    Escritura:

        INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreArqui, SIZEOF strEtqAbreArqui, 1

            INVOKE EscribirTabulacionEnReporte, handleReporte, 1
            INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreEncabezado, SIZEOF strEtqAbreEncabezado, 1

                INVOKE EscribirTabulacionEnReporte, handleReporte, 2
                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqUniversidad, SIZEOF strEtqUniversidad, 1

                INVOKE EscribirTabulacionEnReporte, handleReporte, 2
                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqFacultad, SIZEOF strEtqFacultad, 1

                INVOKE EscribirTabulacionEnReporte, handleReporte, 2
                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqEscuela, SIZEOF strEtqEscuela, 1

                INVOKE EscribirTabulacionEnReporte, handleReporte, 2
                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreCurso, SIZEOF strEtqAbreCurso, 1

                    INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                    INVOKE EscribirEnReporte, handleReporte, ADDR strEtqNombreCurso, SIZEOF strEtqNombreCurso, 1

                    INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                    INVOKE EscribirEnReporte, handleReporte, ADDR strEtqSeccionCurso, SIZEOF strEtqSeccionCurso, 1

                INVOKE EscribirTabulacionEnReporte, handleReporte, 2
                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraCurso, SIZEOF strEtqCierraCurso, 1   

                INVOKE EscribirTabulacionEnReporte, handleReporte, 2
                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreFecha, SIZEOF strEtqAbreFecha, 1

                    INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                        mov al, strFechaReporte[0]
                        mov strEtqDia[5], al
                        mov al, strFechaReporte[1]
                        mov strEtqDia[6], al
                    INVOKE EscribirEnReporte, handleReporte, ADDR strEtqDia, SIZEOF strEtqDia, 1

                    INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                        mov al, strFechaReporte[3]
                        mov strEtqMes[5], al
                        mov al, strFechaReporte[4]
                        mov strEtqMes[6], al                    
                    INVOKE EscribirEnReporte, handleReporte, ADDR strEtqMes, SIZEOF strEtqMes, 1
                    
                    INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                        mov al, strFechaReporte[6]
                        mov strEtqAnio[6], al
                        mov al, strFechaReporte[7]
                        mov strEtqAnio[7], al     
                        mov al, strFechaReporte[8]
                        mov strEtqAnio[8], al     
                        mov al, strFechaReporte[9]
                        mov strEtqAnio[9], al     
                    INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAnio, SIZEOF strEtqAnio, 1

                INVOKE EscribirTabulacionEnReporte, handleReporte, 2
                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraFecha, SIZEOF strEtqCierraFecha, 1

                INVOKE EscribirTabulacionEnReporte, handleReporte, 2
                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreHora, SIZEOF strEtqAbreHora, 1

                INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                    mov al, strTiempoReporte[0]
                    mov strEtqHora[6], al
                    mov al, strTiempoReporte[1]
                    mov strEtqHora[7], al
                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqHora, SIZEOF strEtqHora, 1

                INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                    mov al, strTiempoReporte[3]
                    mov strEtqMinutos[9], al
                    mov al, strTiempoReporte[4]
                    mov strEtqMinutos[10], al
                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqMinutos, SIZEOF strEtqMinutos, 1

                INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                    mov al, strTiempoReporte[6]
                    mov strEtqSegundos[10], al
                    mov al, strTiempoReporte[7]
                    mov strEtqSegundos[11], al
                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqSegundos, SIZEOF strEtqSegundos, 1

                INVOKE EscribirTabulacionEnReporte, handleReporte, 2
                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraHora, SIZEOF strEtqCierraHora, 1

                INVOKE EscribirTabulacionEnReporte, handleReporte, 2
                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreAlumno, SIZEOF strEtqAbreAlumno, 1

                    INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                    INVOKE EscribirEnReporte, handleReporte, ADDR strEtqNombreAlumno, SIZEOF strEtqNombreAlumno, 1

                    INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                    INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCarnet, SIZEOF strEtqCarnet, 1

                INVOKE EscribirTabulacionEnReporte, handleReporte, 2
                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraAlumno, SIZEOF strEtqCierraAlumno, 1

            INVOKE EscribirTabulacionEnReporte, handleReporte, 1
            INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraEncabezado, SIZEOF strEtqCierraEncabezado, 1

            INVOKE EscribirTabulacionEnReporte, handleReporte, 1
            INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreResultados, SIZEOF strEtqAbreResultados, 1

                INVOKE EscribirTabulacionEnReporte, handleReporte, 2
                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreListaEntrada, SIZEOF strEtqAbreListaEntrada, 0

                mov cx, cantidadValoresCargados
                mov si, 0

                CicloListaEntrada:

                    INVOKE EscribirNumeroEnReporte, handleReporte, arregloValoresCargados[si], 0

                    cmp cx, 1
                        jg AgregarComa
                    jmp EvaluarCiclo

                    AgregarComa:
                        
                        INVOKE EscribirEnReporte, handleReporte, ADDR strComa, SIZEOF strComa, 0

                    EvaluarCiclo:
                        add si, TYPE WORD
                        Loop CicloListaEntrada

                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraListaEntrada, SIZEOF strEtqCierraListaEntrada, 1
                
                ResultadosBubble:

                    INVOKE EscribirTabulacionEnReporte, handleReporte, 2
                    INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreBubbleSort, SIZEOF strEtqAbreBubbleSort, 1

                        cmp ordenBubbleSort, ORDEN_DESCENDENTE
                            je BubbleDescendente

                        BubbleAscendente:
                            
                            INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                            INVOKE EscribirEnReporte, handleReporte, ADDR strEtqTipoAscendente, SIZEOF strEtqTipoAscendente, 1
                            jmp InicializarCicloListaBubble

                        BubbleDescendente:
                            
                            INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                            INVOKE EscribirEnReporte, handleReporte, ADDR strEtqTipoDescendente, SIZEOF strEtqTipoDescendente, 1                
                        
                        InicializarCicloListaBubble:
                            
                            INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                            INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreListaOrdenada, SIZEOF strEtqAbreListaOrdenada, 0
                            mov cx, cantidadValoresCargados
                            mov si, 0

                        CicloListaBubble:
                            
                            INVOKE EscribirNumeroEnReporte, handleReporte, arregloValoresBubbleSort[si], 0

                            cmp cx, 1
                                jg AgregarComaBubble
                            jmp EvaluarCicloBubble

                            AgregarComaBubble:
                                
                                INVOKE EscribirEnReporte, handleReporte, ADDR strComa, SIZEOF strComa, 0

                            EvaluarCicloBubble:

                                add si, TYPE WORD
                                Loop CicloListaBubble

                        INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraListaOrdenada, SIZEOF strEtqCierraListaOrdenada, 1

                        VelocidadBubble:
                            
                            INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                            INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreVelocidad, SIZEOF strEtqAbreVelocidad, 0
                                INVOKE EscribirNumeroEnReporte, handleReporte, velocidadBubbleSort, 0
                            INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraVelocidad, SIZEOF strEtqCierraVelocidad, 1
                        
                        TiempoBubble:
                            
                            INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                            INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreTiempo, SIZEOF strEtqAbreTiempo, 1
                                
                                INVOKE EscribirTabulacionEnReporte, handleReporte, 4
                                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreMinutos, SIZEOF strEtqAbreMinutos, 0
                                    INVOKE EscribirNumeroEnReporte, handleReporte, minutosBubbleSort, 0
                                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraMinutos, SIZEOF strEtqCierraMinutos, 1

                                INVOKE EscribirTabulacionEnReporte, handleReporte, 4
                                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreSegundos, SIZEOF strEtqAbreSegundos, 0
                                    INVOKE EscribirNumeroEnReporte, handleReporte, segundosBubbleSort, 0
                                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraSegundos, SIZEOF strEtqCierraSegundos, 1

                                INVOKE EscribirTabulacionEnReporte, handleReporte, 4
                                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreMilisegundos, SIZEOF strEtqAbreMilisegundos, 0
                                    INVOKE EscribirNumeroEnReporte, handleReporte, milisegundosBubbleSort, 0
                                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraMilisegundos, SIZEOF strEtqCierraMilisegundos, 1

                            INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                            INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraTiempo, SIZEOF strEtqCierraTiempo, 1

                    INVOKE EscribirTabulacionEnReporte, handleReporte, 2
                    INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraBubbleSort, SIZEOF strEtqCierraBubbleSort, 1

                ResultadosQuick:

                    INVOKE EscribirTabulacionEnReporte, handleReporte, 2
                    INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreQuickSort, SIZEOF strEtqAbreQuickSort, 1

                        cmp ordenQuickSort, ORDEN_DESCENDENTE
                            je QuickDescendente

                        QuickAscendente:
                            
                            INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                            INVOKE EscribirEnReporte, handleReporte, ADDR strEtqTipoAscendente, SIZEOF strEtqTipoAscendente, 1
                            jmp InicializarCicloListaQuick

                        QuickDescendente:
                            
                            INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                            INVOKE EscribirEnReporte, handleReporte, ADDR strEtqTipoDescendente, SIZEOF strEtqTipoDescendente, 1                

                        InicializarCicloListaQuick:

                            INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                            INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreListaOrdenada, SIZEOF strEtqAbreListaOrdenada, 0
                            mov cx, cantidadValoresCargados
                            mov si, 0

                        CicloListaQuick:
                            
                            INVOKE EscribirNumeroEnReporte, handleReporte, arregloValoresQuickSort[si], 0

                            cmp cx, 1
                                jg AgregarComaQuick
                            jmp EvaluarCicloQuick

                            AgregarComaQuick:
                                
                                INVOKE EscribirEnReporte, handleReporte, ADDR strComa, SIZEOF strComa, 0

                            EvaluarCicloQuick:

                                add si, TYPE WORD
                                Loop CicloListaQuick

                        INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraListaOrdenada, SIZEOF strEtqCierraListaOrdenada, 1

                        VelocidadQuick:
                            
                            INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                            INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreVelocidad, SIZEOF strEtqAbreVelocidad, 0
                                INVOKE EscribirNumeroEnReporte, handleReporte, velocidadQuickSort, 0
                            INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraVelocidad, SIZEOF strEtqCierraVelocidad, 1
                        
                        TiempoQuick:
                            
                            INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                            INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreTiempo, SIZEOF strEtqAbreTiempo, 1
                                
                                INVOKE EscribirTabulacionEnReporte, handleReporte, 4
                                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreMinutos, SIZEOF strEtqAbreMinutos, 0
                                    INVOKE EscribirNumeroEnReporte, handleReporte, minutosQuickSort, 0
                                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraMinutos, SIZEOF strEtqCierraMinutos, 1

                                INVOKE EscribirTabulacionEnReporte, handleReporte, 4
                                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreSegundos, SIZEOF strEtqAbreSegundos, 0
                                    INVOKE EscribirNumeroEnReporte, handleReporte, segundosQuickSort, 0
                                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraSegundos, SIZEOF strEtqCierraSegundos, 1

                                INVOKE EscribirTabulacionEnReporte, handleReporte, 4
                                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreMilisegundos, SIZEOF strEtqAbreMilisegundos, 0
                                    INVOKE EscribirNumeroEnReporte, handleReporte, milisegundosQuickSort, 0
                                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraMilisegundos, SIZEOF strEtqCierraMilisegundos, 1

                            INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                            INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraTiempo, SIZEOF strEtqCierraTiempo, 1

                    INVOKE EscribirTabulacionEnReporte, handleReporte, 2
                    INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraQuickSort, SIZEOF strEtqCierraQuickSort, 1

                ResultadosShell:
                
                    INVOKE EscribirTabulacionEnReporte, handleReporte, 2
                    INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreShellSort, SIZEOF strEtqAbreShellSort, 1

                        cmp ordenShellSort, ORDEN_DESCENDENTE
                            je ShellDescendente

                        ShellAscendente:
                            
                            INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                            INVOKE EscribirEnReporte, handleReporte, ADDR strEtqTipoAscendente, SIZEOF strEtqTipoAscendente, 1
                            jmp InicializarCicloListaShell

                        ShellDescendente:
                            
                            INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                            INVOKE EscribirEnReporte, handleReporte, ADDR strEtqTipoDescendente, SIZEOF strEtqTipoDescendente, 1                

                        InicializarCicloListaShell:

                            INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                            INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreListaOrdenada, SIZEOF strEtqAbreListaOrdenada, 0
                            mov cx, cantidadValoresCargados
                            mov si, 0

                        CicloListaShell:
                            
                            INVOKE EscribirNumeroEnReporte, handleReporte, arregloValoresShellSort[si], 0

                            cmp cx, 1
                                jg AgregarComaShell
                            jmp EvaluarCicloShell

                            AgregarComaShell:
                                
                                INVOKE EscribirEnReporte, handleReporte, ADDR strComa, SIZEOF strComa, 0

                            EvaluarCicloShell:

                                add si, TYPE WORD
                                Loop CicloListaShell

                        INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraListaOrdenada, SIZEOF strEtqCierraListaOrdenada, 1

                        VelocidadShell:
                            
                            INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                            INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreVelocidad, SIZEOF strEtqAbreVelocidad, 0
                                INVOKE EscribirNumeroEnReporte, handleReporte, velocidadShellSort, 0
                            INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraVelocidad, SIZEOF strEtqCierraVelocidad, 1
                        
                        TiempoShell:
                            
                            INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                            INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreTiempo, SIZEOF strEtqAbreTiempo, 1
                                
                                INVOKE EscribirTabulacionEnReporte, handleReporte, 4
                                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreMinutos, SIZEOF strEtqAbreMinutos, 0
                                    INVOKE EscribirNumeroEnReporte, handleReporte, minutosShellSort, 0
                                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraMinutos, SIZEOF strEtqCierraMinutos, 1

                                INVOKE EscribirTabulacionEnReporte, handleReporte, 4
                                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreSegundos, SIZEOF strEtqAbreSegundos, 0
                                    INVOKE EscribirNumeroEnReporte, handleReporte, segundosShellSort, 0
                                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraSegundos, SIZEOF strEtqCierraSegundos, 1

                                INVOKE EscribirTabulacionEnReporte, handleReporte, 4
                                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqAbreMilisegundos, SIZEOF strEtqAbreMilisegundos, 0
                                    INVOKE EscribirNumeroEnReporte, handleReporte, milisegundosShellSort, 0
                                INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraMilisegundos, SIZEOF strEtqCierraMilisegundos, 1

                            INVOKE EscribirTabulacionEnReporte, handleReporte, 3
                            INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraTiempo, SIZEOF strEtqCierraTiempo, 1

                    INVOKE EscribirTabulacionEnReporte, handleReporte, 2
                    INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraShellSort, SIZEOF strEtqCierraShellSort, 1

            INVOKE EscribirTabulacionEnReporte, handleReporte, 1
            INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraResultados, SIZEOF strEtqCierraResultados, 1

        INVOKE EscribirEnReporte, handleReporte, ADDR strEtqCierraArqui, SIZEOF strEtqCierraArqui, 1
    
    Cierre:
        CerrarArchivo handleReporte

    Salir:
        ret

CrearReporte ENDP

;------------------------------------------------
EjecutarMenu PROC USES ax 
;
; Descripción : Muestra el menú y y lee la opción ingresada por el usuario.
; Recibe      : NADA.
; Devuelve    : NADA.
;------------------------------------------------

    Inicializacion:
        
        xor ax, ax

    Mostrar:

        ImprimirEnConsola strMenuInicio
        INVOKE LimpiarBuffer, ADDR strBufferEntrada, SIZEOF strBufferEntrada
        INVOKE LeerCadenaConsola, ADDR strBufferEntrada, SIZEOF strBufferEntrada
    
    EvaluarOpciones:

        cmp strBufferEntrada[1], 00h
            jne OpInvalida

        cmp strBufferEntrada[0], "1"
            je OpCargarArchivo

        cmp strBufferEntrada[0], "2"
            je OpOrdenar

        cmp strBufferEntrada[0], "3"
            je OpGenerarReporte

        cmp strBufferEntrada[0], "4"
            je Salir

        jmp Mostrar
            

    OpCargarArchivo:

        INVOKE LimpiarBuffer, ADDR strBufferEntrada, SIZEOF strBufferEntrada
        ImprimirEnConsola strCargarArchivo
        INVOKE LeerCadenaConsola, ADDR strBufferEntrada, SIZEOF strBufferEntrada
        INVOKE CargarArchivo, ADDR strBufferEntrada

        jmp Mostrar

    OpOrdenar:

        cmp cantidadValoresCargados, 0
            je ErrorValoresNoCargados
        cmp cantidadValoresCargados, 10
            jb ErrorMenosDelRango
        cmp cantidadValoresCargados, 25
            ja ErrorMasDelRango

        INVOKE SeleccionarOrdenamiento
        INVOKE SeleccionarVelocidad
        INVOKE SeleccionarOrden

        INVOKE DibujarValoresEnPantalla, ADDR arregloValoresCargados

        LeerTecla:

            LeerCaracterConsola
            cmp al, " "
                je IniciarOrdenamiento
            
            cmp al, 1Bh
                je RegresarModoTexto

            jmp LeerTecla
            
        IniciarOrdenamiento:

            mov minutosDesdeInicio, 0
            mov segundosDesdeInicio, 0
            mov milisegundosDesdeInicio, 0

            cmp ordenamientoActual, ORDENAMIENTO_BURBUJA
                je OrdenamientoBurbuja

            cmp ordenamientoActual, ORDENAMIENTO_QUICK
                je OrdenamientoQuick
            
            cmp ordenamientoActual, ORDENAMIENTO_SHELL
                je OrdenamientoShell

        OrdenamientoBurbuja:

            mov ax, ordenActual
            mov ordenBubbleSort, ax

            mov al, velocidadActual
            mov velocidadBubbleSort, al

            INVOKE RellenarArregloValoresOrdenados, ADDR arregloValoresBubbleSort
            INVOKE OrdenarConMetodoBurbuja, ADDR arregloValoresBubbleSort, cantidadValoresCargados

            mov ax, minutosDesdeInicio
            mov minutosBubbleSort, ax

            mov ax, segundosDesdeInicio
            mov segundosBubbleSort, ax

            mov ax, milisegundosDesdeInicio
            mov milisegundosBubbleSort, ax

            INVOKE DibujarValoresEnPantalla, ADDR arregloValoresBubbleSort
            jmp FinOrdenado

        OrdenamientoQuick:

            mov ax, ordenActual
            mov ordenQuickSort, ax

            mov al, velocidadActual
            mov velocidadQuickSort, al

            INVOKE RellenarArregloValoresOrdenados, ADDR arregloValoresQuickSort
            
            sub cantidadValoresCargados, 1
            INVOKE OrdenarConMetodoQuickSort, ADDR arregloValoresQuickSort, 0, cantidadValoresCargados
            add cantidadValoresCargados, 1
            
            mov ax, minutosDesdeInicio
            mov minutosQuickSort, ax

            mov ax, segundosDesdeInicio
            mov segundosQuickSort, ax

            mov ax, milisegundosDesdeInicio
            mov milisegundosQuickSort, ax

            INVOKE DibujarValoresEnPantalla, ADDR arregloValoresQuickSort
            jmp FinOrdenado

        OrdenamientoShell:

            mov ax, ordenActual
            mov ordenShellSort, ax

            mov al, velocidadActual
            mov velocidadShellSort, al
        
            INVOKE RellenarArregloValoresOrdenados, ADDR arregloValoresShellSort
            INVOKE OrdenarConMetodoShellSort, ADDR arregloValoresShellSort, cantidadValoresCargados

            mov ax, minutosDesdeInicio
            mov minutosShellSort, ax

            mov ax, segundosDesdeInicio
            mov segundosShellSort, ax

            mov ax, milisegundosDesdeInicio
            mov milisegundosShellSort, ax

            INVOKE DibujarValoresEnPantalla, ADDR arregloValoresShellSort
            jmp FinOrdenado
        
        FinOrdenado:

            jmp LeerTecla

        RegresarModoTexto:

            INVOKE EstablecerModoTexto
            jmp Mostrar

    OpGenerarReporte:

            INVOKE CrearReporte, ADDR strNombreArchivoReporte
            jmp Mostrar

    OpInvalida:

        ImprimirEnConsola strErrorOpInvalida
        jmp Mostrar
    
    ErrorValoresNoCargados:

        ImprimirEnConsola strErrorValoresNoCargados
        jmp Mostrar
    
    ErrorMenosDelRango:

        ImprimirEnConsola strErrorMenosDelRango
        jmp Mostrar

    ErrorMasDelRango:

        ImprimirEnConsola strErrorMasDelRango
        jmp Mostrar

    Salir:
        ret

EjecutarMenu ENDP


Main PROC

    Inicializacion:

        mov ax, @data
        mov ds, ax

    Menu:

        INVOKE EjecutarMenu

    Salir:
        TerminarPrograma
    
Main ENDP


END Main
