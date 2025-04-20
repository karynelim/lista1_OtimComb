{string} NODES = {"s", "a", "b", "c", "d", "t"};

tuple ArcType {
  string origem;
  string destino;
}

{ArcType} ARCS = {
  <"s", "a">, <"s", "b">, <"s", "c">,
  <"a", "c">, <"a", "d">,
  <"b", "c">, <"b", "d">,
  <"c", "t">, <"d", "t">
};

float capacity[ARCS] = [8, 5, 13, 13, 12, 12, 9, 8, 7];

string source = "s";
string sink = "t";

dvar float+ flow[ARCS];

maximize
  sum(a in ARCS : a.origem == source) flow[a];

subject to {
  // Capacidade
  forall(a in ARCS)
    flow[a] <= capacity[a];

  // Conservação de fluxo para nós intermediários
  forall(n in NODES)
    if (n != source && n != sink) 
      sum(a in ARCS : a.destino == n) flow[a] == sum(a in ARCS : a.origem == n) flow[a];
}

