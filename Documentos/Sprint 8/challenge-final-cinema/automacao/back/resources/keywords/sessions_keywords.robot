*** Settings ***
Resource    ../base.robot

*** Keywords ***
Listar Todas as Sessões
    [Documentation]    Lista todas as sessões disponíveis
    ${response}=    Get On Session    api    /sessions
    [Return]    ${response}

Criar Sessão
    [Arguments]    ${payload}    ${token}
    [Documentation]    Cria uma nova sessão (admin)
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    Post On Session    api    /sessions    json=${payload}    headers=${headers}
    [Return]    ${response}

Visualizar Detalhes da Sessão
    [Arguments]    ${session_id}
    [Documentation]    Obtém os detalhes de uma sessão específica
    ${response}=    Get On Session    api    /sessions/${session_id}
    [Return]    ${response}

Atualizar Sessão
    [Arguments]    ${session_id}    ${payload}    ${token}
    [Documentation]    Atualiza uma sessão existente (admin)
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    Put On Session    api    /sessions/${session_id}    json=${payload}    headers=${headers}
    [Return]    ${response}

Deletar Sessão
    [Arguments]    ${session_id}    ${token}
    [Documentation]    Deleta uma sessão existente (admin)
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    Delete On Session    api    /sessions/${session_id}    headers=${headers}
    [Return]    ${response}
