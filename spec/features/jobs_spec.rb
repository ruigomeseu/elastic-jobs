require 'rails_helper'

RSpec.describe "Jobs", :type => :request do
  describe "GET /jobs" do
    it "displays jobs" do
      visit jobs_path
      page.should have_content 'Rails job'
    end
  end
end
