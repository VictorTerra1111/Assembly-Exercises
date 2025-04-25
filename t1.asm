.data 
    print1: .asciiz "Programa de Raiz Quadrada - Newton-Raphson\n"
    print2: .asciiz "Desenvolvedores: Diego Fraga, Joao Victor Terra, Raul Costa, Manuel Soares\n"
    print3loop: .asciiz "Digite os parametros x e i para calcular sqrt_nr (x, i) ou -1 para abortar a execucao\n"

    print_p1: .asciiz "sqrt("
    print_p2: .asciiz  ","
    print_p3: .asciiz ") = "
    print_newline: .asciiz "\n"
.text
.globl main

.macro PRINT (%label)
    li $v0, 4
    la $a0, %label
    syscall
.end_macro

.macro READ 
    li $v0, 5
    syscall 
.end_macro

main:
# imprime "Programa de Raiz Quadrada - Newton-Raphson\n"
    PRINT print1
# imprime "Desenvolvedores: Diego Fraga, Joao Victor Terra, Raul Costa, Manuel Soares\n"
    PRINT print2

loop:
# imprime "Digite os parametros x e i para calcular sqrt_nr (x, i) ou -1 para abortar a execucao\n"
    PRINT print3loop 

# le valor de x
    READ
    move $t0, $v0
    bltz $t0, end # verifica se x = -1

# le valor de i
    READ
    move $t1, $v0
    bltz $t1, end # verifica se i = -1
    
    move $a0, $t0 # parametro x da funcao
    move $a1, $t1 # parametro i da funcao

    jal sqrt_nr #chamada de funcao
    move $t2, $v0 # coloca resultado no $t2

#imprime sqrt(x, i) = resultado / sqrt($t0, $t1) = $t2
    PRINT print_p1

    li $v0, 1
    move $a0, $t0
    syscall

    PRINT print_p2

    li $v0, 1
    move $a0, $t1
    syscall

    PRINT print_p3

    li $v0, 1
    move $a0, $t2
    syscall

    PRINT print_newline

    j loop # volta para o inicio do loop

end:
    li $v0, 10 # fim do programa
    syscall

sqrt_nr: # funcao
    # part1 = $t3
    # parcial = $t4
    # recursivo = nao precisa
    # x = $a0
    # i = $a1
    
    beqz $a1, retorno # se i == 0, retorna x
    
    addi $a1, $a1, -1 # i = i - 1
    
    addi $sp, $sp -20 # libera 5 espaÃ§os na stack
    sw $ra, 16($sp) # guarda o retorno
    sw $a0, 12($sp) # guarda x
    sw $a1, 8($sp) # guarda i
    sw $t3, 4($sp) # guarda part1
    sw $t4, 0($sp) # guarda parcial

    jal sqrt_nr
    move $t3, $v0
    
    div $a0, $t3  # x / part1
    mflo $t4 # parcial = x / part1

    add $t5, $t4, $t3 # parcial + part1

    li $t6, 2 
    div $t5, $t6 # (part1 + parcial) / 2
    mflo $v0
    
    lw $t4, 0($sp)
    lw $t3, 4($sp)
    lw $a1, 8($sp)
    lw $a0, 12($sp)
    lw $ra, 16($sp)
    addi $sp, $sp, 20
    
    jr $ra

retorno: # funcao auxiliar
    li $v0, 1
    jr $ra
