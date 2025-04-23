.data 
print1: .asciiz "Programa de Raiz Quadrada - Newton-Raphson\n"
print2: .asciiz "Desenvolvedores: Diego Fraga, Joao Victor Terra, Raul Costa\n"
print3loop: .asciiz "Digite os parametros x e i para calcular sqrt_nr (x, i) ou -1 para abortar a execucao"

print_p1: .asciiz "sqrt("
print_p2: .asciiz  ","
print_p3: .asciiz ") = "
print_newline: .asciiz "\n"

.text
.globl main

main:
    li $v0, 4
    la $a0, print1 # "Programa de Raiz Quadrada - Newton-Raphson\n"
    syscall

    li $v0, 4
    la $a0, print2 # "Desenvolvedores: Diego Fraga, Joao Victor Terra, Raul Costa\n"
    syscall

loop: # terminar
    li $v0, 4
    la #a0, print3loop # mensagem do loop
    syscall

    li $v0, 5
    syscall // pega valor de x
    move $t0, $v0


    li $v0, 5
    syscall // pega valor de i
    move $t0, $v0

end:
    li $v0, 10 # fim do programa
    syscall

sqrt_nr: # funcao
    beq $a1, $a0, return_um # verifica se i eh igual a zero

    div $a0, $a1  # x / part1
    mflo $t4

    add $t5, $a1, $t4

    li $t6, 2
    div $t5, $t6
    mflo $v0
    jr $ra

return_um: # funcao auxiliar
    li $v0, 1
    jr $ra