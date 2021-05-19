module Auth0Authorization
  module Utils
    RSpec.describe URL do
      describe "#interpolate" do
        it "interpolates path parameters with values" do
          expect(URL.interpolate("/users/:user_id/settings", { user_id: 123 })).to eq("/users/123/settings")
        end

        it "handles duplicate params" do
          expect(URL.interpolate("/:id/path/:id", { id: "abc" })).to eq("/abc/path/abc")
        end

        it "URL escapes interpolated values" do
          expect(URL.interpolate("/users/:user_id/settings", { user_id: "good guy" })).to eq("/users/good+guy/settings")
          expect(URL.interpolate("/users/:user_id", { user_id: "eg@example.com" })).to eq("/users/eg%40example.com")
        end
      end
    end
  end
end
