class Notifier < ActionMailer::Base
  default :from => 'pragtech.co.in',
          :return_path => 'pragtech.co.in'


  
   def friend_request(recipient,username)
     @username = username
     @femail = recipient
     mail(:to => recipient)
   end

   def send_welcome_registration(myuser)
       @userlogin =  myuser.login
       mail(:to => myuser.email)
   end  

   def send_reset_code(user)
     @user = user
     mail(:to => user.email)
   end      


end
