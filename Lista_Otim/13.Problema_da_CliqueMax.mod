//Problema da Clique Máxima

int n = 10; //número de vértices no grafo
range V = 1..n;

// Arestas do grafo (apenas i < j)
tuple Edge { int i; int j; }
{Edge} E = {
  <1,3>, <1,4>, <1,6>, <1,7>, <1,8>, <1,9>,
  <2,3>, <2,7>, <2,10>,
  <3,4>, <3,5>, <3,6>, <3,7>, <3,10>,
  <4,6>,
  <5,7>, <5,10>,
  <6,7>, <6,9>,
  <7,9>, <7,10>,
  <8,9>, <8,10>
};

// Gerar pares (i,j) não conectados
tuple Pair { int i; int j; }
{Pair} NP = 
  { <i,j> | i,j in V : i < j && !(<i,j> in E) };

// Variáveis de decisão
dvar boolean x[V];  // x[i] = 1 se vértice i pertence à clique

// Função objetivo: maximizar o subconjunto de vértices que de um grafo que todos os pares de vértices no subconjunto estão conectados por uma aresta
maximize sum(i in V) x[i];

// Restrições
subject to {
  // Se não há aresta entre i e j, então não podem estar juntos na clique
  forall(p in NP)
    x[p.i] + x[p.j] <= 1;
}

