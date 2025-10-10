*** Variables ***
${REGISTER_NAME_INPUT}           id=name
${REGISTER_EMAIL_INPUT}          id=email
${REGISTER_PASS_INPUT}           id=password
${REGISTER_CONFIRM_PASS_INPUT}   id=confirmPassword
${REGISTER_BUTTON}               xpath=//button[text()="Cadastrar"]
${REGISTER_SUCCESS_MSG}          xpath=//div[contains(text(),"Conta criada com sucesso")]
${REGISTER_DUPLICATE_MSG}        xpath=//div[contains(text(),"User already exists")]

${LOGIN_EMAIL_INPUT}             id=email
${LOGIN_PASS_INPUT}              id=password
${LOGIN_BUTTON}                  css=button.login-btn
${LOGIN_SUCCESS_MSG}             xpath=//h1[contains(text(),"Login realizado com sucesso!")]

${LOGOUT_BUTTON}                 css=button.btn-logout

${PROFILE_NAME_INPUT}                  id=name
${PROFILE_SAVE_BUTTON}                 xpath=//button[@title="Salvar alterações"]
${PROFILE_SUCCESS_MODAL}               xpath=//div[contains(@class,"modal")] 
${PROFILE_SUCCESS_MODAL_MSG}           xpath=//div[contains(@class,"modal-body")]
${PROFILE_SUCCESS_MODAL_OK_BUTTON}     xpath=//div[contains(@class,"modal")]//button[text()="Ok"]




