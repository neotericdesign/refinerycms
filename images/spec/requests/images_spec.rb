require 'spec_helper'

describe "Images", :focus => true do
  describe "tag lists" do
    before(:each) do    
      @refinery ||= Factory(:refinery_user)
      visit admin_root_path
      fill_in "Login", :with => @refinery.username
      fill_in "Password", :with => @refinery.password
      click_button "Sign in"
    end
    
    it "are navigated via the admin sidebar" do
      Factory(:image, :tag_list => 'Events, Fun')
      visit admin_images_path
      click_link "Fun"
      
      current_path.should eq(tagged_admin_images_path(ActsAsTaggableOn::Tag.find_by_name 'Fun'))
      page.should have_content('Images tagged "Fun"')
    end
    
    it "are created in the new image form" do
      visit new_admin_image_path
      attach_file 'image_image', "#{Rails.root}/images/spec/uploads/beach.jpeg"
      fill_in "Tags", :with => "beach, fun, sun"
      click_button "Save"
      page.should have_link('sun')
    end
  end
end
