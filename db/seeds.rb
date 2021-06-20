User.create(email: "admin@example.com", password: "123456", password_confirmation: "123456")
User.create(email: "student@example.com", password: "123456", password_confirmation: "123456")
User.update_all confirmed_at: DateTime.now