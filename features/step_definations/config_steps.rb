require "Open3"

Given(/^I have heroku toolbelt installed$/) do
  output, error, status = Open3.capture3 "heroku"
  expect(status.success?).to eq(true);
end

Given(/^I am logged in$/) do
  output, error, status = Open3.capture3 "heroku apps --all"
  expect(status.success?).to eq(true);
end

When(/^I Clone app$/) do
  cmd = " ansible-playbook playbook.yml --tags clone"
  output, error, @status = Open3.capture3 "#{cmd}"
end

Then(/^It should be successful$/) do
  expect(@status.success?).to eq(true);
end

Then(/^app should exist in app folder$/) do
  output, error, status = Open3.capture3 "ls app"
  expect(status.success?).to eq(true);
end

When(/^I Create app in heroku$/) do
  cmd = " ansible-playbook playbook.yml --tags 'find_app,create_app'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

Then(/^app should exist in heroku$/) do
  output, error, status = Open3.capture3 "heroku apps | grep paas-xmpl"
  expect(status.success?).to eq(true);
end

When(/^I deploy app to heroku$/) do
  cmd = " ansible-playbook playbook.yml --tags deploy"
  output, error, @status = Open3.capture3 "#{cmd}"
end

When(/^I scale the app instances$/) do
  cmd = " ansible-playbook playbook.yml --tags 'deploy,scale'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

When(/^I configure db addon$/) do
  cmd = " ansible-playbook playbook.yml --tags 'find_db,configure_db'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

Then(/^db should exisit in heroku$/) do
  output, error, status = Open3.capture3 "cd app && heroku pg:info"
  expect(status.success?).to eq(true);

end

When(/^I open app in browser$/) do
  cmd = " ansible-playbook playbook.yml --tags open"
  output, error, @status = Open3.capture3 "#{cmd}"
  puts output
  puts error
end