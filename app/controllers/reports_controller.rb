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
    @construction = Construction.find( params[:construction_id] )
    @total_weight = get_total_weight( @construction.construction_stages )
    @gauge_type_weight = get_gauge_type_weight( @construction )

    render pdf: 'elements_report'
  end


  def elementos
    pdf_options = {
      page_size:   "A4",
      page_layout: :portrait,
      margin:      [50, 50]
    }

    locale_file = Tempfile.open('report.pdf')
    pdf = Prawn::Document.new( pdf_options )
    
    construction = Construction.find( params[:construction_id] )
    
    ##### CABEÇALHO DO RELATÒRIO #####

    pdf.font_size 15
    

    pdf.fill_color "000000"
    pdf.move_down 13
    pdf.text "Detalhes da Obra", :align => :center

    pdf.font_size 10

    pdf.move_down 10
    pdf.text "Nome da Obra: #{construction.name}", :align => :left
    pdf.move_up 5.5
    pdf.text "Vendedor: #{construction.customer.salesman}", :align => :center
    pdf.move_up 5
    pdf.text "Telefone de Contato: #{construction.contact_number}", :align => :right

    pdf.move_down 10
    pdf.text "Nome do Cliente: #{construction.customer.name}", :align => :left
    pdf.move_up 5.5
    pdf.text "Telefone para Contato: #{construction.customer.phone}", :align => :center
    pdf.move_up 5
    pdf.text "E-mail: #{construction.customer.email}", :align => :right

    #pdf.fill_color "909090"
    #pdf.rectangle [0, 305], 226.7, 10
    #pdf.fill

    ##### FIM DO CABEÇALHO #####

    ##### PESO TOTAL DA OBRA #####

    total_weight = get_total_weight( construction.construction_stages )

      #pdf.rectangle [0, 330], 226.7, 40
      #pdf.fill

      #romaneio = "#{Date.current.year}#{construction.id}"
      #margin_left = 115 - ( romaneio.size * 8 )

      #pdf.fill_color "ffffff"
      #pdf.draw_text romaneio, at: [margin_left , 300], size: 30

      #pdf.fill_color "000000"

    pdf.fill_color "909090"
    pdf.rectangle [0, 635], 500, 20
    pdf.fill

    pdf.move_down 14
    pdf.fill_color "000000"
    pdf.text "PESO TOTAL DA OBRA", :align => :center
    pdf.move_up 12
    pdf.text "#{total_weight} KG", :align => :right

    ##### FIM PESO TOTAL DA OBRA #####

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

    gauge_type_weight = get_gauge_type_weight( construction )
    pdf.draw_text "#{gauge_type_weight['4_2']} KG", at: [1 , 278],  size: 5
    pdf.draw_text "#{gauge_type_weight['5_0']} KG", at: [26 , 278],  size: 5
    pdf.draw_text "#{gauge_type_weight['6_3']} KG", at: [51 , 278],  size: 5
    pdf.draw_text "#{gauge_type_weight['8_0']} KG", at: [76 , 278],  size: 5
    pdf.draw_text "#{gauge_type_weight['10_0']} KG", at: [101.50 , 278],  size: 5
    pdf.draw_text "#{gauge_type_weight['12_5']} KG", at: [127 , 278],  size: 5
    pdf.draw_text "#{gauge_type_weight['16_0']} KG", at: [152 , 278],  size: 5
    pdf.draw_text "#{gauge_type_weight['20_0']} KG", at: [177 , 278],  size: 5
    pdf.draw_text "#{gauge_type_weight['25_0']} KG", at: [202 , 278],  size: 5

    top_stage = 270
    text_stage = 252
    vertical_line = 260
    pdf.fill_color "909090"
    pdf.rectangle [0, top_stage], 80, 10
    pdf.fill

    top_stage = top_stage - 7
    pdf.fill_color "000000"
    pdf.draw_text "ETAPA 1", at: [1 , top_stage],  size: 5
    pdf.draw_text " 100KG ", at: [55 , top_stage],  size: 5

    top_stage = top_stage - 3
    pdf.horizontal_line 20, 80, :at => top_stage
    top_stage = top_stage - 10

    pdf.horizontal_line 20, 80, :at => 250
    pdf.vertical_line vertical_line, top_stage, :at => 20
    pdf.vertical_line vertical_line, top_stage, :at => 50
    pdf.vertical_line vertical_line, top_stage, :at => 80

    top_stage = top_stage -10
    pdf.horizontal_line 20, 80, :at => top_stage
    pdf.vertical_line vertical_line, top_stage, :at => 20
    pdf.vertical_line vertical_line, top_stage, :at => 50
    pdf.vertical_line vertical_line, top_stage, :at => 80

    top_stage = top_stage -10
    pdf.horizontal_line 20, 80, :at => top_stage
    pdf.vertical_line vertical_line, top_stage, :at => 20
    pdf.vertical_line vertical_line, top_stage, :at => 50
    pdf.vertical_line vertical_line, top_stage, :at => 80

    top_stage = top_stage - 10
    pdf.horizontal_line 20, 80, :at => top_stage
    pdf.vertical_line vertical_line, top_stage, :at => 20
    pdf.vertical_line vertical_line, top_stage, :at => 50
    pdf.vertical_line vertical_line, top_stage, :at => 80

    top_stage = top_stage - 10
    pdf.horizontal_line 20, 80, :at => top_stage
    pdf.vertical_line vertical_line, top_stage, :at => 20
    pdf.vertical_line vertical_line, top_stage, :at => 50
    pdf.vertical_line vertical_line, top_stage, :at => 80

    top_stage = top_stage - 10
    pdf.horizontal_line 20, 80, :at => top_stage
    pdf.vertical_line vertical_line, top_stage, :at => 20
    pdf.vertical_line vertical_line, top_stage, :at => 50
    pdf.vertical_line vertical_line, top_stage, :at => 80

    top_stage = top_stage - 10
    pdf.horizontal_line 20, 80, :at => top_stage
    pdf.vertical_line vertical_line, top_stage, :at => 20
    pdf.vertical_line vertical_line, top_stage, :at => 50
    pdf.vertical_line vertical_line, top_stage, :at => 80

    top_stage = top_stage - 10
    pdf.horizontal_line 20, 80, :at => top_stage
    pdf.vertical_line vertical_line, top_stage, :at => 20
    pdf.vertical_line vertical_line, top_stage, :at => 50
    pdf.vertical_line vertical_line, top_stage, :at => 80

    top_stage = top_stage - 10
    pdf.horizontal_line 20, 80, :at => top_stage
    pdf.vertical_line vertical_line, top_stage, :at => 20
    pdf.vertical_line vertical_line, top_stage, :at => 50
    pdf.vertical_line vertical_line, top_stage, :at => 80

    top_stage = top_stage - 10
    pdf.horizontal_line 20, 80, :at => top_stage
    pdf.vertical_line vertical_line, top_stage, :at => 20
    pdf.vertical_line vertical_line, top_stage, :at => 50
    pdf.vertical_line vertical_line, top_stage, :at => 80

    pdf.stroke

    pdf.draw_text "Elemento 1", at: [22, text_stage],  size: 5
    pdf.draw_text "200 KG", at: [52, text_stage],  size: 5

    text_stage = text_stage - 10
    pdf.draw_text "Ø 4,2", at: [22, text_stage],  size: 5
    pdf.draw_text "200 KG", at: [52, text_stage],  size: 5

    text_stage = text_stage - 10
    pdf.draw_text "Ø 5,0", at: [22 , text_stage],  size: 5
    pdf.draw_text "200 KG", at: [52 , text_stage],  size: 5

    text_stage = text_stage - 10
    pdf.draw_text "Ø 6,3", at: [22 , text_stage],  size: 5
    pdf.draw_text "200 KG", at: [52 , text_stage],  size: 5

    text_stage = text_stage - 10
    pdf.draw_text "Ø 8,0", at: [22 , text_stage],  size: 5
    pdf.draw_text "200 KG", at: [52 , text_stage],  size: 5

    text_stage = text_stage - 10
    pdf.draw_text "Ø 10,0", at: [22 , text_stage],  size: 5
    pdf.draw_text "200 KG", at: [52 , text_stage],  size: 5

    text_stage = text_stage - 10
    pdf.draw_text "Ø 12,5", at: [22 , text_stage],  size: 5
    pdf.draw_text "200 KG", at: [52 , text_stage],  size: 5

    text_stage = text_stage - 10
    pdf.draw_text "Ø 16,0", at: [22 , text_stage],  size: 5
    pdf.draw_text "200 KG", at: [52 , text_stage],  size: 5

    text_stage = text_stage - 10
    pdf.draw_text "Ø 20,0", at: [22 , text_stage],  size: 5
    pdf.draw_text "200 KG", at: [52 , text_stage],  size: 5

    text_stage = text_stage - 10
    pdf.draw_text "Ø 25,0", at: [22 , text_stage],  size: 5
    pdf.draw_text "200 kg", at: [52 , text_stage],  size: 5

    text_stage = text_stage - 30
    top_stage = top_stage - 10
    vertical_line = vertical_line - 50
    pdf.fill_color "909090"
    pdf.rectangle [0, top_stage], 80, 10
    pdf.fill

    top_stage = top_stage - 7
    pdf.fill_color "000000"
    pdf.draw_text "ETAPA 1", at: [1 , top_stage],  size: 5
    pdf.draw_text " 100KG ", at: [55 , top_stage],  size: 5

    top_stage = top_stage - 3
    pdf.horizontal_line 20, 80, :at => top_stage
    top_stage = top_stage - 10
    pdf.horizontal_line 20, 80, :at => 250
    pdf.vertical_line vertical_line, top_stage, :at => 20
    pdf.vertical_line vertical_line, top_stage, :at => 50
    pdf.vertical_line vertical_line, top_stage, :at => 80
