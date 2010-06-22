# == Schema Information
# Schema version: 20100617182328
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  remember_token     :string(255)
#  admin              :boolean
#  signature          :string(255)     default("")
#  contacts           :string(255)     default("")
#

require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :encrypted_password, :password, :password_confirmation, :signature, :contacts, :salt

  has_many :posts,                             :dependent => :destroy
  has_many :topics,                            :dependent => :destroy
  has_many :messages, :foreign_key => :sender, :dependent => :destroy
  has_many :incoming, :foreign_key => :recepient, :class_name => "Message"

#   
#   has_many :incoming, :through => :messages,   :source    => :recepient
# #
#   has_many :incoming_messages,     :foreign_key => "recepient",
#                                    :class_name => "Message",
#                                    :dependent => :destroy

  before_save :encrypt_password

  EmailRegex = /^[\w\d\-.]+\@[a-z\d\-.]*[a-z\d]\.[a-z]+$/i
  NameRegex  = /^[a-z\-'. ]+$/i

  validates_presence_of :name,  :email
  validates_length_of   :name,  :maximum => 50
  validates_length_of   :signature, :maximum => 250
  validates_length_of   :contacts,  :maximum => 250
  validates_format_of   :name,  :with    => NameRegex
  validates_format_of   :email, :with    => EmailRegex

  validates_uniqueness_of :email, :case_sensitive => false

  # Password validations.
  validates_presence_of :password, :on => :create
  validates_length_of   :password, :within => 6..40, :allow_blank => true

  # Automatically create the virtual attribute 'password_confirmation'.
  validates_confirmation_of :password

  # Return true if the user's password matches the submitted password.
  def password_valid?(submitted_password)
    # Compare password with the encrypted version of submitted_password.
    encrypt(submitted_password).eql?(self.encrypted_password)
  end

  def remember_me!
    self.remember_token = encrypt("#{self.salt}--#{self.id}--#{Time.now.utc}")
    save_without_validation # do not make validation since we're saving only the security token
  end

  # Class methods
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.password_valid?(submitted_password)
  end

  # Object private methods
  private

    def encrypt_password
      unless self.password.nil?
        self.salt = make_salt()
        self.encrypted_password = encrypt(self.password)
      end
    end

    def make_salt
      secure_hash("#{Time.now.utc}#{self.password}")
    end

    def encrypt(string)
      secure_hash("#{self.salt}#{string}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

end
