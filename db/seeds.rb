numbers = (1..99).to_a
bools = [true, false]

# admin
Administrator.create!(email: "admin@test.com", password: "abc12345") unless Administrator.exists?

# users
unless User.exists?
  10.times do |i|
    User.create!(email: "user#{i}@test.com", password: "abc12345")
  end

  User.all.each do |user|
    UserDetail.create!(
      company_name: "company#{user.id}",
      department_name: ["テスト#{user.id}部", ""].sample,
      name: "user#{user.id}",
      phone_number: "000000000#{numbers.sample}",
      user_id: user.id
    )
  end

  UserDetail.all.each do |detail|
    UserNotification.create!(
      other: bools.sample,
      job: bools.sample,
      user_detail_id: detail.id
    )
  end
end
