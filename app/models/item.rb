class Item < ActiveRecord::Base
  belongs_to :user
  
  def completed?
     !completed_at.blank
  end
  
   default_scope { order('created_at DESC') }
  
   def days_left
      7 - (DateTime.now.to_date - created_at.to_date).to_i
   end
end
