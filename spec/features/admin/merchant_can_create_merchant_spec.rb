require 'rails_helper'

RSpec.describe 'New Merchant Creation' do
  describe 'As a Admin' do
    it 'I can use the new merchant form to create a new merchant' do
      visit '/merchants/new'

      name = 'Megans Marmalades'
      address = '123 Main St'
      city = "Denver"
      state = "CO"
      zip = 80218

      fill_in 'Name', with: name
      fill_in 'Address', with: address
      fill_in 'City', with: city
      fill_in 'State', with: state
      fill_in 'Zip', with: zip

      click_button 'Create Merchant'

      expect(current_path).to eq('/merchants')
      expect(page).to have_link(name)
    end

    it 'I can not create a merchant with an incomplete form' do
      visit '/merchants/new'

      name = 'Megans Marmalades'

      fill_in 'Name', with: name

      click_button 'Create Merchant'

      expect(page).to have_content("Address can't be blank")
      expect(page).to have_content("City can't be blank")
      expect(page).to have_content("State can't be blank")
      expect(page).to have_content("Zip can't be blank")
      expect(page).to have_button('Create Merchant')
    end
  end
end
