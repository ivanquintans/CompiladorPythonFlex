/* cargamos las librerias necesarias para la ejecución*/

%{
    #include "definiciones.h"
    #include "TS.h"
    #include "errores.h"
%}
%option noyywrap

/*Comenzamos el analisis de los tokens*/

/*En primer lugar definimos tokens básicos*/
LETRA       [A-Za-z]
DIGITO      [0-9]
HEXADECIMAL [0-9A-Fa-f]
BINDIGITO   [01]
OCTAL       [0-7]   

/*Cualquier tipo de digitos con _ por ejemplo 100_000_110*/

DIGITPART   {DIGITO}(\_?{DIGITO})*
BINPART     {BINDIGITO}(\_?{BINDIGITO})*
OCTALPART   {OCTAL}(\_?{OCTAL})*
HEXPART     {HEXADECIMAL}(\_?{HEXADECIMAL})*

/*Tokens para los numeros*/


/*IDENTIFICADORES*/

IDENTIFICADOR ({LETRA|\_})({LETRA|DIGITPART}|\_)*

/*Integers*/

NUMERO_DECINTEGER   {DIGITO}(\_?{DIGITPART})?
NUMERO_BINARIO      0(b|B)\_?{BINPART}
NUMERO_OCTAL        0(o|O)\_?{OCTALPART}
NUMERO_HEXADECIMAL  0(x|x)\_?{HEXPART}

ENTERO ({NUMERO_DECINTEGER}|{NUMERO_BINARIO}|{NUMERO_HEXADECIMAL}|{NUMERO_OCTAL})

/*Decimales (PUNTO flotante)*/

EXPONENTE     (e|E)(\+|\-)?{DIGITPART}

DECIMAL_CON_PUNTO   \.{DIGITPART}{EXPONENTE}?
DECIMAL_SIN_PUNTO   {DIGITPART}\.{DIGITPART}{EXPONENTE}?
EXPONENCIAL         {DIGITPART}{EXPONENTE}

DECIMAL     ({DECIMAL_CON_PUNTO}|{DECIMAL_SIN_PUNTO}|{EXPONENCIAL})

NUMERO  ({ENTERO|IMAGINARIO|DECIMAL})

/*Imaginarios*/
IMAGINARIO  ({ENTERO|DECIMAL})j

/*COMENTARIOS*/

COMENTARIO  #[^\n]*

/*OPERADORES*/

MENORMENOR          \<\<
MAYORMAYOR          \>\>      
DOUSPUNTOSIGUAL     \:\=   
MAYORIGUAL          \>\=
MENORIGUAL          \<\=
IGUALIGUAL          \=\=
DISTINTO            \!\=
ASTERICOASTERISCO   \*\*     
BARRABARRA          \/\/     
GUIONFLECHA         \-\>
MASIGUAL            \+\=
MENOSIGUAL          \-\=
ASTERISCOIGUAL      \*\=     
BARRAIGUAL          \/\=
BARRABARRAIGUAL     \/\/\=
PORCIENTOIGUAL      \%\=
ARROBAIGUAL         \@\=
UNPERSANTIGUAL      \&\=
BARRAVERTICALIGUAL  \|\=
EXPONENCIALIGUAL    \^\=
MAYORMAYORIGUAL     \>\>\=
MENORMENORIGUAL     \<\<\=
ASTERISCOASTERISCOIGUAL \*\*\=

OPERADOR_ASCII  (\+|\-|\*|\/\\%|\@|\&|\||\^|\~|\:\=|\<|\>|\)|\(|\[|\]|\{|\}|\,|\;|\:|\.|\=)
/*STRINGS*/

STRING_SIMPLE   (\'(.|\n)+\')|(\"(.|\n)+\")
STRING_LARGO    \"\"\"(.|\n)+\"\"\"

STRING      {STRING_SIMPLE}|{STRING_LARGO}

/*SALTABLES*/
IGNORAR     [ \t\n]

%% /*Parte de las reglas*/

/*Si tenemos alguno de los tokens que queremos los devolvemos*/
{IDENTIFICADOR}     {return IDENTIFICADOR;}
{STRING}            {return STRING;}
{OPERADOR}          {return OPERADOR;}
{NUMERO}            {return NUMERO;}
/*Si se detecta cualquier otro caracter que no sea el que queremos devolvemos error*/
.                   {return -1;}
<<EOF>>             {yyterminate();}

%%

void openFile(char *nombreArchivo){
    FILE *miArchivo;
    miArchivo = fopen(nombreArchivo,"r");
    if (miArchivo == NULL) error(ERROR_ABRIR_ARCHIVO);
    yyin = miArchivo;
}

void close(){
    fclose(yyin);
    yylex_destroy();
}


void sigCompLexico (TIPOELEMENTO *comp){
    /*Vamos a elimianr el lexico.c y implementarlo directamente desde aqui*/
    comp->codigo == yylex();

    /*Si el codifo es -1 es que encontramos un error*/

    if (comp->codigo == -1){
        //no reconocimos componente
        error(COMP_NO_VALIDO);

    /*Ahora en caso de que sea valido el codigo colocamos en comp->lexema el valor obtenido*/
    }else if(comp->codigo != 0){
        comp->lexema = strdup(yytext); //valor que asociamos al componente

    }

    /*Ahora controlamos el tipo que es ya que si es ID hay que añadir a la tabla de simbolos, si es un operador simple hay que imprimir el ascii y en caso de ser 0 es el final del archivo */

    if (comp->codifo == ID){
        //buscamos el elemento en la tabla de simbolos y si no lo insertamos
        insertarTablaSimbolos(&comp);

    }else if (comp->codigo == OPERADOR_ASCII){
        comp->codifo = comp->lexema;
    }else if (comp->codifo == 0){
        //cuando se llama a yyterminate, se devuelve 0
        comp->codigo = EOF;
    }
}






