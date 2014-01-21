FactoryGirl.define do
  factory :user do
    username "zengqiang"
    password "zen"
    password_confirmation "zen"

    factory :user_with_feed do
      ignore do
        feed_count 1
      end

      after(:create) do |user, evaluator|
        create_list(:feed, evaluator.feed_count, user: user)
      end
    end
  end

  factory :feed do
    user
    feed_url "http://techcrunch.cn/feed/"
  end
end