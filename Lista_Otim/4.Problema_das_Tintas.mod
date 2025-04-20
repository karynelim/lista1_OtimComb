//Problema das Tintas

// Variáveis de decisão
dvar float+ x_SolA;
dvar float+ x_SolB;
dvar float+ x_SEC;
dvar float+ x_COR;

// Parâmetros fixos
float custo_SolA = 1.5;
float custo_SolB = 1.0;
float custo_SEC = 4.0;
float custo_COR = 6.0;

float pct_SEC_SolA = 0.3;
float pct_COR_SolA = 0.7;
float pct_SEC_SolB = 0.6;
float pct_COR_SolB = 0.4;

float total_SR = 1000;
float total_SN = 250;
float total_total = total_SR + total_SN;

// Função objetivo: minimizar custo total de compra
minimize
  custo_SolA * x_SolA +
  custo_SolB * x_SolB +
  custo_SEC * x_SEC +
  custo_COR * x_COR;

// Restrições
subject to {
  // A soma total de todos os líquidos deve ser igual à demanda total (1250L)
  x_SolA + x_SolB + x_SEC + x_COR == total_total;

  // Restrição de SEC total (considerando proporções)
  pct_SEC_SolA * x_SolA + pct_SEC_SolB * x_SolB + x_SEC >= 0.25 * total_SR + 0.20 * total_SN;

  // Restrição de COR total (considerando proporções)
  pct_COR_SolA * x_SolA + pct_COR_SolB * x_SolB + x_COR >= 0.50 * total_SR + 0.50 * total_SN;
}
