
use cinema;

CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome_cliente VARCHAR(100) NOT NULL,
    cpf_cliente VARCHAR(15) NOT NULL UNIQUE,
    email_cliente VARCHAR(30) NOT NULL UNIQUE,
    status_cliente ENUM('ATIVO', 'INATIVO')
);

CREATE TABLE categoria (
    id_cat INT PRIMARY KEY AUTO_INCREMENT,
    descricao_cat VARCHAR(30) NOT NULL
);

CREATE TABLE filme (
    id_filme INT PRIMARY KEY AUTO_INCREMENT,
    nome_filme VARCHAR(100) NOT NULL,
    faixa_etaria INT CHECK (faixa_etaria >= 0),
    duracao_filme INT NOT NULL,
    status_filme ENUM('EM CARTAZ', 'FORA CARTAZ'),
    id_cat INT NOT NULL,
    FOREIGN KEY (id_cat)
	REFERENCES categoria (id_cat)
);

CREATE TABLE sala (
    id_sala INT PRIMARY KEY AUTO_INCREMENT,
    descricao_sala TEXT NOT NULL,
    tipo_sala ENUM('2D', '3D', 'IMAX') DEFAULT '2D',
    capacidade_sala INT NOT NULL CHECK (capacidade_sala > 0),
    vip_sala BOOLEAN DEFAULT FALSE
);

CREATE TABLE sessao (
    id_sessao INT AUTO_INCREMENT PRIMARY KEY,
    data_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status_sessao ENUM('ABERTA', 'ENCERRADA', 'CANCELADA') DEFAULT 'ABERTA',
    id_sala INT NOT NULL,
    FOREIGN KEY (id_sala)
        REFERENCES sala (id_sala),
    id_filme INT NOT NULL,
    FOREIGN KEY (id_filme)
        REFERENCES filme (id_filme),
        unique(data_hora,id_sala) -- evita conflito de hora na mesma sala
);
create table tipo_ingresso(
id_tipo_ingresso int primary key auto_increment,
descricao_ingresso varchar(50) not null,
valor_ingresso decimal(5,2) not null check(valor_ingresso>=0)
);
create table pedido(
id_pedido int primary key auto_increment,
data_hora datetime default current_timestamp,
id_cliente int,
status_pedido enum ('aberto','pago','cancelado') default 'aberto',
foreign key (id_cliente) references cliente(id_cliente)
);

create table ingresso(
id_ingresso int primary key auto_increment,
id_pedido int not null,
id_sessao int not null,
id_tipo_ingresso int not null,
valor_pago decimal(5,2) not null,
status_ingresso enum ('reservado','pago','cancelado')default 'reservado',
foreign key (id_pedido) references pedido(id_pedido),
foreign key (id_sessao) references sessao(id_sessao),
foreign key (id_tipo_ingresso) references tipo_ingresso(id_tipo_ingresso)
);