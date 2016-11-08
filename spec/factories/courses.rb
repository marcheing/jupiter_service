FactoryGirl.define do
  factory :course do
    name 'Course'
    code 'MAC0110'
    alt_name 'Course Alt'
    faculty 'Faculty'
    department 'Department'
    period 'Period'
    activation_date Time.zone.today
    goals 'goals'
    syllabus 'Syllabus'
    short_syllabus 'Short Syllabus'
    bibliography 'Bibliography'
  end
end
