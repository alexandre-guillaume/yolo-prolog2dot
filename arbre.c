#include "arbre.h"
#include <stdlib.h>
#include <stdio.h>

tree create_node_str(typenode type,char * value) {
	tree a = (tree)malloc(sizeof(node));
	a->s =  value;
	//a->n = NULL;
	a->type = type;
	a->gauche = NULL;
	a->droite = NULL;
	return a;
}

tree create_node_int(typenode type,int value) {
		//printf("hello world2\n");
	tree a = (tree)malloc(sizeof(node));
	a->n =  value;
	a->s = NULL;
	//printf("hello world3\n");
	a->type = type;
	a->gauche = NULL;
	a->droite = NULL;
	//printf("hello world4\n");
	return a;
}


tree create_node(typenode type) {
	tree a = (tree)malloc(sizeof(node));
	//a->n = NULL;
	a->s = NULL;
	a->type = type;
	a->gauche = NULL;
	a->droite = NULL;
	return a; 
}

void affiche_arbre(tree a) {
	printf("racine\n");
	if (a != NULL) {
			printf("type = %d\n",a->type);
		
		if(a->n) {
			printf("%d\n",a->n);
		}
		if(a->s != NULL) {
			printf("%s\n", a->s);
		}

		if( a->gauche != NULL) {
			printf("sous arbre gauche\n");
			affiche_arbre(a->gauche);
		}
		if (a->droite != NULL) {
			printf("sous arbre droit\n");
			affiche_arbre(a->droite);
		}	
	}
}

tree racine_gauche(tree r,tree g) {
	if(r->gauche == NULL) {
		r->gauche = g;
	}
	else {
		printf("action impossible r a deja un fils gauche\n");
	}
	return r;
}

tree racine_droite(tree r,tree d) {
	if(r->droite == NULL) {
		r->droite = d;
	}
	else {
		printf("action impossible r a deja un fils droit\n");
	}
	return r;
}

void memory_free(tree a) {
	if(a != NULL) {
		memory_free(a->gauche);
		memory_free(a->droite);
		if (a->type == TCONST_STR || a->type == TCONST || a->type == TVAR)	{
			free(a->s);
		}
		free(a);
		a = NULL;
	}
}

/*int main(int argc, char const *argv[])
{
	//printf("hello world\n");
	tree a = NULL;
	tree b = NULL;
	b = create_node_str(CHAR,"bidul");
	a = create_node_int(VAR,6);
	a = racine_gauche(a,b);
	affiche_arbre(a);
	//printf("hello world\n");
	return 0;
}*/

