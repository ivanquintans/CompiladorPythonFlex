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

/*Imaginarios*/
IMAGINARIO  ({ENTERO|DECIMAL})j

/*COMENTARIOS*/

COMENTARIO  #[^\n]*

/*OPERADORES*/

OPERADOR (\+|\-|\*|\*\*|\/|\/\/|\%|\@|\<\<|\>\>|\&|\||\^|\~|\:\=|\<|\>|\<\=|\>\=|\=\=|\!\=|\)|\(|\[|\]|\{|\}|\,|\;|\:|\.|\=|\-\>|\+\=|\-\=|\*\=|\/\=|\/\/\=|\%\=|\@\=|\&\=|\|\=|\^\=|\>\>\=|\<\<\=|\*\*\=)

/*STRINGS*/

STRING_SIMPLE   (\'(.|\n)+\')|(\"(.|\n)+\")
STRING_LARGO    \"\"\"(.|\n)+\"\"\"

/*SALTABLES*/
IGNORAR     [ \t\n]

% /*Parte de las reglas*/



