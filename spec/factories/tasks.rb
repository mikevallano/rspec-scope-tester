FactoryGirl.define do
  factory :task do
    name { Faker::Hacker.ingverb }
    description { Faker::Hacker.say_something_smart }
    done false
    project

    factory :complete_task do
      done true
    end

    factory :invalid_task do
      name nil
    end
  end

end
