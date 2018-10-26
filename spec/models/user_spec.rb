require 'spec_helper'


describe 'users' do
  before do
    @sheet = Sheet.create(
      sheet_key: "1lLKOePHG2-NCcZaPYoFGlTiZLnqZ9pvZWluCcOv7h3s",
      url: "https://docs.google.com/spreadsheets/d/1lLKOePHG2-NCcZaPYoFGlTiZLnqZ9pvZWluCcOv7h3s/edit#gid=376931900"
    )
    @cohort = Cohort.create(
      mod: 3,
      name: "#nyc-mhtn-web-080618"
    )
  end

  it 'cannot be created without a sheet and cohort' do
    expect(User.create()).to raise_error
  end

end
