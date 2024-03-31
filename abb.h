#ifndef ABB_H
#define ABB_H
#include "definiciones.h"

/**
 * Tipo de dato abstracto para arbol binario con clave de
 * ordenacion y elemento de celda.
 */

typedef char *TIPOCLAVE;
typedef compLexico TIPOELEMENTO;

typedef struct  celda * TABB;//tipo opaco


//FUNCIONES DE CREACIÓN Y DESTRUCCIÓN DEL �?RBOL
/**
 * Crea el arbol vacio.
 * @param A Puntero al arbol. Debe estar inicializado.
 */
void crearAbb(TABB *A);

/**
 * Destruye el arbol recursivamente
 * @param A El arbol que queremos destruir
 */
void destruirAbb(TABB *A);

//FUNCIONES DE INFORMACIÓN
/**
 * Comprueba si el arbol esta vacio
 * @param A El arbol binario
 */
unsigned esAbbVacio(TABB A);

/**
 * Devuelve el subarbol izquierdo de A
 * @param A - Arbol original
 */
TABB izqAbb(TABB A);
/**
 * Devuelve el subarbol derecho de A
 * @param A - Arbol original
 */
TABB derAbb(TABB A);
/**
 * Recupera la informacion de la celda de la raiz del arbol
 * @param A
 * @param E Puntero al nodo que apuntara a la informacion
 */
void leerElementoAbb(TABB A, TIPOELEMENTO *E);

/**
 * Comprueba si el elemento <E> existe en el arbol <A>
 * @param A
 * @param E
 */
unsigned esMiembroAbb(TABB A, TIPOELEMENTO E);

/**
 * Busca un nodo con clave <cl> en el arbol y, si existe
 * modifica el puntero <nodo> para que lo apunte.
 * @param A Arbol binario en el que se busca el nodo.
 * @param cl Clave que se buscara.
 * @param nodo Puntero a un tipoelem.
 */
void buscarNodoAbb(TABB A, TIPOCLAVE cl, TIPOELEMENTO *nodo);

//FUNCIONES DE MODIFICACIÓN
/**
 * Inserta un nuevo nodo en el arbol para el elemento E
 * del que toma su clave. Esta clave no debe existir en
 * el arbol.
 * @param A Arbol binario
 * @param E Informacion del nuevo nodo.
 */
void insertarElementoAbb(TABB *A, TIPOELEMENTO E);

//FUNCIONES DE IMPRIMIR
/**
 * IMPRIME EL CONTENIDO DEL ARBOL
 * @param A Arbol binario
 *  
 * */
void inorden(TABB A);


#endif	// ABB_H