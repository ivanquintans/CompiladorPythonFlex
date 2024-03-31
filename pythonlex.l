/* cargamos las librerias necesarias para la ejecución*/
%{
    #include "definiciones.h"
    #include "TS.h"
    #include "errores.h"
%}
%option noyywrap

/*Comenzamos el analisis de los tokens*/
STRING_LARGO    (\"\"\"([^\"])*\"\"\")|(\'\'\'([^\''])*\'\'\'')
STRING_SIMPLE   (\"[^\n]*?\")|(\'[^\n]*?\')

STRING      ({STRING_SIMPLE}|{STRING_LARGO})

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

IDENTIFICADOR ({LETRA}|\_)({LETRA}|{DIGITPART}|\_)*

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

NUMERO  {ENTERO}|{DECIMAL}

/*COMENTARIOS*/

COMENTARIO  #.+\n

/*OPERADORES*/
DOSPUNTOSIGUAL      \:\=
MAYORMAYORIGUAL     \>\>\=
MENORMENORIGUAL     \<\<\=
ASTERISCOASTERISCOIGUAL \*\*\=
BARRABARRAIGUAL     \/\/\=
MENORMENOR          \<\<
MAYORMAYOR          \>\>     
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
PORCIENTOIGUAL      \%\=
ARROBAIGUAL         \@\=
UNPERSANTIGUAL      \&\=
BARRAVERTICALIGUAL  \|\=
EXPONENCIALIGUAL    \^\=


OPERADOR_ASCII  (\+|\-|\*|\/|\%|\@|\&|\||\^|\~|\:\=|\<|\>|\)|\(|\[|\]|\{|\}|\,|\;|\:|\.|\=)
/*STRINGS*/

/*SALTABLES*/
IGNORAR     [ \t\n]

%% /*Parte de las reglas*/
{STRING}            {return STRING;}
{COMENTARIO}
{IGNORAR}
{DOSPUNTOSIGUAL}    {return DOSPUNTOSIGUAL;}
{IDENTIFICADOR}     {return ID;}
{OPERADOR_ASCII}    {return OPERADOR_ASCII;}
{MENORMENOR}        {return MENORMENOR;}              
{MAYORMAYOR}        {return MAYORMAYOR;}                                
{MAYORIGUAL}        {return MAYORIGUAL;}  
{MENORIGUAL}        {return MENORIGUAL;}  
{IGUALIGUAL}        {return IGUALIGUAL;}  
{DISTINTO}          {return DISTINTO;}
{ASTERICOASTERISCO} {return ASTERICOASTERISCO;}    
{BARRABARRA}        {return BARRABARRA;}       
{GUIONFLECHA}       {return GUIONFLECHA;}
{MASIGUAL}          {return MASIGUAL;}
{ASTERISCOIGUAL}    {return ASTERISCOIGUAL;}      
{BARRAIGUAL}        {return BARRAIGUAL;} 
{BARRABARRAIGUAL}   {return BARRABARRAIGUAL;} 
{PORCIENTOIGUAL}    {return PORCIENTOIGUAL;} 
{ARROBAIGUAL}       {return ARROBAIGUAL;} 
{UNPERSANTIGUAL}    {return UNPERSANTIGUAL;}  
{BARRAVERTICALIGUAL} {return BARRAVERTICALIGUAL;}  
{EXPONENCIALIGUAL}  {return EXPONENCIALIGUAL;}
{MAYORMAYORIGUAL}   {return MAYORMAYORIGUAL;} 
{MENORMENORIGUAL}   {return MENORMENORIGUAL;} 
{ASTERISCOASTERISCOIGUAL}   {return ASTERISCOASTERISCOIGUAL;} 
{NUMERO}   {return NUMERO;}
.          {return -1;}
<<EOF>>    {yyterminate();}

%%

void openFile(char *nombreArchivo){
    FILE *miArchivo;
    miArchivo = fopen(nombreArchivo,"r");
    if (miArchivo == NULL) imprimirError(ERROR_ABRIR_ARCHIVO);
    yyin = miArchivo;
}

void closeFile(){
    fclose(yyin);
    yylex_destroy();
}


void sigCompLexico (compLexico *comp){
    /*Vamos a elimianr el lexico.c y implementarlo directamente desde aqui*/
    comp->codigo = yylex();

    /*Si el codifo es -1 es que encontramos un error*/

    if (comp->codigo != 0){ //Controlamos el eof
        comp->lexema = strdup(yytext); //valor que asociamos al componente

    }else if (comp->codigo == -1){
        //no reconocimos componente
        imprimirError(COMP_NO_VALIDO);
    }

    /*Ahora controlamos el tipo que es ya que si es ID hay que añadir a la tabla de simbolos, si es un operador simple hay que imprimir el ascii y en caso de ser 0 es el final del archivo */

    if (comp->codigo == ID){
        //buscamos el elemento en la tabla de simbolos y si no lo insertamos
        insertarTablaSimbolos(comp);

    if (comp->codigo == STRING){
        printf("Soy un string %s\n",comp->lexema);
    }

    }else if (comp->codigo == OPERADOR_ASCII){
        comp->codigo = comp->lexema[0];

    }else if (comp->codigo == 0){
        //cuando se llama a yyterminate, se devuelve 0
        comp->codigo = EOF;
    }
}






