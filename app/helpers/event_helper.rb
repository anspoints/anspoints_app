# frozen_string_literal: true

module EventHelper
  require 'rqrcode'
  def make_form(code)
    qr = RQRCode::QRCode.new("https://anspoints.herokuapp.com/check-in/#{code}",
                             level: :l, mode: :byte_8bit)
    svg = qr.as_svg(standalone: true, use_path: false, viewbox: true, module_size: 10)
    template = IO.read('app/views/layouts/qrform_template.xhtml')
    template['${SVG}'] = svg[38..] # skip opening XML declaration
    template['${CODE}'] = code
    template
  end
end
