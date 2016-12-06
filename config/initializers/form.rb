# http://www.davehulihan.com/bootstrap-datetimepicker-and-rails/

module ActionView
  module Helpers
    class FormBuilder 
      def date_select(method, options = {}, html_options = {})
        existing_date = @object.send(method) 

        # Set default date if object's attr is nil
        existing_date ||= Time.now.to_date

        formatted_date = existing_date.to_date.strftime("%F") if existing_date.present?
        @template.content_tag(:div, :class => "input-group") do    
          text_field(method, :value => formatted_date, :class => "form-control datepicker", :"data-date-format" => "YYYY-MM-DD") +
          @template.content_tag(:span, @template.content_tag(:span, "", :class => "glyphicon glyphicon-calendar") ,:class => "input-group-addon")
        end
      end

      def datetime_select(method, options = {}, html_options = {})
        existing_time = @object.send(method) 

        # Set default date if object's attr is nil
        existing_date ||= Time.now

        # formatted_time = existing_time.to_time.strftime("%F %I:%M %p") if existing_time.present?
        formatted_time = existing_time.to_time.strftime("%a %b %e, %Y %l:%M %p") if existing_time.present?
        @template.content_tag(:div, :class => "input-group") do    
          # text_field(method, :value => formatted_time, :class => "form-control datetimepicker", :"data-date-format" => "YYYY-MM-DD hh:mm A") +
          text_field(method, :value => formatted_time, :class => "form-control datetimepicker", :"data-date-format" => "ddd MMM D, YYYY h:mm A") +
          @template.content_tag(:span, @template.content_tag(:span, "", :class => "glyphicon glyphicon-calendar") ,:class => "input-group-addon")
        end
      end
    end
  end
end