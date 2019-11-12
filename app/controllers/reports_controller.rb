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

      pdf.image Rails.root.join('app', 'assets', 'images', "#{element.format.image_name}-tag.png"), 
                :width => 220, :position => :center, :vposition => 230

      if element.format.image_name.eql? 'Format-1'
        pdf.draw_text element.format_values['l1']['size'], at: [100, 80], style: :bold, size: 12

      elsif element.format.image_name.eql? 'Format-3'
        pdf.draw_text element.format_values['l1']['size'], at: [115, 65], style: :bold, size: 12
        pdf.draw_text element.format_values['l2']['size'], at: [20, 80], style: :bold, size: 12

      elsif element.format.image_name.eql? 'Format-4'
        pdf.draw_text element.format_values['l1']['size'], at: [105, 65], style: :bold, size: 12
        pdf.draw_text element.format_values['l2']['size'], at: [15, 75], style: :bold, size: 12
        pdf.draw_text element.format_values['l3']['size'], at: [190, 75], style: :bold, size: 12
        
      elsif element.format.image_name.eql? 'Format-8'
        pdf.draw_text element.format_values['l1']['size'], at: [100, 40], style: :bold, size: 12
        pdf.draw_text element.format_values['l2']['size'], at: [140, 75], style: :bold, size: 12
        pdf.draw_text element.format_values['l3']['size'], at: [98, 80], style: :bold, size: 10

      elsif element.format.image_name.eql? 'Format-58'
        pdf.draw_text element.format_values['l1']['size'], at: [105, 50], style: :bold, size: 12
        pdf.draw_text element.format_values['l2']['size'], at: [150, 90], style: :bold, size: 12

      elsif element.format.image_name.eql? 'Format-122'
        pdf.draw_text element.format_values['l1']['size'], at: [30, 80], style: :bold, size: 12

      elsif element.format.image_name.eql? 'Format-245'
        pdf.draw_text element.format_values['l1']['size'], at: [145, 75], style: :bold, size: 12
        pdf.draw_text element.format_values['l2']['size'], at: [105, 35], style: :bold, size: 12
        pdf.draw_text element.format_values['l3']['size'], at: [65,  75], style: :bold, size: 12
        pdf.draw_text element.format_values['l4']['size'], at: [107, 80], style: :bold, size: 10
      end

      pdf.start_new_page if cont < records_array.ntuples
    end

    filename = "reports/tags-#{construction.name}.pdf"
    pdf.render_file filename

    send_file filename, type: 'application/pdf', filename: "Etiquetas-#{construction.name}.pdf"
  end
end
