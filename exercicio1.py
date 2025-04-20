import time
import random

###### (a) Representação da solução #######
#Encontrar uma particao de U em k conjuntos disjuntos
#U1, . . . , Uk de forma que para todo i, a soma de todos os itens em
#cada Ui nao exceda 1, e que o valor de k seja minimizado. 

def solucao_inicial(itens):
    bins = []
    for item in sorted(itens, reverse=True):
        colocado = False
        for b in bins:
            if sum(b) + item <= 1:
                b.append(item)
                colocado = True
                break
        if not colocado:
            bins.append([item])
    return bins

###### (b) Função de avaliação ###### 

def custo(solucao):
    return len(solucao)

###### (c) Geração de vizinhos ######

def gerar_vizinhos(solucao):
    vizinhos = []
    for i in range(len(solucao)):
        for j in range(len(solucao)):
            if i != j:
                for item in solucao[i]:
                    if sum(solucao[j]) + item <= 1:
                        nova = [bin[:] for bin in solucao]
                        nova[i].remove(item)
                        nova[j].append(item)
                        if len(nova[i]) == 0:
                            del nova[i]
                        vizinhos.append(nova)
    return vizinhos

###### (d) Busca local com critério de parada ######

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
    return melhor

####### Execução com 100 números aleatórios ######

if __name__ == "__main__":
    random.seed(42)
    itens = [round(random.uniform(0.1, 0.5), 2) for _ in range(100)]
    inicial = solucao_inicial(itens)
    melhor = busca_local(inicial, tempo_limite=5)

    print("Melhor solução encontrada:")
    for i, b in enumerate(melhor):
        print(f"Bin {i+1}: {b}, total = {sum(b):.2f}")
    print(f"Total de bins utilizados: {len(melhor)}")
