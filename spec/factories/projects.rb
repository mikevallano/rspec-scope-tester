FactoryGirl.define do
  factory :project do
    name { Faker::Hacker.ingverb }
    description { Faker::Hacker.say_something_smart }
    notes { Faker::Hacker.adjective }

    factory :invalid_project do
      name nil
    end
  end

end
