require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  include Amistad::FriendModel
  has_many :comments
  has_many :prayers
  set_table_name 'users'
  
  def image_file=(input_data)
    if !input_data.blank? 
      if((input_data.content_type.chomp == "image/jpg") or (input_data.content_type.chomp == "image/png") or (input_data.content_type.chomp == "image/jpeg") or (input_data.content_type.chomp == "image/gif"))

          self.filename = input_data.original_filename 
          self.content_type = input_data.content_type.chomp
          self.binary_data = input_data.read
      end
    end
  end

  validates :login, :presence   => true,
                    :uniqueness => true,
                    :length     => { :within => 3..40 },
                    :format     => { :with => Authentication.login_regex, :message =>                 Authentication.bad_login_message }

  validates :name,  :format     => { :with => Authentication.name_regex, :message => Authentication.bad_name_message },
                    :length     => { :maximum => 100 },
                    :allow_nil  => true

  validates :email, :presence   => true,
                    :uniqueness => true,
                    :format     => { :with => Authentication.email_regex, :message => Authentication.bad_email_message },
                    :length     => { :within => 6..100 }
  validates :password, :presence   => true
  validates :password_confirmation, :presence   => true
  
  

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation,:avatar,:avatar_file_name,:avatar_content_type,:avatar_file_size,:avatar_updated_at,:description,:content_type,:filename,:binary_data



  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  def create_reset_code
    @reset = true
    p "im creating a reset code"
    self.update_attribute(:reset_code, Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join ))
    p self.reset_code
    
  end 

  def recently_reset?
    @reset
  end 

  def delete_reset_code
    self.reset_code = nil
    self.save
  end


  protected
    


end
