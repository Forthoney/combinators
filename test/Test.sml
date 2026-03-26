fun assertTrue msg cond =
  if cond then () else raise Fail msg

fun assertEqualInt msg expected actual =
  if expected = actual then ()
  else
    raise Fail
      ( msg ^ " (expected: " ^ Int.toString expected ^ ", actual: "
        ^ Int.toString actual ^ ")"
      )

val op |> = Combinators.|>
val op >>= = Combinators.>>=
infix |>
infix >>=

val _ =
  let
    val _ = assertEqualInt "pipeline" 8 ((3 |> (fn x => x + 1)) |> (fn x => x * 2))
    val _ = assertEqualInt "option bind some"
      6
      (case SOME 3 >>= (fn x => SOME (x * 2)) of SOME n => n | NONE => ~1)
    val _ = assertEqualInt "option bind none"
      ~1
      (case NONE >>= (fn x => SOME (x * 2)) of SOME n => n | NONE => ~1)
    val _ = assertEqualInt "id" 42 (Combinators.id 42)
    val _ = assertEqualInt "konst" 10 (Combinators.konst 10 99)
    val _ = assertEqualInt "flip" 3 (Combinators.flip (fn x => fn y => x - y) 2 5)
    val _ = assertEqualInt "compose" 7 (Combinators.compose (fn x => x + 1, fn x => x * 2) 3)
    val _ = assertEqualInt "andThen" 8 (Combinators.andThen (fn x => x * 2, fn x => x + 2) 3)
    val _ = assertEqualInt "curry" 7 (Combinators.curry op+ 3 4)
    val _ = assertEqualInt "uncurry" 7 (Combinators.uncurry (fn x => fn y => x + y) (3, 4))
    val _ = assertTrue "on"
      (Combinators.on op= String.size "abc" "xyz")
    val seen = ref 0
    val _ = assertEqualInt "tap value" 9 (Combinators.tap (fn x => seen := x) 9)
    val _ = assertEqualInt "tap effect" 9 (!seen)
    val fac = Combinators.fix (fn self => fn n => if n = 0 then 1 else n * self (n - 1))
    val _ = assertEqualInt "fix" 120 (fac 5)
  in
    ()
  end