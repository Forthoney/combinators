fun assertTrue msg cond =
  if cond then () else raise Fail msg

fun assertEqualInt msg expected actual =
  if expected = actual then ()
  else
    raise Fail
      ( msg ^ " (expected: " ^ Int.toString expected ^ ", actual: "
        ^ Int.toString actual ^ ")"
      )

open Combinators
open Combinators.Option

val _ = 
  ( assertEqualInt "pipeline" 8 ((3 |> (fn x => x + 1)) |> (fn x => x * 2))
  ; assertEqualInt "option bind some" 6
      (case SOME 3 >>= (fn x => SOME (x * 2)) of SOME n => n | NONE => ~1)
  ; assertEqualInt "option bind none" ~1
      (case NONE >>= (fn x => SOME (x * 2)) of SOME n => n | NONE => ~1)
  ; assertEqualInt "option alt left some" 1
    (case SOME 1 <|> SOME 2 of SOME n => n | NONE => ~1)
  ; assertEqualInt "option alt left none" 2
    (case NONE <|> SOME 2 of SOME n => n | NONE => ~1)
  ; assertEqualInt "option alt both none" ~1
    (case NONE <|> NONE of SOME n => n | NONE => ~1)
  ; assertEqualInt "id" 42 (Combinators.id 42)
  ; assertEqualInt "konst" 10 (Combinators.konst 10 99)
  ; assertEqualInt "flip" 3 (Combinators.flip (fn x => fn y => x - y) 2 5)
  ; assertEqualInt "compose" 7 (Combinators.compose (fn x => x + 1, fn x => x * 2) 3)
  ; assertEqualInt "andThen" 8 (Combinators.andThen (fn x => x * 2, fn x => x + 2) 3)
  ; assertEqualInt "curry" 7 (Combinators.curry op+ 3 4)
  ; assertEqualInt "uncurry" 7 (Combinators.uncurry (fn x => fn y => x + y) (3, 4))
  ; assertTrue "on" (Combinators.on op= String.size "abc" "xyz")
  ; assertTrue "first" (Combinators.first (fn x => x + 1) (2, "abcd") = (3, "abcd"))
  ; assertTrue "second" (Combinators.second String.size (2, "abcd") = (2, 4))
  ; assertTrue "fork" (Combinators.fork (fn x => x + 1, fn x => x * 2) 3 = (4, 6))
  ; assertTrue "dup" (Combinators.dup 3 = (3, 3))
  ; assertTrue "swap" (Combinators.swap (2, "abcd") = ("abcd", 2))
  ; assertTrue "cross" (Combinators.cross (fn x => x + 1, String.size) (2, "abcd") = (3, 4))
  )

val seen = ref 0
val _ = 
  ( assertEqualInt "tap value" 9 (Combinators.tap (fn x => seen := x) 9)
  ; assertEqualInt "tap effect" 9 (!seen)
  )

val fac = Combinators.fix (fn self => fn n => if n = 0 then 1 else n * self (n - 1))
val _ = assertEqualInt "fix" 120 (fac 5)
