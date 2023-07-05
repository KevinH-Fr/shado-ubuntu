class Sport < ApplicationRecord
    has_one_attached :icon

    has_many :athletes
    def self.ransackable_attributes(auth_object = nil)
        ["name"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["icon_attachment", "icon_blob"]
      end
end
