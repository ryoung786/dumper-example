defmodule LibraryWeb.Router do
  use LibraryWeb, :router
  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {LibraryWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LibraryWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/books", BookLive.Index, :index
    live "/books/new", BookLive.Index, :new
    live "/books/:id/edit", BookLive.Index, :edit

    live "/books/:id", BookLive.Show, :show
    live "/books/:id/show/edit", BookLive.Show, :edit

    live "/authors", AuthorLive.Index, :index
    live "/authors/new", AuthorLive.Index, :new
    live "/authors/:id/edit", AuthorLive.Index, :edit

    live "/authors/:id", AuthorLive.Show, :show
    live "/authors/:id/show/edit", AuthorLive.Show, :edit

    live "/patrons", PatronLive.Index, :index
    live "/patrons/new", PatronLive.Index, :new
    live "/patrons/:id/edit", PatronLive.Index, :edit

    live "/patrons/:id", PatronLive.Show, :show
    live "/patrons/:id/show/edit", PatronLive.Show, :edit

    live "/loans", LoanLive.Index, :index
    live "/loans/new", LoanLive.Index, :new
    live "/loans/:id/edit", LoanLive.Index, :edit

    live "/loans/:id", LoanLive.Show, :show
    live "/loans/:id/show/edit", LoanLive.Show, :edit

    live "/book_reviews", BookReviewLive.Index, :index
    live "/book_reviews/new", BookReviewLive.Index, :new
    live "/book_reviews/:id/edit", BookReviewLive.Index, :edit

    live "/book_reviews/:id", BookReviewLive.Show, :show
    live "/book_reviews/:id/show/edit", BookReviewLive.Show, :edit

    live_dashboard "/dashboard",
      additional_pages: [
        dumper: {
          Dumper.LiveDashboardPage,
          repo: Library.Repo, config_module: LibraryWeb.DumperConfig
        }
      ]
  end

  # Other scopes may use custom stacks.
  # scope "/api", LibraryWeb do
  #   pipe_through :api
  # end
end
