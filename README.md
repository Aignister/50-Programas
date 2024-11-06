# 50-Programas
50 Programas de ARM de Lenguajes De Interfaz

# Programas Dificultad: Facil
## 1 Convertir temperatura de Celsius a Fahrenheit
        .global _start
        .section .data
            prompt: .ascii "Ingresa la temperatura en grados Celsius: "
            prompt_len = . - prompt
            input_buffer: .skip 10      // Espacio para entrada de usuario
            input_len = 10
            celsius_msg: .ascii "Temperatura en Celsius: "
            celsius_msg_len = . - celsius_msg
            fahrenheit_msg: .ascii "Temperatura en Fahrenheit: "
            fahrenheit_msg_len = . - fahrenheit_msg
            newline: .ascii "\n"
            newline_len = 1
        
        .section .text
        _start:
            // Imprimir mensaje de solicitud de entrada
            mov x0, #1
            adr x1, prompt
            mov x2, prompt_len
            mov x8, #64
            svc 0
        
            // Leer entrada de usuario
            mov x0, #0
            adr x1, input_buffer
            mov x2, input_len
            mov x8, #63
            svc 0
        
            // Convertir entrada de usuario a número
            adr x19, input_buffer
            bl atoi
            mov x19, x0        // x19 contiene el valor de entrada en Celsius
        
            // Imprimir temperatura en Celsius
            mov x0, #1
            adr x1, celsius_msg
            mov x2, celsius_msg_len
            mov x8, #64
            svc 0
        
            mov x0, x19
            bl print_int
        
            // Convertir Celsius a Fahrenheit
            mov x0, x19
            bl celsius_to_fahrenheit
            mov x19, x0        // x19 contiene el valor en Fahrenheit
        
            // Imprimir temperatura en Fahrenheit
            mov x0, #1
            adr x1, fahrenheit_msg
            mov x2, fahrenheit_msg_len
            mov x8, #64
            svc 0
        
            mov x0, x19
            bl print_int
        
            // Imprimir nueva línea
            mov x0, #1
            adr x1, newline
            mov x2, newline_len
            mov x8, #64
            svc 0
        
            // Salir
            mov x0, #0
            mov x8, #93
            svc 0
        
        // Función para convertir Celsius a Fahrenheit
        celsius_to_fahrenheit:
            // Fórmula: F = (C * 9/5) + 32
            mov x1, #9
            mul x0, x0, x1
            mov x1, #5
            udiv x0, x0, x1
            add x0, x0, #32
            ret
        
        // Función para imprimir un número entero
        print_int:
            // Convertir número a ASCII
            adr x10, input_buffer
            mov x11, #10      // Divisor para convertir dígitos
            mov x12, #0       // Índice para el buffer
        
        convert_digit:
            udiv x13, x0, x11 // Dividir por 10
            msub x14, x13, x11, x0 // Obtener el residuo
            add x14, x14, #48 // Convertir a ASCII
            strb x14, [x10, x12] // Almacenar en buffer
            mov x0, x13      // Actualizar x0 para siguiente dígito
            add x12, x12, #1  // Incrementar índice
            cmp x0, #0
            bne convert_digit
        
            // Imprimir número
            mov x0, #1
            mov x1, x10
            mov x2, x12
            mov x8, #64
            svc 0
            ret
        
        // Función para convertir entrada de usuario a número
        atoi:
            mov x0, #0       // Resultado
            mov x1, #10      // Base (decimal)
            mov x2, #0       // Índice
        
        convert_char:
            ldrb w3, [x19, x2] // Cargar carácter
            cmp w3, #0        // Verificar si es el final de la cadena
            beq end
            sub w3, w3, #48   // Convertir a valor numérico
            mul x0, x0, x1    // Multiplicar por 10 (desplazar un dígito a la izquierda)
            add x0, x0, x3    // Agregar el nuevo dígito
            add x2, x2, #1    // Incrementar índice
            b convert_char
        
        end:
            ret
