class Twitbot < ApplicationRecord
  has_many :tweets, dependent: :destroy
  belongs_to :user
  has_one_attached :spreadsheet

  def spreadsheet_path
    ActiveStorage::Blob.service.path_for(spreadsheet.key)
  end
end
