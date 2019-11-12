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

  def elements
    locale_file = Tempfile.open('report.pdf')
    pdf = Prawn::Document.new( @tags_pdf_options )

    construction = Construction.find( params[:construction_id] )
    Rails.logger.info("++++++++++++++++")
    Rails.logger.info( construction.customer.to_json )
    Rails.logger.info("++++++++++++++++")
    pdf.fill_color "909090"
    pdf.rectangle [0, 360], 226.7, 15
    pdf.fill

    pdf.fill_color "000000"
    pdf.move_down 13
    pdf.text "Detalhes da Obra", size: 7, :align => :center

    pdf.move_down 10
    pdf.text "Nome da Obra: #{construction.name}", size: 5, :align => :left
    pdf.move_up 5.5
    pdf.text "Vendedor: #{construction.customer.salesman}", size: 5, :align => :center
    pdf.move_up 5
    pdf.text "Telefone de Contato: #{construction.contact_number}", size: 5, :align => :right

    pdf.move_down 10
    pdf.text "Nome do Cliente: #{construction.customer.name}", size: 5, :align => :left
    pdf.move_up 5.5
    pdf.text "Telefone para Contato: #{construction.customer.phone}", size: 5, :align => :center
    pdf.move_up 5
    pdf.text "E-mail: #{construction.customer.email}", size: 5, :align => :right

    pdf.fill_color "909090"
    pdf.rectangle [0, 305], 226.7, 10
    pdf.fill

    pdf.move_down 12
    pdf.fill_color "000000"
    pdf.text "PESO TOTAL DA OBRA", size: 5, :align => :center
    pdf.move_up 6
    pdf.text "1000kg", size: 5, :align => :right

    pdf.horizontal_line 0, 226.7, :at => 295
    pdf.horizontal_line 0, 226.7, :at => 285

    pdf.vertical_line 295, 285, :at => 25.18
    pdf.vertical_line 295, 285, :at => 50.37
    pdf.vertical_line 295, 285, :at => 75.55
    pdf.vertical_line 295, 285, :at => 100.73
    pdf.vertical_line 295, 285, :at => 125.91

    pdf.vertical_line 295, 285, :at => 151.09
    pdf.vertical_line 295, 285, :at => 176.27
    pdf.vertical_line 295, 285, :at => 201.45
    pdf.vertical_line 295, 285, :at => 226.70
    pdf.stroke

    pdf.draw_text "Ø 4,2", at: [1 , 288],  size: 5
    pdf.draw_text "Ø 5,0", at: [26 , 288],  size: 5
    pdf.draw_text "Ø 6,3", at: [51 , 288],  size: 5
    pdf.draw_text "Ø 8,0", at: [76 , 288],  size: 5
    pdf.draw_text "Ø 10,0", at: [101.50 , 288],  size: 5
    pdf.draw_text "Ø 12,5", at: [127 , 288],  size: 5
    pdf.draw_text "Ø 16,0", at: [152 , 288],  size: 5
    pdf.draw_text "Ø 20,0", at: [177 , 288],  size: 5
    pdf.draw_text "Ø 25,0", at: [202 , 288],  size: 5

    #dados da bitola

    pdf.horizontal_line 0, 226.7, :at => 275

    pdf.vertical_line 285, 275, :at => 25.18
    pdf.vertical_line 285, 275, :at => 50.37
    pdf.vertical_line 285, 275, :at => 75.55
    pdf.vertical_line 285, 275, :at => 100.73
    pdf.vertical_line 285, 275, :at => 125.91

    pdf.vertical_line 285, 275, :at => 151.09
    pdf.vertical_line 285, 275, :at => 176.27
    pdf.vertical_line 285, 275, :at => 201.45
    pdf.vertical_line 285, 275, :at => 226.70
    pdf.stroke

    pdf.draw_text " 0 ", at: [1 , 278],  size: 5
    pdf.draw_text " 0 ", at: [26 , 278],  size: 5
    pdf.draw_text " 0 ", at: [51 , 278],  size: 5
    pdf.draw_text " 0 ", at: [76 , 278],  size: 5
    pdf.draw_text " 0 ", at: [101.50 , 278],  size: 5
    pdf.draw_text " 0 ", at: [127 , 278],  size: 5
    pdf.draw_text " 0 ", at: [152 , 278],  size: 5
    pdf.draw_text " 0 ", at: [177 , 278],  size: 5
    pdf.draw_text " 0 ", at: [202 , 278],  size: 5

    pdf.fill_color "909090"
    pdf.rectangle [0, 270], 80, 10
    pdf.fill

    construction_stages = ConstructionStage.where(construction_id: construction.id)


    top_stage = 263
    construction_stages.each do |construction|

      stage_items = StageItem.where(construction_stage_id: construction.id)
      stage_items.each do |stage_item|
        item_elements = ItemElement.where(stage_item_id: stage_item.id)
        Rails.logger.info("+++++++++++++++++++++++++++++===")
        Rails.logger.info("+++++++++++++++++++++++++++++===")
        Rails.logger.info("+++++++++++++++++++++++++++++=== pegando os elementos do item daetapa ")
        Rails.logger.info( item_elements.to_json )
        Rails.logger.info("+++++++++++++++++++++++++++++===")
        Rails.logger.info("+++++++++++++++++++++++++++++===")
      end

      #pdf.fill_color "000000"
      #pdf.draw_text "ETAPA 1", at: [1 , top_stage],  size: 5
      #pdf.draw_text " 100KG ", at: [55 , top_stage],  size: 5

      #top_stage = top_stage - 3
      #pdf.horizontal_line 20, 80, :at => top_stage
      #top_stage = top_stage - 10
      #pdf.horizontal_line 20, 80, :at => 250
      #pdf.vertical_line top_stage + 10, top_stage, :at => 20
      #pdf.vertical_line top_stage + 10, top_stage, :at => 50
      #pdf.vertical_line top_stage + 10, top_stage, :at => 80
    end





