//Problema de cobertura
// Conjunto de elementos que devem ser cobertos
int numElementos = 5;
range I = 1..numElementos;

// Conjunto de subconjuntos candidatos
int numSubconjuntos = 4;
range J = 1..numSubconjuntos;

// Custo de cada subconjunto
int custo[J] = [3, 2, 1, 4];

// Matriz de cobertura (a_ij): 1 se subconjunto j cobre elemento i, 0 caso contrário
int a[I][J] = [
  // j1 j2 j3 j4
    [1, 0, 1, 0], // elemento 1
    [1, 1, 0, 0], // elemento 2
    [0, 1, 0, 1], // elemento 3
    [0, 0, 1, 1], // elemento 4
    [0, 0, 0, 1]  // elemento 5
];

// Variável de decisão: x[j] = 1 se subconjunto j for escolhido
dvar boolean x[J];

// Função objetivo: minimizar o custo total dos subconjuntos escolhidos
minimize
  sum(j in J) custo[j] * x[j];

// Restrição: cada elemento deve ser coberto por pelo menos um subconjunto
subject to {
  forall(i in I)
    sum(j in J) a[i][j] * x[j] >= 1;
}
