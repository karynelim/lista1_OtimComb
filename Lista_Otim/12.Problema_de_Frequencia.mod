//Problema de Frequencia

int n = 6; // número de antenas
range Antena = 1..n;
range Freq = 1..n; // máximo de frequências possíveis

// Conflitos: pares de antenas que não podem compartilhar a mesma frequência
tuple Conflito {
  int i;
  int j;
}

{Conflito} conflitos = {
  <1,3>, <1,4>, <1,5>, <2,5>, <3,4>, <3,5>, <4,5>, <4,6>
};

// Variáveis de decisão
dvar int f[Antena] in Freq; // frequência atribuída à antena i
dvar int+ maxFreq;          // maior frequência usada

// Objetivo: minimizar a maior frequência usada (equivale a minimizar número de cores/frequências)
minimize maxFreq;

// Restrições
subject to {
  // Antenas em conflito não podem ter mesma frequência
  forall(c in conflitos)
    f[c.i] != f[c.j];

  // maxFreq deve ser maior ou igual a qualquer frequência usada
  forall(i in Antena)
    f[i] <= maxFreq;
}


