extension DrinkOrder: Equatable {
}

func ==(rhs: DrinkOrder, lhs: DrinkOrder) -> Bool {
  switch (rhs, lhs) {
    case (let .Coffee(lsize, lsweetner, ladditions), let .Coffee(rsize, rsweetner, radditions)): return lsize == rsize && lsweetner == rsweetner && ladditions == radditions
  }
}
