//Problema da Dieta


int n = 6;           // número de ingredientes
range INGREDIENTS = 1..n;
range VIT = 1..2;    // 1 = vitamina A, 2 = vitamina C

// Parâmetros
float minVit[VIT] = [9, 19]; // requisitos mínimos de vitaminas

float vit[VIT][INGREDIENTS] = 
[
  [1, 0, 2, 2, 1, 2], // vitamina A
  [0, 1, 3, 1, 3, 2]  // vitamina C
];

float preco[INGREDIENTS] = [35, 30, 60, 50, 27, 22]; // custo por ingrediente

// Variáveis de decisão
dvar float+ x[INGREDIENTS]; // quantidade de cada ingrediente

// Função objetivo: minimizar o custo total
minimize
  sum(i in INGREDIENTS) preco[i] * x[i];

// Restrições: ingestão mínima de cada vitamina
subject to 
{
  forall (v in VIT)
    sum(i in INGREDIENTS) vit[v][i] * x[i] >= minVit[v];
}

