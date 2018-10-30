.section .data

msg_bem_vindo: .asciz "=============================================================\n|                    Bem vindo ao Truco 1.0                 |\n ===================================================================\n"
msg_cartas: .asciz "Suas cartas são: \n"
msg_carta:  .asciz "                 %s de %s\n"
tempo: .int 4
mostra_tempo: .asciz "\nSemente Aleatoria: Tempo em Segundos = %d\n"
mostra_randomico: .asciz "\nNumero Gerado: %d\n"
mostra_randomico_13: .asciz "\Numero Gerado no maximo 13: %d\n"
print_numero: .asciz " %d"
print_palavra: .asciz " %s"
print_cartas: .asciz "As cartas da mão são:"
print_vira: .asciz "A vira eh: "
print_cartas_sortiadas: .asciz "As cartas sortiadas foram: "
print_sinais_sortiados: .asciz "Os sinais sortiados foram: "
teste: .asciz "cheguei aqui"
quebra_linha: .asciz "\n"
print_cartas_iguais: .asciz "As cartas informadas são iguais: %s, %s \n"
contador: .int 0
print_iguais: .asciz "Estas cartas são iguais! %d e %d"
print_diferentes: .asciz "Estas cartas são diferentes!"
print_comparando: .asciz "Comparando %d e %d\n"
mostra_acao: .asciz "Selecione sua carta [ 1 a 3] ou peça truco [4] => "
entrada: .asciz "%d"

cartas_maquina: .space 28
sinais_cartas_maquina: .space 28
cartas_jogador: .space 28
sinais_cartas_jogador: .space 28

cartas: .asciz "4     ", "5     ", "6     ", "7     ", "Dama  ", "Valete", "Reis  ", "As    ", "2     ", "3     "
sinais: .asciz "Ouros ", "Espada", "Copas ", "Paus  "
cartas_sortiadas: .space 32
sinais_sortiados: .space 32
manilha: .int 0
sinal_manilha: .asciz ""
vira: .space 14
sinal_vira: .space 14
cmp_carta1: .asciz ""
cmp_carta2: .asciz ""
cmp_carta3: .asciz ""
cmp_sinal1: .asciz ""
cmp_sinal2: .asciz ""
cmp_sinal3: .asciz ""

pontojogador: .int 0
pontocomputador: .int 0
pontorodada: .int 1


_gerador_semente_aleatoria:
pushl   $tempo
call    time
pushl   tempo
call    srand
addl    $8, %esp
    ret

_gerador_cartas_maquina:
movl    $3, %ecx                    #numero de cartas que serão geradas devem estar em ecx(instrução loop)
movl    $cartas_maquina, %ebx
movl    $cartas_sortiadas, %edx
_gera_carta_maquina:
pushl   %edx
pushl   %ecx                        #backup %ecx, %ebx e %edx que são o vetores
pushl   %ebx
call    rand                        #gera numero randomico
pushl   %eax                        #eax contem o numero randomico
movl    $0, %edx                    #limpando edx
movl    $10, %ebx                   #iremos pegar apenas numeros entre 0 e 9 assim teremos que dividir por 10
divl    %ebx
pushl   %edx                        #pegando o resto da divisao como aleatorio entre 0 e 9
movl    %edx, %eax                  #salvo o random em %eax
movl    $0, %edx                    #limpando edx
movl    $7, %ebx                    #multiplico por 7 pois é o número de caracteres nos vetores
mull    %ebx
movl    $cartas, %edi               #salvo vetor em %edi para movimentar
addl    %eax, %edi                  #movimento o vetor de acordo com a posição que foi calculada (7 * random) = posição do vetor
addl    $8, %esp                    #limpando a pilha
popl    %ebx                        #recupegando os backup s
popl    %ecx
popl    %edx
movl    %edi, (%ebx)                #adicionando a carta ao vetor de cartas
addl    $7, %ebx
movl    %eax, (%edx)
addl    $4, %edx
loop    _gera_carta_maquina
    ret

