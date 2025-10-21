*** Settings ***
Library     Browser
Resource    ../resources/keywords/keywords_auth.robot
Resource    ../resources/variables.robot

*** Variables ***
${BASE_URL}    http://localhost:3002
${USER_EMAIL}  newuser@example.com
${USER_PASS}   Senha123!
${USER_NAME}   Gabriel Test

*** Test Cases ***

US-AUTH-001 Registrar Conta Com Dados Validos
    [Tags]    auth    critical
    Close Browser
    New Browser    chromium
    New Page       ${BASE_URL}/register
    Wait For Elements State    ${REGISTER_NAME_INPUT}    visible    10s
    Preencher Formulario Registro    ${USER_NAME}    ${USER_EMAIL}    ${USER_PASS}
    Submeter Registro
    ${msg}=    Get Text    ${REGISTER_SUCCESS_MSG}
    Should Contain    ${msg}    Conta criada com sucesso

US-AUTH-002 Registrar Usuario Com E-mail Duplicado
    [Tags]    auth
    Close Browser
    New Browser    chromium
    New Page       ${BASE_URL}/register
    Wait For Elements State    ${REGISTER_NAME_INPUT}    visible    10s
    Preencher Formulario Registro    ${USER_NAME}    ${USER_EMAIL}    ${USER_PASS}
    Submeter Registro Esperando Erro
    ${msg}=    Get Text    ${REGISTER_DUPLICATE_MSG}
    Should Contain    ${msg}    User already exists

US-AUTH-003 Login Com Credenciais Validas
    [Tags]    auth    critical
    Close Browser
    New Browser    chromium
    New Page       ${BASE_URL}/login
    Wait For Elements State    ${LOGIN_EMAIL_INPUT}    visible    10s
    Login Usuario    ${USER_EMAIL}    ${USER_PASS}

US-AUTH-004 Login Com Senha Incorreta
    [Tags]    auth
    Close Browser
    New Browser    chromium
    New Page       ${BASE_URL}/login
    Wait For Elements State    ${LOGIN_EMAIL_INPUT}    visible    10s
    Login Usuario Incorreto    ${USER_EMAIL}    SenhaErrada123!

US-AUTH-005 Logout Usuario
    [Tags]    auth
    Close Browser
    New Browser    chromium
    New Page       ${BASE_URL}/login
    Wait For Elements State    ${LOGIN_EMAIL_INPUT}    visible    10s
    Login Usuario    ${USER_EMAIL}    ${USER_PASS}
    Logout Usuario
    # Garantir que botão logout desapareceu
    Wait For Elements State    ${LOGOUT_BUTTON}    hidden    10s

*** Test Cases ***
US-AUTH-006 Visualizar E Atualizar Perfil
    [Tags]    auth
    # Fechar qualquer navegador aberto e iniciar um novo
    Close Browser
    New Browser    chromium
    New Page       ${BASE_URL}/login

    # Esperar página de login carregar
    Wait For Elements State    ${LOGIN_EMAIL_INPUT}    visible    10s

    # Logar usuário
    Login Usuario    ${USER_EMAIL}    ${USER_PASS}

    # Esperar botão de perfil estar visível e clicar nele
    Wait For Elements State    css=a[href="/profile"]    visible    10s
    Click    css=a[href="/profile"]

    # Esperar inputs do perfil carregarem
    Wait For Elements State    ${PROFILE_NAME_INPUT}    visible    10s

    # Atualizar nome
    Fill Text    ${PROFILE_NAME_INPUT}    ${USER_NAME} Updated

    # Clicar no botão Salvar Alterações
    Click    ${PROFILE_SAVE_BUTTON}

    # Esperar modal de sucesso aparecer
    Wait For Elements State    css=div.success-modal    visible    10s

    # Validar título do modal de sucesso
    ${msg}=    Get Text    css=div.success-modal h2
    Should Contain    ${msg}    Sucesso!

    # Fechar modal clicando no botão OK
    Click    css=div.success-modal button.btn-primary