=begin
    top_stage = top_stage -10
    pdf.horizontal_line 20, 80, :at => top_stage
    pdf.vertical_line vertical_line, top_stage, :at => 20
    pdf.vertical_line vertical_line, top_stage, :at => 50
    pdf.vertical_line vertical_line, top_stage, :at => 80

    top_stage = top_stage -10
    pdf.horizontal_line 20, 80, :at => top_stage
    pdf.vertical_line vertical_line, top_stage, :at => 20
    pdf.vertical_line vertical_line, top_stage, :at => 50
    pdf.vertical_line vertical_line, top_stage, :at => 80

    top_stage = top_stage - 10
    pdf.horizontal_line 20, 80, :at => top_stage
    pdf.vertical_line vertical_line, top_stage, :at => 20
    pdf.vertical_line vertical_line, top_stage, :at => 50
    pdf.vertical_line vertical_line, top_stage, :at => 80

    top_stage = top_stage - 10
    pdf.horizontal_line 20, 80, :at => top_stage
    pdf.vertical_line vertical_line, top_stage, :at => 20
    pdf.vertical_line vertical_line, top_stage, :at => 50
    pdf.vertical_line vertical_line, top_stage, :at => 80

    top_stage = top_stage - 10
    pdf.horizontal_line 20, 80, :at => top_stage
    pdf.vertical_line vertical_line, top_stage, :at => 20
    pdf.vertical_line vertical_line, top_stage, :at => 50
    pdf.vertical_line vertical_line, top_stage, :at => 80

    top_stage = top_stage - 10
    pdf.horizontal_line 20, 80, :at => top_stage
    pdf.vertical_line vertical_line, top_stage, :at => 20
    pdf.vertical_line vertical_line, top_stage, :at => 50
    pdf.vertical_line vertical_line, top_stage, :at => 80

    top_stage = top_stage - 10
    pdf.horizontal_line 20, 80, :at => top_stage
    pdf.vertical_line vertical_line, top_stage, :at => 20
    pdf.vertical_line vertical_line, top_stage, :at => 50
    pdf.vertical_line vertical_line, top_stage, :at => 80

    top_stage = top_stage - 10
    pdf.horizontal_line 20, 80, :at => top_stage
    pdf.vertical_line vertical_line, top_stage, :at => 20
    pdf.vertical_line vertical_line, top_stage, :at => 50
    pdf.vertical_line vertical_line, top_stage, :at => 80

    top_stage = top_stage - 10
    pdf.horizontal_line 20, 80, :at => top_stage
    pdf.vertical_line vertical_line, top_stage, :at => 20
    pdf.vertical_line vertical_line, top_stage, :at => 50
    pdf.vertical_line vertical_line, top_stage, :at => 80

    top_stage = top_stage - 20
    pdf.stroke

    text_stage = text_stage - 30
    pdf.draw_text "Elemento 1", at: [22, text_stage],  size: 5
    pdf.draw_text "200 KG", at: [52, text_stage],  size: 5

    text_stage = text_stage - 10
    pdf.draw_text "Ø 4,2", at: [22, text_stage],  size: 5
    pdf.draw_text "200 KG", at: [52, text_stage],  size: 5

    text_stage = text_stage - 10
    pdf.draw_text "Ø 5,0", at: [22 , text_stage],  size: 5
    pdf.draw_text "200 KG", at: [52 , text_stage],  size: 5

    text_stage = text_stage - 10
    pdf.draw_text "Ø 6,3", at: [22 , text_stage],  size: 5
    pdf.draw_text "200 KG", at: [52 , text_stage],  size: 5

    text_stage = text_stage - 10
    pdf.draw_text "Ø 8,0", at: [22 , text_stage],  size: 5
    pdf.draw_text "200 KG", at: [52 , text_stage],  size: 5

    text_stage = text_stage - 10
    pdf.draw_text "Ø 10,0", at: [22 , text_stage],  size: 5
    pdf.draw_text "200 KG", at: [52 , text_stage],  size: 5

    text_stage = text_stage - 10
    pdf.draw_text "Ø 12,5", at: [22 , text_stage],  size: 5
    pdf.draw_text "200 KG", at: [52 , text_stage],  size: 5

    text_stage = text_stage - 10
    pdf.draw_text "Ø 16,0", at: [22 , text_stage],  size: 5
    pdf.draw_text "200 KG", at: [52 , text_stage],  size: 5

    text_stage = text_stage - 10
    pdf.draw_text "Ø 20,0", at: [22 , text_stage],  size: 5
    pdf.draw_text "200 KG", at: [52 , text_stage],  size: 5

    text_stage = text_stage - 10
    pdf.draw_text "Ø 25,0", at: [22 , text_stage],  size: 5
    pdf.draw_text "200 kg", at: [52 , text_stage],  size: 5
