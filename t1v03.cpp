#include <iostream>
using namespace std;

/*
***Programa relativo ao Trabalho 1 de Organizacao e Arquitetura de Processadores***
- Este codigo eh uma versao do codigo principal feito em alto nivel para melhor entendimento
- do funcionamento do assembly MIPS
*/

//funcao que retorna a raiz quadrada de um numero utilizando a formula de Newtwon Raphson
int sqrt_nr(int x, int i){
    if(i == 0) return 1;
    int part1 = sqrt_nr(x, i-1);
    int parcial = x / part1;
    int recursivo = (part1 + parcial) /2;
    return recursivo;
}

int main(){
    cout << "Programa de Raiz Quadrada - Newton-Raphson" << endl;
    cout << "Desenvolvedores: Diego Fraga, Joao Victor Terra, Raul Costa" << endl;
    int x = 0;
    int i;
    while(x >= 0){
        cout << "Digite os parametros x e i para calcular sqrt_nr (x, i) ou -1 para abortar a execucao" << endl;
        cin >> x;
        if(x < 0) break;
        cin >> i;
        if( i < 0) break;
        int answer = sqrt_nr(x, i);
        //sqrt(500, 8) = 22
        cout << "sqrt(" << x << ", " << i << ") = " << answer << endl;
    }
    return 0;
}