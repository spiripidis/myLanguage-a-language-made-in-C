%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "syntax.tab.h"

    void token_print(int token_id);
    int count_err = 0;
    void yyerror(const char* err);
    char string_buffer[256];
    int String2Int(char *str);

%}

%option noyywrap 
%option case-insensitive
%option yylineno

%x SINGLE_LINE_COMMENT
%x MULTI_LINE_COMMENT
%x STRING

DIGIT            [0-9]
LETTER           [a-zA-Z]
ALPHANUM         {LETTER}|{DIGIT}


IDENTIFIER       _*{LETTER}{ALPHANUM}*

ICONST              [0-9]+
FCONST          ([1-9][0-9]*\.[0-9]+)|(0)?\.[0-9]+ 


TRUE              [1]
FALSE             [0]  

%%





"CLASS"                     { token_print(T_CLASS); return T_CLASS; }
"CHAR"                      { token_print(T_CHAR); return T_CHAR; }
"INT"                       { token_print(T_INT); return T_INT; }
"FLOAT"                     { token_print(T_FLOAT); return T_FLOAT; }
"DOUBLE"                    { token_print(T_DOUBLE); return T_DOUBLE; }
"VOID"                      { token_print(T_VOID); return T_VOID; }
"BOOL"                      { token_print(T_BOOL); return T_BOOL; }
"IF"                        { token_print(T_IF); return T_IF; }
"ELSE"                      { token_print(T_ELSE); return T_ELSE; }
"WHILE"                     { token_print(T_WHILE); return T_WHILE; }
"DO"                        { token_print(T_DO); return T_DO;}

{TRUE}                      { token_print(T_TRUE); return T_TRUE;}
{FALSE}                     { token_print(T_FALSE); return T_FALSE;}

"RETURN"                    { token_print(T_RETURN); return T_RETURN; }
"MAIN"                      { token_print(T_MAIN); return T_MAIN; }
"PRINT"                     { token_print(T_PRINT); return T_PRINT; }


{IDENTIFIER}                { token_print(T_ID); return T_ID; }
{FCONST}                    { token_print(T_FCONST); return T_FCONST; }
{ICONST}                    { token_print(T_ICONST); return T_ICONST; }


"!"                         { token_print(T_NOT); return T_NOT; }
"<="|"<"|">"|">="           { token_print(T_RELATIONALOP); return T_RELATIONALOP; }
"=="|"!="                   { token_print(T_EQUALOP); return T_EQUALOP; }
"||"                        { token_print(T_LOGICALOR); return T_LOGICALOR; }
"&&"                        { token_print(T_LOGICALAND); return T_LOGICALAND; }
"="                         { token_print(T_ASSIGN); return T_ASSIGN; }
"+"|"-"                     { token_print(T_ADDSUBOP); return T_ADDSUBOP; }
"*"|"/"|"%"                 { token_print(T_MULTIPLOP); return T_MULTIPLOP; }
"++"|"--"                   { token_print(T_INCRDECR); return T_INCRDECR; }
"{"                         { token_print(T_OCBRACKET); return T_OCBRACKET; }
"}"                         { token_print(T_CCBRACKET); return T_CCBRACKET; }
"["                         { token_print(T_OBRACKET); return T_OBRACKET; }
"]"                         { token_print(T_CBRACKET); return T_CBRACKET; }
"("                         { token_print(T_OPARENTHESIS); return T_OPARENTHESIS; }
")"                         { token_print(T_CPARENTHESIS); return T_CPARENTHESIS; }
";"                         { token_print(T_SEMICOLON); return T_SEMICOLON; }
","                         { token_print(T_COMMA); return T_COMMA; }
":"                         { token_print(T_COLON); return T_COLON; }


\'[a-zA-Z0-9]\'             { token_print(T_CCONST); return T_CCONST; }
\'[!@#$%^&*()]\'            { token_print(T_CCONST); return T_CCONST; }
\'[^\\]|\\[nbtrv]\'         { token_print(T_CCONST); return T_CCONST; }

"//"                            { printf ("A single line comment found \n"); BEGIN(SINGLE_LINE_COMMENT);}
<SINGLE_LINE_COMMENT>(\n|\n\r)  { BEGIN(INITIAL); printf("Comment Ended \n"); }
<SINGLE_LINE_COMMENT>.          {   }

"/*"                            { printf("Multi line comment found \n"); BEGIN(MULTI_LINE_COMMENT); }
<MULTI_LINE_COMMENT>[^*]*                {   }
<MULTI_LINE_COMMENT>"*"+[^*/]*           {   }
<MULTI_LINE_COMMENT>"*/"                 { printf("multi line comment ended \n"); BEGIN(INITIAL); }



\"                          { strcpy(string_buffer,""); BEGIN(STRING); }
<STRING>\"                  { BEGIN(INITIAL); printf("Found String %s \n", string_buffer); return T_SCONST; }
<STRING>(\\\n|\\\r\n)       { }
<STRING>(\\.|[^"\\])        { 
                                if(strlen(yytext) == 2)
                                {
                                    if(strcmp(yytext,"\\n") == 0)     
                                     { 
                                         strcat(string_buffer,"\n"); 
                                     } else if(strcmp(yytext,"\\t") == 0) 
                                     { 
                                        strcat(string_buffer,"\t"); 
                                     } else if(strcmp(yytext,"\\r")== 0) 
                                     { 
                                         strcat(string_buffer,"\r"); 
                                     } else if(strcmp(yytext,"\\f")== 0) 
                                     { 
                                         strcat(string_buffer,"\f"); 
                                     } else if(strcmp(yytext,"\\b")== 0) 
                                     { 
                                         strcat(string_buffer,"\b"); 
                                    } else if(strcmp(yytext,"\\v")== 0) 
                                    { 
                                        strcat(string_buffer,"\v"); 
                                    } else 
                                    { 
                                        strcat(string_buffer,&yytext[1]); 
                                    }
                                }
                                else { 
                                        strcat(string_buffer,yytext); 
                                     }
                            }
<STRING>(\n|\n\r)           { yyerror("New line in String found without \\ \n");  }  
<STRING><<EOF>>             { yyerror("End of string without closing it \n"); return 0;}
<STRING>.                   { yyerror("Unknow Character. \n");  } 

[ \n]                       {;}/*ignore this*/  
[\r\n]                      {;}/*ignore this*/
[\t]                        {;}/*ignore this*/
.                           { printf("Uncategorised TOKEN at line %d !!!\n",yylineno); }
<<EOF>>                     { return 0;}

%%


void token_print(int token_id)
{
     
      
    printf("Found token %s (%d) at line %d \n",yytext,token_id,yylineno);
    
}

int String2Int(char *str)
{
    return (int) strtoll(&str[2],NULL,10);
}

void yyerror(const char* err)
{
    count_err++;
    printf("[ERROR - LINE %d] %s \n", yylineno, err);
    if(count_err == 10)
    {
        printf("MAXIMUM ERROR FOUND\n");
        exit(EXIT_FAILURE);
    }
    yyless(1); 
}