## 2 Suma de dos números
        .global _start
        .section .data
            prompt1: .ascii "Ingresa el primer número: "
            prompt1_len = . - prompt1
            prompt2: .ascii "Ingresa el segundo número: "
            prompt2_len = . - prompt2
            result_msg: .ascii "La suma es: "
            result_msg_len = . - result_msg
            newline: .ascii "\n"
            newline_len = 1
            input_buffer1: .skip 10
            input_buffer2: .skip 10
        
        .section .text
        _start:
            // Imprimir mensaje de solicitud para el primer número
            mov x0, #1
            adr x1, prompt1
            mov x2, prompt1_len
            mov x8, #64
            svc 0
        
            // Leer el primer número
            mov x0, #0
            adr x1, input_buffer1
            mov x2, 10
            mov x8, #63
            svc 0
        
            // Imprimir mensaje de solicitud para el segundo número
            mov x0, #1
            adr x1, prompt2
            mov x2, prompt2_len
            mov x8, #64
            svc 0
        
            // Leer el segundo número
            mov x0, #0
            adr x1, input_buffer2
            mov x2, 10
            mov x8, #63
            svc 0
        
            // Convertir las entradas a números
            adr x19, input_buffer1
            bl atoi
            mov x20, x0        // x20 contiene el primer número
        
            adr x19, input_buffer2
            bl atoi
            mov x21, x0        // x21 contiene el segundo número
        
            // Sumar los números
            add x22, x20, x21
        
            // Imprimir el resultado
            mov x0, #1
            adr x1, result_msg
            mov x2, result_msg_len
            mov x8, #64
            svc 0
        
            mov x0, x22
            bl print_int
        
            // Imprimir nueva línea
            mov x0, #1
            adr x1, newline
            mov x2, newline_len
            mov x8, #64
            svc 0
        
            // Salir
            mov x0, #0
            mov x8, #93
            svc 0
        
        // Función para imprimir un número entero
        print_int:
            // Convertir número a ASCII
            adr x10, input_buffer1
            mov x11, #10      // Divisor para convertir dígitos
            mov x12, #0       // Índice para el buffer
        
        convert_digit:
            udiv x13, x0, x11 // Dividir por 10
            msub x14, x13, x11, x0 // Obtener el residuo
            add x14, x14, #48 // Convertir a ASCII
            strb x14, [x10, x12] // Almacenar en buffer
            mov x0, x13      // Actualizar x0 para siguiente dígito
            add x12, x12, #1  // Incrementar índice
            cmp x0, #0
            bne convert_digit
        
            // Imprimir número
            mov x0, #1
            mov x1, x10
            mov x2, x12
            mov x8, #64
            svc 0
            ret
        
        // Función para convertir entrada de usuario a número
        atoi:
            mov x0, #0       // Resultado
            mov x1, #10      // Base (decimal)
            mov x2, #0       // Índice
        
        convert_char:
            ldrb w3, [x19, x2] // Cargar carácter
            cmp w3, #0        // Verificar si es el final de la cadena
            beq end
            sub w3, w3, #48   // Convertir a valor numérico
            mul x0, x0, x1    // Multiplicar por 10 (desplazar un dígito a la izquierda)
            add x0, x0, x3    // Agregar el nuevo dígito
            add x2, x2, #1    // Incrementar índice
            b convert_char
        
        end:
            ret
