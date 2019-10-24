class ReportsController < ApplicationController
  include Prawn::Measurements
  skip_before_action :verify_authenticity_token

  def initialize
    @tags_pdf_options = {
      page_size:   [cm2pt(13), cm2pt(8)],
      page_layout: :landscape,
      margin:      [0, 0]
    }
  end

  def tags
    construction = Construction.find( params[:construction_id] )

    sql = "select id from item_elements 
          where stage_item_id in ( 
            select id from stage_items where construction_stage_id in ( 
              select id from construction_stages where construction_id = #{construction.id}
            ) 
          )"
    records_array = ActiveRecord::Base.connection.execute(sql)

    pdf = Prawn::Document.new(@tags_pdf_options)

    cont = 0
    records_array.each do |element_id|
      cont += 1

      element = ItemElement.find( element_id["id"] )
      item = element.stage_item
      stage = item.construction_stage
      construction = stage.construction
    
      pdf.font_size 7.5
      
      # margem superior fica em 368
      # margem esquerda fica em 0
      #          X   X  , hor, vert
      pdf.rectangle [0, 330], 226.7, 40
      pdf.fill

      romaneio = "#{Date.current.year}#{construction.id}"
      margin_left = 115 - ( romaneio.size * 8 )

      pdf.fill_color "ffffff" 
      pdf.draw_text romaneio, at: [margin_left , 300], size: 30
      
      pdf.fill_color "000000" 

      # No block
      #line [110, 0], [110, 0]
      pdf.horizontal_line 0, 226.7, :at => 255
      pdf.horizontal_line 0, 226.7, :at => 220
      pdf.horizontal_line 0, 226.7, :at => 185
      
      pdf.vertical_line 220, 255, :at => 150
      pdf.vertical_line 185, 220, :at => 50
      pdf.vertical_line 185, 220, :at => 90
      pdf.vertical_line 185, 220, :at => 130
      pdf.vertical_line 185, 220, :at => 170
      pdf.stroke
      
      pdf.draw_text "CLIENTE", at: [3, 278], style: :bold
      pdf.draw_text "OBRA", at: [3, 243], style: :bold
      pdf.draw_text "ITEM", at: [153, 243], style: :bold
      pdf.draw_text "SEQUENCIA", at: [3, 208], style: :bold
      pdf.draw_text "POSIÇÂO", at: [53, 208], style: :bold
      pdf.draw_text "BITOLA", at: [93, 208], style: :bold
      pdf.draw_text "AÇO", at: [133, 208], style: :bold
      pdf.draw_text "QUANTIDADE", at: [173, 208], style: :bold
      pdf.draw_text "ETAPA", at: [3, 173], style: :bold

      pdf.draw_text construction.customer.name, at: [3, 265]
      pdf.draw_text construction.name, at: [3, 230]
      pdf.draw_text item.name, at: [153, 230]
      pdf.draw_text element.sequential, at: [3, 195]
      pdf.draw_text element.position, at: [53, 195]
      pdf.draw_text element.gauge_text, at: [93, 195]
      pdf.draw_text element.steel_type, at: [133, 195]
      pdf.draw_text element.quantity, at: [173, 195]

      pdf.draw_text stage.name, at: [3, 160]

      pdf.start_new_page if cont < records_array.ntuples
    end

    filename = "reports/tags-#{construction.name}.pdf"
    pdf.render_file filename

    send_file filename, type: 'application/pdf', filename: "Etiquetas-#{construction.name}.pdf"
  end
end
