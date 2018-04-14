window.onload = function () {
    document.querySelector("#logIn_btn").addEventListener("click", function(elem){
        var formElement = document.querySelector(".login-form");
        if(formElement){
            var formData = 'username=' + encodeURIComponent(formElement.querySelector("input[name=inputLogin]").value) +
                      '&password=' + encodeURIComponent(formElement.querySelector("input[name=inputPassword]").value);
            sendAuthForm(formData);
        }
    },true);

    $('#inputPassword').keypress(function(event) {
    	if(event.keyCode===13){
                $('#logIn_btn').click();
            }
        });
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
        callback(this.responseText);
    }

    xhr.open("POST", path, true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

    xhr.send(formData);
 }

function sendAuthForm(formData){
    _sendForm("http://localhost:8080/api/login", formData, function(response){
        var obj = JSON.parse(response);
        if(obj.code == 200){
            window.location.replace("/changelog/add");
        }else{
            $("#error-text").html(obj.msg);
        }
    })
}