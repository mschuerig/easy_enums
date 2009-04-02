
require 'easy_enums'

ActiveRecord::Base.class_eval do
  include EasyEnumerations
end