_gerador_sinais_cartas_maquina:
movl    $3, %ecx                    #numero de sinais que serão geradas devem estar em ecx(instrução loop)
movl    $sinais_cartas_maquina, %ebx
movl    $sinais_sortiados, %edx
_gera_sinal_carta_maquina:
pushl   %edx
pushl   %ecx                        #backup %ecx, %ebx e %edx que é o vetor
pushl   %ebx
call    rand                        #gera numero randomico
pushl   %eax                        #eax contem o numero randomico
movl    $0, %edx                    #limpando edx
movl    $4, %ebx                   #iremos pegar apenas numeros entre 0 e 4 assim teremos que dividir por 4
divl    %ebx
pushl   %edx                        #pegando o resto da divisao como aleatorio entre 0 e 9
movl    %edx, %eax                  #salvo o random em %eax
movl    $0, %edx                    #limpando edx
movl    $7, %ebx                    #multiplico por 7 pois é o número de caracteres nos vetores
mull    %ebx
movl    $sinais, %edi               #salvo vetor em %edi para movimentar
addl    %eax, %edi                  #movimento o vetor de acordo com a posição que foi calculada (7 * random) = posição do vetor
addl    $8, %esp                    #limpando a pilha
popl    %ebx                        #recupegando os backup s
popl    %ecx    
popl    %edx
movl    %edi, (%ebx)                #adicionando a carta ao vetor de cartas
addl    $7, %ebx
movl    %eax, (%edx)
addl    $4, %edx
loop    _gera_sinal_carta_maquina
    ret
    
_gerador_cartas_jogador:
movl    $3, %ecx                    #numero de cartas que serão geradas devem estar em ecx(instrução loop)
movl    $cartas_jogador, %ebx
movl    $cartas_sortiadas, %edx
addl    $12, %edx
_gera_carta_jogador:
pushl   %edx
pushl   %ecx                        #backup %ecx e %ebx que é o vetor
pushl   %ebx
call    rand                        #gera numero randomico
pushl   %eax                        #eax contem o numero randomico
movl    $0, %edx                    #limpando edx
movl    $10, %ebx                   #iremos pegar apenas numeros entre 0 e 9 assim teremos que dividir por 10
divl    %ebx
pushl   %edx                        #pegando o resto da divisao como aleatorio entre 0 e 9
movl    %edx, %eax                  #salvo o random em %eax
movl    $0, %edx                    #limpando edx
movl    $7, %ebx                    #multiplico por 7 pois é o número de caracteres nos vetores
mull    %ebx
movl    $cartas, %edi               #salvo vetor em %edi para movimentar
addl    %eax, %edi                  #movimento o vetor de acordo com a posição que foi calculada (7 * random) = posição do vetor
addl    $8, %esp                    #limpando a pilha
popl    %ebx                        #recupegando os backup s
popl    %ecx
popl    %edx
movl    %edi, (%ebx)                #adicionando a carta ao vetor de cartas
addl    $7, %ebx
movl    %eax, (%edx)
addl    $4, %edx
loop    _gera_carta_jogador
    ret
    
_gera_vira:
movl    $vira, %ebx
movl    $cartas_sortiadas, %edx
addl    $24, %edx
pushl   %edx
pushl   %ebx
call    rand                        #gera numero randomico
pushl   %eax                        #eax contem o numero randomico
movl    $0, %edx                    #limpando edx
movl    $10, %ebx                   #iremos pegar apenas numeros entre 0 e 9 assim teremos que dividir por 10
divl    %ebx
pushl   %edx                        #pegando o resto da divisao como aleatorio entre 0 e 9
movl    %edx, %eax                  #salvo o random em %eax
movl    $0, %edx                    #limpando edx
movl    $7, %ebx                    #multiplico por 7 pois é o número de caracteres nos vetores
mull    %ebx
movl    $cartas, %edi               #salvo vetor em %edi para movimentar
addl    %eax, %edi                  #movimento o vetor de acordo com a posição que foi calculada (7 * random) = posição do vetor
addl    $8, %esp                    #limpando a pilha
popl    %ebx                        #recupegando os backup s
popl    %edx
movl    %edi, (%ebx)                #adicionando a carta ao vetor de cartas
addl    $7, %ebx
movl    %eax, (%edx)
addl    $4, %edx
    ret
    
