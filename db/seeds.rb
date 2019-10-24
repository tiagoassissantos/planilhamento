# Administrator User
User.create email: 'admin@planilhamento.com.br', name: 'Administrador', cpf: '', role: 'admin', :password => '12345678', :password_confirmation => '12345678'



#FORMATS

Format.create name: 'Formato 1', sides: 1, image_name: '1'
Format.create name: 'Formato 3', sides: 2, image_name: '3'
Format.create name: 'Formato 4', sides: 3, image_name: '4'
Format.create name: 'Formato 8', sides: 3, image_name: '8'
Format.create name: 'Formato 58', sides: 2, image_name: '58'
Format.create name: 'Formato 122', sides: 1, image_name: '122'
Format.create name: 'Formato 245', sides: 4, image_name: '245'
