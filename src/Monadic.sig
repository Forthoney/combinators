signature MONADIC =
sig
  structure Option :
  sig
    val <|> : 'a option * 'a option -> 'a option
    val >>= : 'a option * ('a -> 'b option) -> 'b option
  end
end