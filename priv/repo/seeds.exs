# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Library.Repo.insert!(%Library.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

import Ecto.Query

alias Library.Repo
alias Library.Authors.Author
alias Library.Books.Book
alias Library.Books.BookReview
alias Library.Patrons.Patron
alias Library.Loans.Loan

random_book_id = fn ->
  x =
    Book
    |> select([:id])
    |> order_by(fragment("RANDOM()"))
    |> limit(1)
    |> Repo.one()

  x.id
end

#############################################################################
## Authors and Books

Enum.each(1..100, fn _ ->
  author =
    %Author{
      first_name: Faker.Person.first_name(),
      last_name: Faker.Person.last_name(),
      date_of_birth: Faker.Date.date_of_birth()
    }
    |> Repo.insert!()

  # create books written by author
  1..Enum.random(3..8)
  |> Enum.each(fn _ ->
    %Book{
      title: Faker.Lorem.words(1..4) |> Enum.join(" "),
      published_at: Faker.Date.between(~D[1800-01-01], Date.utc_today()),
      author_id: author.id
    }
    |> Repo.insert!()
  end)
end)

#############################################################################
## Patrons, Loans, and BookReviews

Enum.each(1..1000, fn _ ->
  late_fees = if Enum.random(1..100) > 75, do: Enum.random(1..10) * 10, else: 0

  patron =
    %Patron{
      first_name: Faker.Person.first_name(),
      last_name: Faker.Person.last_name(),
      date_of_birth: Faker.Date.date_of_birth(),
      email_address: Faker.Internet.free_email(),
      late_fees_balance: late_fees
    }
    |> Repo.insert!()

  # Loans
  Enum.each(0..4, fn _ ->
    borrowed_at =
      Faker.Date.between(~D[1970-01-01], ~D[2023-12-01]) |> DateTime.new!(~T[00:00:00])

    returned_at =
      if Enum.random(1..100) > 92, do: DateTime.add(borrowed_at, Enum.random(3..37), :day)

    loan =
      %Loan{
        borrowed_at: borrowed_at,
        returned_at: returned_at,
        due_at: DateTime.add(borrowed_at, 21, :day),
        patron_id: patron.id,
        book_id: random_book_id.()
      }
      |> Repo.insert!()

    # 25% chance of leaving a review
    if Enum.random(1..100) > 75 do
      %BookReview{
        rating: Enum.random(1..5),
        review_text: Faker.Lorem.paragraph(),
        patron_id: loan.patron_id,
        book_id: loan.book_id
      }
      |> Repo.insert!()
    end
  end)
end)
