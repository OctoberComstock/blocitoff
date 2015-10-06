class Item < ActiveRecord::Base
  belongs_to :user
  
  def completed
     completed == true
  end
  
   default_scope { order('expires_at ASC') }
  
    def days_left
     result = 7 - (DateTime.now.to_date - created_at.to_date).to_i

       if result > 0
         return result
       else
         return "Expired"
       end
    end
    
    def delete_items
      #this will delete the items that are created 7 days ago from today.
       self.where('created_at =?', 7.days.ago).destroy_all
    end
end
