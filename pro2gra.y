%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "arbre.h"
#define YYSTYPE void *
// lire un 
int yyparse();
// fonction externes 
int yylex(void);
extern void yyerror(const char *s);
extern int yylineno;
extern char yytext[8192];
extern FILE * yyin;
FILE * out;

int arite = 0;

%}

//Symboles terminaux qui seront fournis par yylex()
%token OUVRIR FERMER
%token CONST_CHAR ENTIER CONST VARIABLE
%token PLUS MOINS DIVISE FOIS
%token AFFECT
%token GT GTE LT LTE EQ NE
%token AND EOL SEP

%%
start : programme {arbre = $1;};

programme : faits regles {$$ = racine_gauche(racine_droite(create_node(TLISTE),$1),$2);}
| faits {$$ = racine_droite(create_node(TLISTE),$1);}
| regles {$$ = racine_gauche(create_node(TLISTE),$1);}
;

faits : faits fait {$$ = racine_gauche(racine_droite(create_node(TLISTE_FAIT),$2),$1);}
|fait {$$ = racine_droite(create_node(TLISTE_FAIT),$1);}
;

regles : regles regle {$$ = racine_gauche(racine_droite(create_node(TLISTE_REGLE),$1),$2);}
| regle {racine_droite(create_node(TLISTE_REGLE),$1);}
;

fait : atom EOL {$$ = $1;}
;

regle : atom SEP corps EOL {$$ = racine_gauche(racine_droite(create_node(TREGLE), $3), $1);}
| SEP corps EOL {$$ = racine_droite(create_node(TREGLE), $2);}
;

corps : corps2 AND corps {$$ = racine_gauche(racine_droite(create_node(TCORPS), $1), $3);}
| corps2 {racine_droite(create_node(TCORPS), $1);}
;

corps2 : atom {$$ = $1;}
| compare {$$ = $1;}
| affectation {$$ = $1;}
;

compare : operation operateur operation {$$ = racine_gauche(racine_droite(create_node_int(TCMP, $2), $3),(int)$1);}
;

affectation : VARIABLE AFFECT operation {$$ = racine_gauche(racine_droite(create_node(TAFFECT), $3), create_node_str(TVAR, $1));}
;

atom : argument OUVRIR params FERMER {$$ = racine_gauche(racine_droite(create_node(TATOM), $1), $3);}
|argument {racine_gauche(create_node(TATOM), $1);}
|argument OUVRIR FERMER {racine_gauche(create_node(TATOM), $1);}
;

params : argument AND params {arite += 1; $$ = racine_gauche(racine_droite(create_node_int(TLISTE_ARG, arite),(int) $1), $3);}
| argument {arite = 1; $$ = racine_droite(create_node_int(TLISTE_ARG,arite),$1);}
;

operation : operation PLUS e1 {$$ = racine_gauche(racine_droite(create_node(TPLUS), $1), $3);}
| operation MOINS e1 {$$ = racine_gauche(racine_droite(create_node(TMOINS), $1), $3);}
| e1 {$$ = $1;}
;

e1 : e1 FOIS e2 {$$ = racine_gauche(racine_droite(create_node(TMULT), $1), $3);}
| e1 DIVISE e2 {$$ = racine_gauche(racine_droite(create_node(TDIV), $1), $3);}
| e2 {$$ = $1;}
;

operateur: GT {$$ = TGT ;}
| GTE {$$ = TGTE;}
| LT {$$ = TLT;}
| LTE {$$ = TLTE;}
| EQ {$$ = TEQ;}
| NE {$$ = TNE;}
;

argument : ENTIER {$$ = create_node_int(TCONST_INT,(int)$1);}
| CONST {$$ = create_node_str(TCONST,$1);}
| VARIABLE {$$ = create_node_str(TVAR,$1);}
| CONST_CHAR {$$ = create_node_str(TCONST_STR,$1);}
;

e2 : VARIABLE {$$ = create_node_str(TVAR,$1);}
| ENTIER {$$ = create_node_int(TCONST_INT,(int)$1);}
;

%%

int main(int argc, char *argv[]) {
	if(argc != 3) {
	printf("erreur dans le passage d'argument %s <fichier entre> <fichier sortie>\n",argv[0]);
	exit(EXIT_FAILURE);
	}
	yyin = fopen(argv[1], "r");
	//out = fopen(argv[2], "w");
	if(yyin == NULL) {
		printf("erreur fichier %s \n",argv[1]);
		exit(EXIT_FAILURE);		
	}
	//if (out == NULL){
	//	printf("Impossible d'écrire dans %s\n", argv[2]);
	//	exit(EXIT_FAILURE);
	//}
	if(yyparse()){
	printf("erreur parsing\n");
	exit(EXIT_FAILURE);
	}
	affiche_arbre(arbre);
	fclose(yyin);
	memory_free(arbre);

	
	return 0;
}

void yyerror(const char *s) {
	printf("yyerror : %s at ligne %d : %s \n",s,yylineno,yytext);
	exit(EXIT_FAILURE);
}
