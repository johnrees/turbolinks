module Turbolinks
  # Corrects the behavior of url_for (and link_to, which uses url_for) with the :back
  # option by using the X-XHR-Referer request header instead of the standard Referer
  # request header.
  module XHRUrlFor
    def url_for(options = {})
      options = (controller.request.headers["X-XHR-Referer"] || options) if options == :back
      super
    end
  end

  # TODO: Remove me when support for Ruby < 2 && Rails < 4 is dropped
  module LegacyXHRUrlFor
    def self.included(base)
      base.alias_method_chain :url_for, :xhr_referer
    end

    def url_for_with_xhr_referer(options = {})
      options = (controller.request.headers["X-XHR-Referer"] || options) if options == :back
      url_for_without_xhr_referer options
    end
  end
end
