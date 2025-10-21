*** Settings ***
Documentation  Cenários de tentatva de cadastro com senha muito curta
Resource       ../resources/base.resource
Test Template  Short password

Test Setup     Start Session
Test Teardown  Take Screenshot

*** Test Cases ***
Não deve logar com senha de 1 digito   1
Não deve logar com senha de 2 digitos  12
Não deve logar com senha de 3 digitos  123
Não deve logar com senha de 4 digitos  1234
Não deve logar com senha de 5 digitos  12345