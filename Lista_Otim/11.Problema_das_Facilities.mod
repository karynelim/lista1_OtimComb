//Problema das Facilities

int N = 3;
int M = 4;

range Depositos = 1..N;
range Clientes = 1..M;

float f[Depositos] = [500, 300, 400]; // custos de instalação

float c[Depositos][Clientes] = [      // custos de atendimento
  [24, 30, 11, 20],
  [28, 27, 82, 83],
  [74, 97, 71, 96]
];

// ------------------------
// Variáveis
// ------------------------

dvar boolean y[Depositos];                 // y[i] = 1 se depósito i for instalado
dvar boolean x[Depositos][Clientes];       // x[i][j] = 1 se cliente j atendido pelo depósito i

// ------------------------
// Função objetivo
// ------------------------

minimize
  sum(i in Depositos) f[i] * y[i] +
  sum(i in Depositos, j in Clientes) c[i][j] * x[i][j];

// ------------------------
// Restrições
// ------------------------

subject to {
  // Cada cliente deve ser atendido por exatamente um depósito
  forall(j in Clientes)
    sum(i in Depositos) x[i][j] == 1;

  // Um cliente só pode ser atendido por um depósito instalado
  forall(i in Depositos, j in Clientes)
    x[i][j] <= y[i];
}
