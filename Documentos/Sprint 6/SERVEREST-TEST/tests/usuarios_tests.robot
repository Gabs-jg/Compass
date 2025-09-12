*** Settings ***
Documentation  Testes do endpoint /usuarios (US001)
Resource       ../keywords/usuarios_keywords.robot
Resource       ../support/common/common.robot
Resource       ../support/fixtures/dynamics.robot
Suite Setup    Criar Sessao

*** Test Cases ***
Cenário - GET Todos Os Usuários 200
    [TAGS]  GET  usuarios
    GET Endpoint /usuarios
    Validar Status Code "200"

Cenário - POST Cadastrar Usuário Válido 201
    [TAGS]  POST  usuarios  smoke
    ${payload}=  Criar Dados Usuario Valido
    POST Endpoint /usuarios  ${payload}
    Validar Status Code "201"
    Validar Se Mensagem Contem "sucesso"
    
Cenário - POST Criar Usuário Duplicado 400
    [TAGS]  POST  usuarios  regressao
    ${email}=  Gerar Email Unico  dup
    Criar Dados Usuario Com Email  ${email}
    ${response}=   POST On Session   serverest   ${USUARIOS_ENDPOINT}   json=${payload}   expected_status=201
    Log To Console    Usuário criado: ${response.json()}
    Validar Status Code "201"
    # Tentar Criar Novamente Com O Mesmo E-mail
    Criar Dados Usuario Com Email  ${email}
    ${dup_response}=   POST On Session   serverest   ${USUARIOS_ENDPOINT}   json=${payload}   expected_status=400
    Log To Console    Tentativa de usuário duplicado: ${dup_response.json()}
    Should Be Equal As Integers    ${dup_response.status_code}    400
    Should Contain    ${dup_response.json()["message"]}    Este email já está sendo usado

Cenário - POST Criar Usuário Com Provedor Proibido (gmail) 400
    [TAGS]  POST  usuarios  regressao
    ${timestamp}    Get Time    epoch
    ${email}        Set Variable    usuario_proibido_${timestamp}@gmail.com

    # Criar payload usando email proibido único
    ${nome}         FakerLibrary.Name
    ${payload}      Create Dictionary    nome=${nome}    email=${email}    password=${DEFAULT_PASSWORD}    administrador=${DEFAULT_ADMIN}
    Set Test Variable    ${payload}

    ${response}     POST Endpoint /usuarios    ${payload}
    Validar Status Code "400"
    Log To Console    POST /usuarios response: ${response.content}

Cenário - POST Criar Usuário Com Provedor Proibido (hotmail) 400
    [TAGS]  POST  usuarios  regressao
    ${timestamp}    Get Time    epoch
    ${email}        Set Variable    usuario_proibido_${timestamp}@hotail.com

    # Criar payload usando email proibido único
    ${nome}         FakerLibrary.Name
    ${payload}      Create Dictionary    nome=${nome}    email=${email}    password=${DEFAULT_PASSWORD}    administrador=${DEFAULT_ADMIN}
    Set Test Variable    ${payload}

    ${response}     POST Endpoint /usuarios    ${payload}
    Validar Status Code "400"
    Log To Console    POST /usuarios response: ${response.content}
    

Cenário - POST Criar Usuario Com Senha Inválida (<5) 400
    [TAGS]  POST  usuarios
    ${timestamp}    Get Time    epoch
    ${email}        Set Variable    usuario_teste_${timestamp}@teste.com
    ${nome}     FakerLibrary.Name
    ${payload}  Create Dictionary  nome=${nome}  email=${email}  password=123  administrador=${DEFAULT_ADMIN}
    ${response}  POST Endpoint /usuarios  ${payload}
    Validar Status Code "400"
    Log To Console    POST /usuarios response: ${response.content}

Cenário - POST Criar Usuario Com Senha Inválida (>10) 400
   [TAGS]  POST  usuarios
    ${timestamp}    Get Time    epoch
    ${email}        Set Variable    usuario_teste_${timestamp}@teste.com
    ${nome}     FakerLibrary.Name
    ${payload}  Create Dictionary  nome=${nome}  email=${email}  password=12345678901  administrador=${DEFAULT_ADMIN}
    ${response}  POST Endpoint /usuarios  ${payload}
    Validar Status Code "400"
    Log To Console    POST /usuarios response: ${response.content}

Cenário - POST Criar Usuário Com E-mail Inválido 400
    [TAGS]  POST  usuarios
    # Gerar dados
    ${nome}=       FakerLibrary.Name
    ${email}=      Set Variable    invalid-email
    ${password}=   Set Variable    senha123

    # Criar payload
    ${payload}=    Create Dictionary    nome=${nome}    email=${email}    password=${password}    administrador=${DEFAULT_ADMIN}

    # Fazer POST e permitir status 400
    ${response}=   POST On Session    serverest    ${USUARIOS_ENDPOINT}    json=${payload}    expected_status=400

    # Log para debug
    Log To Console    POST /usuarios response: ${response.content}

    # Validar status code
    Should Be Equal As Integers    ${response.status_code}    400

    # Validar mensagem específica do e-mail
    Should Contain    ${response.json()["email"]}    email deve ser um email válido

Cenário - PUT Atualizar Usuário Inexistente Via PUT Cria Novo Usuário(200/201)
    [Tags]  PUT  usuarios
    # Gerar email válido para API
    ${rand} =  Generate Random String  8  [LETTERS][LOWER]
    ${email} =  Set Variable  put${rand}@serverest.dev

    # Criar payload do usuário
    ${payload} =  Create Dictionary
    ...  nome=UsuarioPut
    ...  email=${email}
    ...  password=senha123
    ...  administrador=true

    # Gerar ID falso para PUT
    ${fake_id} =  Generate Random String  24  [LETTERS][DIGITS]
    PUT Endpoint /usuarios  ${fake_id}  ${payload}
    Set Global Variable  ${response}

    # Log para debug
    Log To Console  PUT /usuarios/${fake_id} response: ${response.content}

    # Log dependendo do status
    Run Keyword If  ${response.status_code} == 201  Log To Console  "PUT Criou Novo Usuário (201)"
    Run Keyword If  ${response.status_code} == 200  Log To Console  "PUT Atualizou Usuário (200)"
    Should Be True  ${response.status_code} in [200, 201]

Cenário - DELETE Usuário Inexistente 200
    [TAGS]  DELETE  usuarios
    ${fake_id}=  Generate Random String  24  [LETTERS][DIGITS]
    DELETE Endpoint /usuarios  ${fake_id}
    Validar Status Code "200"
    Should Contain  ${response.json()["message"]}  Nenhum registro excluído
