class LotItemsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    return unless user_logged?

    lot_items = LotItem.where(lot_id: params[:lot_id])

    render json: lot_items, status: :ok
  end


  def create
    return unless user_logged?
    damages_types_ids = params[:lot_item][:damage_type_id]
    damages_types = []

    lot = Lot.find( params[:lot_id] )
    lot_item = lot.lot_items.new( lot_item_params )

    damages_types_ids.each do |id|
      damage = DamageType.find(id)
      lot_item.damage_types << damage
    end

    p '-------------------------------------------------+++-'
    p lot_item.to_json

    if lot_item.save
      render json: lot_item, status: :ok
    else
      render json: {'message': lot_item.errors.full_messages}, status: :internal_server_error
    end
  end


  def destroy
    return unless user_logged?

    lot_item = LotItem.find( params[:id])

    if lot_item.delete
      render json: lot_item, status: 200
    else
      render json: {'message': lot_item.errors.full_message}, status: :internal_server_error
    end
  end


  def show
    return unless user_logged?
    lot_item = LotItem.find( params[:id] )

    render json: lot_item, status: :ok
  end


  def update
    return unless user_logged?

    lot_item = LotItem.find( params[:lot_item_id] )
    damage_types_id = params[:damage_types_id]

    lot_item_damage_type = LotItemDamageType.where(lot_item_id: lot_item.id)
    lot_item_damage_type.delete_all

    damage_types_id.each do |id|
      damage = DamageType.find(id)
      lot_item.damage_types << damage
    end

    destination_id = params[:destination_id]
    unless destination_id.nil? || destination_id == 'null'
      lot_item.update_attributes(:destination_id => destination_id)
    end

    render json: lot_item, status: 200
  end

  def get_all_skus
    skus = Sku.all
    render json: skus, status: 200
  end

  def get_sku
    sku = Sku.find_by(id: params[:sku_id])
    render :json => {sku: sku} , status: 200
  end

  def search_lot
    add_item = params[:add_item]

    if params[:bar_code] != "undefined"
      bar_code = params[:bar_code]
      lot_items = search_with_bar_code( bar_code, add_item )
      render json: lot_items, status: :ok
      return
    end

    if params[:lot_number] != "undefined"
      lot_number = params[:lot_number]
      lot_items = search_with_lot_number( lot_number, add_item )
      render json: lot_items, status: :ok
      return
    end

    if params[:serial_number] != "undefined"
      serial_number = params[:serial_number]
      lot_items = search_with_serial_number( serial_number, add_item )
      render json: lot_items, status: :ok
      return
    end
  end

  def change_destination
    lot_item = LotItem.find_by(id: params[:lot_item_destination][:id])
    if lot_item.update_attributes(:destination_id => params[:lot_item_destination][:destination])
      render json: {'message': 'Destino do item atualizado com sucesso.'}
    else
      render json: {'message': lot_item.errors.full_message}, status: :internal_server_error
    end
  end

  def get_stock
    lot_items = []

    unless params[:h_type_id] == 'undefined'
      items_h_type = get_stock_h_type( params[:h_type_id] )
      lot_items = lot_items + items_h_type
    end

    unless params[:manufacturer_id] == 'undefined'
      items_manufacturer = get_stock_manufacturer(lot_items, params[:manufacturer_id])
      lot_items = []
      lot_items = items_manufacturer
    end

    unless params[:model_id] == 'undefined'
      items_model = get_stock_model(lot_items, params[:model_id])
      lot_items = []
      lot_items = items_model
    end

    unless params[:lot_id] == 'undefined'
      lot = Lot.find_by(order_number: params[:lot_id])
      items_lot = get_stock_lot(lot_items, lot.id)
      lot_items = []
      lot_items = items_lot
    end

    unless params[:destination_id] == 'undefined'
      items_destination = get_stock_destination(lot_items, params[:destination_id])
      lot_items = []
      lot_items = items_destination
    end

    render json: lot_items, status: 200
  end

  #Writing in xls
  def report_xls
    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet
    sheet1.name = 'Itens de lote'

    sheet1.row(0).push('TIPO DE HARDWARE', 'FABRICANTE', 'MODELO', 'MEMÓRIA RAM', 'NÚMERO DE SÉRIE', 'ASSET TAG', 'CÓDIGO DE BARRAS', 'CATEGORIA', 'COMENTÁRIOS', 'LOCAL / TIPO DE AVARIA', 'DESCRIÇÃO DO PROCESSADOR', 'TAMANHO', 'TIPO', 'PARENT (ID)','TELA', 'WEBCAM', 'TIPO TECLADO', 'DESTINO', 'WIRELESS', 'BLUETOOTH', 'MINI DISPLAY PORT', 'HDMI', 'VGA', 'ESATA', 'TECLADO LUMINOSO', 'LEITOR BIOMÉTRICO', 'TIPO PLACA DE VÍDEO', 'NÚMERO PEDIDO VENDA')

    format = Spreadsheet::Format.new :weight => :bold,:size => 11
    sheet1.row(0).height = 30
    sheet1.row(0).default_format = format

    x = 0
    while x <= 29
      sheet1.column(x).width = 30
      x += 1
    end

    lot_items = []
    lot_items_id = params[:lot_items].split(',')
    lot_items_id.each do |lot_item_id|
      item = LotItem.find_by(id: lot_item_id)
      lot_items << item
    end

    row = 1
    lot_items.each do |line|
      processor_name = ''
      disk_size = ''
      disk_type = ''
      webcam = ''
      keyboard = ''
      destination = ''
      wireless = ''
      bluetooth = ''
      mini_display_port = ''
      hdmi = '',
      esata = '',
      vga = '',
      category = '',
      damage_type = '',
      vga_card = '',
      sales_number = ''

      unless line.processor.nil?
        processor_name = line.processor.name
      end

      unless line.disk_size.nil?
        disk_size = line.disk_size.name
      end

      unless line.disk_type.nil?
        disk_type = line.disk_type.name
      end

      case line.webcam
      when '13'
        webcam = 'Não'
      when '12'
        webcam = 'Sim'
      else
        webcam = ''
      end

      unless line.keyboard_type.nil?
        keyboard = line.keyboard_type.name
      end

      unless line.destination.nil?
        destination = line.destination.name

        sales_number = line.sales_order.order_number if line.destination.name.downcase.eql? 'vendido'
      end

      case line.wireless
      when '13'
        wireless = 'Não'
      when '12'
        wireless = 'Sim'
      else
        wireless = ''
      end

      case line.bluetooth
      when '0'
        bluetooth = 'Não'
      when '1'
        bluetooth = 'Sim'
      else
        bluetooth = ''
      end

      case line.mini_display_port
      when '13'
        mini_display_port = 'Não'
      when '12'
        mini_display_port = 'Sim'
      else
        mini_display_port = ''
      end

      case line.esata
      when '2'
        esata = 'Não'
      when '1'
        esata = 'Sim'
      else
        esata = ''
      end

      case line.hdmi
      when '13'
        hdmi = 'Não'
      when '12'
        hdmi = 'Sim'
      else
        hdmi = ''
      end

      case line.biometric_reader
      when '13'
        biometric_reader = 'Não'
      when '12'
        biometric_reader = 'Sim'
      else
        biometric_reader = ''
      end

      case line.vga
      when '13'
        vga = 'Não'
      when '12'
        vga = 'Sim'
      else
        vga = ''
      end

      unless line.category.nil?
        category = line.category.name
      end

      unless line.damage_type.nil?
        damage_type = line.damage_type.name
      end

      case line.vga_card
      when '1'
        vga_card = 'Integrada'
      when '0'
        vga_card = 'Dedicada'
      else
        vga_card = ''
      end

      sheet1.row(row).push(
        line.hardware_type.name, line.model.manufacturer.name, line.model.name, line.ram_memory,
        line.serial_number, line.asset_tag, line.bar_code, category, line.comments, damage_type,
        processor_name, disk_size, disk_type, line.parent_id, line.screen, webcam, keyboard, destination, wireless,
        bluetooth, mini_display_port, hdmi, vga, esata, line.bright_keyboard, biometric_reader, vga_card, sales_number)
      sheet1.row(row).height = 20
      row += 1
    end

    file_contents = StringIO.new
    time = Time.now()
    time.strftime("%b-%m-%Y-%H:M")
    t = Tempfile.new("Listagem_de_Items-#{time}.xlsx")
    book.write t.path
    send_file t.path , :type => 'application/excel'
  end

  private
  def lot_item_params
    params.require(:lot_item).permit(
      :hardware_type_id, :model_id, :ram_memory, :serial_number, :asset_tag,
      :category_id, :comments, :processor_id, :disk_type_id,
      :disk_size_id, :parent_id, :screen, :webcam, :keyboard_type_id, :wireless,
      :bluetooth, :mini_display_port, :hdmi, :vga, :esata, :bright_keyboard,
      :destination_id, :bar_code, :biometric_reader, :vga_card
    )
  end

  def search_with_bar_code( bar_code, add_item )

    if add_item === 'true'
      lot_items = LotItem.where(bar_code: bar_code).where.not(destination_id: 2)
      return lot_items
    end
    if add_item == 'false'
      lot_items = LotItem.where(bar_code: bar_code)
      return lot_items
    end
    if add_item == 'devolution'
      lot_items = LotItem.where(["bar_code = ? and destination_id = ?", bar_code, 2])
      return lot_items
    end
  end

  def search_with_lot_number( lot_number, add_item )
    if add_item == 'true'
      lot_items = LotItem.where(lot_id: lot_number).where.not(destination_id: 2)
      return lot_items
    end
    if add_item == 'false'
      lot_items = LotItem.where(lot_id: lot_number)
      return lot_items
    end
  end

  def search_with_serial_number( serial_number, add_item )
    if add_item == 'true'
      lot_items = LotItem.where(serial_number: serial_number).where.not(destination_id: 2)
      return lot_items
    end
    if add_item == 'false'
      lot_items = LotItem.where(serial_number: serial_number)
      return lot_items
    end
    if add_item == 'devolution'
      lot_items = LotItem.where(["serial_number = ? and destination_id = ?", serial_number, 2])
      return lot_items
    end
  end

  #methods of query stock
  def get_stock_h_type( params )
    items_h_type = LotItem.where(hardware_type_id: params)
    return items_h_type
  end

  def get_stock_manufacturer(lot_items, params)
    models = Model.where(manufacturer_id: params)

    if lot_items.size == 0
      models.each do |model|
        item = LotItem.where(model_id: model.id)
        lot_items = lot_items + item
      end
    else
      item_manufacturers = []

      lot_items.each do |item|
        models.each do |model|
          if item.model_id === model.id
            item_manufacturers << item
          end
        end
      end
      lot_items = []
      lot_items = lot_items + item_manufacturers
    end
    return lot_items
  end

  def get_stock_model(lot_items, params)
    if lot_items.size == 0
      items_model = LotItem.where(model_id: params)
      lot_items = lot_items + items_model
    else
      items_model = []

      lot_items.each do |item|
        if item.model_id === params.to_i
          items_model << item
        end
      end
      lot_items = []
      lot_items = lot_items + items_model
    end
    return lot_items
  end

  def get_stock_lot (lot_items, params)
    if lot_items.size === 0
      lot_items = LotItem.where(lot_id: params)
    else
      items_lot = []
      lot_items.each do |item|
        if item.lot_id === params.to_i
          items_lot << item
        end
      end
      lot_items = []
      lot_items = lot_items + items_lot
    end
    return lot_items
  end

  def get_stock_destination (lot_items, params)
    if lot_items.size === 0
      lot_items = LotItem.where(destination_id: params)
    else
      items_destination = []

      lot_items.each do |item|
        if item.destination_id === params.to_i
          items_destination << item
        end
      end
      lot_items = []
      lot_items = lot_items + items_destination
    end
    return lot_items
  end
end
