require 'rails_helper'

RSpec.describe "Thanks", type: :request do
  let(:user) { create(:user) }

  describe "GET /thanks" do
    context "when logged in" do
      it "returns http success" do
        sign_in user
        get thanks_path
        expect(response).to have_http_status(:success)
      end
    end

    context "when not logged in" do
      it "redirects to login page" do
        get thanks_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
