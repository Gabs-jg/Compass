*** Settings ***
Resource    ../base.robot

*** Keywords ***
Listar Todos Teatros
    [Arguments]    ${token}
    [Documentation]    Lista todos os teatros disponíveis
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    Get On Session    api    /theaters    headers=${headers}
    [Return]    ${response}

Criar Teatro
    [Arguments]    ${dados}    ${token}
    [Documentation]    Cria um novo teatro (admin)
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    Post On Session    api    /theaters    json=${dados}    headers=${headers}
    [Return]    ${response}

Visualizar Detalhes Teatro
    [Arguments]    ${theater_id}    ${token}
    [Documentation]    Retorna os detalhes de um teatro específico
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    Get On Session    api    /theaters/${theater_id}    headers=${headers}
    [Return]    ${response}

Atualizar Teatro Existente
    [Arguments]    ${theater_id}    ${dados}    ${token}
    [Documentation]    Atualiza as informações de um teatro existente
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    Put On Session    api    /theaters/${theater_id}    json=${dados}    headers=${headers}
    [Return]    ${response}

Deletar Teatro Existente
    [Arguments]    ${theater_id}    ${token}
    [Documentation]    Deleta um teatro existente (admin)
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    Delete On Session    api    /theaters/${theater_id}    headers=${headers}
    [Return]    ${response}