=begin
    pdf.horizontal_line 20, 80, :at => 240
    pdf.vertical_line 260, 240, :at => 20
    pdf.vertical_line 260, 240, :at => 50
    pdf.vertical_line 260, 240, :at => 80

    pdf.horizontal_line 20, 80, :at => 230
    pdf.vertical_line 260, 230, :at => 20
    pdf.vertical_line 260, 230, :at => 50
    pdf.vertical_line 260, 230, :at => 80

    pdf.horizontal_line 20, 80, :at => 220
    pdf.vertical_line 260, 220, :at => 20
    pdf.vertical_line 260, 220, :at => 50
    pdf.vertical_line 260, 220, :at => 80

    pdf.horizontal_line 20, 80, :at => 210
    pdf.vertical_line 260, 210, :at => 20
    pdf.vertical_line 260, 210, :at => 50
    pdf.vertical_line 260, 210, :at => 80

    pdf.horizontal_line 20, 80, :at => 200
    pdf.vertical_line 260, 200, :at => 20
    pdf.vertical_line 260, 200, :at => 50
    pdf.vertical_line 260, 200, :at => 80

    pdf.horizontal_line 20, 80, :at => 190
    pdf.vertical_line 260, 190, :at => 20
    pdf.vertical_line 260, 190, :at => 50
    pdf.vertical_line 260, 190, :at => 80

    pdf.horizontal_line 20, 80, :at => 180
    pdf.vertical_line 260, 180, :at => 20
    pdf.vertical_line 260, 180, :at => 50
    pdf.vertical_line 260, 180, :at => 80

    pdf.horizontal_line 20, 80, :at => 170
    pdf.vertical_line 260, 170, :at => 20
    pdf.vertical_line 260, 170, :at => 50
    pdf.vertical_line 260, 170, :at => 80

    pdf.horizontal_line 20, 80, :at => 160
    pdf.vertical_line 260, 160, :at => 20
    pdf.vertical_line 260, 160, :at => 50
    pdf.vertical_line 260, 160, :at => 80

    pdf.stroke

    pdf.draw_text "Elemento 1", at: [22, 252],  size: 5
    pdf.draw_text "Ø 4,2", at: [22, 242],  size: 5
    pdf.draw_text "Ø 5,0", at: [22 , 232],  size: 5
    pdf.draw_text "Ø 6,3", at: [22 , 222],  size: 5
    pdf.draw_text "Ø 8,0", at: [22 , 212],  size: 5
    pdf.draw_text "Ø 10,0", at: [22 , 202],  size: 5
    pdf.draw_text "Ø 12,5", at: [22 , 192],  size: 5
    pdf.draw_text "Ø 16,0", at: [22 , 182],  size: 5
    pdf.draw_text "Ø 20,0", at: [22 , 172],  size: 5
    pdf.draw_text "Ø 25,0", at: [22 , 162],  size: 5

    pdf.draw_text "200 KG", at: [52, 252],  size: 5
    pdf.draw_text "200 KG", at: [52, 242],  size: 5
    pdf.draw_text "200 KG", at: [52 , 232],  size: 5
    pdf.draw_text "200 KG", at: [52 , 222],  size: 5
    pdf.draw_text "200 KG", at: [52 , 212],  size: 5
    pdf.draw_text "200 KG", at: [52 , 202],  size: 5
    pdf.draw_text "200 KG", at: [52 , 192],  size: 5
    pdf.draw_text "200 KG", at: [52 , 182],  size: 5
    pdf.draw_text "200 KG", at: [52 , 172],  size: 5
    pdf.draw_text "200 kg", at: [52 , 162],  size: 5
=end

    pdf.render_file locale_file.path
    send_file locale_file.path , type: 'application/pdf', filename: "Relatório_compromisso.pdf"
  end

end
