class Friend < ApplicationRecord
    validates :name, presence: true, allow_blank: false
end
