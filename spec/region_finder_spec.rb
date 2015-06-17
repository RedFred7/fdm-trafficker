# @author Tomos John Rees

require 'webmock/rspec'

describe RegionFinder do

  before :each do
    json_returned_postcode = {"postcode"=>"B36 9DQ", "geo"=>{"lat"=>52.507504103916, "lng"=>-1.789771358500505, "easting"=>414365.0, "northing"=>289977.0, "geohash"=>"http://geohash.org/gcqdxq8wrk1w"}, "administrative"=>{"council"=>{"title"=>"Solihull", "uri"=>"http://statistics.data.gov.uk/id/statistical-geography/E08000029", "code"=>"E08000029"}, "ward"=>{"title"=>"Castle Bromwich", "uri"=>"http://statistics.data.gov.uk/id/statistical-geography/E05001286", "code"=>"E05001286"}, "constituency"=>{"title"=>"Meriden", "uri"=>"http://statistics.data.gov.uk/id/statistical-geography/E14000812", "code"=>"E14000812"}, "parish"=>{"title"=>"Castle Bromwich", "uri"=>"http://statistics.data.gov.uk/id/statistical-geography/E04000149", "code"=>"E04000149"}}}.to_json
    stub_request(:get, "http://uk-postcodes.com/latlng/52.509186,-1.789579.json").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => json_returned_postcode, :headers => {})


    json_returned_region = {"wgs84_lat"=>52.50750098788352, "coordsyst"=>"G", "shortcuts"=>{"WMC"=>65932, "ward"=>9344, "council"=>2538}, "wgs84_lon"=>-1.7897858954403103, "postcode"=>"B36 9DQ", "easting"=>414365, "areas"=>{"9344"=>{"parent_area"=>2538, "generation_high"=>24, "all_names"=>{}, "id"=>9344, "codes"=>{"ons"=>"00CTFW", "gss"=>"E05001286", "unit_id"=>"65"}, "name"=>"Castle Bromwich", "country"=>"E", "type_name"=>"Metropolitan district ward", "generation_low"=>1, "country_name"=>"England", "type"=>"MTW"}, "11809"=>{"parent_area"=>nil, "generation_high"=>24, "all_names"=>{}, "id"=>11809, "codes"=>{"ons"=>"05", "gss"=>"E15000005", "unit_id"=>"41426"}, "name"=>"West Midlands", "country"=>"E", "type_name"=>"European region", "generation_low"=>1, "country_name"=>"England", "type"=>"EUR"}, "900000"=>{"parent_area"=>nil, "generation_high"=>19, "all_names"=>{}, "id"=>900000, "codes"=>{}, "name"=>"House of Commons", "country"=>"", "type_name"=>"UK Parliament", "generation_low"=>1, "country_name"=>"-", "type"=>"WMP"}, "76263"=>{"parent_area"=>nil, "generation_high"=>24, "all_names"=>{}, "id"=>76263, "codes"=>{"ons"=>"E01010122"}, "name"=>"Solihull 001D", "country"=>"E", "type_name"=>"Lower Layer Super Output Area (Full)", "generation_low"=>13, "country_name"=>"England", "type"=>"OLF"}, "2538"=>{"parent_area"=>nil, "generation_high"=>24, "all_names"=>{}, "id"=>2538, "codes"=>{"ons"=>"00CT", "gss"=>"E08000029", "unit_id"=>"9"}, "name"=>"Solihull Borough Council", "country"=>"E", "type_name"=>"Metropolitan district", "generation_low"=>1, "country_name"=>"England", "type"=>"MTD"}, "65932"=>{"parent_area"=>nil, "generation_high"=>24, "all_names"=>{}, "id"=>65932, "codes"=>{"gss"=>"E14000812", "unit_id"=>"24729"}, "name"=>"Meriden", "country"=>"E", "type_name"=>"UK Parliament constituency", "generation_low"=>13, "country_name"=>"England", "type"=>"WMC"}, "59087"=>{"parent_area"=>2538, "generation_high"=>24, "all_names"=>{}, "id"=>59087, "codes"=>{"ons"=>"00CT005", "gss"=>"E04000149", "unit_id"=>"64"}, "name"=>"Castle Bromwich", "country"=>"E", "type_name"=>"Civil parish/community", "generation_low"=>12, "country_name"=>"England", "type"=>"CPC"}, "110641"=>{"parent_area"=>nil, "generation_high"=>24, "all_names"=>{}, "id"=>110641, "codes"=>{"ons"=>"E01010122"}, "name"=>"Solihull 001D", "country"=>"E", "type_name"=>"Lower Layer Super Output Area (Generalised)", "generation_low"=>13, "country_name"=>"England", "type"=>"OLG"}, "43154"=>{"parent_area"=>nil, "generation_high"=>24, "all_names"=>{}, "id"=>43154, "codes"=>{"ons"=>"E02002081"}, "name"=>"Solihull 001", "country"=>"E", "type_name"=>"Middle Layer Super Output Area (Generalised)", "generation_low"=>13, "country_name"=>"England", "type"=>"OMG"}, "900001"=>{"parent_area"=>nil, "generation_high"=>24, "all_names"=>{}, "id"=>900001, "codes"=>{}, "name"=>"European Parliament", "country"=>"", "type_name"=>"European Parliament", "generation_low"=>1, "country_name"=>"-", "type"=>"EUP"}, "35960"=>{"parent_area"=>nil, "generation_high"=>24, "all_names"=>{}, "id"=>35960, "codes"=>{"ons"=>"E02002081"}, "name"=>"Solihull 001", "country"=>"E", "type_name"=>"Middle Layer Super Output Area (Full)", "generation_low"=>13, "country_name"=>"England", "type"=>"OMF"}}, "northing"=>289980}.to_json
    stub_request(:get, "http://mapit.mysociety.org/postcode/B369DQ").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => json_returned_region, :headers => {})
  end

  describe ".postcode_from_lat_long" do
    it "returns a postcode given a latitude and longitude point" do
      expect(RegionFinder.postcode_from_lat_long(52.509186,-1.789579)).to eq("B36 9DQ")
    end
  end

  describe ".european_region_from_postcode" do
    it "returns the region in which a postcode resides" do
      expect(RegionFinder.european_region_from_postcode("B36 9DQ")).to eq("West Midlands")
    end
  end
end
