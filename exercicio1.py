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
    # itens com peso de 0.1 - 0.5 e custo de 1 - 10
    # (peso, custo)
    itens = [
        (0.41, 6), (0.32, 10), (0.14, 4), (0.17, 7), (0.13, 10), (0.38, 8), (0.35, 5), (0.5, 9), (0.3, 8), (0.43, 9),
        (0.29, 10), (0.34, 6), (0.46, 4), (0.12, 8), (0.27, 2), (0.17, 2), (0.28, 7), (0.45, 6), (0.43, 2), (0.49, 2),
        (0.22, 1), (0.24, 4), (0.13, 2), (0.45, 5), (0.25, 7), (0.34, 6), (0.44, 5), (0.22, 3), (0.13, 3), (0.24, 3),
        (0.12, 6), (0.48, 5), (0.13, 4), (0.41, 9), (0.39, 7), (0.47, 5), (0.3, 9), (0.48, 4), (0.44, 10), (0.17, 2),
        (0.48, 2), (0.44, 4), (0.15, 7), (0.26, 9), (0.12, 10), (0.39, 5), (0.24, 4), (0.19, 2), (0.34, 8), (0.17, 6),
        (0.43, 5), (0.14, 3), (0.21, 2), (0.26, 9), (0.44, 7), (0.24, 3), (0.5, 5), (0.12, 5), (0.33, 3), (0.42, 3),
        (0.4, 7), (0.44, 8), (0.2, 3), (0.27, 2), (0.46, 3), (0.45, 10), (0.34, 7), (0.26, 2), (0.18, 5), (0.14, 9),
        (0.38, 1), (0.2, 6), (0.37, 9), (0.34, 3), (0.5, 4), (0.48, 2), (0.5, 4), (0.13, 2), (0.26, 1), (0.47, 5),
        (0.2, 10), (0.29, 4), (0.42, 1), (0.49, 4), (0.17, 10), (0.35, 7), (0.42, 6), (0.1, 2), (0.39, 3), (0.37, 2),
        (0.48, 6), (0.47, 9), (0.43, 6), (0.25, 1), (0.38, 2), (0.18, 2), (0.49, 9), (0.14, 1), (0.33, 10), (0.2, 3)
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
