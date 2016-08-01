/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package test;

import java.util.Scanner;

/**
 *
 * @author KHAICK O. BRITO
 */
public class TestMode {

    //Geração de Fibonacci (recursivo)
    //Ordenação de um vetor (Bubble Sort)
    //Cálculo do fatorial de um número inteiro (recursivo)
    //Geração de números primos
    //Algoritmo para calcular Raiz Quadrada
    //Algoritmo para calcular potência (x^y)

    public static void main(String[] args) {
        int i = 1;
        Scanner scan = new Scanner(System.in);
        while (i > 0) {
            printFunctions();
            System.out.print("Digite: ");
            i = scan.nextInt();
            System.out.println("\n\n\n\n\n\n\n\n\n");
            switch (i) {
                case 1:
                    System.out.println("1");
                    break;
                case 2:
                    System.out.println("2");
                    break;
                case 3:
                    System.out.println("3");
                    break;
                case 4:
                    System.out.println("4");
                    break;
                case 5:
                    System.out.println("5");
                    break;
                case 6:
                    System.out.println("6");
                    break;
                default:
                    System.out.println("Saiu do programa");
                    break;
            }

        }
    }

    private static void printFunctions() {
        System.out.println("Escolha a função:");
        System.out.println();
        System.out.println("1 - Gerar sequência de Fibonnaci");
        System.out.println("2 - Ordenação de um vetor (Bubble Sort)");
        System.out.println("3 - Cálculo do fatorial de um número inteiro");
        System.out.println("4 - Geração de números primos");
        System.out.println("5 - Calcular raiz quadrada");
        System.out.println("6 - Calcular Potencia (x^y)");
        System.out.println("0 - (SAIR)");
    }

    private static void f1() {
//        fibo(int n) {
//            if (n < 2) {
//                return n;
//            } else {
//                return fibo(n - 1) + fibo(n - 2);
//            }
//        }
        
        //https://www.vivaolinux.com.br/script/Fibonacci-em-assembly
        
        
    }

    private static void f2() {
        
    }

    private static void f3() {

    }

    private static void f4() {

    }

    private static void f5() {

    }

    private static void f6() {

    }

}
