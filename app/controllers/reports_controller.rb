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
    @items_weight_by_gauge = items_weight_by_gauge( @construction )

    render pdf: 'elements_report', page_size: 'A4', encoding: "UTF-8"
  end


  def stages
    @construction = Construction.find( params[:construction_id] )
    @total_weight = get_total_weight( @construction.construction_stages )
    @gauge_type_weight = get_gauge_type_weight( @construction )
    @stages_weight_by_gauge = stages_weight_by_gauge( @construction )

    render pdf: 'stepss_report', page_size: 'A4', encoding: "UTF-8"
  end

  
  private
  def get_total_weight( construction_stages )
    total = 0
    construction_stages.each do |construction_stage|
      total = total + construction_stage.quantity.to_f
    end

    return total
  end

  def get_gauge_type_weight( construction )
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


  def stages_weight_by_gauge( construction )
    stages = []

    construction.construction_stages.each do |construction_stage|
      gauges = {
        "4_2" =>  {label: '4,2',  weight: 0},
        "5_0" =>  {label: '5,0',  weight: 0},
        "6_3" =>  {label: '6,3',  weight: 0},
        "8_0" =>  {label: '8,0',  weight: 0},
        "10_0" => {label: '10,0', weight: 0},
        "12_5" => {label: '12,5', weight: 0},
        "16_0" => {label: '16,0', weight: 0},
        "20_0" => {label: '20,0', weight: 0},
        "25_0" => {label: '25,0', weight: 0},
        "32_0" => {label: '32,0', weight: 0}
      }

      construction_stage.stage_items.each do |stage_item|
        gauges = proccess_gauge( gauges, stage_item )
      end

      stages.push( {
        name: construction_stage.name,
        quantity: construction_stage.quantity,
        gauges: gauges
      } )
    end

    return stages
  end


  def items_weight_by_gauge( construction )
    stages = []

    construction.construction_stages.each do |construction_stage|
      items = []
      construction_stage.stage_items.each do |stage_item|
        gauges = {
          "4_2" =>  {label: '4,2',  weight: 0},
          "5_0" =>  {label: '5,0',  weight: 0},
          "6_3" =>  {label: '6,3',  weight: 0},
          "8_0" =>  {label: '8,0',  weight: 0},
          "10_0" => {label: '10,0', weight: 0},
          "12_5" => {label: '12,5', weight: 0},
          "16_0" => {label: '16,0', weight: 0},
          "20_0" => {label: '20,0', weight: 0},
          "25_0" => {label: '25,0', weight: 0},
          "32_0" => {label: '32,0', weight: 0}
        }

        gauges = proccess_gauge( gauges, stage_item )

        items.push( {
          name: stage_item.name,
          quantity: stage_item.quantity,
          gauges: gauges
        } )
      end

      stages.push( {
        name: construction_stage.name,
        quantity: construction_stage.quantity,
        items: items
      } )
    end

    return stages
  end


  def proccess_gauge( gauges, stage_item )
    stage_item.item_elements.each do |element|
      case element.gauge
        when "4_2"
          gauges['4_2'][:weight]  = gauges['4_2'][:weight]  + element.weight * stage_item.quantity
        when "5_0"
          gauges['5_0'][:weight]  = gauges['5_0'][:weight]  + element.weight * stage_item.quantity
        when "6_3"
          gauges['6_3'][:weight]  = gauges['6_3'][:weight]  + element.weight * stage_item.quantity
        when "8_0"
          gauges['8_0'][:weight]  = gauges['8_0'][:weight]  + element.weight * stage_item.quantity
        when "10_0"
          gauges['10_0'][:weight] = gauges['10_0'][:weight] + element.weight * stage_item.quantity
        when "12_5"
          gauges['12_5'][:weight] = gauges['12_5'][:weight] + element.weight * stage_item.quantity
        when "16_0"
          gauges['16_0'][:weight] = gauges['16_0'][:weight] + element.weight * stage_item.quantity
        when "20_0"
          gauges['20_0'][:weight] = gauges['20_0'][:weight] + element.weight * stage_item.quantity
        when "25_0"
          gauges['25_0'][:weight] = gauges['25_0'][:weight] + element.weight * stage_item.quantity
        when "32_0"
          gauges['32_0'][:weight] = gauges['32_0'][:weight] + element.weight * stage_item.quantity
      end
    end

    gauges
  end
end

