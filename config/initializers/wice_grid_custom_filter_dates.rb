# encoding: UTF-8
module Wice

  module Columns #:nodoc:

    class ViewColumnDateCustom < ViewColumn #:nodoc:

      def render_filter_internal(params) #:nodoc:
        @contains_a_text_input = true

        @query,  _, parameter_name,  @dom_id  = form_parameter_name_id_and_query(fr: '')
        @query2, _, parameter_name2, @dom_id2 = form_parameter_name_id_and_query(to: '')

        opts1 = {size: 2, id: @dom_id,  class: 'form-control input-sm range-start'}
        opts2 = {size: 2, id: @dom_id2, class: 'form-control input-sm range-end'}

        if auto_reload
          opts1[:class] += ' auto-reload'
          opts2[:class] += ' auto-reload'
        end

        content_tag(
          :div,
          text_field_tag(parameter_name,  params[:fr], opts1) + text_field_tag(parameter_name2, params[:to], opts2),
          class: 'form-inline')
      end

      def yield_declaration_of_column_filter #:nodoc:
        {
          templates: [@query, @query2],
          ids:       [@dom_id, @dom_id2]
        }
      end

      def has_auto_reloading_input? #:nodoc:
        auto_reload
      end
    end


    class ConditionsGeneratorColumnDateCustom < ConditionsGeneratorColumn  #:nodoc:

      def  generate_conditions(table_alias, opts)   #:nodoc:
        unless opts.kind_of? Hash
          Wice.log "invalid parameters for the grid integer filter - must be a hash"
          return false
        end
        conditions = [[]]
        if opts[:fr]
          opts[:fr] = opts[:fr].force_encoding('ISO-8859-1').encode('UTF-8')
          if opts[:fr] =~ /[0-3][0-9]\/[0-1][0-9]\/20[0-3][0-9]/ #valide le format de la date par regex. 
            conditions[0] << " CONVERT(date, #{@column_wrapper.alias_or_table_name(table_alias)}.#{@column_wrapper.name},103) >= CONVERT(date,CONVERT(varchar," + Date.parse(opts[:fr]).strftime('%Y%m%d') + "))"
          else
            opts.delete(:fr)
          end
        end

        if opts[:to]
            opts[:to] = opts[:to].force_encoding('ISO-8859-1').encode('UTF-8')
          if opts[:to] =~ /[0-3][0-9]\/[0-1][0-9]\/20[0-3][0-9]/      
            conditions[0] << " CONVERT(date, #{@column_wrapper.alias_or_table_name(table_alias)}.#{@column_wrapper.name},103) <= CONVERT(date,CONVERT(varchar," + Date.parse(opts[:to]).strftime('%Y%m%d') + "))"
          else
            opts.delete(:to)
          end
        end
        conditions[0] = conditions[0].join(' and ')

        conditions
      end
    end
  end
end