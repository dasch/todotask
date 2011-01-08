module WOPR; end

Dir.glob "#{__FILE__.gsub /\.rb$/, ''}/*.rb" do |f|
  require f.gsub(/\.rb$/, '')
end
