require File.dirname(__FILE__) + '/../spec_helper'

describe 'The Local Controller' do
  controller_name :local
  # MvZ
  it 'front page' do
    get :frontpage
    response.should render_template(:frontpage)
    assigns[:page_title].should_not be_nil
  end
end
