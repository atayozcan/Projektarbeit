interface Shape
  fun ref get_coord(): Coord
  fun ref get_sides(): U8

class Coord
  let x: USize let y: USize
  new create(x': USize = 0, y': USize = 0) => x = x'; y = y'
  fun string(): String => "(" + x.string() + "," + y.string() + ")"

class Triangle is Shape
  let _sides: U8 = 3
  var _coord: Coord
  new create(coord: Coord) => _coord = coord
  new create_empty() => _coord = Coord()
  fun ref get_sides(): U8 => _sides
  fun ref get_coord(): Coord => _coord

class Square is Shape
  let _sides: U8 = 4
  var _coord: Coord
  new create(coord: Coord) => _coord = coord
  new create_empty() => _coord = Coord()
  fun ref get_sides(): U8 => _sides
  fun ref get_coord(): Coord => _coord

actor Main
  new create(env: Env) =>
    let t1 = Triangle.create(Coord(5, 10))
    let s1 = Square.create_empty()
    let shapes = [t1; s1]
    for (i, shape) in shapes.pairs() do
      env.out.print("Shape "+ i.string() + " has " + shape.get_sides().string() + " sides.")
      env.out.print("And it's coordinates are: " + shape.get_coord().string())
    end
