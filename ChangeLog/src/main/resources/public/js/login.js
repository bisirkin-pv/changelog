window.onload = function () {
    document.querySelector("#logIn_btn").addEventListener("click", function(elem){
        var formElement = document.querySelector(".login-form");
        if(formElement){
            var formData = 'username=' + encodeURIComponent(formElement.querySelector("input[name=inputLogin]").value) +
                      '&password=' + encodeURIComponent(formElement.querySelector("input[name=inputPassword]").value);
            sendAuthForm(formData);
        }
    },true);
};

/*
    Object: none, private, Downloading the file in JSON format
    In: String path - path to JSON file containing the syntax
    In: FormData formData - generated data form object
    In: Function callback - function performed when the file is received
*/
function _sendForm(path, formData, callback) {
    if(path===''){return -1;}

    var xhr = new XMLHttpRequest();

    xhr.onreadystatechange = function() {
      if (this.readyState != 4) return;
        console.log(this.responseText);
    }

    xhr.open("POST", path, true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

    xhr.send(formData);
 }

function sendAuthForm(formData){
    _sendForm("http://localhost:8080/api/login", formData, function(response){
        console.log(response);
    })
}