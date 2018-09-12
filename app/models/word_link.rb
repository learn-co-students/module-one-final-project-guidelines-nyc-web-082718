class WordLink < ActiveRecord::Base
  belongs_to :longword
  belongs_to :shortword
end
