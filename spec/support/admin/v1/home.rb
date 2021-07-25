require 'rails_helper'

describe "Home", type: :request do
    let(:employe) { create(:employe) }

    it "Test Home" do
        get '/admin/v1/home', headers: auth_header(employe)
        expect(body_json).to  eq({'message' => 'Você esta logado!'})
    end

    it "Test Home" do
        get '/admin/v1/home', headers: auth_header(employe)
        expect(response).to  have_http_status(:ok)
    end
end