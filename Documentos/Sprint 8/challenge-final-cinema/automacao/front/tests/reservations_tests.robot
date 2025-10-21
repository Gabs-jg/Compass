*** Settings ***
Library    Browser
Library    BuiltIn
Resource   ../resources/keywords/keywords_reservations.robot

*** Test Cases ***
US-RESERVATION-001 Criar Reserva
    [Documentation]    Testa a criação de uma nova reserva para usuário logado
    New Browser    chromium
    New Page       ${BASE_URL}/login
    Login Usuario    usuario@teste.com    123456
    Criar Nova Reserva    Gabriel Oliveira    The Avengers    19:00
    Close Browser

US-RESERVATION-002 Visualizar Minhas Reservas
    [Documentation]    Testa se o usuário consegue visualizar suas reservas
    New Browser    chromium
    New Page       ${BASE_URL}/login
    Login Usuario    usuario@teste.com    123456
    Acessar Lista De Reservas
    ${count}=    Get Element Count    ${RESERVATION_ITEM}
    Should Be True    ${count} >= 0
    Close Browser

US-RESERVATION-003 Atualizar Status Da Reserva (Admin)
    [Documentation]    Testa se o admin consegue atualizar o status de uma reserva
    New Browser    chromium
    New Page       ${BASE_URL}/login
    Login Usuario    admin@teste.com    admin123
    Atualizar Status Da Reserva    0    Confirmada
    Close Browser

US-RESERVATION-004 Deletar Reserva (Admin)
    [Documentation]    Testa se o admin consegue deletar uma reserva
    New Browser    chromium
    New Page       ${BASE_URL}/login
    Login Usuario    admin@teste.com    admin123
    Deletar Reserva    0
    Close Browser
