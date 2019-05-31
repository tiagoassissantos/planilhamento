# Administrator User
User.create email: 'admin@ct.com', name: 'Administrador', cpf: '', role: 'admin', :password => '1234zxcv', :password_confirmation => '1234zxcv'


####### Hardware Types #######
=begin 
monitor =  HardwareType.find_or_create_by id: 1, name: 'Monitor', can_delete: false
desktop =  HardwareType.find_or_create_by id: 2, name: 'Desktop', can_delete: false
server =   HardwareType.find_or_create_by id: 3, name: 'Servidor', can_delete: false
notebook = HardwareType.find_or_create_by id: 4, name: 'Notebook', can_delete: false
celular =  HardwareType.find_or_create_by id: 5, name: 'Celular', can_delete: false
tablet =   HardwareType.find_or_create_by id: 6, name: 'Tablet', can_delete: false
switch =   HardwareType.find_or_create_by id: 7, name: 'Switch', can_delete: false
hdd =      HardwareType.find_or_create_by id: 8, name: 'HD', can_delete: false
ssd =      HardwareType.find_or_create_by id: 9, name: 'SSD', can_delete: false
oters =    HardwareType.find_or_create_by id: 10, name: 'Outros', can_delete: false


####### Damege Types - NOTEBOOK #######
DamageType.create name: 'Placa Mãe - NÃO LIGA', hardware_type: notebook
DamageType.create name: 'Placa Mãe - FAN ERROR', hardware_type: notebook
DamageType.create name: 'Placa Mãe - PORTA USB QUEBRADA', hardware_type: notebook
DamageType.create name: 'Placa Mãe - PORTA HDMI QUEBRADA', hardware_type: notebook
DamageType.create name: 'Placa Mãe - PORTA DISPLAYPORT', hardware_type: notebook
DamageType.create name: 'Placa Mãe - VGA QUEBRADO', hardware_type: notebook
DamageType.create name: 'Placa Mãe - SAÍDA LAN DANIFICADA', hardware_type: notebook
DamageType.create name: 'Placa Mãe - SAÍDA LAN COM FOLGA', hardware_type: notebook
DamageType.create name: 'Placa Mãe - CONECTOR DA BATERIA DANIFICADO', hardware_type: notebook
DamageType.create name: 'Placa Mãe - PORTA DE ENERGIA DANIFICADA', hardware_type: notebook
DamageType.create name: 'Placa Mãe - SPEAKER DANIFICADO', hardware_type: notebook
DamageType.create name: 'Carcaça - MOLDURA DO LCD TRINCADA', hardware_type: notebook
DamageType.create name: 'Carcaça - BASE TRINCADA', hardware_type: notebook
DamageType.create name: 'Carcaça - BASE DO LCD TRINCADA', hardware_type: notebook
DamageType.create name: 'Carcaça - TECLADO APAGADO', hardware_type: notebook
DamageType.create name: 'Carcaça - TECLADO QUEBRADO', hardware_type: notebook
DamageType.create name: 'Carcaça - TOUCHPAD QUEBRADO', hardware_type: notebook
DamageType.create name: 'Carcaça - TOUCHPAD MANCHADO', hardware_type: notebook
DamageType.create name: 'Carcaça - ESTRUTURA QUEBRADA', hardware_type: notebook
DamageType.create name: 'Carcaça - ESTRUTURA MANCHADA', hardware_type: notebook
DamageType.create name: 'Carcaça - BATERIA NÃO CARREGA', hardware_type: notebook
DamageType.create name: 'Carcaça - SLOT DA BATERIA DANIFICADA', hardware_type: notebook
DamageType.create name: 'Display - LCD NÃO LIGA', hardware_type: notebook
DamageType.create name: 'Display - MANCHAS NA TELA', hardware_type: notebook
DamageType.create name: 'Display - TELA TRINCADA', hardware_type: notebook
DamageType.create name: 'OUTROS', hardware_type: notebook


