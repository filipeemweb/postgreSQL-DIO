--START TRANSACTION

CREATE TABLE IF NOT EXISTS banco (
	codigo INTEGER NOT NULL,
	nome VARCHAR(50) NOT NULL,
	ativo BOOLEAN NOT NULL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- or NOW()
	PRIMARY KEY (codigo)
);

CREATE TABLE IF NOT EXISTS agencia (
	codigo_banco INTEGER NOT NULL,
	numero INTEGER NOT NULL,
	nome VARCHAR(80) NOT NULL,
	ativo BOOLEAN NOT NULL,
	data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (codigo_banco, numero),
	FOREIGN KEY (codigo_banco) REFERENCES Banco (codigo)
);

CREATE TABLE IF NOT EXISTS cliente (
	codigo BIGSERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	email VARCHAR(250) NOT NULL,
	ativo BOOLEAN NOT NUlL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS conta_corrente (
	banco_codigo INTEGER NOT NULL,
	agencia_numero INTEGER NOT NULL,
	numero BIGINT NOT NULL,
	digito SMALLINT NOT NULL,
	codigo_cliente BIGINT NOT NULL,
	ativo BOOLEAN NOT NUlL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (banco_codigo, agencia_numero, numero, digito, codigo_cliente),
	FOREIGN KEY (banco_codigo, agencia_numero) REFERENCES agencia (codigo_banco, numero),
	FOREIGN KEY (codigo_cliente) REFERENCES cliente (codigo)
);

CREATE TABLE IF NOT EXISTS tipo_transacao (
	id SMALLSERIAL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	ativo BOOLEAN NOT NUlL DEFAULT TRUE,
	data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS cliente_transacoes (
	id BIGSERIAL PRIMARY KEY,
	banco_codigo INTEGER NOT NULL,
	agencia_numero INTEGER NOT NULL, 
	conta_corrente_numero BIGINT NOT NULL, 
	conta_corrente_digito SMALLINT NOT NULL, 
	codigo_cliente BIGINT NOT NULL,
	tipo_transacao_id SMALLINT NOT NULL,
	valor NUMERIC(15,2) NOT NULL,
	data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (banco_codigo, agencia_numero, conta_corrente_numero, conta_corrente_digito, codigo_cliente) REFERENCES conta_corrente (banco_codigo, agencia_numero, numero, digito, codigo_cliente),
	FOREIGN KEY (tipo_transacao_id) REFERENCES tipo_transacao (id)
);


--ROLLBACK
--COMMIT