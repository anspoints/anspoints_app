# frozen_string_literal: true

module EventHelper
  require 'rqrcode'
  def make_form(code, base_url)
    qr = RQRCode::QRCode.new("https://#{base_url}/events/join?event[eventCode]=#{code}",
                             level: :l, mode: :byte_8bit)
    svg = qr.as_svg(standalone: true, use_path: false, viewbox: true, module_size: 10)
    template = File.read('app/views/layouts/qrform_template.xhtml')
    template['${SVG}'] = svg[38..] # skip opening XML declaration
    template['${CODE}'] = code
    template['${URL}'] = base_url
    template
  end
end
