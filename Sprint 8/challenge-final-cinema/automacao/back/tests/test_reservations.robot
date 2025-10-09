*** Settings ***
Resource    ../resources/keywords/reservations_keywords.robot

*** Test Cases ***
Criar Reserva
    ${payload}=    Create Dictionary    session_id=1    assentos=[1,2]
    ${response}=    Criar Reserva    ${payload}
    Should Be Equal As Integers    ${response.status_code}    201

Visualizar Minhas Reservas
    ${response}=    Visualizar Minhas Reservas
    Should Be Equal As Integers    ${response.status_code}    200

Atualizar Status da Reserva
    ${reservation_id}=    Set Variable    1
    ${payload}=    Create Dictionary    status=confirmada
    ${response}=    Atualizar Status da Reserva    ${reservation_id}    ${payload}
    Should Be Equal As Integers    ${response.status_code}    200

Deletar Reserva
    ${reservation_id}=    Set Variable    1
    ${response}=    Deletar Reserva    ${reservation_id}
    Should Be Equal As Integers    ${response.status_code}    200
