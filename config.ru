require 'bundler/setup'
require 'sinatra/base'
require 'rack-rewrite'

# The project root directory
$root = ::File.dirname(__FILE__)

use Rack::Rewrite do
    r301 %r{^/wp-content/uploads/2011/05/jess-meng-thesis.pdf$}, '/publications/pdf/jess-meng-thesis.pdf'
    r301 %r{^/wp-content/uploads/2011/05/cogsci2011.pdf$}, '/publications/pdf/cogsci2011.pdf'
    r301 %r{^/wp-content/uploads/2012/05/HamrBattTene12VSS.pdf$}, '/publications/pdf/HamrBattTene12VSS.pdf'
    r301 %r{^/wp-content/uploads/2011/05/jhamrick-cogsci2011-slides.pdf$}, '/publications/pdf/jhamrick-cogsci2011-slides.pdf'
    r301 %r{^/wp-content/uploads/2011/05/jessica-hamrick-resume.pdf$}, '/jessica-hamrick-cv.pdf'
    r301 %r{^/publications/abstract-physical-reasoning-in-complex-scenes-is-sensitive-to-mass/?$}, '/publications/abstracts/physical-reasoning-in-complex-scenes-is-sensitive-to-mass'
    r301 %r{^/publications/abstract-internal-physics-models-guide-probabilistic-judgments-about-object-dynamics/?$}, '/publications/abstracts/internal-physics-models-guide-probabilistic-judgments-about-object-dynamics'

end

class SinatraStaticServer < Sinatra::Base

  get(/.+/) do
    send_sinatra_file(request.path) {404}
  end

  not_found do
    send_sinatra_file('404.html') {"Sorry, I cannot find #{request.path}"}
  end

  def send_sinatra_file(path, &missing_file_block)
    file_path = File.join(File.dirname(__FILE__), 'public',  path)
    file_path = File.join(file_path, 'index.html') unless file_path =~ /\.[a-z]+$/i
    File.exist?(file_path) ? send_file(file_path) : missing_file_block.call
  end

end

run SinatraStaticServer
