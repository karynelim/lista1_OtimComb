// Problema do Transporte

range F = 1..3; // Fábricas
range D = 1..3; // Depósitos

// Parâmetros: custo de transporte c_ij
float c[F][D] = [
  [8, 5, 6],   // fábrica 1 para depósitos 1, 2, 3
  [15, 10, 12],// fábrica 2
  [3, 9, 10]   // fábrica 3
];

// Oferta das fábricas
float oferta[F] = [120, 80, 80];

// Demanda dos depósitos
float demanda[D] = [150, 70, 60];

// Variáveis de decisão: quantidade enviada da fábrica i ao depósito j
dvar float+ x[F][D];

// Função objetivo: minimizar custo total de transporte
minimize
  sum(i in F, j in D) c[i][j] * x[i][j];

// Restrições
subject to {
  // A quantidade enviada por cada fábrica não pode ultrapassar sua oferta
  forall(i in F)
    sum(j in D) x[i][j] <= oferta[i];

  // A demanda de cada depósito deve ser totalmente atendida
  forall(j in D)
    sum(i in F) x[i][j] == demanda[j];
}
