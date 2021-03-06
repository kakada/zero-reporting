module Event::Attachmentable
  extend ActiveSupport::Concern

  included do
    has_many :attachments, class_name: 'EventAttachment', dependent: :destroy

    accepts_nested_attributes_for :attachments, allow_destroy: true, :reject_if => lambda { |e| e[:file].blank? }
  end

end
