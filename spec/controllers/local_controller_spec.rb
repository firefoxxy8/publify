require 'rails_helper'

describe LocalController, type: :controller do
  render_views

  it 'front page' do
    create :blog
    get :frontpage
    expect(response).to render_template(:frontpage)
    expect(assigns[:page_title]).to_not be_nil
  end
end
