#Khaick Oliveira Brito
#include<stdio.h>

void calcularPrimos(int qtd){//Calcular quantidade de primos
int i = 0;
int n = 2;
int j = n;
	while(i!=qtd){
		while(n%j != 0 || j == n){
			j--;
			if(j==1){
				printf("%d, ",n);
				i++;		    
			}
		}
		n++;
		j = n;
	}
}

int main()
{
    int n = 20;
    calcularPrimos(n);    
    return 1;
}
