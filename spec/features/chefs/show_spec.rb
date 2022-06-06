require 'rails_helper'

RSpec.describe 'Chefs show page', type: :feature do
  let!(:chef1) {Chef.create(name: "Chef Boy R Dee")}
  let!(:chef2) {Chef.create(name: "Gordon Ramsay")}

  let!(:dish1) {chef1.dishes.create(name: "Macaroni and Cheese", description: "Delicious pasta and cheese")}
  let!(:dish2) {chef2.dishes.create(name: "Beef Wellington", description: "Medium Rare Beef with a bread cover")}

  let!(:ingredient1) {dish1.ingredients.create(name: "Pasta", calories: 400)}
  let!(:ingredient2) {dish1.ingredients.create(name: "Cheese", calories: 300)}
  let!(:ingredient3) {dish2.ingredients.create(name: "Beef", calories: 250)}
  let!(:ingredient4) {dish2.ingredients.create(name: "Bread", calories: 600)}

  it "can see the name of a chef and a link that take me to the chefs ingredient page" do
     visit "/chefs/#{chef1.id}"

     within '#chef-info' do
      expect(page).to have_content("Chef Boy R Dee")
      expect(page).to_not have_content("Gordon Ramsay")

      expect(page).to have_link("View Ingredients")
      click_link "View Ingredients"
    end

    expect(current_path).to eq("/chefs/#{chef1.id}/ingredients")

     within '#chefs-ingredients' do
      expect(page).to have_content("Pasta")
      expect(page).to have_content("Cheese")
      expect(page).to_not have_content("Beef")
      expect(page).to_not have_content("Bread")
     end
  end
end