=end
    text_stage = text_stage - 30

    pdf.render_file locale_file.path
    send_file locale_file.path , type: 'application/pdf', filename: "Relatório_elementos.pdf"
  end

  private
  def get_total_weight( construction_stages )
    total = 0
    construction_stages.each do |construction_stage|
      total = total + construction_stage.quantity.to_f
    end

    return total
  end

  def get_gauge_type_weight ( construction )
    gauge = {
      "4_2" =>  0,
      "5_0" =>  0,
      "6_3" =>  0,
      "8_0" =>  0,
      "10_0" => 0,
      "12_5" => 0,
      "16_0" => 0,
      "20_0" => 0,
      "25_0" => 0,
      "32_0" => 0
    }

    construction.construction_stages.each do |construction_stage|
      construction_stage.stage_items.each do |stage_item|
        stage_item.item_elements.each do |element|
          case element.gauge
            when "4_2"
              gauge['4_2'] = gauge['4_2'] + element.weight * stage_item.quantity
            when "5_0"
              gauge['5_0'] = gauge['5_0'] + element.weight * stage_item.quantity
            when "6_3"
              gauge['6_3'] = gauge['6_3'] + element.weight * stage_item.quantity
            when "8_0"
              gauge['8_0'] = gauge['8_0'] + element.weight * stage_item.quantity
            when "10_0"
              gauge['10_0'] = gauge['10_0'] + element.weight * stage_item.quantity
            when "12_5"
              gauge['12_5'] = gauge['12_5'] + element.weight * stage_item.quantity
            when "16_0"
              gauge['16_0'] = gauge['16_0'] + element.weight * stage_item.quantity
            when "20_0"
              gauge['20_0'] = gauge['20_0'] + element.weight * stage_item.quantity
            when "25_0"
              gauge['25_0'] = gauge['25_0'] + element.weight * stage_item.quantity
            when "32_0"
              gauge['32_0'] = gauge['32_0'] + element.weight * stage_item.quantity
          end
        end
      end
    end

    return gauge
  end
end

