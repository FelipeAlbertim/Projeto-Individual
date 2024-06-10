// sessão
function validarSessao() {
    var email = sessionStorage.EMAIL_USUARIO;
    var nome = sessionStorage.NOME_USUARIO;

    // var b_usuario = document.getElementById("b_usuario");

    if (email != null && nome != null) {
        // b_usuario.innerHTML = nome;
        window.location = "../questionario.html";
    } else {
        alert("Cadastro Obrigatório !")        
        window.location = "../cadastro.html";
    }
}


function limparSessao() {
    sessionStorage.clear();
    window.location = "../login.html";
}

// carregamento (loading)
function aguardar() {
    alert('CARREGANDO....')
    
    // var divAguardar = document.getElementById("div_aguardar");
    // divAguardar.style.display = "flex";
}

function finalizarAguardar(texto) {
    alert("FINALIZANDO AGUARDAR")

    if (texto == true) {
        alert(`Erro: ${texto}`)
    }
}