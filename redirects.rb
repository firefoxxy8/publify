b = Blog.default
base = b.base_url

(1..38).each do |i|
  a = Article.find_by_id(i)
  next if a.nil?
  from = "id_#{i}"
  to = a.permalink_url.sub(base,'')
  r = Redirect.find_by_from_path(from)
  if r.nil?
    r = Redirect.new
    r.from_path = from
    r.to_path = to
    r.save
    puts "NEW #{from} => #{to}"
  else
    #r.to_path = to
    #r.save
    puts "#{r.to_path == to ? 'PASS' : 'FAIL'} #{r.from_path} => #{r.to_path}"
  end
end
