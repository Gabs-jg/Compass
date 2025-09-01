*** Settings ***
Documentation    Suíte de testes da API Restful Booker. Contém cenários de criação, busca, atualização e deleção de bookings.
Resource  ../resources/api_booker_keywords.robot

*** Test Cases ***
Cenário 01: POST Criar Token 200
    [Documentation]  Verifica se é possível gerar um token de autenticação com usuário e senha válidos.
    Criar Sessao
    Criar Token
    Validar Status Code "200"

Cenário 02: POST Criar Booking 200
    [Documentation]  Cria um novo booking e valida se o status code retornado é 200.
    Criar Sessao
    Criar Booking
    Validar Status Code "200"

Cenário 03: GET Buscar Booking Específico Através do Id 200
    [Documentation]  Cria um booking e busca pelo ID para validar os dados retornados.
    Criar Sessao
    Criar Booking
    Buscar Booking Pelo Id
    Conferir Dados Retornados
    Validar Status Code "200"

Cenário 04: DELETE Deletar Booking 201
    [Documentation]  Cria um booking, deleta e valida se o status code retornado é 201.
    Criar Sessao
    Criar Sessao
    Criar Token
    Criar Booking
    Buscar Booking Pelo Id
    Conferir Dados Retornados
    Deletar Livro
    Validar Status Code "201"

Cenário: 05 PUT Atualizar Dados de Algum Booking 200
    [Documentation]  Atualiza os dados de um booking existente e verifica se as alterações foram aplicadas.
    Criar Sessao
    Criar Token
    Criar Booking
    Buscar Booking Pelo Id
    Conferir Dados Retornados
    Atualizar Dados do Livro
    Buscar Booking Pelo Id
    Conferir Dados Retornados Atualizado
    Validar Status Code "200"





