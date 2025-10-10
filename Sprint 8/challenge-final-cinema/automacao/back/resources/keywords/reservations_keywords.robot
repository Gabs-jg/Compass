*** Settings ***
Resource  ../base.robot

*** Keywords ***
Criar Reserva
    [Arguments]    ${dados}    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}    Content-Type=application/json
    ${response}=   POST On Session    api    /reservations    json=${dados}    headers=${headers}
    Log To Console    Criando reserva: ${dados}
    RETURN    ${response}

Visualizar Minhas Reservas
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}    Content-Type=application/json
    ${response}=   GET On Session    api    /reservations/me    headers=${headers}
    Log To Console    Visualizando minhas reservas
    RETURN    ${response}

Atualizar Status Da Reserva
    [Arguments]    ${reservation_id}    ${dados}    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}    Content-Type=application/json
    ${response}=   PUT On Session    api    /reservations/${reservation_id}    json=${dados}    headers=${headers}
    Log To Console    Atualizando reserva: ${reservation_id}
    RETURN    ${response}

Deletar Reserva
    [Arguments]    ${reservation_id}    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}    Content-Type=application/json
    ${response}=   DELETE On Session    api    /reservations/${reservation_id}    headers=${headers}
    Log To Console    Deletando reserva: ${reservation_id}
    RETURN    ${response}

Criar Usuario Se Não Existir
    [Arguments]    ${email}    ${senha}    ${role}=user
    Criar Sessão da API
    ${payload}=    Create Dictionary    email=${email}    password=${senha}    role=${role}

    # Faz a requisição permitindo 201 ou 400 como status válidos
    ${response}=    POST On Session    api    /auth/register    json=${payload}    expected_status=201,400
    ${status_code}=    Get From Dictionary    ${response}    status_code

    Run Keyword If    '${status_code}' == 201    Log To Console    Usuário criado com sucesso
    Run Keyword If    '${status_code}' == 400    Log To Console    Usuário já existe

    Encerrar Sessão da API

