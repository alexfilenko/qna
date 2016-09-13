FactoryGirl.define do
  factory :answer do
    body "MyText"
    question nil
    user
  end

  factory :invalid_answer, class: "answer" do
    question nil
    body nil
    user
  end
end
