*** Settings ***
Resource    ../base.robot

*** Keywords ***
Criar Reserva
    [Arguments]    ${payload}
    [Documentation]    Cria uma reserva para usuário logado
    ${response}=    Post Request    api    /reservations    json=${payload}    headers=${AUTH_HEADER}
    [Return]    ${response}

Visualizar Minhas Reservas
    [Documentation]    Retorna a lista de reservas do usuário logado
    ${response}=    Get Request    api    /reservations/me    headers=${AUTH_HEADER}
    [Return]    ${response}

Atualizar Status da Reserva
    [Arguments]    ${reservation_id}    ${payload}
    [Documentation]    Atualiza o status de uma reserva (admin)
    ${response}=    Put Request    api    /reservations/${reservation_id}    json=${payload}    headers=${AUTH_HEADER}
    [Return]    ${response}

Deletar Reserva
    [Arguments]    ${reservation_id}
    [Documentation]    Deleta uma reserva (admin)
    ${response}=    Delete Request    api    /reservations/${reservation_id}    headers=${AUTH_HEADER}
    [Return]    ${response}
