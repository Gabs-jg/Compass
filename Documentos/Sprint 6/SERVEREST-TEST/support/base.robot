*** Settings ***
Documentation  Arquivo base: sessão, imports e resources globais
...            Define libs usadas em todo o projeto
Library        RequestsLibrary
Library        Collections
Library        OperatingSystem
Resource       ./variables/serverest_variables.robot
Resource       ./common/common.robot
Resource       ./fixtures/dynamics.robot

*** Keywords ***
Criar Sessao
    [Documentation]  Cria sessão HTTP para o serverest
    Create Session   serverest    ${BASE_URL}