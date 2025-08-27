#soma
def soma(a, b):
    return a + b

#subtração
def subtracao(a, b):
    return a - b

#multiplicação
def multiplicacao(a, b):
    return a * b

#divisão
def divisao(a, b):
    if b == 0:
        raise ValueError("O divisor não pode ser zero")
    return a / b

#potencia
def potencia(a, b):
    return a ** b

#modulo
def modulo(a, b):
    return a % b

def menu():
    print("1 - Soma")
    print("2 - Subtração")
    print("3 - Multiplicação")
    print("4 - Divisão")
    print("5 - Potência")
    print("6 - Módulo")
    print("7 - Sair")

while True:
    menu()
    opcao = input("Escolha uma opção: ")

    match opcao:
        case '7':
            print("Encerrando a calculadora.")
            break
        case '1' | '2' | '3' | '4' | '5' | '6':
            num1 = float(input("Digite o primeiro número: "))
            num2 = float(input("Digite o segundo número: "))
            match opcao:
                case '1':
                    resultado = soma(num1, num2)
                case '2':
                    resultado = subtracao(num1, num2)
                case '3':
                    resultado = multiplicacao(num1, num2)
                case '4':
                    resultado = divisao(num1, num2)
                case '5':
                    resultado = potencia(num1, num2)
                case '6':
                    resultado = modulo(num1, num2)
                case _:
                    print("Opção inválida, tente novamente!")
            print(resultado)