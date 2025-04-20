import time
import random

# a) Representação da solução com custo por item
def solucao_inicial(itens):
    bins = []
    for item in sorted(itens, key=lambda x: x[0], reverse=True):
        colocado = False
        for b in bins:
            if sum(i[0] for i in b) + item[0] <= 1:
                b.append(item)
                colocado = True
                break
        if not colocado:
            bins.append([item])
    return bins

# b) Função de avaliação: soma dos custos dos itens usados
def custo(solucao):
    return sum(item[1] for bin in solucao for item in bin)

# c) Geração de vizinhos 
def gerar_vizinhos(solucao):
    vizinhos = []
    for i in range(len(solucao)):
        for j in range(len(solucao)):
            if i != j:
                for item in solucao[i]:
                    if sum(it[0] for it in solucao[j]) + item[0] <= 1:
                        nova = [bin[:] for bin in solucao]
                        nova[i].remove(item)
                        nova[j].append(item)
                        if len(nova[i]) == 0:
                            del nova[i]
                        vizinhos.append(nova)
    return vizinhos

# d) Busca local com critério de parada
def busca_local(solucao_inicial, tempo_limite=5):
    melhor = solucao_inicial
    melhor_custo = custo(melhor)
    inicio = time.time()

    while time.time() - inicio < tempo_limite:
        vizinhos = gerar_vizinhos(melhor)
        melhorou = False
        for v in vizinhos:
            if custo(v) < melhor_custo:
                melhor = v
                melhor_custo = custo(v)
                melhorou = True
                break 
        if not melhorou:
            break
    return melhor, melhor_custo


# Execução com 100 itens aleatórios com custos
if __name__ == "__main__":
    # itens com peso de 0.1 - 1.0 e custo de 1 - 10
    # (peso, custo)
    itens = [
        (0.64, 7), (0.21, 3), (0.39, 9), (0.29, 4), (0.42, 8), (0.92, 5), (0.19, 2), (0.99, 6), (0.96, 4), (0.25, 7),
        (0.13, 5), (0.84, 4), (0.77, 8), (0.22, 2), (0.59, 6), (0.39, 10), (0.5, 4), (0.68, 9), (0.69, 9), (0.56, 8),
        (0.49, 6), (0.56, 1), (0.84, 10), (0.98, 10), (0.28, 8), (0.21, 8), (0.24, 1), (0.46, 8), (0.76, 5), (0.86, 3),
        (0.67, 9), (0.74, 8), (0.34, 5), (0.77, 3), (0.22, 2), (0.42, 5), (0.72, 3), (0.5, 3), (0.8, 2), (0.9, 2),
        (0.14, 10), (0.66, 3), (0.92, 8), (0.62, 2), (0.75, 7), (0.71, 4), (0.14, 2), (0.24, 5), (0.17, 7), (0.72, 8),
        (0.58, 3), (0.81, 2), (0.55, 8), (0.87, 6), (0.14, 8), (0.5, 6), (0.65, 1), (0.37, 9), (0.98, 1), (0.23, 1),
        (0.11, 8), (0.71, 8), (0.59, 1), (0.84, 8), (0.74, 4), (0.36, 2), (0.29, 5), (0.69, 7), (0.18, 10), (0.76, 1),
        (0.36, 1), (0.65, 2), (0.63, 10), (0.71, 7), (0.28, 4), (0.74, 9), (0.27, 5), (0.66, 8), (0.78, 7), (0.32, 1),
        (0.15, 9), (0.93, 2), (0.11, 3), (0.85, 7), (0.69, 10), (0.1, 5), (1.0, 2), (0.69, 6), (0.4, 9), (0.71, 6),
        (0.32, 10), (0.21, 9), (0.72, 4), (0.41, 3), (0.36, 8), (0.4, 2), (0.8, 4), (0.74, 6), (0.72, 2), (0.32, 3)
    ]

    inicial = solucao_inicial(itens)
    melhor, custo_total = busca_local(inicial, tempo_limite=5)

    print("Melhor solução encontrada:")
    for i, b in enumerate(melhor):
        pesos = [f"{x[0]:.2f}" for x in b]
        custos = [str(x[1]) for x in b]
        print(f"Bin {i+1}: Pesos = {pesos}, Custos = {custos}, total peso = {sum(x[0] for x in b):.2f}")
    print(f"Total de bins utilizados: {len(melhor)}")
    print(f"Custo total dos itens alocados: {custo_total}")