## 3 Resta de dos números
        .global _start
        .section .data
            prompt1: .ascii "Ingresa el primer número: "
            prompt1_len = . - prompt1
            prompt2: .ascii "Ingresa el segundo número: "
            prompt2_len = . - prompt2
            result_msg: .ascii "La resta es: "
            result_msg_len = . - result_msg
            newline: .ascii "\n"
            newline_len = 1
            input_buffer1: .skip 10
            input_buffer2: .skip 10
        
        .section .text
        _start:
            // Imprimir mensaje de solicitud para el primer número
            mov x0, #1
            adr x1, prompt1
            mov x2, prompt1_len
            mov x8, #64
            svc 0
        
            // Leer el primer número
            mov x0, #0
            adr x1, input_buffer1
            mov x2, 10
            mov x8, #63
            svc 0
        
            // Imprimir mensaje de solicitud para el segundo número
            mov x0, #1
            adr x1, prompt2
            mov x2, prompt2_len
            mov x8, #64
            svc 0
        
            // Leer el segundo número
            mov x0, #0
            adr x1, input_buffer2
            mov x2, 10
            mov x8, #63
            svc 0
        
            // Convertir las entradas a números
            adr x19, input_buffer1
            bl atoi
            mov x20, x0        // x20 contiene el primer número
        
            adr x19, input_buffer2
            bl atoi
            mov x21, x0        // x21 contiene el segundo número
        
            // Restar los números
            sub x22, x20, x21
        
            // Imprimir el resultado
            mov x0, #1
            adr x1, result_msg
            mov x2, result_msg_len
            mov x8, #64
            svc 0
        
            mov x0, x22
            bl print_int
        
            // Imprimir nueva línea
            mov x0, #1
            adr x1, newline
            mov x2, newline_len
            mov x8, #64
            svc 0
        
            // Salir
            mov x0, #0
            mov x8, #93
            svc 0
        
        // Función para imprimir un número entero
        print_int:
            // Convertir número a ASCII
            adr x10, input_buffer1
            mov x11, #10      // Divisor para convertir dígitos
            mov x12, #0       // Índice para el buffer
        
        convert_digit:
            udiv x13, x0, x11 // Dividir por 10
            msub x14, x13, x11, x0 // Obtener el residuo
            add x14, x14, #48 // Convertir a ASCII
            strb x14, [x10, x12] // Almacenar en buffer
            mov x0, x13      // Actualizar x0 para siguiente dígito
            add x12, x12, #1  // Incrementar índice
            cmp x0, #0
            bne convert_digit
        
            // Imprimir número
            mov x0, #1
            mov x1, x10
            mov x2, x12
            mov x8, #64
            svc 0
            ret
        
        // Función para convertir entrada de usuario a número
        atoi:
            mov x0, #0       // Resultado
            mov x1, #10      // Base (decimal)
            mov x2, #0       // Índice
        
        convert_char:
            ldrb w3, [x19, x2] // Cargar carácter
            cmp w3, #0        // Verificar si es el final de la cadena
            beq end
            sub w3, w3, #48   // Convertir a valor numérico
            mul x0, x0, x1    // Multiplicar por 10 (desplazar un dígito a la izquierda)
            add x0, x0, x3    // Agregar el nuevo dígito
            add x2, x2, #1    // Incrementar índice
            b convert_char
        
        end:
            ret
## 4 Multiplicación de dos números
        .global _start
        .section .data
            prompt1: .ascii "Ingresa el primer número: "
            prompt1_len = . - prompt1
            prompt2: .ascii "Ingresa el segundo número: "
            prompt2_len = . - prompt2
            result_msg: .ascii "La multiplicación es: "
            result_msg_len = . - result_msg
            newline: .ascii "\n"
            newline_len = 1
            input_buffer1: .skip 10
            input_buffer2: .skip 10
        
        .section .text
        _start:
            // Imprimir mensaje de solicitud para el primer número
            mov x0, #1
            adr x1, prompt1
            mov x2, prompt1_len
            mov x8, #64
            svc 0
        
            // Leer el primer número
            mov x0, #0
            adr x1, input_buffer1
            mov x2, 10
            mov x8, #63
            svc 0
        
            // Imprimir mensaje de solicitud para el segundo número
            mov x0, #1
            adr x1, prompt2
            mov x2, prompt2_len
            mov x8, #64
            svc 0
        
            // Leer el segundo número
            mov x0, #0
            adr x1, input_buffer2
            mov x2, 10
            mov x8, #63
            svc 0
        
            // Convertir las entradas a números
            adr x19, input_buffer1
            bl atoi
            mov x20, x0        // x20 contiene el primer número
        
            adr x19, input_buffer2
            bl atoi
            mov x21, x0        // x21 contiene el segundo número
        
            // Multiplicar los números
            mul x22, x20, x21
        
            // Imprimir el resultado
            mov x0, #1
            adr x1, result_msg
            mov x2, result_msg_len
            mov x8, #64
            svc 0
        
            mov x0, x22
            bl print_int
        
            // Imprimir nueva línea
            mov x0, #1
            adr x1, newline
            mov x2, newline_len
            mov x8, #64
            svc 0
        
            // Salir
            mov x0, #0
            mov x8, #93
            svc 0
        
        // Función para imprimir un número entero
        print_int:
            // Convertir número a ASCII
            adr x10, input_buffer1
            mov x11, #10      // Divisor para convertir dígitos
            mov x12, #0       // Índice para el buffer
        
        convert_digit:
            udiv x13, x0, x11 // Dividir por 10
            msub x14, x13, x11, x0 // Obtener el residuo
            add x14, x14, #48 // Convertir a ASCII
            strb x14, [x10, x12] // Almacenar en buffer
            mov x0, x13      // Actualizar x0 para siguiente dígito
            add x12, x12, #1  // Incrementar índice
            cmp x0, #0
            bne convert_digit
        
            // Imprimir número
            mov x0, #1
            mov x1, x10
            mov x2, x12
            mov x8, #64
            svc 0
            ret
        
        // Función para convertir entrada de usuario a número
        atoi:
            mov x0, #0       // Resultado
            mov x1, #10      // Base (decimal)
            mov x2, #0       // Índice
        
        convert_char:
            ldrb w3, [x19, x2] // Cargar carácter
            cmp w3, #0        // Verificar si es el final de la cadena
            beq end
            sub w3, w3, #48   // Convertir a valor numérico
            mul x0, x0, x1    // Multiplicar por 10 (desplazar un dígito a la izquierda)
            add x0, x0, x3    // Agregar el nuevo dígito
            add x2, x2, #1    // Incrementar índice
            b convert_char
        
        end:
            ret
