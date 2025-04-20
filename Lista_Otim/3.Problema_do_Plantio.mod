// Problema do Plantio

{string} culturas = {"milho", "arroz", "feijao"};
range Fazendas = 1..3;

// Parâmetros por cultura
float lucro[culturas] = [5000, 4000, 1800];
float aguaPorArea[culturas] = [5.5, 4.0, 3.5];
float areaMax[culturas] = [660, 880, 400];

// Parâmetros por fazenda
float areaFazenda[Fazendas] = [400, 650, 350];
float aguaFazenda[Fazendas] = [1800, 2200, 950];

// Variáveis de decisão: proporção da área de cada cultura (mesma para todas as fazendas)
dvar float+ x[culturas]; // área plantada da cultura c em cada fazenda

// Função objetivo: maximizar o lucro total
maximize
  sum(c in culturas, f in Fazendas) lucro[c] * x[c];

// Restrições
subject to {
  // Limite de área por fazenda
  forall(f in Fazendas)
    sum(c in culturas) x[c] <= areaFazenda[f];

  // Limite de água por fazenda
  forall(f in Fazendas)
    sum(c in culturas) aguaPorArea[c] * x[c] <= aguaFazenda[f];

  // Área total máxima por cultura (distribuída entre 3 fazendas)
  forall(c in culturas)
    3 * x[c] <= areaMax[c];
}

