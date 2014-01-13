module WelcomeHelper
  
    def featured_user
      User.find_by_email 'member@example.com' #'tonypgh1192@gmail.com' 
    end
    
end
