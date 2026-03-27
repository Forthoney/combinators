structure Monadic : MONADIC =
struct
  structure Option =
  struct
    fun NONE <|> y = y
      | x <|> _ = x

    fun opt >>= f = Option.mapPartial f opt
  end
end