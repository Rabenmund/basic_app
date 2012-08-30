require 'spec_helper'

describe User do

  let(:user) { create :user }
  
  subject { user }

  describe :attributes do
    
    it { should be_valid }
    it { should respond_to :name }
    it { should respond_to :nickname }
    it { should respond_to :email }
    it { should respond_to :password }
    it { should respond_to :password_confirmation }
    it { should respond_to :password_digest }
    it { should respond_to :remember_token }
    it { should respond_to :deactivated }
    it { should respond_to :admin }
    
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :nickname }
    it { should allow_mass_assignment_of :email }
    it { should allow_mass_assignment_of :password }
    it { should allow_mass_assignment_of :password_confirmation }
    
    it { should_not allow_mass_assignment_of :password_digest }
    it { should_not allow_mass_assignment_of :remember_token }
    it { should_not allow_mass_assignment_of :deactivated }
    it { should_not allow_mass_assignment_of :admin }
    
  end
  
  describe :associations do
    
    it { should have_many(:microposts) }
    
  end
  
  describe :validations do
    
    it { should validate_presence_of :name }
    it { should validate_presence_of :nickname }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password_confirmation }
    
    it { should ensure_length_of(:password).is_at_least(6) }
    it { should ensure_length_of(:name).is_at_least(5).is_at_most(20) }
    it { should ensure_length_of(:nickname).is_at_least(5).is_at_most(20) }
    
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_uniqueness_of(:nickname).case_insensitive }

    describe "when email format is invalid" do
      it "should be invalid" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
        addresses.each do |invalid_address|
          user.email = invalid_address
          user.should_not be_valid
        end      
      end
    end
    
    describe "when email format is valid" do
      it "should be valid" do
        addresses = %w[user@foo.com A_USER@f.b.org frst.lst@foo.jp a+b@baz.cn]
        addresses.each do |valid_address|
          user.email = valid_address
          user.should be_valid
        end      
      end
    end
    
  end
  
  describe :db do
    
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:password_digest).of_type(:string) }
    it { should have_db_column(:remember_token).of_type(:string) }
    it { should have_db_column(:admin).of_type(:boolean) }
    it { should have_db_column(:deactivated).of_type(:boolean) }
    it { should have_db_column(:nickname).of_type(:string) }
    
    it { should_not have_db_column :password }
    it { should_not have_db_column :password_confirmation }
    
    it { should have_db_index(:email).unique(true) }
    it { should have_db_index(:nickname).unique(true) }
    it { should have_db_index(:remember_token) }
    
  end
    
  describe :before_save do
    
    describe :downcase_email do
      before do
        @before_email = "UpAnDoWn@example.com"
        @user = build(:user, email: @before_email)
        @user.save
      end
      it { @user.email.should eq @before_email.downcase }
    end
    
    describe :deactivate do
      describe :initially do
        before { @user = build(:user) }
        it { @user.deactivated.should be_nil }
      end
      describe :after_save do
        it { user.deactivated.should be_true }
      end
    end
    
    describe :remember_token do
      its(:remember_token) { should_not be_blank }
    end
    
  end
  
  describe :methods do
    
  end
  
    

  # before do
  #   @user = User.new(name: "Example User", email: "user@example.com", 
  #                    password: "foobar", password_confirmation: "foobar")
  # end
  # 
  # subject { @user }
  # 
  # it { should respond_to(:name) }
  # it { should respond_to(:email) }
  # it { should respond_to(:password_digest) }
  # it { should respond_to(:password) }
  # it { should respond_to(:password_confirmation) }
  # it { should respond_to(:remember_token) }
  # it { should respond_to(:authenticate) }
  # 
  # it { should be_valid }
  # 
  # describe "when name is not present" do
  #   before { @user.name = " " }
  #   it { should_not be_valid }
  # end
  # 
  # describe "when email is not present" do
  #   before { @user.email = " " }
  #   it { should_not be_valid }
  # end
  # 
  # describe "when name is too long" do
  #   before { @user.name = "a" * 51 }
  #   it { should_not be_valid }
  # end
  # 

  # describe "when email address is already taken" do
  #   before do
  #     user_with_same_email = @user.dup
  #     user_with_same_email.email = @user.email.upcase
  #     user_with_same_email.save
  #   end
  # 
  #   it { should_not be_valid }
  # end
  # 
  # describe "when password is not present" do
  #   before { @user.password = @user.password_confirmation = " " }
  #   it { should_not be_valid }
  # end
  # 
  # describe "when password doesn't match confirmation" do
  #   before { @user.password_confirmation = "mismatch" }
  #   it { should_not be_valid }
  # end
  # 
  # describe "when password confirmation is nil" do
  #   before { @user.password_confirmation = nil }
  #   it { should_not be_valid }
  # end
  # 
  # describe "with a password that's too short" do
  #   before { @user.password = @user.password_confirmation = "a" * 5 }
  #   it { should be_invalid }
  # end
  # 
  # describe "return value of authenticate method" do
  #   before { @user.save }
  #   let(:found_user) { User.find_by_email(@user.email) }
  # 
  #   describe "with valid password" do
  #     it { should == found_user.authenticate(@user.password) }
  #   end
  # 
  #   describe "with invalid password" do
  #     let(:user_for_invalid_password) { found_user.authenticate("invalid") }
  # 
  #     it { should_not == user_for_invalid_password }
  #     specify { user_for_invalid_password.should be_false }
  #   end
  # end

end