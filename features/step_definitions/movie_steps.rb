Given /the following movies have been added to RottenPotatoes:/ do |movies_table|
	movies_table.hashes.each do |movie|
		Movie.create(movie)
	end
end


When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
	assert_match(/#{e1}.*#{e2}/m, page.body)
end

When /^(?:|I )check "([^"]*)"$/ do |field|
  check(field)
end


When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end


When /^I have opted to see movies rated: "(.*?)"$/ do |rating_list|

	ratings = rating_list.split(/\s*,\s*/)
	ratings.each { |rating| check("ratings_#{rating}") }
	
	click_button("Refresh")
end

Then /^I should see only movies rated "(.*?)"$/ do |rating_list|
	ratings = page.all("table#movies tbody tr td[2]").map {|t| t.text}
	rating_list.split(",").each do |field|
		assert ratings.include?(field.strip)
	end
end

Then /^I should see all of the movies$/ do
	rows = page.all("table#movies tbody tr td[1]").map {|t| t.text}
	assert rows.size == Movie.all.count
end



Given /^I am on the RottenPotatoes home page$/ do
  visit movies_path
 end


 When /^I have added a movie with title "(.*?)" and rating "(.*?)"$/ do |title, rating|
  visit new_movie_path
  fill_in 'Title', :with => title
  select rating, :from => 'Rating'
  click_button 'Save Changes'
 end

 Then /^I should see a movie list entry with title "(.*?)" and rating "(.*?)"$/ do |title, rating| 
   result=false
   all("tr").each do |tr|
     if tr.has_content?(title) && tr.has_content?(rating)
       result = true
       break
     end
   end  
   assert result
 end

 When /^I have visited the Details about "(.*?)" page$/ do |title|
   visit movies_path
   click_on "More about #{title}"
 end


Then /^(?:|I )should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    expect(page).to have_content(text)
  else
    assert page.has_content?(text)
  end
end

 When /^I have edited the movie "(.*?)" to change the rating to "(.*?)"$/ do |movie, rating|
  click_on "Edit"
  select rating, :from => 'Rating'
  click_button 'Update Movie Info'
 end





