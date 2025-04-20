//Problema da mochila
int n = 10; //número de itens
range Itens = 1..n;

int W = 35;

int peso[Itens] = [2, 1, 5, 4, 4, 3, 2, 9, 2, 10];
int valor[Itens] = [64, 14, 13, 21, 37, 39, 74, 87, 13, 81];

dvar boolean x[Itens]; // x[i] = 1 se item i for incluído na mochila

maximize
  sum(i in Itens) valor[i] * x[i];

subject to {
  sum(i in Itens) peso[i] * x[i] <= W;
}