## 5 División de dos números
        .global _start
        .section .data
            prompt1: .ascii "Ingresa el dividendo: "
            prompt1_len = . - prompt1
            prompt2: .ascii "Ingresa el divisor: "
            prompt2_len = . - prompt2
            result_msg: .ascii "La división es: "
            result_msg_len = . - result_msg
            newline: .ascii "\n"
            newline_len = 1
            input_buffer1: .skip 10
            input_buffer2: .skip 10
        
        .section .text
        _start:
            // Imprimir mensaje de solicitud para el dividendo
            mov x0, #1
            adr x1, prompt1
            mov x2, prompt1_len
            mov x8, #64
            svc 0
        
            // Leer el dividendo
            mov x0, #0
            adr x1, input_buffer1
            mov x2, 10
            mov x8, #63
            svc 0
        
            // Imprimir mensaje de solicitud para el divisor
            mov x0, #1
            adr x1, prompt2
            mov x2, prompt2_len
            mov x8, #64
            svc 0
        
            // Leer el divisor
            mov x0, #0
            adr x1, input_buffer2
            mov x2, 10
            mov x8, #63
            svc 0
        
            // Convertir las entradas a números
            adr x19, input_buffer1
            bl atoi
            mov x20, x0        // x20 contiene el dividendo
        
            adr x19, input_buffer2
            bl atoi
            mov x21, x0        // x21 contiene el divisor
        
            // Dividir los números
            sdiv x22, x20, x21 // División con signo
        
            // Imprimir el resultado
            mov x0, #1
            adr x1, result_msg
            mov x2, result_msg_len
            mov x8, #64
            svc 0
        
            mov x0, x22
            bl print_int
        
            // Imprimir nueva línea
            mov x0, #1
            adr x1, newline
            mov x2, newline_len
            mov x8, #64
            svc 0
        
            // Salir
            mov x0, #0
            mov x8, #93
            svc 0
        
        // Función para imprimir un número entero
        print_int:
            // Convertir número a ASCII
            adr x10, input_buffer1
            mov x11, #10      // Divisor para convertir dígitos
            mov x12, #0       // Índice para el buffer
        
        convert_digit:
            udiv x13, x0, x11 // Dividir por 10
            msub x14, x13, x11, x0 // Obtener el residuo
            add x14, x14, #48 // Convertir a ASCII
            strb x14, [x10, x12] // Almacenar en buffer
            mov x0, x13      // Actualizar x0 para siguiente dígito
            add x12
# Programas Dificultad: Intermedia

# Programas Dificultad: Dificil
