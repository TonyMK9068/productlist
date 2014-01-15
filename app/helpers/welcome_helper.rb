module WelcomeHelper
  
    def featured_user
      email = User.find_by_email('tonypgh1192@gmail.com') ? 'tonypgh1192@gmail.com' : 'member@example.com'
      User.find_by_email email
    end
    
end
