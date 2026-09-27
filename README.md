# TODO Elixir

Uma API REST de TODO List feita em [Elixir](https://elixir-lang.org/)

| :placard: Vitrine.Dev |                                                           |
| --------------------- | --------------------------------------------------------- |
| :sparkles: Nome       | **TODO**                                                  |
| :label: Tecnologias   | Elixir, Phoenix, Ecto, PostgreSQL                         |
| :rocket: URL          | [Documentação](https://todo-api-elixir.onrender.com/docs) |

[![Elixir](https://img.shields.io/badge/Elixir-4B275F?logo=elixir&logoColor=fff&style=for-the-badge)](https://elixir-lang.org/)
[![Phoenix Framework](https://img.shields.io/badge/Phoenix%20Framework-FD4F00?logo=phoenixframework&logoColor=fff&style=for-the-badge)](https://www.phoenixframework.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?logo=postgresql&logoColor=fff&style=for-the-badge)](https://www.postgresql.org/)

## Como Usar

1. Clone o repositório

```bash
git clone https://github.com/matheusgondra/todo_elixir.git
```

2. Defina as variáveis de ambiente descritas no `.env.example`

```bash
DB_USER=dev
DB_PASSWORD=dev
DB_HOST=localhost
DB_NAME=todo_dev
MIX_ENV=dev
PORT=4000
JWT_SECRET_KEY=secret
```

3. Instale as dependencias e conexão com o banco de dados:

```bash
mix setup
```

4. Inicie o projeto

```bash
mix phx.server
```
