*** Settings ***
Documentation    Keywords para gerenciar reservas na API Restful Booker
...              Inclui criação, atualização, busca e deleção de bookings.
Library          RequestsLibrary
Library          Collections

*** Variables ***
${BASE_URL}      https://restful-booker.herokuapp.com
${VALID_USER}    admin
${VALID_PASS}    password123

*** Keywords ***
Criar Sessao
    [Documentation]    Cria uma sessão HTTP com a URL base da API.
    Create Session    booker    ${BASE_URL}

Criar Token
    [Documentation]    Gera um token de autenticação na API.
    [Arguments]    ${username}=${VALID_USER}    ${password}=${VALID_PASS}
    
    ${body}=    Create Dictionary    username=${username}    password=${password}
    ${response}=    POST On Session    booker    /auth    json=${body}
    
    Set Suite Variable    ${RESPONSE}    ${response}
    Set Suite Variable    ${TOKEN}    ${response.json()["token"]}
    
    Log    Token gerado: ${TOKEN}
    RETURN    ${TOKEN}

Criar Booking
    [Documentation]    Cria uma nova reserva com dados padrão ou customizados.
    [Arguments]    &{booking_data}
    
    ${default_dates}=    Create Dictionary    checkin=2025-08-20    checkout=2025-09-01
    ${default_booking}=    Create Dictionary
    ...    firstname=teste
    ...    lastname=debooking
    ...    totalprice=${99}
    ...    depositpaid=${True}
    ...    bookingdates=${default_dates}
    ...    additionalneeds=testedebooking
    
    # Merge dados customizados com padrões
    FOR    ${key}    ${value}    IN    &{booking_data}
        Set To Dictionary    ${default_booking}    ${key}    ${value}
    END
    
    ${response}=    POST On Session    booker    /booking    json=${default_booking}
    Set Suite Variable    ${RESPONSE}    ${response}
    Set Suite Variable    ${BOOKING_ID}    ${response.json()["bookingid"]}
    
    Log    Booking ID criado: ${BOOKING_ID}

Buscar Booking Pelo Id
    [Documentation]    Busca uma reserva específica pelo ID.
    [Arguments]    ${booking_id}=${BOOKING_ID}
    
    ${response}=    GET On Session    booker    /booking/${booking_id}
    Set Suite Variable    ${RESPONSE}    ${response}
    Set Suite Variable    ${BOOKING_DATA}    ${response.json()}
    
    Log    Booking encontrado: ${BOOKING_DATA}

Deletar Booking
    [Documentation]    Deleta uma reserva utilizando token de autenticação.
    [Arguments]    ${booking_id}=${BOOKING_ID}
    
    ${cookies}=    Create Dictionary    token=${TOKEN}
    ${response}=    DELETE On Session    booker    /booking/${booking_id}    cookies=${cookies}
    Set Suite Variable    ${RESPONSE}    ${response}
    
    Log    Booking ${booking_id} deletado

Atualizar Dados do Booking
    [Documentation]    Atualiza dados de uma reserva existente.
    [Arguments]    &{update_data}
    
    ${default_dates}=    Create Dictionary    checkin=2025-07-20    checkout=2025-08-01
    ${default_update}=    Create Dictionary
    ...    firstname=nomeatualizado
    ...    lastname=lastnameatualizado
    ...    totalprice=${49}
    ...    depositpaid=${False}
    ...    bookingdates=${default_dates}
    ...    additionalneeds=bookingtesteatualizado
    
    # Merge dados de atualização com padrões
    FOR    ${key}    ${value}    IN    &{update_data}
        Set To Dictionary    ${default_update}    ${key}    ${value}
    END
    
    ${cookies}=    Create Dictionary    token=${TOKEN}
    ${response}=    PUT On Session    booker    /booking/${BOOKING_ID}    json=${default_update}    cookies=${cookies}
    Set Suite Variable    ${RESPONSE}    ${response}
    Set Suite Variable    ${UPDATED_BOOKING}    ${response.json()}
    
    Log    Booking atualizado: ${UPDATED_BOOKING}

Conferir Dados Retornados
    [Documentation]    Valida dados de uma reserva com valores esperados.
    [Arguments]    &{expected_data}
    
    ${expected}=    Create Dictionary
    ...    firstname=teste
    ...    lastname=debooking
    ...    totalprice=${99}
    ...    depositpaid=${True}
    ...    additionalneeds=testedebooking
    
    # Merge valores esperados customizados
    FOR    ${key}    ${value}    IN    &{expected_data}
        Set To Dictionary    ${expected}    ${key}    ${value}
    END
    
    Dictionary Should Contain Item    ${BOOKING_DATA}    firstname    ${expected.firstname}
    Dictionary Should Contain Item    ${BOOKING_DATA}    lastname     ${expected.lastname}
    Dictionary Should Contain Item    ${BOOKING_DATA}    totalprice   ${expected.totalprice}
    Dictionary Should Contain Item    ${BOOKING_DATA}    depositpaid  ${expected.depositpaid}
    Dictionary Should Contain Item    ${BOOKING_DATA}    additionalneeds    ${expected.additionalneeds}
    
    Log    Validação de dados concluída com sucesso

Conferir Dados Retornados Atualizado
    [Documentation]    Valida dados atualizados de uma reserva.
    [Arguments]    &{expected_data}
    
    ${expected}=    Create Dictionary
    ...    firstname=nomeatualizado
    ...    lastname=lastnameatualizado
    ...    totalprice=${49}
    ...    depositpaid=${False}
    ...    additionalneeds=bookingtesteatualizado
    
    # Merge valores esperados customizados
    FOR    ${key}    ${value}    IN    &{expected_data}
        Set To Dictionary    ${expected}    ${key}    ${value}
    END
    
    Dictionary Should Contain Item    ${UPDATED_BOOKING}    firstname    ${expected.firstname}
    Dictionary Should Contain Item    ${UPDATED_BOOKING}    lastname     ${expected.lastname}
    Dictionary Should Contain Item    ${UPDATED_BOOKING}    totalprice   ${expected.totalprice}
    Dictionary Should Contain Item    ${UPDATED_BOOKING}    depositpaid  ${expected.depositpaid}
    Dictionary Should Contain Item    ${UPDATED_BOOKING}    additionalneeds    ${expected.additionalneeds}
    
    Log    Validação de dados atualizados concluída

Validar Status Code "${status_code}"
    [Documentation]    Valida se o código de status HTTP é o esperado.
    Should Be Equal As Integers    ${RESPONSE.status_code}    ${status_code}