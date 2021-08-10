# admin
Administrator.create!( email: "admin@appirits.com", password: 'abc12345' )

# users
10.times do |i|
  User.create!( email: "user#{i}@appirits.com", password: 'abc12345' )
end

User.all.each do |user|
  UserDetail.create!(
    company_name: "company#{user.id}",
    department_name: user.id.even? ? "テスト#{user.id}部" : "",
    name: "user#{user.id}",
    phone_number: "0000000000#{user.id}",
    user_id: user.id,
  )
end
