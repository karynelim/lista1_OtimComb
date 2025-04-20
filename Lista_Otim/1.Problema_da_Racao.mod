
//Problema da ração

// Variáveis de decisão
dvar float+ x1; // Quantidade de ração AMGS
dvar float+ x2; // Quantidade de ração RE

// Função objetivo: maximizar o lucro
maximize
  11 * x1 + 12 * x2;

// Restrições
subject to 
{
  x1 + 4 * x2 <= 10000;      // Restrição de carne
  5 * x1 + 2 * x2 <= 30000;  // Restrição de cereal
}