package codigo;

import static codigo.Tokens.*;

%%

%class Lexer
%type Tokens

/* Definimos los patrones básicos */
L=[a-zA-Z_]+
D=[0-9]+
espacio=[ \t\r]+

%{
    public String lexeme;
%}

%%

/* Espacios en blanco */
{espacio} {}

/* Saltos de línea */
("\n") { return Linea; }

/* Palabras clave de Ruby */
( def ) { lexeme = yytext(); return Def; }
( class ) { lexeme = yytext(); return Class; }
( module ) { lexeme = yytext(); return Module; }
( do ) { lexeme = yytext(); return Do; }
( end ) { lexeme = yytext(); return End; }
( if ) { lexeme = yytext(); return If; }
( elsif ) { lexeme = yytext(); return Elsif; }
( else ) { lexeme = yytext(); return Else; }
( while ) { lexeme = yytext(); return While; }
( until ) { lexeme = yytext(); return Until; }
( for ) { lexeme = yytext(); return For; }
( in ) { lexeme = yytext(); return In; }
( return ) { lexeme = yytext(); return Return; }
( yield ) { lexeme = yytext(); return Yield; }
( break ) { lexeme = yytext(); return Break; }
( next ) { lexeme = yytext(); return Next; }
( redo ) { lexeme = yytext(); return Redo; }
( rescue ) { lexeme = yytext(); return Rescue; }
( ensure ) { lexeme = yytext(); return Ensure; }
( case ) { lexeme = yytext(); return Case; }
( when ) { lexeme = yytext(); return When; }

/* Operadores */
( == ) { lexeme = yytext(); return IgualIgual; }
( != ) { lexeme = yytext(); return Diferente; }
( <=> ) { lexeme = yytext(); return Comparacion; }
( === ) { lexeme = yytext(); return TripleIgual; }
( \.\. ) { lexeme = yytext(); return RangoInclusivo; }
( \.\.\. ) { lexeme = yytext(); return RangoExclusivo; }
( \*\* ) { lexeme = yytext(); return Exponenciacion; }
( \+ ) { lexeme = yytext(); return Suma; }
( - ) { lexeme = yytext(); return Resta; }
( \* ) { lexeme = yytext(); return Multiplicacion; }
( \/ ) { lexeme = yytext(); return Division; }
( % ) { lexeme = yytext(); return Modulo; }
( && ) { lexeme = yytext(); return And; }
( \|\| ) { lexeme = yytext(); return Or; }
( not ) { lexeme = yytext(); return Not; }
( => ) { lexeme = yytext(); return FlechaHash; }

/* Variables y símbolos */
( @[a-zA-Z_]+ ) { lexeme = yytext(); return VariableInstancia; }
( @@[a-zA-Z_]+ ) { lexeme = yytext(); return VariableClase; }
( \$[a-zA-Z_]+ ) { lexeme = yytext(); return VariableGlobal; }
( :[a-zA-Z_]+ ) { lexeme = yytext(); return Simbolo; }

/* Paréntesis, llaves, corchetes */
( \( ) { lexeme = yytext(); return Parentesis_a; }
( \) ) { lexeme = yytext(); return Parentesis_c; }
( \{ ) { lexeme = yytext(); return Llave_a; }
( \} ) { lexeme = yytext(); return Llave_c; }
( \[ ) { lexeme = yytext(); return Corchete_a; }
( \] ) { lexeme = yytext(); return Corchete_c; }

/* Otros caracteres */
( , ) { lexeme = yytext(); return Coma; }
( \. ) { lexeme = yytext(); return Punto; }
( : ) { lexeme = yytext(); return DosPuntos; }
( ; ) { lexeme = yytext(); return P_coma; }

/* Identificadores */
{L}({L}|{D})* { lexeme = yytext(); return Identificador; }

/* Números */
( 0x{D}+ ) { lexeme = yytext(); return Numero; }

/* Errores */
. { return ERROR; }
