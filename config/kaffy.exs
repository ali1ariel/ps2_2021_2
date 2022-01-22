use Mix.Config

config :kaffy,
  admin_title: "Rede Transformação - Administração",
  otp_app: :black_cat,
  ecto_repo: BlackCat.Repo,
  router: BlackCatWeb.Router,
  resources: [
    blog: [
      name: "Blog",
      resources: [
        post: [schema: BlackCat.BlogPosts.Post, admin: BlackCatWeb.Kaffy.PostAdmin]
      ]
    ],
    offered_service: [
      name: "Rede de Atendimento",
      resources: [
        offered_service: [schema: BlackCat.OfferedServices.OfferedService, admin: BlackCatWeb.Kaffy.ServiceAdmin]
      ]
    ],
    user: [
      name: "Usuários",
      resources: [
        user: [schema: BlackCat.Accounts.User, admin: BlackCatWeb.Kaffy.UserAdmin]
      ]
    ]
  ]
