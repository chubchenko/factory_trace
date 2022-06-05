# frozen_string_literal: true

class User
  attr_accessor :name, :phone, :email, :address
end

class Company
  attr_accessor :address, :manager
end

class Article
end

class Comment
  attr_accessor :article
end

FactoryBot.define do
  factory :user do
    name { "name" }

    trait :with_phone do
      phone { "phone" }
    end

    factory :user_with_defaults, traits: %i[with_address with_phone]
  end

  factory :admin, parent: :user do
    trait :with_email do
      email { "email" }
    end

    trait :combination do
      with_email
      with_phone
    end
  end

  factory :manager, parent: :admin do
    with_phone
  end

  factory :company do
    trait :with_manager do
      manager
    end
  end

  factory :article, aliases: %i[post]

  factory :comment do
    post
  end

  trait :with_address do
    address { "address" }
  end

  factory :a do
    trait :a1 do
      a1 { "a1" }
    end

    trait :a2 do
      a2 { "a2" }
    end
  end

  factory :b, parent: :a, class: "B" do
    trait :b1 do
      a1 { "b1" }
    end
  end
end

class A
  attr_accessor :a1, :a2
end

class B < A
  attr_accessor :b1
end
