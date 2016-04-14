import Swiftest

class DrinkOrderIsEquatableSpec: Swiftest.Spec {
  let spec = describe("DrinkOrder+Equatable") {
    it("is equal when the drinks match and the sub-parts all match") {
      let original: DrinkOrder = .Coffee(.Small, .None, .None)
      let other: DrinkOrder = .Coffee(.Small, .None, .None)
      expect(original).to.equal(other)
    }
  }
}
