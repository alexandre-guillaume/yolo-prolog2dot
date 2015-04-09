#ifndef ARBRE_H
#define ARBRE_H
typedef enum 
{
	TVAR,//0
	TCONST,//1
	TCONST_STR,//2
	TCONST_INT,

	TLISTE,
	TLISTE_FAIT,
	TLISTE_REGLE,

	TREGLE,
	TCORPS,

	TATOM,
	TAFFECT,

	TLISTE_ARG,

	TCMP,

	TPLUS,
	TMOINS,
	TMULT,
	TDIV,

	TLT,
	TLTE,
	TEQ,
	TGT,
	TGTE,
	TNE,

	TVIDE

} typenode;



typedef struct node
{
	int n;
	char * s;
	typenode type;
	struct node *gauche;
	struct node *droite; 
} node ;

typedef node *tree;
tree arbre;

//tree create_node_val(typenode type, int value);
tree create_node(typenode type);
tree create_node_str(typenode type, char * s);
tree create_node_int(typenode type, int value);
tree racine_gauche(tree r,tree g);
tree racine_droite(tree r,tree d);
void memory_free(tree a);
#endif