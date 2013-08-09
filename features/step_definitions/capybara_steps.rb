Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )press "([^\"]*)"(?: within "([^\"]*)")?$/ do |text_or_id, selector|
  selector.nil? ? click_button(text_or_id) : within(selector){ click_button(text_or_id) }
end

When /^(?:|I )click "([^\"]*)"(?: within "([^\"]*)")?$/ do |link, selector|
  begin
    selector.nil? ? click_link(link) : within(selector){ click_link(link) }
  rescue Capybara::ElementNotFound => e
    find("a", :text => link).click
  end
end

When /^(?:|I )fill in "([^\"]*)" with "([^\"]*)"(?: within "([^\"]*)")?$/ do |field, value, selector|
  selector.nil? ? fill_in(field, :with => value) : within(selector){ fill_in(field, :with => value); }
end

# Use this to fill in an entire form with data from a table. Example:
#
#   When I fill in the following:
#     | Account Number | 5002       |
#     | Expiry date    | 2009-11-01 |
#     | Note           | Nice guy   |
#     | Wants Email?   |            |
#
# TODO: Add support for checkbox, select og option
# based on naming conventions.
#
When /^(?:|I )fill in the following(?: within "([^\"]*)")?:$/ do |selector, fields|
  if selector.nil?
    fields.rows_hash.each do |name, value|
      step %{I fill in "#{name}" with "#{value}"}
    end
  else
    within(selector) do
      fields.rows_hash.each do |name, value|
        step %{I fill in "#{name}" with "#{value}"}
      end
    end
  end
end

When /^(?:|I )select "([^\"]*)" from "([^\"]*)"(?: within "([^\"]*)")?$/ do |value, field, selector|
  selector.nil? ? select(value, :from => field) : within(selector){ select(value, :from => field) }
end

When /^(?:|I )check "([^\"]*)"(?: within "([^\"]*)")?$/ do |field, selector|
  selector.nil? ? check(field) : within(selector){ check(field) }
end

When /^(?:|I )uncheck "([^\"]*)"(?: within "([^\"]*)")?$/ do |field, selector|
  selector.nil? ? uncheck(field) : within(selector){ uncheck(field) }
end

When /^(?:|I )choose "([^\"]*)"(?: within "([^\"]*)")?$/ do |field, selector|
  selector.nil? ? choose(field) : within(selector){ choose(field) }
end

When /^(?:|I )attach the file "([^\"]*)" to "([^\"]*)"(?: within "([^\"]*)")?$/ do |path, field, selector|
  selector.nil? ? attach_file(field, path) : within(selector){ attach_file(field, path) }
end

Then /^(?:|I )should see JSON:$/ do |expected_json|
  require 'json'
  expected = JSON.pretty_generate(JSON.parse(expected_json))
  actual   = JSON.pretty_generate(JSON.parse(response.body))
  expected.should == actual
end

Then /^(?:|I )should see "([^\"]*)"(?: within "([^\"]*)")?$/ do |text, selector|
  if selector
    within(selector) { page.html.should have_content(text) }
  else
    page.html.should have_content(text)
  end
end

Then /^(?:|I )should see \/([^\/]*)\/(?: within "([^\"]*)")?$/ do |regexp, selector|
  regexp = Regexp.new(regexp)
  within(selector) do
    if page.respond_to? :should
      page.should have_xpath('//*', :text => regexp)
    else
      assert page.has_xpath?('//*', :text => regexp)
    end
  end
end

Then /^(?:|I )should not see "([^\"]*)"(?: within "([^\"]*)")?$/ do |text, selector|
  if selector
    within(selector) { page.should have_no_content(text) }
  else
    page.should have_no_content(text)
  end
end

Then /^(?:|I )should not see \/([^\/]*)\/(?: within "([^\"]*)")?$/ do |regexp, selector|
  regexp = Regexp.new(regexp)
  within(selector) do
    if page.respond_to? :should
      page.should have_no_xpath('//*', :text => regexp)
    else
      assert page.has_no_xpath?('//*', :text => regexp)
    end
  end
end

