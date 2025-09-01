*** Settings ***
Documentation  Contém keywords para gerenciar reservas na API Restful Booker. Inclui criação, atualização, busca e deleção de bookings.
Library  RequestsLibrary
Library  Collections

*** Variables ***
${BASE_URL}  https://restful-booker.herokuapp.com/

*** Keywords ***
Criar Sessao
    [Documentation]  Cria uma sessão HTTP chamada 'booker' com a URL base da API.
    Create Session  booker  ${BASE_URL}

Criar Token
    [Documentation]  Gera um token de autenticação na API.
    [Arguments]  ${username}=admin  ${password}=password123
    ${body}  Create Dictionary  username=${username}  password=${password}
    ${response}  POST On Session  booker  /auth  json=${body}
    Set Global Variable  ${response}
    Set Global Variable  ${token}  ${response.json()["token"]}
    Log To Console  Token gerado: ${token}
    RETURN  ${token}

Criar Booking
    [Documentation]  Cria uma nova reserva (booking) com os dados fornecidos.
    [Arguments]  ${firstname}=teste
    ...          ${lastname}=debooking
    ...          ${totalprice}=${99}
    ...          ${depositpaide}=${True}
    ...          ${checkin}=2025-08-20
    ...          ${checkout}=2025-09-01
    ...          ${additionalneeds}=testedebooking
    ${bookingdates}  Create Dictionary  checkin=${checkin}    checkout=${checkout}
    ${payload}  Create Dictionary
    ...         firstname=${firstname}
    ...         lastname=${lastname}
    ...         totalprice=${totalprice}
    ...         depositpaid=${depositpaide}
    ...         bookingdates=${bookingdates}
    ...         additionalneeds=${additionalneeds}
    
    ${response}  POST On Session  booker  /booking  json=${payload}
    Set Global Variable  ${response}

    ${bookingid}  Set Variable  ${response.json()['bookingid']}
    Set Test Variable  ${bookingid}
    Set Global Variable  ${bookingid}

    Log To Console  Response: ${response.content}
    Log To Console  Booking ID criado: ${bookingid}

Buscar Booking Pelo Id
    [Documentation]  Busca e retorna os dados de uma reserva específica através do bookingid.
    [Arguments]  ${bookingid}=${bookingid}
    ${response}  GET On Session  booker  /booking/${bookingid}
    Set Global Variable  ${response}
    Log To Console  Response: ${response.content}

    ${booking}  Set Variable  ${response.json()}
    Set Global Variable  ${booking}

    Log To Console  Booking retornado: ${booking}

Deletar Livro
    [Documentation]  Deleta uma reserva existente utilizando o bookingid e token de autenticação.
    [Arguments]  ${bookingid}=${bookingid}
    ${cookies}    Create Dictionary    token=${token}
    ${response}  DELETE On Session  booker  /booking/${bookingid}  cookies=${cookies}
    Log To Console  Booking Deletado.
    Log To Console  Response: ${response.content}
    Set Global Variable  ${response}

Atualizar Dados do Livro
    [Documentation]  Atualiza os dados de uma reserva existente com novos valores fornecidos.
    [Arguments]  ${firstname}=nomeatualizado
    ...          ${lastname}=lastnameatualizado
    ...          ${totalprice}=${49}
    ...          ${depositpaide}=${False}
    ...          ${checkin}=2025-07-20
    ...          ${checkout}=2025-08-01
    ...          ${additionalneeds}=bookingtesteatualizado 
    ${bookingdates}  Create Dictionary  checkin=${checkin}    checkout=${checkout}
    &{payload}  Create Dictionary
    ...         firstname=${firstname}
    ...         lastname=${lastname}
    ...         totalprice=${totalprice}
    ...         depositpaid=${depositpaide}
    ...         bookingdates=${bookingdates}
    ...         additionalneeds=${additionalneeds}  

    ${cookies}  Create Dictionary  token=${token}
    ${response}  PUT On Session  booker  /booking/${bookingid}  json=&{payload}  cookies=${cookies}

    Log To Console  Booking atualizado: ${response.json()}
    ${booking_atualizado}  Set Variable  ${response.json()}
    Set Global Variable  ${booking_atualizado}

Conferir Dados Retornados
    [Documentation]  Valida se os dados retornados de uma reserva correspondem aos valores esperados.
    [Arguments]  ${expected_firstname}=teste
    ...          ${expected_lastname}=debooking
    ...          ${expected_totalprice}=${99}
    ...          ${expected_depositpaid}=${True}
    ...          ${expected_checkin}=2025-08-20
    ...          ${expected_checkout}=2025-09-01
    ...          ${expected_additionalneeds}=testedebooking
    
    Dictionary Should Contain Item  ${booking}  firstname                 ${expected_firstname}
    Dictionary Should Contain Item  ${booking}  lastname                  ${expected_lastname}
    Dictionary Should Contain Item  ${booking}  totalprice                ${expected_totalprice}
    Dictionary Should Contain Item  ${booking}  depositpaid               ${expected_depositpaid}
    Dictionary Should Contain Item  ${booking['bookingdates']}  checkin   ${expected_checkin}
    Dictionary Should Contain Item  ${booking['bookingdates']}  checkout  ${expected_checkout}
    Dictionary Should Contain Item  ${booking}  additionalneeds           ${expected_additionalneeds}

    Log To Console  Todos os campos conferidos com sucesso!

Conferir Dados Retornados Atualizado
    [Documentation]  Valida se os dados retornados após atualização da reserva correspondem aos valores esperados.
    [Arguments]  ${expected_firstname}=nomeatualizado
    ...          ${expected_lastname}=lastnameatualizado
    ...          ${expected_totalprice}=${49}
    ...          ${expected_depositpaid}=${False}
    ...          ${expected_checkin}=2025-07-20
    ...          ${expected_checkout}=2025-08-01
    ...          ${expected_additionalneeds}=bookingtesteatualizado
    
    Dictionary Should Contain Item  ${booking_atualizado}  firstname                 ${expected_firstname}
    Dictionary Should Contain Item  ${booking_atualizado}  lastname                  ${expected_lastname}
    Dictionary Should Contain Item  ${booking_atualizado}  totalprice                ${expected_totalprice}
    Dictionary Should Contain Item  ${booking_atualizado}  depositpaid               ${expected_depositpaid}
    Dictionary Should Contain Item  ${booking_atualizado['bookingdates']}  checkin   ${expected_checkin}
    Dictionary Should Contain Item  ${booking_atualizado['bookingdates']}  checkout  ${expected_checkout}
    Dictionary Should Contain Item  ${booking_atualizado}  additionalneeds           ${expected_additionalneeds}

    Log To Console  Todos os campos conferidos com sucesso!

Validar Status Code "${status_code}"
    [Documentation]  Valida se o código de status HTTP retornado é o esperado.
    Should Be True  ${response.status_code} == ${status_code}