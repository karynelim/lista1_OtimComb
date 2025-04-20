//Problema de escalonamento de horário
int nbDias = 7;
range Dias = 1..nbDias;

// Demanda diária 
int demanda[Dias] = [3, 2, 4, 4, 5, 3, 2]; //Dados aleatórios

// Variável de decisão: enfermeiras que começam no dia i
dvar int+ x[Dias]; // x[i] = número de enfermeiras que começam no dia i

// Função objetivo: minimizar o número de enfermeiras contratadas
minimize
  sum(i in Dias) x[i];

// Restrição: Todos os dias é preciso atender a demanda
subject to {
  forall(d in Dias) {
    sum(i in Dias : ((d - i + 8) % 7 + 1) <= 5) x[i] >= demanda[d];
    // ((d - i + 8) % 7 + 1) <= 5 → verifica se d está dentro dos 5 dias após i
  }
}
