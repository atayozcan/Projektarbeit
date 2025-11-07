interface Shape
    fun ref get_sides(): U8

class Coord
    let x: USize let y: USize
    new create(x': USize = 0, y': USize = 0) => x = x'; y = y'
    fun string(): String => "(" + x.string() + "," + y.string() + ")"

class Triangle
    let sides: U8 = 3
    var coord: Coord
    new create(coord': Coord) => coord = coord'
    new create_empty() => coord = Coord()
    fun ref get_sides(): U8 => sides

class Square
    let sides: U8 = 4
    var coord: Coord
    new create(coord': Coord) => coord = coord'
    new create_empty() => coord = Coord()
    fun ref get_sides(): U8 => sides

actor Main
  new create(env: Env) =>
    let t1 = Triangle.create_empty()
    let s1 = Square.create_empty()
    let shapes = [t1; s1]
    for (i, shape) in shapes.pairs() do
        env.out.print("Shape "+ i.string() +
        " has " + shape.get_sides().string() + " sides")
    end
