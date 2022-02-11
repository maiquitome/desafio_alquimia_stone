defmodule DesafioTest do
  use ExUnit.Case
  doctest Desafio

  # Lista de emails com valores repetidos
  emails = ~w(
    paulo@email.com
    valente@email.com
    teste@email.com
    valente@email.com
    paulo@email.com
    valente@email.com
  )

  # Primeiro, vamos validar os casos em que o valor total é menor ou igual ao número de emails
  assert %{"paulo@email.com" => 1, "valente@email.com" => 0, "teste@email.com" => 0} ==
           Desafio.split([{"banana", 1, 1}, {"maçã", 0, 10}], emails)

  assert %{"paulo@email.com" => 1, "valente@email.com" => 1, "teste@email.com" => 0} ==
           Desafio.split([{"banana", 2, 1}, {"maçã", 0, 10}], emails)

  assert %{"paulo@email.com" => 1, "valente@email.com" => 1, "teste@email.com" => 1} ==
           Desafio.split([{"banana", 1, 1}, {"maçã", 1, 2}], emails)

  # Caso em que há mais de um centavo de resto
  assert %{"paulo@email.com" => 2, "valente@email.com" => 2, "teste@email.com" => 1} ==
           Desafio.split([{"banana", 1, 1}, {"maçã", 1, 2}, {"uva", 2, 1}], emails)

  # Teste de erro de arredondamento

  assert %{
           "1@email.com" => 1,
           "2@email.com" => 1,
           "3@email.com" => 1,
           "4@email.com" => 1,
           "5@email.com" => 1,
           "6@email.com" => 1,
           "7@email.com" => 1,
           "8@email.com" => 0,
           "9@email.com" => 0,
           "10@email.com" => 0,
           "11@email.com" => 0
         } == Desafio.split([{"banana", 7, 1}], Enum.map(1..11, &"#{&1}@email.com"))
end
