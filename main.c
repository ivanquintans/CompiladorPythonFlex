#include <stdio.h>
#include <stdlib.h>

#include "sintactico.h"
#include "TS.h"
#include "lex.yy.h"

int main(int argc, char **argv){
  // comprobamos que el archivo que se pasa por linea de comandos sea valido

  if (argc != 2){
    printf("Error en los parametros de entrada. El comando debe de ser ./main codigoFuente(Fichero con el codigo fuente deseado)\n");
    exit(EXIT_FAILURE);
  }

  //abrimos el archivo
  openFile(argv[1]);

  //inicializamos la tabla de simbolos
  inicializarTablaSimbolos();

  //Inicializamos el sintactico
  inicializarSintactico();

  /*hay que finalizar la tabla de simbolos el sistema de entrada y el lexico*/

  finalizarTablaSimbolos();

  close();

  exit(0);

}