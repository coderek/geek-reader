module FeedsHelper
  class Parser
    def self.parse content
      $parser = Feedzirra::Feed
      feed = $parser.parse content
    end
  end

  class WhiteWatch < Loofah::Scrubber
    def initialize base_url
      @direction = :top_down
      @base_url = base_url
    end

    def scrub(node)
      if node.name=="object" or node.name=="iframe"
        return STOP
      end
      node.attributes.each do |attr|
        unless (node.name == "img" and attr.first=="src") or (node.name=="a" and attr.first=="href")
          node.remove_attribute(attr.first)
        end
      end
      if node.name == "img" and /^\// =~ node["src"]
        node["src"] =  @base_url + node["src"]
      end
      if node.name =~ /pre|code/ and node.content == ""
        node.remove
        return STOP
      end
      if node.name =~ /script|style/
        node.remove
        return STOP
      end
      if node.name == "pre"
        node.set_attribute("class", "prettyprint linenums")
      end
      if node.name == "a"
        node.set_attribute('rel', 'nofollow')
        node.set_attribute('target', '_blank')
      end
    end
  end

  def parse_article original, base_url
    puts "parsing ---"

    # change encoding
    if original =~ /gb2312/
      original = original.force_encoding('gb2312').encode('UTF-8')
    end
    # else
    # original = original.force_encoding('UTF-8')
    if original.respond_to? :encode!
      original.encode!('UTF-16', 'UTF-8', :invalid => :replace, :replace => '')
      original.encode!('UTF-8', 'UTF-16')
    end
    # end

    white = WhiteWatch.new base_url
    # Loofah::HTML5::ACCEPTABLE_ATTRIBUTES - ["style"]
    doc = Loofah.fragment(original)
    doc.scrub!(white)
    doc.xpath("//pre").scrub!(:strip)
    doc.to_s
  end


  def get_domain url
    splits = URI.split(url)
    splits[0].to_s  + "://" + splits[2].to_s
  end

end
