xm.entry do
  xm.author { xm.name item.author }
  xm.id "tag:www.matijs.net,#{item.created_at.strftime("%Y")}:id_#{item.id}"

  xm.published item.created_at.xmlschema
  xm.updated item.updated_at.xmlschema
  xm.title "Comment on #{item.article.title} by #{item.author}", "type"=>"html"

  xm.link "rel" => "alternate", "type" => "text/html", "href" => item.permalink_url

  xm.content html(item), "type"=>"html"
end
