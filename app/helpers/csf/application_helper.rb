module Csf
  module ApplicationHelper

    # composes the HTML for the footer links
    def footer_links
      links = t("layouts.footer.links.number").to_i.times.inject([]) do |m, i|
        n = i + 1
        title = t("layouts.footer.links.link_#{n}.title")
        url   = t("layouts.footer.links.link_#{n}.url")
        m << link_to(title, url)
      end

      links.join(t("layouts.footer.links.separator")).html_safe
    end

    # renders the page head section
    def page_head
      l = {}
      if !(title = t(".title", default: '')).blank?
        l[:title] = title
      end

      if !(subtitle = t(".subtitle", default: '')).blank?
        l[:subtitle] = subtitle
      end

      render partial: "shared/page_head", locals: l
    end

  end
end
