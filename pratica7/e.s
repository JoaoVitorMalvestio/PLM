.section .data

apresenta: .asciz "\n*** Programa Localiza Subvetor dentro de Vetor 1.0 ***\n\n"
pedetamvet: .asciz "Digite o tamanho do vetor (0 < tam <= 50) => "
pedetamsubvet: .asciz "Digite o tamanho do subvetor (0 < tam <= %d) => "
pedenum: .asciz "Entre com o numero %d => "
infovet: .asciz "\nLEITURA DO VETOR:\n\n"
infosubvet: .asciz "\nLEITURA DO SUBVETOR:\n\n"
infovet2: .asciz "\nVetor Lido : "
infosubvet2: .asciz "\nSubvetor Lido : "
infoproc: .asciz "\nProcurando ...\n"
formain: .asciz "%d"
formaout: .asciz " %d"
resppositiva: .asciz "\nO Subvetor estah contido no vetor a partir da posicao %d!\n\n"
respnegativa: .asciz "\nO Subvetor não estah contido no vetor!\n\n"
pulalinha: .asciz "\n"
pergcont: .asciz "\nDeseja nova execucao <s>im ou <n>ao? => "
limpabuf: .string "%*c"
maxtam: .int 50
maxaux: .int 0
tamaux: .int 0
tamsubvet: .int 0
tamvet: .int 0
posmax: .int 0
num: .int 0
n: .int 0
resp: .int 0
subvetor: .space 204 # 4 bytes para cada numero a ser armazenado
vetor: .space 204 # 4 bytes para cada numero a ser armazenado

.section .text

letam:
    pushl $tamaux
    pushl $formain
    call scanf
    pushl $pulalinha
    call printf
    addl $12, %esp # desfaz os ultimos 3 push's
    movl tamaux, %ecx
    cmpl $0, %ecx
    jle letam
    cmpl maxaux, %ecx
    jg letam
    ret

levet:
    movl $0, %ebx

volta1:
    incl %ebx
    pushl %edi
    pushl %ecx
    pushl %ebx
    pushl $pedenum
    call printf
    pushl $num
    pushl $formain
    call scanf
    addl $12, %esp # desfaz os ultimos 3 push's
    popl %ebx
    popl %ecx
    popl %edi
    movl num, %eax
    movl %eax, (%edi)
    addl $4, %edi
    loop volta1
    ret

mostravet:
    pushl %edi
    pushl %ecx
    movl (%edi), %eax
    pushl %eax
    pushl $formaout
    call printf
    addl $8, %esp
    popl %ecx
    popl %edi
    addl $4, %edi
    loop mostravet
    pushl $pulalinha
    call printf
    addl $4, %esp
    ret

comparasubvet:
    movl (%edi), %eax
    movl (%esi), %ebx
    cmpl %eax, %ebx
    jnz acabou
    addl $4, %edi
    addl $4, %esi
    loop comparasubvet
    cmpl %eax, %eax

acabou:
    ret

.globl _start
_start:
    pushl $apresenta
    call printf
    addl $4, %esp
    movl $0, n
    le_tamanhos:
    pushl $pedetamvet
    call printf
    addl $4, %esp

    movl maxtam, %ecx
    movl %ecx, maxaux
    call letam
    movl %ecx, tamvet
    pushl %ecx
    pushl $pedetamsubvet
    call printf
    addl $8, %esp
    movl tamvet, %ecx
    movl %ecx, maxaux
    call letam
    movl %ecx, tamsubvet
    movl tamvet, %ecx
    subl tamsubvet, %ecx
    incl %ecx
    movl %ecx, posmax

le_vetores:
    pushl $infovet
    call printf
    addl $4, %esp
    movl $vetor, %edi
    movl tamvet, %ecx
    call levet

    pushl $infosubvet
    call printf
    addl $4, %esp
    movl $subvetor, %edi
    movl tamsubvet, %ecx
    call levet

mostra_vetores:
    pushl $infovet
    call printf

    addl $4, %esp
    movl $vetor, %edi
    movl tamvet, %ecx
    call mostravet
    pushl $infosubvet
    call printf
    addl $4, %esp
    movl $subvetor, %edi
    movl tamsubvet, %ecx
    call mostravet

compara_vetores:
    pushl $infoproc
    call printf
    addl $4, %esp
    movl $vetor, %esi
    subl $4, %esi

voltacomp:
    addl $4, %esi
    pushl %esi
    incl n
    movl n, %eax
    cmpl posmax, %eax
    jg naoachou
    movl tamsubvet, %ecx
    movl $subvetor, %edi
    call comparasubvet
    jz achou
    popl %esi
    jmp voltacomp
    naoachou:
    pushl $respnegativa
    call printf
    addl $4, %esp
    jmp fim
    achou:
    pushl n
    pushl $resppositiva
    call printf
    addl $8, %esp
    
fim:
    pushl $pergcont
    call printf
    pushl $limpabuf
    call scanf
    addl $8, %esp
    call getchar
    cmpl $'s', %eax
    jz _start
    pushl $0
    call exit 