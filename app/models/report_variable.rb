# == Schema Information
#
# Table name: report_variables
#
#  id           :integer          not null, primary key
#  report_id    :integer
#  variable_id  :integer
#  type         :string(255)
#  value        :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  has_audio    :boolean          default(FALSE)
#  listened     :boolean          default(FALSE)
#  token        :string(255)
#  is_alerted   :boolean          default(FALSE)
#  exceed_value :string(255)
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

  def mark_as_reaching_alert
    self.is_alerted = true
    self.save
  end

  def mark_as_reaching_alert_with_exceed_value(value)
    self.is_alerted = true
    self.exceed_value = value
    self.save
  end

  def unmark_as_reaching_alert
    self.is_alerted = false
    self.save
  end

  def check_alert_by_week(week, place)
    self.set_threshold_alert(week, place) if self.variable.is_alerted_by_threshold?
    self.set_report_variable_alert if self.variable.is_alerted_by_report?
  end

  def set_threshold_alert(week, place)
    threshold = Threshold.new(week, place, self.variable).value
    if self.value.to_i > threshold
      self.mark_as_reaching_alert_with_exceed_value(self.value.to_i - threshold)
    else
      self.unmark_as_reaching_alert
    end
  end

  def set_report_variable_alert
    if self.value.to_i > 0
      self.mark_as_reaching_alert_with_exceed_value(self.value)
    else
      self.unmark_as_reaching_alert
    end
  end

  def to_hub_parameters
    variable && variable.dhis2_data_element_uuid ? {variable.dhis2_data_element_uuid => value} : {}
  end

end
