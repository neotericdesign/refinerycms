require 'spec_helper'

describe "Images" do
  before(:each) do    
    @refinery ||= Factory(:refinery_user)
    visit admin_root_path
    fill_in "Login", :with => @refinery.username
    fill_in "Password", :with => @refinery.password
    click_button "Sign in"
  end
  
  describe "optional tag lists" do  
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
  
  describe "other optional fields", :focus => true do
    it "include a name" do
      visit new_admin_image_path
      attach_file 'image_image', "#{Rails.root}/images/spec/uploads/beach.jpeg"
      fill_in "Image Name", :with => "The Beach"
      click_button "Save"
      
      current_path.should eq(admin_images_path)
      page.should have_content("The Beach")
    end
    
    it "include a description" do
      visit new_admin_image_path
      attach_file 'image_image', "#{Rails.root}/images/spec/uploads/beach.jpeg"
      fill_in "Description", :with => "A lovely day for the beach"
      click_button "Save"
      
      current_path.should eq(admin_images_path)
      page.should have_content(Image.last.title)
      p Image.all
      Image.last.description.should eq("A lovely day for the beach")
    end
    
    it "include a caption" do
      visit new_admin_image_path
      attach_file 'image_image', "#{Rails.root}/images/spec/uploads/beach.jpeg"
      fill_in "Caption", :with => "We love it here"
      click_button "Save"
      
      current_path.should eq(admin_images_path)
      Image.last.caption.should eq("We love it here")
    end
    
    it "include an alt attribute" do
      visit new_admin_image_path
      attach_file 'image_image', "#{Rails.root}/images/spec/uploads/beach.jpeg"
      fill_in "Alt Attribute", :with => "a lovely beach"
      click_button "Save"
      
      current_path.should eq(admin_images_path)
      Image.last.alt_attribute.should eq("a lovely beach")
    end
    
    it "include a title attribute" do
      visit new_admin_image_path
      attach_file 'image_image', "#{Rails.root}/images/spec/uploads/beach.jpeg"
      fill_in "Title Attribute", :with => "Take a look!"
      click_button "Save"
      
      current_path.should eq(admin_images_path)
      Image.last.title_attribute.should eq("Take a look!")
    end
  end
end
