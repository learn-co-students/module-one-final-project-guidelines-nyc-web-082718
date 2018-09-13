class WordLink < ActiveRecord::Base
  belongs_to :long_word
  belongs_to :short_word
end