_gera_sinal_vira:
movl    $sinal_vira, %ebx
movl    $sinais_sortiados, %edx
addl    $24, %edx
pushl   %edx
pushl   %ebx
call    rand                        #gera numero randomico
pushl   %eax                        #eax contem o numero randomico
movl    $0, %edx                    #limpando edx
movl    $4, %ebx                   #iremos pegar apenas numeros entre 0 e 9 assim teremos que dividir por 10
divl    %ebx
pushl   %edx                        #pegando o resto da divisao como aleatorio entre 0 e 9
movl    %edx, %eax                  #salvo o random em %eax
movl    $0, %edx                    #limpando edx
movl    $7, %ebx                    #multiplico por 7 pois é o número de caracteres nos vetores
mull    %ebx
movl    $sinais, %edi               #salvo vetor em %edi para movimentar
addl    %eax, %edi                  #movimento o vetor de acordo com a posição que foi calculada (7 * random) = posição do vetor
addl    $8, %esp                    #limpando a pilha
popl    %ebx                        #recupegando os backup s
popl    %edx
movl    %edi, (%ebx)                #adicionando a carta ao vetor de cartas
addl    $7, %ebx
movl    %eax, (%edx)
addl    $4, %edx
    ret 
    
_gerador_sinais_cartas_jogador:
movl    $3, %ecx                    #numero de sinais que serão geradas devem estar em ecx(instrução loop)
movl    $sinais_cartas_jogador, %ebx
movl    $sinais_sortiados, %edx
addl    $12, %edx
_gera_sinal_carta_jogador:
pushl   %edx
pushl   %ecx                        #backup %ecx e %ebx que é o vetor
pushl   %ebx
call    rand                        #gera numero randomico
pushl   %eax                        #eax contem o numero randomico
movl    $0, %edx                    #limpando edx
movl    $4, %ebx                   #iremos pegar apenas numeros entre 0 e 9 assim teremos que dividir por 10
divl    %ebx
pushl   %edx                        #pegando o resto da divisao como aleatorio entre 0 e 9
movl    %edx, %eax                  #salvo o random em %eax
movl    $0, %edx                    #limpando edx
movl    $7, %ebx                    #multiplico por 7 pois é o número de caracteres nos vetores
mull    %ebx
movl    $sinais, %edi               #salvo vetor em %edi para movimentar
addl    %eax, %edi                  #movimento o vetor de acordo com a posição que foi calculada (7 * random) = posição do vetor
addl    $8, %esp                    #limpando a pilha
popl    %ebx                        #recupegando os backup s
popl    %ecx
popl    %edx
movl    %edi, (%ebx)                #adicionando a carta ao vetor de cartas
addl    $7, %ebx
movl    %eax, (%edx)
addl    $4, %edx
loop    _gera_sinal_carta_jogador
    ret 
    
    
_imprime_vira:
pushl   $print_vira
call    printf
addl    $4, %esp
movl    $vira, %ebx
movl    $sinal_vira, %edi
pushl   %ebx
pushl   %edi
pushl   (%ebx)
pushl   $print_palavra
call    printf
pushl   (%edi)
pushl   $print_palavra
call    printf
addl    $16, %esp
popl    %edi
popl    %ebx
pushl   $quebra_linha
call    printf
addl    $4, %esp
    ret


_imprime_cartas_maquina:
pushl   $print_cartas
call    printf
addl    $4, %esp
movl    $3, %ecx
movl    $cartas_maquina, %ebx
movl    $sinais_cartas_maquina, %edi
_impressao_cartas_maquina:
pushl   %ecx
pushl   %ebx
pushl   %edi
pushl   (%ebx)
pushl   $print_palavra
call    printf
pushl   (%edi)
pushl   $print_palavra
call    printf
addl    $16, %esp
popl    %edi
popl    %ebx
popl    %ecx
addl    $7, %ebx
addl    $7, %edi
loop    _impressao_cartas_maquina
pushl   $quebra_linha
call    printf
addl    $4, %esp
    ret
    
