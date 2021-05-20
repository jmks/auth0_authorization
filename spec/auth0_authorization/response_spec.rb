module Auth0Authorization
  RSpec.describe Response do
    describe "#success?" do
      it "returns true when response code is 200" do
        response = Response.new(OpenStruct.new(code: "200"))

        expect(response).to be_success
      end

      it "returns true when response code is 2XX" do
        response = Response.new(OpenStruct.new(code: "204"))

        expect(response).to be_success
      end

      it "returns false otherwise" do
        response = Response.new(OpenStruct.new(code: "403"))

        expect(response).not_to be_success
      end
    end

    describe "#body" do
      it "returns deserialized JSON" do
        response = Response.new(OpenStruct.new(body: JSON.dump({ hello: "world" })))

        expect(response.body).to include("hello" => "world")
      end

      context "when body is not JSON" do
        it "returns an empty body" do
          response = Response.new(OpenStruct.new(body: JSON.dump("")))

          expect(response.body).to eq("")
        end

        it "returns the body as is" do
          response = Response.new(OpenStruct.new(body: "Not JSON"))

          expect(response.body).to eq("Not JSON")
        end

        it "returns a nil body" do
          response = Response.new(OpenStruct.new(body: nil))

          expect(response.body).to eq(nil)
        end
      end
    end
  end
end
