//Luis Enrique Torres Murillo - 22210361
//Programa que realiza una serie de fibonacci
.global _start

.section .data
    N: .word 10                 // Número de términos de Fibonacci a calcular (ejemplo: 10)
    fibo_buffer: .ascii "     \n" // Buffer para almacenar los números de Fibonacci en ASCII

.section .text
_start:
    // Inicializar los primeros términos de Fibonacci
    mov w0, #0                  // Primer término (0)
    mov w1, #1                  // Segundo término (1)

    // Cargar el valor de N
    adr x2, N
    ldr w2, [x2]                // Cargar el valor de N en w2

    // Imprimir el primer término (0)
    bl print_number
    // Imprimir el segundo término (1)
    bl print_number

    // Calcular la serie de Fibonacci hasta el N-ésimo término
fibonacci_loop:
    sub w2, w2, #1              // Disminuir N para contar el término calculado
    cmp w2, #1                  // Comparar con 1, ya que ya imprimimos los primeros dos términos
    ble end_fibonacci           // Si N <= 1, salir del bucle

    // Calcular el siguiente término
    add w3, w0, w1              // w3 = w0 + w1 (siguiente término de Fibonacci)
    mov w0, w1                  // Mover el segundo término al primero
    mov w1, w3                  // Actualizar el segundo término con el nuevo valor

    // Imprimir el término actual
    bl print_number
    b fibonacci_loop            // Repetir el ciclo

end_fibonacci:
    // Salir del programa
    mov x0, #0
    mov x8, #93                 // Llamada al sistema para salir
    svc 0

// Subrutina para imprimir un número en ASCII
print_number:
    // Convertir el número en w3 a ASCII y almacenarlo en fibo_buffer
    adr x4, fibo_buffer         // x4 apunta al buffer
    mov w5, w3                  // Copiar el número en w5 para la conversión

    // Convertir unidades
    mov w6, #10
    udiv w7, w5, w6             // w7 = número / 10 (parte entera)
    msub w8, w7, w6, w5         // w8 = número % 10
    add w8, w8, #48             // Convertir a ASCII
    strb w8, [x4, #4]           // Guardar la unidad en el buffer

    mov w5, w7                  // Actualizar w5 a número / 10

    // Convertir decenas
    udiv w7, w5, w6             // w7 = (número / 10) / 10
    msub w8, w7, w6, w5         // w8 = (número / 10) % 10
    add w8, w8, #48             // Convertir a ASCII
    strb w8, [x4, #3]           // Guardar la decena en el buffer

    mov w5, w7                  // Actualizar w5 para convertir centenas

    // Convertir centenas
    udiv w7, w5, w6             // w7 = ((número / 10) / 10) / 10
    msub w8, w7, w6, w5         // w8 = ((número / 10) / 10) % 10
    add w8, w8, #48             // Convertir a ASCII
    strb w8, [x4, #2]           // Guardar la centena en el buffer

    mov w5, w7                  // Actualizar w5 para convertir las unidades de mil

    // Convertir unidades de mil
    add w5, w5, #48             // Convertir a ASCII
    strb w5, [x4, #1]           // Guardar las unidades de mil en el buffer

    // Imprimir el número en pantalla
    mov x0, #1                  // Descriptor de archivo para stdout
    adr x1, fibo_buffer         // Dirección del buffer
    mov x2, #6                  // Número de bytes a imprimir (incluye un espacio para separación)
    mov x8, #64                 // Código del sistema para write
    svc 0

    ret                         // Regresar al punto de llamada

