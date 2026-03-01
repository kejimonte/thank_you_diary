require 'rails_helper'

RSpec.describe Thank, type: :model do
  let(:user) { create(:user) }

  it "is valid with content and user" do
    thank = Thank.new(content: "ありがとう", user: user)
    expect(thank).to be_valid
  end

  it "is invalid without content" do
    thank = Thank.new(content: nil, user: user)
    expect(thank).not_to be_valid
  end
end