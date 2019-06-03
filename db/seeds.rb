# Administrator User
User.create email: 'admin@ct.com', name: 'Administrador', cpf: '', role: 'admin', :password => '1234zxcv', :password_confirmation => '1234zxcv'


####### Hardware Types #######
monitor =  HardwareType.find_or_create_by name: 'Monitor', can_delete: false
desktop =  HardwareType.find_or_create_by name: 'Desktop', can_delete: false
server =   HardwareType.find_or_create_by name: 'Servidor', can_delete: false
notebook = HardwareType.find_or_create_by name: 'Notebook', can_delete: false
celular =  HardwareType.find_or_create_by name: 'Celular', can_delete: false
tablet =   HardwareType.find_or_create_by name: 'Tablet', can_delete: false
switch =   HardwareType.find_or_create_by name: 'Switch', can_delete: false
hdd =      HardwareType.find_or_create_by name: 'HD', can_delete: false
ssd =      HardwareType.find_or_create_by name: 'SSD', can_delete: false
others =    HardwareType.find_or_create_by name: 'Outros', can_delete: false


####### Damage Types - NOTEBOOK #######
DamageType.find_or_create_by name: 'Placa Mãe - NÃO LIGA', hardware_type: notebook
DamageType.find_or_create_by name: 'Placa Mãe - FAN ERROR', hardware_type: notebook
DamageType.find_or_create_by name: 'Placa Mãe - PORTA USB QUEBRADA', hardware_type: notebook
DamageType.find_or_create_by name: 'Placa Mãe - PORTA HDMI QUEBRADA', hardware_type: notebook
DamageType.find_or_create_by name: 'Placa Mãe - PORTA DISPLAYPORT', hardware_type: notebook
DamageType.find_or_create_by name: 'Placa Mãe - VGA QUEBRADO', hardware_type: notebook
DamageType.find_or_create_by name: 'Placa Mãe - SAÍDA LAN DANIFICADA', hardware_type: notebook
DamageType.find_or_create_by name: 'Placa Mãe - SAÍDA LAN COM FOLGA', hardware_type: notebook
DamageType.find_or_create_by name: 'Placa Mãe - CONECTOR DA BATERIA DANIFICADO', hardware_type: notebook
DamageType.find_or_create_by name: 'Placa Mãe - PORTA DE ENERGIA DANIFICADA', hardware_type: notebook
DamageType.find_or_create_by name: 'Placa Mãe - SPEAKER DANIFICADO', hardware_type: notebook
DamageType.find_or_create_by name: 'Carcaça - MOLDURA DO LCD TRINCADA', hardware_type: notebook
DamageType.find_or_create_by name: 'Carcaça - BASE TRINCADA', hardware_type: notebook
DamageType.find_or_create_by name: 'Carcaça - BASE DO LCD TRINCADA', hardware_type: notebook
DamageType.find_or_create_by name: 'Carcaça - TECLADO APAGADO', hardware_type: notebook
DamageType.find_or_create_by name: 'Carcaça - TECLADO QUEBRADO', hardware_type: notebook
DamageType.find_or_create_by name: 'Carcaça - TOUCHPAD QUEBRADO', hardware_type: notebook
DamageType.find_or_create_by name: 'Carcaça - TOUCHPAD MANCHADO', hardware_type: notebook
DamageType.find_or_create_by name: 'Carcaça - ESTRUTURA QUEBRADA', hardware_type: notebook
DamageType.find_or_create_by name: 'Carcaça - ESTRUTURA MANCHADA', hardware_type: notebook
DamageType.find_or_create_by name: 'Carcaça - BATERIA NÃO CARREGA', hardware_type: notebook
DamageType.find_or_create_by name: 'Carcaça - SLOT DA BATERIA DANIFICADA', hardware_type: notebook
DamageType.find_or_create_by name: 'Display - LCD NÃO LIGA', hardware_type: notebook
DamageType.find_or_create_by name: 'Display - MANCHAS NA TELA', hardware_type: notebook
DamageType.find_or_create_by name: 'Display - TELA TRINCADA', hardware_type: notebook
DamageType.find_or_create_by name: 'OUTROS', hardware_type: notebook


