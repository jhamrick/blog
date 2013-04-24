begin
  require './plugins/config_tag'
rescue LoadError # config_tag is not installed
  raise "This plugin requires the config_tag plugin, available at https://github.com/octopress/config-tag"
end

class ADNTimeline < Liquid::Tag
  def initialize(tag_name, options, tokens)
    super
  end

  def render(context)
    output = config_tag(context.registers[:site].config, 'adn_timeline')
    output += "\n<script type='text/javascript'>$(document).ready(function(){ AdnTimeline.init() })</script>"
  end
end

Liquid::Template.register_tag('adn_timeline', ADNTimeline)