####### Damege Types - DESKTOP #######
DamageType.create name: 'Placa Mãe - NÃO LIGA', hardware_type: desktop
DamageType.create name: 'Placa Mãe - FONTE QUEIMADA', hardware_type: desktop
DamageType.create name: 'Placa Mãe - PORTA USB QUEBRADA', hardware_type: desktop
DamageType.create name: 'Placa Mãe - PORTA HDMI QUEBRADA', hardware_type: desktop
DamageType.create name: 'Placa Mãe - PORTA DISPLAYPORT', hardware_type: desktop
DamageType.create name: 'Placa Mãe - VGA QUEBRADO', hardware_type: desktop
DamageType.create name: 'Placa Mãe - SAÍDA LAN DANIFICADA', hardware_type: desktop
DamageType.create name: 'Carcaça - ESTRUTURA QUEBRADA OU MANCHADA', hardware_type: desktop
DamageType.create name: 'OUTROS', hardware_type: desktop


####### Damege Types - SERVIDOR #######
DamageType.create name: 'Placa Mãe - NÃO LIGA', hardware_type: server
DamageType.create name: 'Placa Mãe - FONTE QUEIMADA', hardware_type: server
DamageType.create name: 'Placa Mãe - PORTA USB QUEBRADA', hardware_type: server
DamageType.create name: 'Placa Mãe - PORTA HDMI QUEBRADA', hardware_type: server
DamageType.create name: 'Placa Mãe - PORTA DISPLAYPORT', hardware_type: server
DamageType.create name: 'Placa Mãe - VGA QUEBRADO', hardware_type: server
DamageType.create name: 'Placa Mãe - SAÍDA LAN DANIFICADA', hardware_type: server
DamageType.create name: 'Carcaça - ESTRUTURA QUEBRADA OU MANCHADA', hardware_type: server
DamageType.create name: 'OUTROS', hardware_type: server


####### Damege Types - MONITOR #######
DamageType.create name: 'Placa - NÃO LIGA', hardware_type: monitor
DamageType.create name: 'Placa - FONTE QUEIMADA', hardware_type: monitor
DamageType.create name: 'Placa - PORTA USB QUEBRADA', hardware_type: monitor
DamageType.create name: 'Placa - PORTA HDMI QUEBRADA', hardware_type: monitor
DamageType.create name: 'Placa - PORTA DISPLAYPORT', hardware_type: monitor
DamageType.create name: 'Placa - VGA QUEBRADO', hardware_type: monitor
DamageType.create name: 'Carcaça - CARCAÇA DO MONITOR QUEBRADA', hardware_type: monitor
DamageType.create name: 'Carcaça - PEDESTAL QUEBRADO', hardware_type: monitor
DamageType.create name: 'Tela - TELA MANCHADA', hardware_type: monitor
DamageType.create name: 'Tela - TELA TRINCADA', hardware_type: monitor
DamageType.create name: 'OUTROS', hardware_type: monitor


####### Damege Types - HD #######
DamageType.create name: 'HD - NÃO LIGA', hardware_type: hdd
DamageType.create name: 'HD - SETORES COM PROBLEMAS', hardware_type: hdd
DamageType.create name: 'HD - ERRO DE LEITURA', hardware_type: hdd
DamageType.create name: 'HD - BAIXO DESEMPENHO', hardware_type: hdd
DamageType.create name: 'OUTROS', hardware_type: hdd


####### Damege Types - SSD #######
DamageType.create name: 'SSD - NÃO LIGA', hardware_type: ssd
DamageType.create name: 'SSD - ERRO DE LEITURA', hardware_type: ssd
DamageType.create name: 'SSD - BAIXO DESEMPENHO', hardware_type: ssd
DamageType.create name: 'SSD - SETORES COM PROBLEMAS', hardware_type: ssd
DamageType.create name: 'OUTROS', hardware_type: ssd
=end