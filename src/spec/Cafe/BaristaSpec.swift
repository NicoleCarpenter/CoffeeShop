import Swiftest

enum DrinkOrder {
  case Coffee(Size, Sweetener, Additions)
}

enum Size {
  case Small
}

enum Sweetener {
  case None
}

enum Additions {
  case None
}

class MockMakesDrinks: MakesDrinks {
  var makeDrinkWasCalledWith: DrinkOrder!

  func makeDrink(makeDrinkWasCalledWith: DrinkOrder) {
    self.makeDrinkWasCalledWith = makeDrinkWasCalledWith
  }
}

protocol MakesDrinks {
  func makeDrink(order: DrinkOrder)
}

protocol ProcessesOrders {
  func parseOrder(drink: String) -> DrinkOrder
}

class Barista {
  let makesDrinks: MakesDrinks
  let processesOrders: ProcessesOrders

  init(_ makesDrinks: MakesDrinks, _ processesOrders: ProcessesOrders) {
    self.makesDrinks = makesDrinks
    self.processesOrders = processesOrders
  }

  func takeDrinkOrder(drink: String) {
    let drinkOrder = processesOrders.parseOrder(drink)
    makesDrinks.makeDrink(drinkOrder)
  }
}

class MockProcessesOrders: ProcessesOrders {
  var parseOrderReturnValue: DrinkOrder!
  var parseOrderWasCalledWith: String!

  func parseOrderStubToReturn(parseOrderReturnValue: DrinkOrder) -> Self {
    self.parseOrderReturnValue = parseOrderReturnValue
    return self
  }

  func parseOrder(drink: String) -> DrinkOrder {
    parseOrderWasCalledWith = drink
    return parseOrderReturnValue
  }
}

class BaristaSpec: Swiftest.Spec {
  let spec = describe("Barista") {
    it("receives a drink order and sends it to the coffee maker") {
      let unparsedOrder = "foo"
      let drinkOrder: DrinkOrder = .Coffee(.Small, .None, .None)
      let makesDrinks = MockMakesDrinks()
      let processesOrders = MockProcessesOrders().parseOrderStubToReturn(drinkOrder)
      let barista = Barista(makesDrinks, processesOrders)

      barista.takeDrinkOrder(unparsedOrder)

      expect(processesOrders.parseOrderWasCalledWith).to.equal(unparsedOrder)
      expect(makesDrinks.makeDrinkWasCalledWith).to.equal(drinkOrder)
    }
  }
}
