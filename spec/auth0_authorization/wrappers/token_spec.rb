module Auth0Authorization
  RSpec.describe Token do
    describe "#header" do
      it "return the token type followed by the access token" do
        token = Token.new({"token_type" => "Bearer", "access_token" => "abc123"})

        expect(token.header).to eq("Bearer abc123")
      end
    end
  end
end
