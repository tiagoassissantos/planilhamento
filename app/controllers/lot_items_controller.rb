class LotItemsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    return unless user_logged?

    lot_items = LotItem.where(lot_id: params[:lot_id])

    render json: lot_items, status: :ok
  end


  def create
    return unless user_logged?

    lot = Lot.find( params[:lot_id] )
    lot_item = lot.lot_items.new( lot_item_params )

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

    lot_item = LotItem.find( params[:id] )

    if lot_item.update( lot_item_params )
      render json: lot_item, status: 200
    else
      render json: {'message': lot_item.errors.full_message}, status: :internal_server_error
    end
  end

  def get_all_skus
    skus = Sku.select('code', 'id').all
    render json: skus, status: 200
  end

  def get_sku
    sku = Sku.find_by(id: params[:sku_id])
    render json: sku, status: 200
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
      item_h_type = LotItem.where(hardware_type_id: params[:h_type_id])
      lot_items = lot_items + item_h_type
    end

    unless params[:manufacturer_id] == 'undefined'
      models = Model.where(manufacturer_id: params[:manufacturer_id])
      item_manufacturers = []

      models.each do |model|
        item = LotItem.where(model_id: model.id)
        item_manufacturers = item_manufacturers + item
      end

      item_manufacturers.each do |item_manufacturer|
        unless lot_items.include?(item_manufacturer)
          lot_items << item_manufacturer
        end
      end
    end

    unless params[:model_id] == 'undefined'
      item_models = LotItem.where(model_id: params[:model_id])

      item_models.each do |item_model|
        unless lot_items.include?(item_model)
          lot_items << item_model
        end
      end
    end

    render json: lot_items, status: 200
  end

  #Writing in xls
  def report_xls
    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet
    sheet1.name = 'Itens de lote'

    sheet1.row(0).push('TIPO DE HARDWARE', 'FABRICANTE', 'MODELO', 'MEMÓRIA RAM', 'NÚMERO DE SÉRIE', 'ASSET TAG', 'CÓDIGO DE BARRAS', 'CATEGORIA', 'COMENTÁRIOS', 'LOCAL / TIPO DE AVARIA', 'DESCRIÇÃO DO PROCESSADOR', 'TAMANHO', 'TIPO', 'PARENT (ID)',
    'TELA', 'WEBCAM', 'TIPO TECLADO', 'DESTINO', 'WIRELESS', 'BLUETOOTH', 'MINI DISPLAY PORT', 'HDMI', 'ESATA', 'TECLADO LUMINOSO', 'LEITOR BIOMÉTRICO', 'TIPO PLACA DE VÍDEO')

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

      unless line.processor.nil?
        processor_name = line.processor.name
      end

      unless line.disk_size.nil?
        disk_size = line.disk_size_name.name
      end

      unless line.disk_type.nil?
        disk_type = line.disk_type.name
      end

      if line.webcam.nil? || line.webcam == 13
        webcam = 'Não Contem WebCam'
      else
        webcam = 'Contem WebCam'
      end

      unless line.keyboard_type.nil?
        keyboard = line.keyboard_type.name
      end

      unless line.destination.nil?
        destination = line.destination.name
      end

      if line.wireless.nil? || line.wireless == 13
        wireless = 'Não Contem wireless'
      else
        wireless = 'Contem wireless'
      end

      if line.bluetooth.nil? || line.bluetooth == 0
        bluetooth = 'Não Contem bluetooth'
      else
        bluetooth = 'Contem bluetooth'
      end

      if line.mini_display_port.nil? || line.bluetooth == 0
        mini_display_port = 'Não Contem mini display port'
      else
        mini_display_port = 'Contem mini display port'
      end

      if line.esata.nil? || line.esata == 13
        esata = 'Não Contem esata'
      else
        esata = 'Contem esata'
      end

      if line.hdmi.nil? || line.hdmi == 13
        hdmi = 'Não Contem hdmi'
      else
        hdmi = 'Contem hdmi'
      end

      if line.biometric_reader.nil? || line.biometric_reader == 13
        biometric_reader = 'Não Contem leitor biometrico'
      else
        biometric_reader = 'Contem leitor biometrico'
      end

      if line.vga.nil? || line.vga == 13
        vga = 'Não Contem leitor vga'
      else
        vga = 'Contem placa de vídeo'
      end

      sheet1.row(row).push(
        line.hardware_type.name, line.model.manufacturer.name, line.model.name, line.ram_memory,
        line.serial_number, line.asset_tag, line.bar_code, line.category.name, line.comments, line.damage_type.name,
        processor_name, disk_size, disk_type, line.parent_id, line.screen, webcam, keyboard, destination, wireless,
        bluetooth, mini_display_port, hdmi, esata, line.bright_keyboard, biometric_reader, vga)
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
      :category_id, :comments, :damage_type_id, :processor_id, :disk_type_id,
      :disk_size_id, :parent_id, :screen, :webcam, :keyboard_type_id, :wireless,
      :bluetooth, :mini_display_port, :hdmi, :vga, :esata, :bright_keyboard,
      :destination_id, :bar_code, :biometric_reader, :vga_card
    )
  end

  def search_with_bar_code( bar_code, add_item )
    if add_item == 'true'
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
end
