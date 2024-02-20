from ninja import NinjaAPI

api = NinjaAPI()

@api.get("/hello")
def hello(request, name):
    test = "Test string"
    test2 = "Restart?"
    return "Hello world"