Then /^the "([^\"]*)" field(?: within "([^\"]*)")? should contain "([^\"]*)"$/ do |field, selector, value|
  within(selector) do
    field_value = find_field(field).value
    if field_value.respond_to? :should
      field_value.should =~ /#{value}/
    else
      assert_match(/#{value}/, field_value)
    end
  end
end

Then /^the "([^\"]*)" field(?: within "([^\"]*)")? should not contain "([^\"]*)"$/ do |field, selector, value|
  within(selector) do
    field_value = find_field(field).value
    if field_value.respond_to? :should_not
      field_value.should_not =~ /#{value}/
    else
      assert_no_match(/#{value}/, field_value.value)
    end
  end
end

Then /^the "([^\"]*)" checkbox(?: within "([^\"]*)")? should be checked$/ do |label, selector|
  within(selector) do
    field_checked = find_field(label)['checked']
    if field_checked.respond_to? :should
      field_checked.should == 'checked'
    else
      assert_equal 'checked', field_checked
    end
  end
end

Then /^the "([^\"]*)" checkbox(?: within "([^\"]*)")? should not be checked$/ do |label, selector|
  within(selector) do
    field_checked = find_field(label)['checked']
    if field_checked.respond_to? :should_not
      field_checked.should_not == 'checked'
    else
      assert_not_equal 'checked', field_checked
    end
  end
end
 
Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Then /^(?:|I )should have the following query string:$/ do |expected_pairs|
  actual_params   = CGI.parse(URI.parse(current_url).query)
  expected_params = Hash[expected_pairs.rows_hash.map{|k,v| [k,[v]]}]
 
  if actual_params.respond_to? :should
    actual_params.should == expected_params
  else
    assert_equal expected_params, actual_params
  end
end

Then /^I should not see the image "(.+)"$/ do |image|
  assert page.has_no_xpath?("//img[contains(@src, \"#{image}\")]")
end

Then /^I should see the image "(.+)"$/ do |image|
  assert page.has_xpath?("//img[contains(@src, \"#{image}\")]")
end

Then /^I should not see the button "(.+)"$/ do |button|
  page.has_button?(button).should be_false
end

Then /^I should not see the link "(.+)"$/ do |link|
  page.has_link?(link).should be_false
end

Then /^show me$/ do
  save_and_open_page
end

module TableStepsHelper
  module ArrayMethods

    def find_row(expected_row)
      find_index do |row|
        expected_row.all? do |expected_column|
          first_column = row.find_index do |column|
            content = normalize_content(column.content)
            expected_content = normalize_content(expected_column)
            matching_parts = expected_content.split('*', -1).collect { |part| Regexp.escape(part) }
            matching_expression = /\A#{matching_parts.join(".*")}\z/
            content =~ matching_expression
          end
          if first_column.nil?
            false
          else
            row = row[(first_column + 1)..-1]
            true
          end
        end
      end
    end

    def normalize_content(content)
      nbsp = 0xC2.chr + 0xA0.chr
      content.gsub(/[\r\n\t]+/, ' ').gsub(nbsp, ' ').gsub(/ {2,}/, ' ').strip
    end

  end

  rspec = defined?(RSpec) ? RSpec : Spec

  rspec::Matchers.define :contain_table do |*args|
    match do |table|
      expected_table, unordered = args
      expected_table.all? do |expected_row|
        @last_expected_row = expected_row
        table.extend ArrayMethods
        first_row = table.find_row(expected_row)
        if first_row.nil?
          false
        else
          if unordered
            table.delete_at(first_row)
          else
            table = table[(first_row + 1)..-1]
          end
          true
        end
      end
    end

    failure_message_for_should do
      "Could not find the following row: #{@last_expected_row.inspect}"
    end
  end

  rspec::Matchers.define :not_contain_table do |expected_table|
    match do |table|
      table.extend ArrayMethods
      expected_table.none? do |expected_row|
        @last_expected_row = expected_row
        first_row = table.find_row(expected_row)
      end
    end

    failure_message_for_should do
      "Found the following row: #{@last_expected_row.inspect}"
    end
  end

  def parse_table(table)
    if table.is_a?(String)
      # multiline string. split it assuming a format like cucumber tables have.
      table.split(/\n/).collect do |line|
        line.sub!(/^\|/, '')
        line.sub!(/\|$/, '')
        line.split(/\s*\|\s*/)
      end
    else
      # vanilla cucumber table.
      table.raw
    end
  end

end

Then /^I should( not)? see the following table rows( in any order)?:?$/ do |negate, unordered, expected_table|
  extend TableStepsHelper

  document = Nokogiri::HTML(page.body)
  table = document.xpath('//table//tr').collect { |row| row.xpath('.//th|td') }
  expected_table = parse_table(expected_table)

  if negate
    table.should not_contain_table(expected_table)
  else
    table.should contain_table(expected_table, unordered)
  end
end
