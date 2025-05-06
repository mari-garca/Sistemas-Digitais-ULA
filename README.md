# Relatório 1 - Sistemas Digitais

## Introdução

O relatório abrange o desafio da construção de uma ULA (Unidade lógica e aritmética) que receba o equivalente ao operando A (4 bits), ao operando B (4 bits) e ao bit de controle da ULA, que definirá a operação a ser realizada (3 bits). Posteriormente, espera-se na saída que se mostre os operandos escolhidos, a operação solicitada e seu resultado; entrando em um looping o qual sempre mostrará os operandos, a operação posterior da ULA e seu resultado, sucessivamente até que o sistema seja resetado. Sua visualização se dará por meio de um sistema de interface implementado que será também explicado.

Para sua realização, foram utilizadas
- Linguagem de programação: VHDL (VHSIC Hardware Description Language) - linguagem de descrição de hardware usada para descrever o comportamento e estrutura de um sistema digital;
- Placa: Spartan-3A/3AN;
- Programa: Oracle Virtual Box.

Assim, foi começado o projeto estruturando a ULA nas suas 8 operações escolhidas: AND, NOT e OR (operações lógicas), além da implementação de um Somador, Complemento de 2, Subtrator, Deslocador e Multiplicador (operações aritméticas). O módulo Main.vhd foi criado com a finalidade de unir os comandos internos da ULA e o módulo Interface.vhd, para permitir interação externa com os comandos internos do projeto.

Modelo esboçado:

![image](https://github.com/user-attachments/assets/8abf9866-dd3f-4ed3-895a-6d8dd660017e)

