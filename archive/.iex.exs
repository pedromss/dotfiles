defmodule S do
  def nol, do: IEx.configure(inspect: [limit: :infinity])
  def l3, do: IEx.configure(inspect: [limit: 3])
  def lm, do: Code.eval_file("main.ex")
  def r, do: recompile()
  def c, do: clear()

  # advent-of-code
  def t1, do: apply(X, :run, [:test, 1])
  def t2, do: apply(X, :run, [:test, 2])
  def r1, do: apply(X, :run, [:real, 1])
  def r2, do: apply(X, :run, [:real, 2])
end
import S
