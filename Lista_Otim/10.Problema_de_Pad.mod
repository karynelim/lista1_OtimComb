//Problema de Padrões

int numP = 4;
range Padrao = 1..numP;

// Dados dos padrões
int tipo_folha[Padrao] = [1, 2, 1, 1];
int num_corpo[Padrao] = [1, 2, 0, 4];
int num_tampa[Padrao] = [7, 3, 9, 4];
//int tempo[Padrao] = [2, 3, 2, 1];

// Recursos disponíveis
int folha1 = 200;
int folha2 = 90;
//int tempo_limite = 100;

// Variáveis de decisão
dvar int+ x[Padrao]; // quantidade de cada padrão a imprimir
dvar int+ z;         // número de latinhas completas
dvar int+ corpos_sobrando;
dvar int+ tampas_sobrando;

// Função objetivo: maximizar o lucro total da produção
maximize 
  50 * z - 3 * tampas_sobrando - 50 * corpos_sobrando;

subject to {
  // Restrição de folhas tipo 1
  sum(p in Padrao : tipo_folha[p] == 1) x[p] <= folha1;

  // Restrição de folhas tipo 2
  sum(p in Padrao : tipo_folha[p] == 2) x[p] <= folha2;

 // Restrição de tempo total
 // sum(p in Padrao) tempo[p] * x[p] <= tempo_limite;
 //Como no problema não considera limite de tempo, não foi considerada a restrição

  // Definição dos totais de corpos e tampas
  sum(p in Padrao) num_corpo[p] * x[p] == z + corpos_sobrando;
  sum(p in Padrao) num_tampa[p] * x[p] == 2 * z + tampas_sobrando;
}