####### Damage Types - DESKTOP #######
DamageType.find_or_create_by name: 'Placa Mãe - NÃO LIGA', hardware_type: desktop
DamageType.find_or_create_by name: 'Placa Mãe - FONTE QUEIMADA', hardware_type: desktop
DamageType.find_or_create_by name: 'Placa Mãe - PORTA USB QUEBRADA', hardware_type: desktop
DamageType.find_or_create_by name: 'Placa Mãe - PORTA HDMI QUEBRADA', hardware_type: desktop
DamageType.find_or_create_by name: 'Placa Mãe - PORTA DISPLAYPORT', hardware_type: desktop
DamageType.find_or_create_by name: 'Placa Mãe - VGA QUEBRADO', hardware_type: desktop
DamageType.find_or_create_by name: 'Placa Mãe - SAÍDA LAN DANIFICADA', hardware_type: desktop
DamageType.find_or_create_by name: 'Carcaça - ESTRUTURA QUEBRADA OU MANCHADA', hardware_type: desktop
DamageType.find_or_create_by name: 'OUTROS', hardware_type: desktop


####### Damage Types - SERVIDOR #######
DamageType.find_or_create_by name: 'Placa Mãe - NÃO LIGA', hardware_type: server
DamageType.find_or_create_by name: 'Placa Mãe - FONTE QUEIMADA', hardware_type: server
DamageType.find_or_create_by name: 'Placa Mãe - PORTA USB QUEBRADA', hardware_type: server
DamageType.find_or_create_by name: 'Placa Mãe - PORTA HDMI QUEBRADA', hardware_type: server
DamageType.find_or_create_by name: 'Placa Mãe - PORTA DISPLAYPORT', hardware_type: server
DamageType.find_or_create_by name: 'Placa Mãe - VGA QUEBRADO', hardware_type: server
DamageType.find_or_create_by name: 'Placa Mãe - SAÍDA LAN DANIFICADA', hardware_type: server
DamageType.find_or_create_by name: 'Carcaça - ESTRUTURA QUEBRADA OU MANCHADA', hardware_type: server
DamageType.find_or_create_by name: 'OUTROS', hardware_type: server


####### Damage Types - MONITOR #######
DamageType.find_or_create_by name: 'Placa - NÃO LIGA', hardware_type: monitor
DamageType.find_or_create_by name: 'Placa - FONTE QUEIMADA', hardware_type: monitor
DamageType.find_or_create_by name: 'Placa - PORTA USB QUEBRADA', hardware_type: monitor
DamageType.find_or_create_by name: 'Placa - PORTA HDMI QUEBRADA', hardware_type: monitor
DamageType.find_or_create_by name: 'Placa - PORTA DISPLAYPORT', hardware_type: monitor
DamageType.find_or_create_by name: 'Placa - VGA QUEBRADO', hardware_type: monitor
DamageType.find_or_create_by name: 'Carcaça - CARCAÇA DO MONITOR QUEBRADA', hardware_type: monitor
DamageType.find_or_create_by name: 'Carcaça - PEDESTAL QUEBRADO', hardware_type: monitor
DamageType.find_or_create_by name: 'Tela - TELA MANCHADA', hardware_type: monitor
DamageType.find_or_create_by name: 'Tela - TELA TRINCADA', hardware_type: monitor
DamageType.find_or_create_by name: 'OUTROS', hardware_type: monitor


####### Damage Types - HD #######
DamageType.find_or_create_by name: 'HD - NÃO LIGA', hardware_type: hdd
DamageType.find_or_create_by name: 'HD - SETORES COM PROBLEMAS', hardware_type: hdd
DamageType.find_or_create_by name: 'HD - ERRO DE LEITURA', hardware_type: hdd
DamageType.find_or_create_by name: 'HD - BAIXO DESEMPENHO', hardware_type: hdd
DamageType.find_or_create_by name: 'OUTROS', hardware_type: hdd


####### Damage Types - SSD #######
DamageType.find_or_create_by name: 'SSD - NÃO LIGA', hardware_type: ssd
DamageType.find_or_create_by name: 'SSD - ERRO DE LEITURA', hardware_type: ssd
DamageType.find_or_create_by name: 'SSD - BAIXO DESEMPENHO', hardware_type: ssd
DamageType.find_or_create_by name: 'SSD - SETORES COM PROBLEMAS', hardware_type: ssd
DamageType.find_or_create_by name: 'OUTROS', hardware_type: ssd


####### Destinations #######
Destination.find_or_create_by name: 'Vendas'
Destination.find_or_create_by name: 'Manutenção'
Destination.find_or_create_by name: 'Reciclagem'
