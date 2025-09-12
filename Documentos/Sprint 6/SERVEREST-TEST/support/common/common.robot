*** Settings ***
Library  String
Library  Collections

*** Keywords ***
Validar Status Code "${statuscode}"
    ${statuscode_int}=  Convert To Integer  ${statuscode}
    Should Be Equal As Integers    ${response.status_code}    ${statuscode_int}

Validar Se Mensagem Contem "${palavra}"
    ${msg}=  Set Variable  ${response.json()["message"]}
    Should Contain    ${msg}    ${palavra}

Gerar Email Unico
    [Arguments]  ${prefix}=test
    ${rand}=   Generate Random String  8  [LETTERS][LOWER]
    ${email}=  Set Variable  ${prefix}${rand}@test.com
    [Return]   ${email}