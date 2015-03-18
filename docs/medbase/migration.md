```ruby


@laboratory = Laboratory.last

require 'json'

data_hash = JSON.parse(File.read('/tmp/dump.json'))

@doctors  = {}
def get_doctor(name)
  @doctors[name] ||= @laboratory.account.doctors.find_or_create_by(name: name)
end

@trial_types  = {}
def get_trial_type(name)
  @trial_types[name] ||= @laboratory.trial_types.find_or_create_by(name: name)
end

@antibodies_list  = {}
def get_antibody(name)
  @antibodies_list[name] ||= Antibody.find_or_create_by(name: name)
end


element = data_hash.first

data_hash.each do |element|
  order = @laboratory.orders.build

  begin
      order.order_date = Date.parse(element['test_date'])
  rescue
    puts "parsing error"
    order.order_date = Date.today
  end

  order.conclusion = element['conclusion'] if element['conclusion']
  order.tracking_number = element['tracking_number'] if element['tracking_number']
  order.comment = element['description'] if element['description']

  order.trial_type = get_trial_type(element['test_purpose'])
  order.doctor = get_doctor(element['doctor_client'])
  unless(order.save)
    puts order.errors.inspect
  end
  order = order.reload

  element['antibodies'].each { |antibody| order.trials.create(antibody: get_antibody(antibody['name'])) unless antibody['name'].blank? } if element['antibodies']

end


```