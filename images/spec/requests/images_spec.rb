require 'spec_helper'

describe "Images" do
  describe "tag lists" do
    before(:each) do
      @image1 = Factory(:image, :tag_list => 'Events, Fun')
      @image2 = Factory(:image, :tag_list => 'Other Tag, Something else')

      refinery = Factory(:refinery_user)
      visit admin_root_path
      fill_in "Login", :with => refinery.username
      fill_in "Password", :with => refinery.password
      click_button "Sign in"
    end
    
    it "are navigated via the admin sidebar", :focus => true do
      visit admin_images_path
      click_link "Fun"
      
      current_path.should eq(tagged_admin_images_path(ActsAsTaggableOn::Tag.find_by_name 'Fun'))
      page.should have_content('Images tagged "Fun"')
    end
  end
end
