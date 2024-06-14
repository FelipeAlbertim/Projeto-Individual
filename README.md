# Projeto Individual 🔫

## Descrição do Projeto 📝

Este projeto é uma aplicação web desenvolvida como parte de um estudo independente, com o objetivo de consolidar conhecimentos adquiridos em várias disciplinas de desenvolvimento de software. O tema escolhido foi Valorant, um popular jogo de tiro em primeira pessoa. O projeto inclui um site com informações sobre Valorant e um quiz com ranqueamento dos usuários cadastrados, integrando conceitos de front-end, back-end, priorização de requisitos e planejamento.

## Tecnologias Utilizadas 💻

### Front-End 
- **HTML**
- **CSS**
- **JavaScript**
- **ChartJS**

### Back-End
- **JavaScript**
- **Node.js**: Implementação de operações CRUD (Create, Read, Update, Delete).
- **MySQL**: Banco de dados relacional para armazenamento de informações do quiz e dos usuários.
- **API Web-data-viz**: Utilizada para consulta de dados. [Link para o repositório](https://github.com/bandTec/web-data-viz/)

### Ambiente de Desenvolvimento
- **VirtualBox**: Utilizado para virtualização do ambiente de desenvolvimento.
- **Lubuntu**: Sistema operacional utilizado na máquina virtual.

## Funcionalidades do Projeto

- **Página Informativa**: Conteúdo breve e informativo sobre o jogo Valorant.
- **Sistema de Quiz**: Quiz interativo com perguntas sobre Valorant, com armazenamento de resultados.
- **Dashboars e KPI's**: Com base na tentativa dos usuários e também na média geral de acertos, apresento gráficos e indicadores de médias e tempo de todos os usuários.
- **Ranqueamento de Usuários**: Classificação dos usuários com base nas pontuações e tempo de tentativa obtidas no quiz.
- **Operações CRUD**: Gerenciamento dos dados dos usuários e resultados do quiz.

## Estrutura do Projeto

### Diretório `public`
Contém os arquivos HTML, CSS e JavaScript para a interface do usuário.

### Diretório `src`
Contém os arquivos do servidor Node.js e os scripts para operações CRUD com o banco de dados MySQL.

### Diretório `src/database`
Scripts SQL para criação e gerenciamento do banco de dados MySQL.

## Instalação e Configuração

1. **Clone o repositório:**
    ```bash
    git clone <https://github.com/FelipeAlbertim/Projeto-Individual.git>
    ```

2. **Configuração do Back-End:**
    - Acesse o diretório `Projeto-Individual` e instale as dependências:
      ```bash
      npm install
      ```

3. **Configuração do Banco de Dados:**
    - Utilize os scripts no diretório `src/database` para criar e configurar o banco de dados MySQL.

4. **Atualize suas credenciais**
    - Atualize o arquivo `.env.dev` com suas credenciais do seu banco de dados.

5. **Execução do Servidor:**
    - Inicie o servidor Node.js:
      ```bash
      npm start
      ```

6. **Configuração do Front-End:**
    - Abra os arquivos HTML no navegador ou configure um servidor estático para servir os arquivos.

## 📬 Contato

Qualquer dúvida, melhoria ou sugestão, estou à disposição para ouvir 😁

📧 E-mail de contato: [felipe.albertim@sptech.school](mailto:felipe.albertim@sptech.school)
