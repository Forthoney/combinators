signature COMBINATORS =
sig
  val |> : 'a * ('a -> 'b) -> 'b

  val id : 'a -> 'a
  val konst : 'a -> 'b -> 'a
  val flip : ('a -> 'b -> 'c) -> 'b -> 'a -> 'c
  val compose : ('b -> 'c) * ('a -> 'b) -> 'a -> 'c
  val andThen : ('a -> 'b) * ('b -> 'c) -> 'a -> 'c
  val curry : ('a * 'b -> 'c) -> 'a -> 'b -> 'c
  val uncurry : ('a -> 'b -> 'c) -> 'a * 'b -> 'c
  val on : ('b * 'b -> 'c) -> ('a -> 'b) -> 'a -> 'a -> 'c
  val first : ('a -> 'b) -> 'a * 'c -> 'b * 'c
  val second : ('b -> 'c) -> 'a * 'b -> 'a * 'c
  val fork : ('a -> 'b) * ('a -> 'c) -> 'a -> 'b * 'c
  val dup : 'a -> 'a * 'a
  val swap : 'a * 'b -> 'b * 'a
  val cross : ('a -> 'b) * ('c -> 'd) -> 'a * 'c -> 'b * 'd
  val tap : ('a -> unit) -> 'a -> 'a
  val fix : (('a -> 'b) -> 'a -> 'b) -> 'a -> 'b

  structure Option :
  sig
    val <|> : 'a option * 'a option -> 'a option
    val >>= : 'a option * ('a -> 'b option) -> 'b option
  end
end
