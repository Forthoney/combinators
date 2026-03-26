structure Combinators =
struct
  infix |>
  infix >>=

  fun id x = x

  fun x |> f = f x

  fun mx >>= f =
    case mx of
      NONE => NONE
    | SOME x => f x

  fun konst x _ = x

  fun flip f x y = f y x

  fun compose (f, g) x = f (g x)

  fun andThen (f, g) x = g (f x)

  fun curry f x y = f (x, y)

  fun uncurry f (x, y) = f x y

  fun on f g x y = f (g x, g y)

  fun tap f x = (f x; x)

  fun fix f =
    let
      fun recFn x = f recFn x
    in
      recFn
    end
end
