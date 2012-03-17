require 'active_record'
require 'friendly_id'

db = YAML.load(File.open('spec/dummy/config/database.yml'))
ActiveRecord::Base.establish_connection(db['spnr_test'])

module Refinery
  module Core
    class BaseModel < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end


def acts_as_indexed(*args)
end

def acts_as_taggable(*args)
end