_imprime_cartas_jogador:
pushl   $print_cartas
call    printf
addl    $4, %esp
movl    $3, %ecx
movl    $cartas_jogador, %ebx
movl    $sinais_cartas_jogador, %edi
_impressao_cartas_jogador:
pushl   %ecx
pushl   %ebx
pushl   %edi
pushl   (%ebx)
pushl   $print_palavra
call    printf
pushl   (%edi)
pushl   $print_palavra
call    printf
addl    $16, %esp
popl    %edi
popl    %ebx
popl    %ecx
addl    $7, %ebx
addl    $7, %edi
loop    _impressao_cartas_jogador
pushl   $quebra_linha
call    printf
addl    $4, %esp
    ret
    
_imprime_cartas_sortiadas:
pushl   $print_cartas_sortiadas
call    printf
addl    $4, %esp
movl    $7, %ecx
movl    $cartas_sortiadas, %ebx
_impressao_cartas_sortiadas:
pushl   %ecx
pushl   %ebx
pushl   (%ebx)
pushl   $print_numero
call    printf
addl    $8, %esp
popl    %ebx
addl    $4, %ebx
popl    %ecx
loop    _impressao_cartas_sortiadas
pushl   $quebra_linha
call    printf
addl    $4, %esp
    ret
    
_imprime_sinais_cartas_sortiadas:
pushl   $print_sinais_sortiados
call    printf
addl    $4, %esp
movl    $7, %ecx
movl    $sinais_sortiados, %ebx
_impressao_sinais_cartas_sortiadas:
pushl   %ecx
pushl   %ebx
pushl   (%ebx)
pushl   $print_numero
call    printf
addl    $8, %esp
popl    %ebx
addl    $4, %ebx
popl    %ecx
loop    _impressao_sinais_cartas_sortiadas
pushl   $quebra_linha
call    printf
addl    $4, %esp
    ret
##### O valor a ser comparado deve estar em %eax
_proximo_elemento_vetor:
addl    $1, contador
addl    $0, %edx
movl    contador, %eax
movl    $4, %ebx
mull    %ebx
movl    $cartas_sortiadas, %edi
addl    %eax, %edi
movl    (%edi), %eax
addl    $4, %edi
movl    $6, %ecx
jmp     _loop_verifica_carta
_verifica_carta:
movl    $6, %ecx
movl    $cartas_sortiadas, %edi
movl    (%edi), %eax
addl    $4, %edi
_loop_verifica_carta:
pushl   %ecx
pushl   %edi
pushl   %eax
pushl   (%edi)
pushl   %eax
pushl   $print_comparando
call    printf
addl    $12, %esp
popl    %eax
popl    %edi
popl    %ecx
movl    (%edi), %ebx
cmpl    %eax, %ebx
je      _verifica_sinal
addl    $4, %edi
loop    _loop_verifica_carta
movl    contador, %eax
movl    $6, %ebx
cmpl    %eax, %ebx
jne     _proximo_elemento_vetor
cmpl    %eax, %eax
acabou:
    ret
    
_verifica_sinal:
pushl   $print_iguais
call    printf
jmp     finalizar_programa
ret

_faz_acao_jogador:
    call _imprime_cartas_jogador

    pushl $mostra_acao
    call printf

    pushl $entrada
    call scanf



#####

.globl _start
_start:

_bem_vindo:
pushl   $msg_bem_vindo
call    printf
addl    $4, %esp #limpa a pilha

call _gerador_semente_aleatoria

call _gerador_cartas_maquina

call _gerador_sinais_cartas_maquina

call _gerador_cartas_jogador

call _gerador_sinais_cartas_jogador

call _gera_vira

call _gera_sinal_vira

call _imprime_cartas_maquina

call _imprime_cartas_jogador

call _imprime_cartas_sortiadas

call _imprime_sinais_cartas_sortiadas

call _imprime_vira

call _faz_acao_jogador

call _verifica_carta

finalizar_programa:
pushl   $quebra_linha
call    printf
pushl   $0
call    exit
