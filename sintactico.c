#include <stdio.h>
#include <stdlib.h>

#include "sintactico.h"
#include  "definiciones.h"
#include "lex.yy.h"


// funcion que inicializa el analizador sintactico
void inicializarSintactico() {
    compLexico comp;
    comp.lexema = NULL;
    do{
        sigCompLexico(&comp);
        if (comp.lexema != NULL) { 
            printf("< %d, %s >\n", comp.codigo, comp.lexema);
        }

        /*Ahora ya que no liberamos en lexico el lexema tenemos que hacerlo aquí*/
        if (comp.codigo != NULL){
            free(comp.lexema);
            comp.lexema = NULL;
        }
    }while (comp.codigo !=EOF);

    printf("Saliendo del programa\n");

}