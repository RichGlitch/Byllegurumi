module ApplicationHelper
  def gravatar_for(user, options = { size: 80})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "img-circle avatar")
  end
  
  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight(code, lexer: language, options: {lineanchors: "line"})
    end
    def autolink(link, link_type)
      case link_type
      when :url then url_link(link)
      end
    end
    def url_link(link)
      if link.include?("https://www.youtube.com")
        youtube_link(link)
      else
        normal_link(link)
      end
    end
    def youtube_link(link)
      parameters_start = link.index('=')
      video_id = link[parameters_start + 1..-1]
      "<iframe width=\"100%\" height=\"400\" src=\"https://www.youtube.com/embed/#{video_id}?autoplay=0\" allowfullscreen></iframe>"
    end
    def normal_link(link)
      "<a href=\"#{link}\" target=\"_blank\">#{link}</a>"
    end
    
    def imagen(link)
      "<img src=\"#{link}\" class=\"imagenP\"></img>"
    end
  end
  
  def markdown(content)
    renderer = HTMLwithPygments.new(hard_wrap: true, filter_html: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }
    Redcarpet::Markdown.new(renderer, options).render(content).html_safe
  end
  
end
