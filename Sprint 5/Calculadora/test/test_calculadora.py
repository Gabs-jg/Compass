import sys
import os
import pytest

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '../src')))

from Calculadora import soma, subtracao, multiplicacao, divisao, potencia, modulo

def test_soma():
    assert soma(2, 3) == 5, "Soma incorreta, resultado esperado: 5" #Teste com números positivos
    assert soma(-2, 3) == 1, "Soma incorreta, resultado esperado: 1" #Teste com número negativo e positivo
    assert soma(-2, -3) == -5, "Soma incorreta, resultado esperado: -5" #Teste com números negativos

def test_subtracao():
    assert subtracao(10, 5) == 5, "Subtração incorreta, resultado esperado: 5" #Teste com números positivos
    assert subtracao(-10, 5) == -15, "Subtração incorreta, resultado esperado: -15" #Teste com número negativo e positivo
    assert subtracao(-10, -5) == -5, "Subtração incorreta, resultado esperado: -5" #Teste com números negativos

def test_multiplicacao():
    assert multiplicacao(2, 5) == 10, "Multiplicação incorreta, resultado esperado: 10" #Teste com números positivos
    assert multiplicacao(-2, 5) == -10, "Multiplicação incorreta, resultado esperado: -10" #Teste com número negativo e positivo
    assert multiplicacao(-2, -5) == 10, "Multiplicação incorreta, resultado esperado: 10" #Teste com números negativos

def test_divisao():
    assert divisao(10, 2) == 5, "Divisão incorreta, resultado esperado: 5" #Teste com números positivos
    assert divisao(-10, 2) == -5, "Divisão incorreta, resultado esperado: -5" #Teste com número negativo e positivo
    assert divisao(-10, -2) == 5, "Divisão incorreta, resultado esperado: 5" #Teste com números negativos

def test_divisao_por_zero():
    with pytest.raises(ValueError) as exec_info:
        divisao(10, 0)
    assert "O divisor não pode ser zero" in str(exec_info.value)

def test_potencia():
    assert potencia(3, 2) == 9, "Potência incorreta, resultado esperado: 9" #Teste com números positivos
    assert potencia(-2, 3) == -8, "Potência incorreta, resultado esperado: -8" #Teste com número negativo e positivo
    assert potencia(3, 0) == 1, "Potência incorreta, resultado esperado: 1" #Teste com 0

def test_modulo():
    assert modulo(4, 2) == 0, "Resto da divisão incorreta, resultado esperado: 0" #Teste com números pares
    assert modulo(5, 3) == 2, "Resto da divisão incorreta, resultado esperado: 0" #Teste com números ímpares
    assert modulo(5, 5) == 0, "Resto da divisão incorreta, resultado esperado: 0" #Teste com mesmo número