defmodule Desafio do
  @moduledoc """
  Este é o módulo que deverá ser preenchido com a sua solução.

  É permitido criar quantas funções privadas for necessário,
  mas a única função pública deverá ser a função `split/2`
  que está definida como placeholder abaixo.
  """

  @doc """
  Realiza a divisão de valores de uma lista de compras entre pessoas.

  ### Examples

    emails = ~w(paulo@email.com valente@email.com teste@email.com valente@email.com paulo@email.com valente@email.com)
    ["paulo@email.com", "valente@email.com", "teste@email.com", "valente@email.com", "paulo@email.com", "valente@email.com"]

    shopping_list = [{"banana", 7, 1}, {"maçã", 2, 2}]
    [{"banana", 7, 1}, {"maçã", 2, 2}]

    Desafio.split shopping_list, emails
    %{"paulo@email.com" => 4, "teste@email.com" => 3, "valente@email.com" => 4}

  """
  @spec split(
          shopping_list :: [
            {item :: String.t(), quantity :: pos_integer(), unit_price_cents :: pos_integer()}
          ],
          emails :: [String.t()]
        ) :: [%{String.t() => non_neg_integer()}]
  def split(_shopping_list, []), do: %{}
  def split(shopping_list, emails) do
    emails_uniq = Enum.uniq(emails)
    num_emails = length(emails_uniq)

    total_value = calculates_total_value(shopping_list)
    value_per_person = div(total_value, num_emails)
    remaining_value = rem(total_value, num_emails)

    # emails_uniq
    # |> Enum.with_index(fn email, index ->
    #   # o resto vai ser sempre menor do que a quantidade de emails que a gente tem
    #   if index < remaining_value do
    #     {email, value_per_person + 1}
    #   else
    #     {email, value_per_person}
    #   end
    # end)
    # |> Map.new()

    emails_uniq
    |> Map.new(fn email -> {email, value_per_person} end)
    |> distributed_remaining_value(emails_uniq, remaining_value)
  end

  defp calculates_total_value(shopping_list) do
    Enum.reduce(shopping_list, 0, fn {_item, quantity, unit_price_cents}, acc ->
      acc + quantity * unit_price_cents
    end)

    # shopping_list
    # |> Enum.map(fn {_item, quantity, valor_unitario} -> quantity * valor_unitario end)
    # |> Enum.sum()

    # for {_item, quantity, unit_price_cents} <- shopping_list, reduce: 0 do
    #   acc -> acc + quantity * unit_price_cents
    # end
  end

  defp distributed_remaining_value(map, _emails, 0), do: map
  defp distributed_remaining_value(map, [email | t], rem_value) do
    email_value = map[email]

    modified_map = Map.put(map, email, email_value + 1)

    distributed_remaining_value(modified_map, t ++ [email], rem_value - 1)
  end
end
