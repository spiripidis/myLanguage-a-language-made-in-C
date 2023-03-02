/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_SYNTAX_TAB_H_INCLUDED
# define YY_YY_SYNTAX_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    T_EOF = 0,
    T_ICONST = 258,
    T_FCONST = 259,
    T_CCONST = 260,
    T_TRUE = 261,
    T_FALSE = 262,
    T_SCONST = 263,
    T_ID = 264,
    T_CLASS = 265,
    T_CHAR = 266,
    T_INT = 267,
    T_FLOAT = 268,
    T_DOUBLE = 269,
    T_VOID = 270,
    T_IF = 271,
    T_ELSE = 272,
    T_WHILE = 273,
    T_DO = 274,
    T_BOOL = 275,
    T_RETURN = 276,
    T_MAIN = 277,
    T_PRINT = 278,
    T_RELATIONALOP = 279,
    T_EQUALOP = 280,
    T_LOGICALOR = 281,
    T_LOGICALAND = 282,
    T_ASSIGN = 283,
    T_ADDSUBOP = 284,
    T_MULTIPLOP = 285,
    T_NOT = 286,
    T_INCRDECR = 287,
    T_OCBRACKET = 288,
    T_CCBRACKET = 289,
    T_OBRACKET = 290,
    T_CBRACKET = 291,
    T_OPARENTHESIS = 292,
    T_CPARENTHESIS = 293,
    T_SEMICOLON = 294,
    T_COMMA = 295,
    T_COLON = 296,
    LOWER_THAN_ELSE = 297
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 18 "Syntax.y" /* yacc.c:1909  */
    int intval;
            float floatval;
            char chraval;
            _Bool boolval;
            char* strval;
        

#line 106 "Syntax.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_SYNTAX_TAB_H_INCLUDED  */
