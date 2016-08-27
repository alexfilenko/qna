FactoryGirl.define do
  factory :answer do
    body "MyText"
    question
  end

  factory :invalid_answer, class: "answer" do
    title nil
    body nil
  end
end
