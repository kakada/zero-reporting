# == Schema Information
#
# Table name: report_variables
#
#  id          :integer          not null, primary key
#  report_id   :integer
#  variable_id :integer
#  type        :string(255)
#  value       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  has_audio   :boolean          default(FALSE)
#  listened    :boolean          default(FALSE)
#  token       :string(255)
#
# Indexes
#
#  index_report_variables_on_report_id    (report_id)
#  index_report_variables_on_variable_id  (variable_id)
#

class ReportVariable < ActiveRecord::Base
  has_secure_token

  belongs_to :report
  belongs_to :variable
end