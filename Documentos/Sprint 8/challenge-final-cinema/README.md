# Projeto de Automação de Testes - Cinema App

## Visão Geral

Este projeto contém testes automatizados para a aplicação "Cinema App", cobrindo tanto o backend (API) quanto o frontend (UI).

O objetivo é garantir a qualidade e o funcionamento correto das funcionalidades de autenticação, gerenciamento de filmes, sessões, reservas e usuários.

## Tecnologias Utilizadas

* **Framework de Teste**: Robot Framework
* **Testes de API (Backend)**: `RequestsLibrary`
* **Testes de UI (Frontend)**: `Browser` (powered by Playwright)
* **Bibliotecas Auxiliares**: `JSONLibrary`, `Collections`, `BuiltIn`

## Estrutura do Projeto

O projeto é dividido em dois módulos principais de automação:

automacao/ | ├── back/ | ├── resources/ | | ├── keywords/ # Keywords de alto nível (API) | | ├── base.robot # Configuração base da sessão da API | | └── variables.robot # Variáveis de ambiente (ex: BASE_URL) | ├── tests/ # Suítes de teste da API | └── results/ # Relatórios de execução (log.html, report.html, etc.) | └── front/ ├── resources/ | ├── keywords/ # Keywords de alto nível (UI) | ├── locators/ # Mapeamento de seletores (locators) | └── variables.robot # Variáveis de ambiente e credenciais ├── tests/ # Suítes de teste da UI └── results/ # Relatórios de execução (log.html, report.html, screenshots, etc.)


## Pré-requisitos

Antes de executar os testes, é necessário ter o Python e o Robot Framework instalados, juntamente com as bibliotecas necessárias.

1.  **Instalar Python** (versão 3.8 ou superior).
2.  **Instalar as bibliotecas Robot Framework:**
    ```bash
    pip install robotframework
    pip install robotframework-browser
    pip install robotframework-requests
    pip install robotframework-jsonlibrary
    ```
3.  **Inicializar a biblioteca Browser:**
    (Necessário na primeira execução para baixar os navegadores)
    ```bash
    rfbrowser init
    ```

## Como Executar os Testes

Os testes podem ser executados separadamente para backend e frontend.

### Executando Testes de Backend (API)

Execute os comandos a partir do diretório raiz `challenge-final-cinema/`.

```bash
# Executar todas as suítes de API
robot automacao/back/tests/

# Executar uma suíte específica (ex: autenticação)
robot automacao/back/tests/test_auth.robot
Executando Testes de Frontend (UI)
Execute os comandos a partir do diretório raiz challenge-final-cinema/.


# Executar todas as suítes de UI
robot automacao/front/tests/

# Executar uma suíte específica (ex: autenticação)
robot automacao/front/tests/auth_tests.robot
Visualizando os Resultados
Os relatórios de execução são gerados nos respectivos diretórios results/ de cada módulo (back/ e front/).

report.html: Relatório de alto nível com estatísticas.

log.html: Log detalhado passo a passo da execução.

output.xml: Saída XML bruta.

browser/screenshot/: (Apenas no frontend) Capturas de tela tiradas automaticamente em caso de falha.

Análise da Última Execução (Baseado nos Arquivos de Resultados)
Abaixo está uma análise baseada nos arquivos output.xml fornecidos.

Backend (API)
Total de Testes: 33

Passaram: 14

Falharam: 19

Suítes com Falhas: Test Movies, Test Reservations, Test Sessions, Test Theaters, Test Users.

Suítes com Sucesso: Test Auth.

Análise das Falhas (Backend):

As falhas parecem ser sistemáticas, indicando problemas nos dados de teste, configuração dos endpoints, ou escopo de autenticação:

Test Movies (4 Falhas):

Criar Filme falhou com HTTPError: 400 Client Error: Bad Request. A resposta da API indica falha de validação para campos obrigatórios que não foram fornecidos no teste (como releaseDate, classification, duration, synopsis). O teste está enviando apenas title, director e year.

As falhas subsequentes (Visualizar, Atualizar, Deletar) ocorrem porque o movie_id não foi obtido (definido como None).

Test Reservations (4 Falhas):

Criar Reserva falhou na keyword Criar Usuario Se Não Existir com HTTPError: 400 Bad Request. A resposta da API indica que o campo name é obrigatório, mas o payload do teste envia apenas email, password e role.

As falhas subsequentes ocorrem por dependência dos dados que falharam na criação (ex: ${RESERVATION_ID} não foi definido).

Test Sessions & Test Theaters (8 Falhas):

Todos os testes que exigem autenticação de admin (Criar, Atualizar, Deletar) falharam com HTTPError: 401 Client Error: Unauthorized.

O log indica que o token de autorização estava sendo enviado como Bearer None. Isso sugere que o ${AUTH_TOKEN} (definido no Test Movies ou Test Users) não está persistindo entre as suítes de teste.

Test Users (3 Falhas):

Criar Usuario Para Teste falhou com HTTPError: 404 Client Error: Not Found for url: http://localhost:3000/api/v1/users. Isso sugere que a rota da API (/api/v1/users) pode estar incorreta ou desabilitada.

Os testes Atualizar Usuario Existente e Deletar Usuario Existente falharam porque a variável ${USER_ID} não foi encontrada, pois a criação falhou.

Frontend (UI)
Total de Testes: 13

Passaram: 8

Falharam: 5

Suítes com Falhas: Reservations Tests, Sessions Tests.

Suítes com Sucesso: Auth Tests, Movies Tests.

Análise das Falhas (Frontend):

As falhas no frontend parecem estar relacionadas a timeouts e inconsistências nos seletores (locators):

Reservations Tests (4 Falhas):

Todos os 4 testes (US-RESERVATION-001 a US-RESERVATION-004) falharam na keyword Login Usuario.

O erro é um TimeoutError ao tentar preencher o campo de email: locator.fill: Timeout 10000ms exceeded. Call log: - waiting for locator('input[name="email"]').

Causa Raiz: Há uma inconsistência de locators. Os testes de auth_tests.robot (que passam) usam id=email. Os testes de reservations_tests.robot (que falham) usam css=input[name="email"]. As capturas de tela (fail-screenshot-1.png a 4.png) mostram a página de login, confirmando que o problema é o seletor.

Sessions Tests (1 Falha):

US-SESSION-001 falhou na keyword Acessar Detalhes Do Filme.

O erro foi um TimeoutError ao esperar pelo botão de detalhes: locator.waitFor: Timeout 10000ms exceeded. Call log: - waiting for locator('button.view-details').

A captura de tela (fail-screenshot-5.png) mostra a página de filmes, indicando que o seletor css=button.view-details pode estar incorreto ou o elemento não está visível.