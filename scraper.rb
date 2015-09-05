require 'scraperwiki'
require 'mechanize'
require 'json'

agent = Mechanize.new

# Set the URL - we're separating the page ID as it's used later in the JSON
base_url = "http://missingmigrants.iom.int/node/"
# TODO: Loop through page IDs to get all of these instead of this one page
page_id = "5092"
# Read in the page
page = agent.get(base_url + page_id)

# Find the script tag and remove the JavaScript from around the JSON
json_string = page.at(:head).search(:script).last.inner_text.gsub("jQuery.extend(Drupal.settings, ", "").gsub(");", "")
# Parse JSON
json = JSON.parse(json_string)
# Extract lat/long from pased JSON (which is now a Ruby Hash)
coordinates = json["geolocationGooglemaps"]["formatters"]["e_#{page_id}i_80"]["deltas"]["d_0"]

# TODO: Save this to the database along with any other info we're interested in
p coordinates
