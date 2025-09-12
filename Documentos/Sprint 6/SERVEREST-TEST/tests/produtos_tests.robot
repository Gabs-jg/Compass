*** Settings ***
Documentation  Testes do endpoint /produtos (US003)
Resource       ../keywords/produtos_keywords.robot
Resource       ../keywords/login_keywords.robot
Resource       ../support/fixtures/dynamics.robot
Resource    ../keywords/usuarios_keywords.robot
Suite Setup    Criar Sessao

*** Test Cases ***
Cenário - Criar Produto Válido 201
    [Tags]    POSTPRODUTO    smoke
    ${payload_usuario}=    Criar Dados Usuario Valido
    POST Endpoint /usuarios    ${payload_usuario}
    Validar Status Code "201"
    ${email}=    Set Variable    ${payload_usuario["email"]}
    ${senha}=    Set Variable    ${payload_usuario["password"]}
    POST Endpoint /login    ${email}    ${senha}
    Validar Status Code "200"
    ${token}=    Set Variable    ${response.json()["authorization"]}
    ${payload_produto}=    Criar Dados Produto Valido
    POST Endpoint /produtos    ${payload_produto}    ${token}
    Validar Status Code "201"
    Validar Ter Criado Produto

Cenário - Criar Produto Duplicado 400
    [Tags]  POSTPRODUTO  regressao
    # Criar Usuário
    ${payload}=  Criar Dados Usuario Valido
    POST Endpoint /usuarios  ${payload}
    Validar Status Code "201"

    # Login
    ${email}=  Set Variable  ${payload["email"]}
    ${senha}=  Set Variable  ${payload["password"]}
    POST Endpoint /login  ${email}  ${senha}
    Validar Status Code "200"
    ${token}=  Set Variable  ${response.json()["authorization"]}

    # Criar Produto
    ${nome_prod}=  Generate Random String  6  [LETTERS]
    ${payload_prod}  Create Dictionary  nome=${nome_prod}  preco=10  descricao=x  quantidade=1
    &{header}=  Create Dictionary  Authorization=${token}

    ${response}=    POST On Session    serverest    ${PRODUTOS_ENDPOINT}    json=${payload_prod}    headers=${header}    expected_status=201
    Log To Console    Produto criado: ${response.json()}
    Validar Status Code "200"

    # Tentar criar o mesmo produto novamente (duplicado)
    ${payload_dup}=   Create Dictionary   nome=${nome_prod}   preco=10   descricao=x   quantidade=1
    ${response_dup}=  POST On Session    serverest    ${PRODUTOS_ENDPOINT}    json=${payload_dup}    headers=${header}    expected_status=400
    Log To Console    Tentativa de produto duplicado: ${response_dup.json()}
    
    Should Be Equal As Integers    ${response_dup.status_code}    400

    # Validar mensagem de erro
    Should Contain    ${response_dup.json()["message"]}    Já existe produto com esse nome

Cenário - Tentar Criar Produto Sem Autenticação 401
    [TAGS]  POSTPRODUTO
    ${payload}=  Criar Dados Produto Valido
    Log To Console  Dados do produto: ${payload}

    ${response}=  POST On Session  serverest  /produtos  json=${payload}  expected_status=any
    Log To Console  Tentativa sem token: ${response.json()}

    Should Be Equal As Integers  ${response.status_code}  401
    Should Contain  ${response.json()["message"]}  Token de acesso ausente

