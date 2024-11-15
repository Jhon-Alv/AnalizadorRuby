package codigo;

import java_cup.runtime.Symbol;

%%

%class LexerCup
%type java_cup.runtime.Symbol
%cup
%full
%line
%char

/* Patrones básicos */
L=[a-zA-Z_]+
D=[0-9]+
espacio=[ \t\r\n]+

%{
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }

    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
%}

%%

/* Espacios en blanco */
{espacio} { /* Ignorar */ }

/* Palabras clave de Ruby */
( def ) { return symbol(sym.Def, yytext()); }
( class ) { return symbol(sym.Class, yytext()); }
( module ) { return symbol(sym.Module, yytext()); }
( do ) { return symbol(sym.Do, yytext()); }
( end ) { return symbol(sym.End, yytext()); }
( if ) { return symbol(sym.If, yytext()); }
( elsif ) { return symbol(sym.Elsif, yytext()); }
( else ) { return symbol(sym.Else, yytext()); }
( while ) { return symbol(sym.While, yytext()); }
( until ) { return symbol(sym.Until, yytext()); }
( for ) { return symbol(sym.For, yytext()); }
( in ) { return symbol(sym.In, yytext()); }
( return ) { return symbol(sym.Return, yytext()); }
( yield ) { return symbol(sym.Yield, yytext()); }
( break ) { return symbol(sym.Break, yytext()); }
( next ) { return symbol(sym.Next, yytext()); }
( redo ) { return symbol(sym.Redo, yytext()); }
( rescue ) { return symbol(sym.Rescue, yytext()); }
( ensure ) { return symbol(sym.Ensure, yytext()); }
( case ) { return symbol(sym.Case, yytext()); }
( when ) { return symbol(sym.When, yytext()); }

/* Operadores */
( == ) { return symbol(sym.IgualIgual, yytext()); }
( != ) { return symbol(sym.Diferente, yytext()); }
( <=> ) { return symbol(sym.Comparacion, yytext()); }
( === ) { return symbol(sym.TripleIgual, yytext()); }
( \.\. ) { return symbol(sym.RangoInclusivo, yytext()); }
( \.\.\. ) { return symbol(sym.RangoExclusivo, yytext()); }
( \*\* ) { return symbol(sym.Exponenciacion, yytext()); }
( \+ ) { return symbol(sym.Suma, yytext()); }
( - ) { return symbol(sym.Resta, yytext()); }
( \* ) { return symbol(sym.Multiplicacion, yytext()); }
( \/ ) { return symbol(sym.Division, yytext()); }
( % ) { return symbol(sym.Modulo, yytext()); }
( && ) { return symbol(sym.And, yytext()); }
( \|\| ) { return symbol(sym.Or, yytext()); }
( not ) { return symbol(sym.Not, yytext()); }
( => ) { return symbol(sym.FlechaHash, yytext()); }

/* Variables y símbolos */
( @[a-zA-Z_]+ ) { return symbol(sym.VariableInstancia, yytext()); }
( @@[a-zA-Z_]+ ) { return symbol(sym.VariableClase, yytext()); }
( \$[a-zA-Z_]+ ) { return symbol(sym.VariableGlobal, yytext()); }
( :[a-zA-Z_]+ ) { return symbol(sym.Simbolo, yytext()); }

/* Paréntesis, llaves, corchetes */
( \( ) { return symbol(sym.Parentesis_a, yytext()); }
( \) ) { return symbol(sym.Parentesis_c, yytext()); }
( \{ ) { return symbol(sym.Llave_a, yytext()); }
( \} ) { return symbol(sym.Llave_c, yytext()); }
( \[ ) { return symbol(sym.Corchete_a, yytext()); }
( \] ) { return symbol(sym.Corchete_c, yytext()); }

/* Otros caracteres */
( , ) { return symbol(sym.Coma, yytext()); }
( \. ) { return symbol(sym.Punto, yytext()); }
( : ) { return symbol(sym.DosPuntos, yytext()); }
( ; ) { return symbol(sym.P_coma, yytext()); }

/* Identificadores */
{L}({L}|{D})* { return symbol(sym.Identificador, yytext()); }

/* Números hexadecimales */
( 0x{D}+ ) { return symbol(sym.Numero, yytext()); }

/* Errores */
. { return symbol(sym.ERROR, yytext()); }
