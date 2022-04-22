module ActsAsRailable
  module ViewHelpers
    def void_link_to name, html_options=nil
      link_to name, "javascript:void(0);", html_options
    end

    def back_link_to name, html_options
      link_to name, :back, html_options
    end

    def native_flash_messages!
      html = ""
      flash.each do |name, msg|
        if msg.is_a? String
          color_code = name == 'notice' ? 'green' : 'red'
          flash_style = "color: #{color_code}"
          html += <<-HTML
          <p style="#{flash_style}">
            #{msg}
          </p>
          HTML
        end
      end
      html.html_safe
    end

    def bootstrap_flash_messages!
      html = ""
      flash.each do |name, msg|
        if msg.is_a? String
          color_code = name == 'notice' ? 'success' : 'danger'
          flash_class = "alert alert-#{color_code} alert-dismissible fade show"
          html += <<-HTML
          <div class="#{flash_class}" role="alert">
            <div>#{msg}</div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
          </div>
          HTML
        end
      end
      html.html_safe
    end

    def native_form_error_messages!(object)
      if object.errors.any?
        messages = object.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
        sentence = I18n.t("errors.template.header",
                          count: object.errors.count,
                          model: object.class.model_name.human.downcase)
        bodyhead = I18n.t("errors.template.body")

        html = <<-HTML
          <div id="#{object.form_error_placeholder_id}" style="color: red">
            <h2>#{sentence}</h2>
            <ul>#{messages}</ul>
          </div>
        HTML
      else
        html = <<-HTML
          <div id="#{object.form_error_placeholder_id}">
          </div>
        HTML
      end

      html.html_safe
    end

    def bootstrap_form_error_messages!(object)
      if object.errors.any?
        messages = object.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
        sentence = I18n.t("errors.template.header",
                          count: object.errors.count,
                          model: object.class.model_name.human.downcase)
        bodyhead = I18n.t("errors.template.body")

        html = <<-HTML
          <div id="#{object.form_error_placeholder_id}">
            <div class="alert alert-danger" role="alert">
              <h6 class="alert-heading">#{sentence}</h6>
              <ul class="mb-0">#{messages}</ul>
            </div>
          </div>
        HTML
      else
        html = <<-HTML
          <div id="#{object.form_error_placeholder_id}">
          </div>
        HTML
      end

      html.html_safe
    end

    def native_devise_error_messages!(resource)
      return "" if resource.errors.empty?

      messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
      sentence = I18n.t("errors.messages.not_saved",
                        count: resource.errors.count,
                        resource: resource.class.model_name.human.downcase)
      bodyhead = I18n.t("errors.template.body")

      html = <<-HTML
        <div id="error_explanation">
          <h2>#{sentence}</h2>
          <ul>#{messages}</ul>
        </div>
      HTML

      html.html_safe
    end

    def bootstrap_devise_error_messages!(resource)
      return "" if resource.errors.empty?

      messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
      sentence = I18n.t("errors.messages.not_saved",
                        count: resource.errors.count,
                        resource: resource.class.model_name.human.downcase)
      bodyhead = I18n.t("errors.template.body")

      html = <<-HTML
      <div class="alert alert-danger" role="alert">
        <h6>#{sentence}</h6>
        <ul class="my-0">#{messages}</ul>
      </div>
      HTML

      html.html_safe
    end
  end
end
