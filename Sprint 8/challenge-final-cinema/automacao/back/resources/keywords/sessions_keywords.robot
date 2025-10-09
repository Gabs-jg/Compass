*** Settings ***
Resource    ../base.robot

*** Keywords ***
Listar Todas as Sessões
    [Documentation]    Lista todas as sessões disponíveis
    GET    /sessions
    ${response}=    Get Request    api    /sessions
    [Return]    ${response}

Criar Sessão
    [Arguments]    ${payload}
    [Documentation]    Cria uma nova sessão (admin)
    ${response}=    Post Request    api    /sessions    json=${payload}
    [Return]    ${response}

Visualizar Detalhes da Sessão
    [Arguments]    ${session_id}
    [Documentation]    Obtém os detalhes de uma sessão específica
    ${response}=    Get Request    api    /sessions/${session_id}
    [Return]    ${response}

Atualizar Sessão
    [Arguments]    ${session_id}    ${payload}
    [Documentation]    Atualiza uma sessão existente (admin)
    ${response}=    Put Request    api    /sessions/${session_id}    json=${payload}
    [Return]    ${response}

Deletar Sessão
    [Arguments]    ${session_id}
    [Documentation]    Deleta uma sessão existente (admin)
    ${response}=    Delete Request    api    /sessions/${session_id}
    [Return]    ${response}
