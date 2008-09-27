require File.dirname(__FILE__) + '/../spec_helper'

describe 'The Local Controller' do
  controller_name :local
  # MvZ
  it 'front page' do
    get :frontpage
    response.should render_template(:frontpage)
    assigns[:page_title].should_not be_nil
  end

  # MvZ
  it 'should redirect bryar links to actual article' do
    art = Article.find(:first)
    get :bryarlink, :bryarid => "id_#{art.id}"
    response.should redirect_to(art.permalink_url)
    get :bryarlink, :bryarid => "id_5"
    assert_response :missing
  end

end
