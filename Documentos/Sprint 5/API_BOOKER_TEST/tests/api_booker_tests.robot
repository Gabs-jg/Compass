*** Settings ***
Documentation    Suíte de testes da API Restful Booker
...              Contém cenários de criação, busca, atualização e deleção de bookings.
Resource         ../resources/api_booker_keywords.robot
Suite Setup      Criar Sessao
Test Tags        api    restful-booker

*** Test Cases ***
Criar Token Com Credenciais Válidas
    [Documentation]    Verifica se é possível gerar um token de autenticação com usuário e senha válidos.
    [Tags]             auth    smoke
    Criar Token
    Validar Status Code "200"

Criar Novo Booking
    [Documentation]    Cria um novo booking e valida se o status code retornado é 200.
    [Tags]             booking    crud    smoke
    Criar Booking
    Validar Status Code "200"

Buscar Booking Por ID
    [Documentation]    Cria um booking e busca pelo ID para validar os dados retornados.
    [Tags]             booking    crud
    Criar Booking
    Buscar Booking Pelo Id
    Conferir Dados Retornados
    Validar Status Code "200"

Deletar Booking Existente
    [Documentation]    Cria um booking, deleta e valida se o status code retornado é 201.
    [Tags]             booking    crud
    Criar Token
    Criar Booking
    Buscar Booking Pelo Id
    Conferir Dados Retornados
    Deletar Booking
    Validar Status Code "201"

Atualizar Dados Do Booking
    [Documentation]    Atualiza os dados de um booking existente e verifica se as alterações foram aplicadas.
    [Tags]             booking    crud
    Criar Token
    Criar Booking
    Buscar Booking Pelo Id
    Conferir Dados Retornados
    Atualizar Dados do Booking
    Buscar Booking Pelo Id
    Conferir Dados Retornados Atualizado
    Validar Status Code "200"