# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html

["DS3", "CD 40", "Her2 Neu", "CD 3", "CD 5", "CD 20", "Cetin"].each { |antibody_name|
  Antibody.create(name: antibody_name)
}

account = Account.create(name: "НИИ Онкологии и Медицинской Радиологии им. Александрова")

["Иван Иванов", "Надежда Наджедина"].each do |doctor_name|
  account.doctors.create(name: doctor_name)
end


["Иммуногистохимическая лаборатория"].each { |lab_name|
  lab = account.laboratories.create(name: lab_name)


  ["РМЖ", "Рак желудка"].each { |trial_type_name|
    lab.trial_types.create(name: trial_type_name)
  }


  100.times do |i|
    order = lab.orders.create(doctor: account.doctors.sample, trial_type: lab.trial_types.sample, tracking_number: "2345182#{i}/2-1",
    order_date: Date.today)

    (rand(3)+1).times {  order.trials.create(antibody: Antibody.all.sample) }


  end


}