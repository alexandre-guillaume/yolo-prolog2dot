famille(1).
femme(titi).
homme("toto").
parent(X,Y) :- enfant(Y,X).
pere(X) :- parent(X,Y), homme(X).
famille(Y) :- nbfamille(Z), famille(X), Y = X + 1, Y <= Z.
