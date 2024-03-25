#ifndef ERRORES_H
#define ERRORES_H


#define ERROR_ABRIR_ARCHIVO 1
#define TAM_LEXEMA_EXCEDIDO 2
#define COMENTARIO_MULTILINEA_NO_CERRADO 3
#define COMP_NO_VALIDO 4


//funcion encargada de lanzar un error
void imprimirError(int codigo);


#endif