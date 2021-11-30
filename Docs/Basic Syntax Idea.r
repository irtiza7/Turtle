

def function_1() {
    var a = 10 
    return 10
}

def function_2(number) {
    return number + 10
}

var greetings = "Hello"
const name = "Ali"
var age = 20

var ten = function_1()
print(function_1())

var num_1 = 0
if(num_1 =? 0) {
    var num_2 = function_1()
}else {
    var num_2 = function_2(num_1)
}

def function_3(number) {
    if(number =? 1) {
        return 1
    }
    return function_3(number - 1)
}
var one = function_3(10)


def foo_1(print_hello){
    print_hello()

    const foo_2 = def () {
        print("World")
    }

    return foo_2
}

const my_func = def () {
    print("hello")
}

const another_func = foo_1(my_func)

/////////////////////////////////////////////////////////////////
def f1(myFunc){
    return def () {
        my_func()
    }
}
constant f = def () {
    show("HAT")
}
variable var = f1(f)
var()