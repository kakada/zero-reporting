# == Schema Information
#
# Table name: variables
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  description             :string(255)
#  verboice_id             :integer
#  verboice_name           :string(255)
#  verboice_project_id     :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  background_color        :string(255)
#  text_color              :string(255)
#  dhis2_data_element_uuid :string(255)
#  is_alerted_by_threshold :boolean          default(TRUE)
#  is_alerted_by_report    :boolean          default(FALSE)
#  disabled                :boolean          default(FALSE)
#

FactoryGirl.define do
  factory :variable do
    name 'bed'
    description 'number of bed'
    verboice_id 1
    verboice_name 1
    verboice_project_id 1
  end

end
