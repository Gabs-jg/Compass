*** Settings ***
Resource    ../base.robot

*** Keywords ***
Criar Usuario
    [Arguments]    ${dados}    ${token}
    [Documentation]    Cria um usuário novo (admin)
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}    Content-Type=application/json
    ${response}=   POST On Session    api    /users    json=${dados}    headers=${headers}
    Log To Console    Criando usuário: ${dados}
    [Return]    ${response}

Listar Todos Usuarios
    [Arguments]    ${token}
    [Documentation]    Lista todos os usuários cadastrados (admin)
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    GET On Session    api    /users    headers=${headers}
    [Return]    ${response}

Atualizar Usuario Existente
    [Arguments]    ${user_id}    ${dados}    ${token}
    [Documentation]    Atualiza os dados de um usuário específico (admin)
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}    Content-Type=application/json
    ${response}=    PUT On Session    api    /users/${user_id}    json=${dados}    headers=${headers}
    Log To Console    Atualizando usuário: ${user_id} com ${dados}
    [Return]    ${response}

Deletar Usuario Existente
    [Arguments]    ${user_id}    ${token}
    [Documentation]    Deleta um usuário específico (admin)
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    DELETE On Session    api    /users/${user_id}    headers=${headers}
    Log To Console    Deletando usuário: ${user_id}
    [Return]    ${response}
