%{

    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <stdbool.h>
    #include "syntax.tab.h"

    extern FILE *yyin;
    extern int yylex();
    extern void token_print(int token_id);
    extern int String2Int(char *str);
    
%}

%error-verbose

%union {    int intval;
            float floatval;
            char chraval;
            _Bool boolval;
            char* strval;
        }


%token <intval> T_ICONST "integer constant"
%token <floatval> T_FCONST "float constant"          
%token <charval> T_CCONST "character constant"  
%token <boolval> T_TRUE "True"
%token <boolval> T_FALSE "False"
%token <strval> T_SCONST "String constant"
%token <strval> T_ID "Identifier"

%token T_CLASS     "Class"
%token T_CHAR      "Char"
%token T_INT       "Integer"
%token T_FLOAT     "Float"
%token T_DOUBLE    "Double"
%token T_VOID      "Void"
%token T_IF        "If"
%token T_ELSE      "Else"
%token T_WHILE     "While"
%token T_DO        "Do"
%token T_BOOL      "Bool"

%token T_RETURN    "Return"
%token T_MAIN      "Main"
%token T_PRINT     "Print"
%token T_RELATIONALOP       "RelOp"                    
%token T_EQUALOP            "EqualOp"          
%token T_LOGICALOR          "LogicalOr"
%token T_LOGICALAND         "LogicalAnd"
%token T_ASSIGN             "="
%token T_ADDSUBOP           "AddSubOp"
%token T_MULTIPLOP          "MultiplOp"
%token T_NOT                "NotOp"
%token T_INCRDECR           "IncrDecr"
%token T_OCBRACKET          "{"
%token T_CCBRACKET          "}"
%token T_OBRACKET           "[" 
%token T_CBRACKET           "]"
%token T_OPARENTHESIS       "("
%token T_CPARENTHESIS       ")" 
%token T_SEMICOLON          ";"
%token T_COMMA              ","
%token T_COLON              ":"
%token T_EOF    0           "End Of File"

%left T_COMMA
%left T_LOGICALOR
%left T_LOGICALAND 
%left T_ADDSUBOP
%left T_MULTIPLOP
%left T_OCBRACKET
%left T_CCBRACKET
%left T_OBRACKET
%left T_CBRACKET
%left T_NOT
%left T_INCRDECR
%left T_EQUALOP
%right T_ASSIGN
%right T_RELATIONALOP


%nonassoc LOWER_THAN_ELSE 
%nonassoc T_ELSE
                
%start Program



%%
    Program:                    Class
    Class:                      T_CLASS T_ID T_OCBRACKET global_declarations main_function T_CCBRACKET
    global_declarations:		global_declarations global_declaration
				                | %empty
    global_declaration:		    global_var_declaration
				                | func_declaration
    typename:			        standard_type
				                | T_ID
    standard_type:			    T_CHAR
				                | T_INT
				                | T_FLOAT
				                | T_VOID
                                | T_BOOL
    dims:				          dims dim
    dim:				        T_OBRACKET T_ICONST T_CBRACKET
				                | T_OBRACKET T_CBRACKET
    initializer:			    T_ASSIGN init_value
				                | %empty
    init_value:			        expression
				                | T_OCBRACKET init_values T_CCBRACKET
    expression:			        expression T_LOGICALOR expression
				                | expression T_LOGICALAND expression
				                | expression T_EQUALOP expression
				                | expression T_RELATIONALOP expression
				                | expression T_ADDSUBOP expression
				                | expression T_MULTIPLOP expression
				                | T_NOT expression
				                | T_ADDSUBOP expression
				                | T_INCRDECR expression
				                | variable T_INCRDECR
				                | variable 
				                | variable T_OPARENTHESIS expression_list T_CPARENTHESIS 
				                | constant
				                | T_OPARENTHESIS general_expression T_CPARENTHESIS 
				                | T_OPARENTHESIS standard_type T_CPARENTHESIS 
				                | listexpression
    variable:			        variable T_OBRACKET general_expression T_CBRACKET 
				                | typename T_ID
							    | T_ID
    general_expression:		    general_expression T_COMMA general_expression
				                | assignment
    assignment:		        	variable T_ASSIGN assignment
				                | expression
    expression_list:		    general_expression
				                | %empty
    constant:			        T_CCONST
				                | T_ICONST
				                | T_FCONST
				                | T_SCONST
                                | T_FALSE
                                | T_TRUE
    listexpression:			    T_OBRACKET expression_list T_CBRACKET
    init_values:			    init_values T_COMMA init_value
				                | init_value
    variabledefs:			    variabledefs T_COMMA variabledef
				                | variabledef
    variabledef:			    T_ID dims
    short_func_declaration:		short_par_func_header T_SEMICOLON
				                | nopar_func_header T_SEMICOLON
    short_par_func_header:		func_header_start T_OPARENTHESIS parameter_types T_CPARENTHESIS 
    func_header_start: 		    typename T_ID
    parameter_types:		    parameter_types T_COMMA typename pass_list_dims
				                | typename pass_list_dims
    pass_list_dims:			    dims
    nopar_func_header:		    func_header_start T_OPARENTHESIS T_CPARENTHESIS
    global_var_declaration:		typename init_variabledefs T_SEMICOLON
    init_variabledefs:		    init_variabledefs T_COMMA init_variabledef
				                | init_variabledef
    init_variabledef:	    	variabledef initializer
    func_declaration:		    short_func_declaration
				                | full_func_declaration
    full_func_declaration:		full_par_func_header T_OCBRACKET decl_statements T_CCBRACKET
				                | nopar_func_header T_OCBRACKET decl_statements T_CCBRACKET
    full_par_func_header:		func_header_start T_OPARENTHESIS parameter_list T_CPARENTHESIS
    parameter_list:			    parameter_list T_COMMA typename pass_variabledef
				                | typename pass_variabledef
    pass_variabledef:		    variabledef
				                | T_ID
    decl_statements:	    	declarations statements
				                | declarations 
				                | statements
				                | %empty
    declarations:			    declarations typename variabledefs T_SEMICOLON
				                | typename variabledefs T_SEMICOLON
    statements:		        	statements statement
				                | statement
    statement:			        expression_statement
				                | if_statement
 				                | while_statement
				                | return_statement
				                | comp_statement
				                | T_SEMICOLON
    expression_statement:		general_expression T_SEMICOLON
    if_statement:		    	T_IF T_OPARENTHESIS general_expression T_CPARENTHESIS statement if_tail 
    if_tail:			        T_ELSE statement 
				                | %empty %prec LOWER_THAN_ELSE
    while_statement: 		    T_WHILE T_OPARENTHESIS general_expression T_CPARENTHESIS statement
    optexpr:			        general_expression 
				                | %empty
    return_statement:	    	T_RETURN optexpr T_SEMICOLON
    comp_statement:			    T_OCBRACKET decl_statements T_CCBRACKET
    main_function:			    main_header T_OCBRACKET decl_statements T_CCBRACKET
    main_header:			    T_INT T_MAIN T_OPARENTHESIS T_CPARENTHESIS 



    


%%

int main(int argc, char *argv[])
{
    int token; 
    if(argc > 1)
    {
        yyin = fopen(argv[1],"r");
        if(yyin == NULL)
        {
                perror ("Error Opening the File \n");
                return -1;
        }
    }     

yyparse();

fclose(yyin);
return 0;
}
